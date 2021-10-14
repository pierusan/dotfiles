# List of packages to install
$app_ids = @('BlenderFoundation.Blender',
             'Deezer.Deezer',
             'Docker.DockerDesktop',
             'ExpressVPN.ExpressVPN',
             'Figma.Figma',
             'Google.Chrome',
             'Google.Drive',
             'Insomnia.Insomnia',
             'Microsoft.VisualStudioCode',
             'Microsoft.WindowsTerminal',
             'Mozilla.Firefox',
             'Notion.Notion',
             'OBSProject.OBSStudio',
             'SlackTechnologies.Slack',
             'VideoLAN.VLC',
             'WhatsApp.WhatsApp',
             'Zoom.Zoom')

winget source update
foreach ($app in $app_ids) {
    winget install -e --id $app
}