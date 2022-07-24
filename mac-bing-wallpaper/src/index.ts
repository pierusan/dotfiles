import axios from "axios";
import { access } from "node:fs/promises";
import { createWriteStream } from "node:fs";
import { join, extname } from "node:path";
import { load } from "cheerio";
import sharp from "sharp";
import TextToSvg from "text-to-svg";

class Dimensions {
  width: number;
  height: number;

  constructor(w: number, h: number) {
    this.width = w;
    this.height = h;
  }

  get aspectRatio() {
    return this.width / this.height;
  }
}

interface ImageInfo {
  title: string;
  copyrightInfo: string;
  filename: string;
}

class BingImageInfo implements ImageInfo {
  title: string;
  copyrightInfo: string;
  #urlDefault: string;

  constructor(urlDefault: string, title: string, copyrightInfo: string) {
    this.#urlDefault = urlDefault;
    this.title = title;
    this.copyrightInfo = copyrightInfo;
  }

  get urlUHD() {
    let urlUHD = removeQueryParamFromURL(this.#urlDefault, "rf");
    urlUHD = urlUHD.replace(/(_)tmb(\.)/, "$1UHD$2");
    // If dealing with an image with a specific resolution, use this
    // urlUHD = urlUHD.replace(/(_)\d{1,}x\d{1,}(\.jpg)/, "$1UHD$2");

    return urlUHD;
  }

  get filenameUHD(): string {
    const filenameSearchParam = new URL(this.urlUHD).searchParams.get("id");

    if (!filenameSearchParam) {
      throw new Error(`Couldn't find filename in url: ${this.urlUHD}`);
    }
    return filenameSearchParam;
  }

  get filename(): string {
    return this.filenameUHD;
  }
}

class WallpaperImage {
  inputImageInfo;
  dimensions;
  #sharpImage;
  #overlays;

  private constructor(
    inputImageInfo: ImageInfo,
    inputImagePath: string,
    screenDims: Dimensions
  ) {
    this.inputImageInfo = inputImageInfo;
    this.dimensions = screenDims;
    this.#sharpImage = sharp(inputImagePath);
    this.#overlays = this.overlays(this.inputImageInfo, screenDims);
  }

  public static async create(
    imgInfo: ImageInfo,
    inputImagePath: string,
    screenDims: Dimensions
  ) {
    const wallpaperImage = new WallpaperImage(
      imgInfo,
      inputImagePath,
      screenDims
    );
    await wallpaperImage.prepareOutputImage();
    return wallpaperImage;
  }

  private async prepareOutputImage() {
    await this.cropToFitAspectRatio(this.dimensions);
    this.#sharpImage = this.#sharpImage.resize({
      width: this.dimensions.width,
    });
  }

  private overlays(imageInfo: ImageInfo, imageDims: Dimensions) {
    const imageWidth = imageDims.width;
    // Create new image with title and copyright overlayed
    const textToSvg = TextToSvg.loadSync(
      join(process.env["HOME"]!, "Library/Fonts/SourceCodePro-Regular.ttf")
    );
    let titleSvg = textToSvg.getSVG(imageInfo.title, {
      fontSize: 24,
      anchor: "top",
      attributes: { fill: "#bbb" },
    });
    let copyrightSvg = textToSvg.getSVG(imageInfo.copyrightInfo, {
      fontSize: 18,
      anchor: "top",
      attributes: { fill: "#aaa" },
    });
    return [
      ...sharpSvgOverlays(
        imageWidth,
        titleSvg,
        { left: 16, top: 8 },
        { right: 80, top: 80 },
        "#0004"
      ),
      ...sharpSvgOverlays(
        imageWidth,
        copyrightSvg,
        { left: 16, top: 8 },
        { right: 80, top: 136 },
        "#0004"
      ),
    ];
  }

  private async cropToFitAspectRatio(screenDims: Dimensions) {
    const { width: inputWidth, height: inputHeight } =
      await this.#sharpImage.metadata();
    if (!inputWidth || !inputHeight) {
      throw new Error("Could not retrieve input dimensions");
    }
    const inputDims = new Dimensions(inputWidth, inputHeight);

    if (inputDims.aspectRatio > screenDims.aspectRatio) {
      // Crop width
      const percentageToKeep = screenDims.aspectRatio / inputDims.aspectRatio;
      const widthToKeep = Math.round(inputDims.width * percentageToKeep);
      const leftOffset = Math.round((inputDims.width - widthToKeep) / 2);
      this.#sharpImage = this.#sharpImage.extract({
        left: leftOffset,
        width: widthToKeep,
        top: 0,
        height: inputDims.height,
      });
    }
  }

  public writeToPath(path: string) {
    this.#sharpImage.composite(this.#overlays).toFile(path, (err) => {
      if (err) {
        throw err;
      }
    });
  }
}

