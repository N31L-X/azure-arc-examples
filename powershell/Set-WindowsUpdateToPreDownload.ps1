$WUSettings = (New-Object -com "Microsoft.Update.AutoUpdate").Settings
$WUSettings.NotificationLevel = 3
$WUSettings.Save()

#[Pre-Download](https://learn.microsoft.com/en-us/azure/update-center/configure-wu-agent)