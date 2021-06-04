#Begin Script
############ Chia plotting script for a lot of small capacity temp drives ###############

# Use it if you have multiple temp folders, that should deliver plots to one destination folder
# It's a perfect config for a butch of a small 256GB drives.

# Max RAM allocation in megabytes per one plot. I would recommend to set 3800 - it is more than enough
$ram = 3800

# CPU threads. More threads does not mean faster plotting. Watch this video for more details - https://www.youtube.com/watch?v=v1xhpkuyIaA
$threadsCount = 3

# Displayed on the top of the terminal window
$workerName = 'Worker'

# Specify all of your temp folders in quotes, separated by a comma
# A new worker (terminal window) will be opened for each temp folder
$tempFolders = @('D:\temp', 'E:\temp', 'F:\temp')

# Destination folder, where plots should be stored
$destFolder = 'W:\plots'

# Count of repeats for EACH worker
$repeatsCount = 10

# Delay is a musthave in two cases
# 1. when you start parallel plotting from one temp drive. In this case, i would not recommend you
# to start all workers in one time, because it would overload the temp drive in phase 1, and decrease
# the speed of plotting. I recommend yo to set delay for 20-30 minutes if you have highspeed NVMe SSD,
# and 40-50 minutes for HDD.
# 2. When you start parallel plotting to one destination drive. The phase 4 (copying plot to destination HDD)
# will take about 10-15 minutes for a common SATA drive with 7200 RPM.
$delay = 40

# Specify the correct version of your plotter. Version number could be find here C:\Users\%USERNAME%\AppData\Local\chia-blockchain
$chiaPlotterVersion = "1.1.5"

#Don't change this values, if you dont sure what you are doing
$bucketSize = 128
$plotSize = 32


for ( $index = 0; $index -lt $tempFolders.count; $index++)
{
    $chiaCommand = "cd 'C:\Users\$env:UserName\AppData\Local\chia-blockchain\app-$chiaPlotterVersion\resources\app.asar.unpacked\daemon\';`$host.ui.RawUI.WindowTitle` = `"$workerName-$index to $destFolder`"; start-sleep $($index*($delay*60)) ; .\chia.exe plots create -k $plotSize -b $ram -u $bucketSize -r $threadsCount -t $($tempFolders[$index]) -d $destFolder -n $repeatsCount ;Read-Host -Prompt 'press enter to exit'"
    $executeCommand = "cmd /c start powershell -NoExit -Command {$chiaCommand}"
    invoke-expression $executeCommand
}