////////////////////////////////////////////////////////
// Main Script
////////////////////////////////////////////////////////
async function main() {
  // Get the wallpapers directory and screen info from script arguments
  const args = process.argv.slice(2);
  const { wallpapersDir, screenDims } = await parseArgs(args);

  // Retrieve Bing image info for today
  const bingImage: BingImageInfo = await getBingImageInfoForToday();

  // Download if needed
  const local_uhd_photo_path = join(wallpapersDir, bingImage.filenameUHD);
  try {
    await access(local_uhd_photo_path);
  } catch {
    try {
      await downloadImage(bingImage.urlUHD, local_uhd_photo_path);
    } catch {
      throw new Error(`Couldn't download image ${bingImage.urlUHD}`);
    }
  }
  // Create new image with title and copyright overlayed
  const wallpaperImage = await WallpaperImage.create(
    bingImage,
    local_uhd_photo_path,
    screenDims
  );

  // Write new image to new file
  const imageExtension = extname(local_uhd_photo_path);
  const final_photo_path = local_uhd_photo_path.replace(
    imageExtension,
    `_WithOverlays${imageExtension}`
  );
  wallpaperImage.writeToPath(final_photo_path);

  // Result of the script, used by other scripts
  console.log(final_photo_path);
}

await main();

////////////////////////////////////////////////////////
// Util Functions
////////////////////////////////////////////////////////

async function parseArgs(args: string[]) {
  const wallpapersDir = args[0]!; // Ok to assume now because we're catching right after in case it wasn't provided
  try {
    await access(wallpapersDir!);
  } catch {
    throw new Error(
      `No valid directory provided to script. Received: ${wallpapersDir}`
    );
  }
  if (!args[1] || !args[2]) {
    throw new Error(
      `The width and height of your screen must be provided as 2nd and 3d arguments of your script for it to work`
    );
  }
  const screenWidth = parseInt(args[1]);
  const screenHeight = parseInt(args[2]);
  const screenDims: Dimensions = new Dimensions(screenWidth, screenHeight);

  return { wallpapersDir, screenDims };
}

async function getBingImageInfoForToday() {
  // Get Bing Html Selector
  const BING_URL = "https://bing.com";
  let $ = load(await getHtml(BING_URL)); // Cheerio selector

  // Get Bing Image info from HTML
  const bingImagePath = $("meta[property='og:image']").attr("content");
  // The image is not always downloadable so we prefer to get the URL from the head
  // const bingImagePath = $(".hp_top_cover .copyright-container a").attr("href");
  // const bingImageURL = `${BING_URL}${bingImagePath}`;
  const bingImageURL = bingImagePath!;
  const bingImageTitle = $(".musCardCont > h2").text();
  const bingImageCopyrightInfo = $(
    ".musCardCont .copyright-container .copyright"
  ).text();
  return new BingImageInfo(
    bingImageURL,
    bingImageTitle,
    bingImageCopyrightInfo
  );
}

function removeQueryParamFromURL(url: string, paramToDelete: string) {
  const urlObj = new URL(url);
  urlObj.searchParams.delete(paramToDelete);
  return urlObj.toString();
}

async function getHtml(url: string) {
  try {
    return await (
      await axios.get(url)
    ).data;
  } catch {
    throw new Error(`Could not download HTML at url: ${url}`);
  }
}

async function downloadImage(url: string, filepath: string) {
  const response = await axios({ url, method: "GET", responseType: "stream" });
  return new Promise((resolve, reject) => {
    response.data
      .pipe(createWriteStream(filepath))
      .on("error", reject)
      .once("close", () => resolve(filepath));
  });
}

function sharpSvgOverlays(
  bottomImageWidth: number,
  svg: string,
  padding: { left: number; top: number },
  margin: { right: number; top: number },
  svgBackground: string
): sharp.OverlayOptions[] {
  const $ = load(svg, null, false);
  const svgWidth = $("svg").attr("width");
  const svgHeight = $("svg").attr("height");
  const boxWidth = Number(svgWidth) + 2 * padding.left;
  const boxHeight = Number(svgHeight) + 2 * padding.top;

  return [
    // compositing an svg with some opacity didn't seem to work, so we add the
    // transparent background separately as another compositing layer
    {
      input: {
        create: {
          width: Math.round(boxWidth),
          height: Math.round(boxHeight),
          channels: 4,
          background: svgBackground,
        },
      },
      top: margin.top,
      left: Math.round(bottomImageWidth - margin.right - boxWidth),
    },
    {
      input: Buffer.from(svg),
      top: margin.top + padding.top,
      left: Math.round(
        bottomImageWidth - margin.right - boxWidth + padding.left
      ),
    },
  ];
}
