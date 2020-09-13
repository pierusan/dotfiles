# List of packages to install
$app_ids = @('BlenderFoundation.Blender',
             'Deezer.Deezer',
             'Docker.DockerDesktop',
             # 'figma', --> not available yet (Sept 2020)
             'Google.BackupAndSync',
             'Google.Chrome',
             'Microsoft.VisualStudioCode',
             'Microsoft.WindowsTerminal',
             'SlackTechnologies.Slack',
             'VideoLAN.VLC',
             'WhatsApp.WhatsApp',
             'Zoom.Zoom')

winget source update
foreach ($app in $app_ids) {
    winget install -e --id $app
}