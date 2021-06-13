$madMaxPlotterPath = 'C:\madMAx43v3r_chia-plotter_win_build_v0.0.4.1\chia_plot.exe'

$tempFolder = 'Z:\temp\'

$destinationFolder = 'X:\plots\'

$CPUthreadsCount = 15

$repeatsCount = -1

$poolKey = ''

$farmerKey = ''

$executeCommand = "$madMaxPlotterPath -p $poolKey -f $farmerKey -t $tempFolder -r $CPUthreadsCount -d $destinationFolder -n $repeatsCount"
invoke-expression $executeCommand
