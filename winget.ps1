# List of packages to install
$app_monikers = @('blender',
                  'deezer',
                  'docker',
                  # 'figma', --> not available yet (Sept 2020)
                  'googlechrome',
                  'google-backup-and-sync',
                  'slack',
                  'Terminal',
                  'vscode',
                  'vlc',
                  'whatsapp',
                  'zoom')

winget source update
foreach ($app in $app_monikers) {
    winget install $app
}