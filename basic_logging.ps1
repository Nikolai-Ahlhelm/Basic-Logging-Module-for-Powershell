### Basic Powershell Logging
#28.04.2022 - v2.1

### USAGE
#Import Module:		Import-Module -Name .\basic_logging.ps1

#Create Logger Obj:		$Log = New-Object -TypeName Logger -ArgumentList "log.txt"

#LogEntry:			$Log.Entry("Info", "Test Message")



class Logger
{
    [string] $LogFilePath 
    [string] $LogDate
    [string] $LogMessage
    [string] $LogType
    [string] $format

    Logger(
        [string] $logFilePath
    ){
        $this.logFilePath = $logFilePath
        $this.LogDate = Get-Date -Format "dd/MM/yyyy"
		#Get-Date -Format "dd-MM-yyyy-hh:mm:ss:ffff"
		$this.format = "dd/MM/yyyy-hh:mm:ss:ffff"
    }

    [void] SetLogFilePath($FilePath) {
        $this.logFilePath = $FilePath
    }

    [void] Entry($Type,$Message) {
        if ($Type -eq "ERROR" -or $Type -eq "Error" -or $Type -eq "error" -or $Type -eq "err") {
            $ErrorMessage = "["+(Get-Date -Format $this.format)+"] [ERROR] "+$Message
            Write-Output $ErrorMessage
            Out-File $this.logFilePath -Append -InputObject $ErrorMessage
        }
        elseif ($Type -eq "INFO" -or $Type -eq "Info" -or $Type -eq "info" -or $Type -eq "inf") {
            $InfoMessage = "["+(Get-Date -Format $this.format)+"] [INFO] "+$Message
            Write-Output $InfoMessage
            Out-File $this.logFilePath -Append -InputObject $InfoMessage
        }
        elseif ($Type -eq "WARN" -or $Type -eq "Warn" -or $Type -eq "warn" -or $Type -eq "warning") {
            $WarnMessage = "["+(Get-Date -Format $this.format)+"] [WARNING] "+$Message
            Write-Output $WarnMessage
            Out-File $this.logFilePath -Append -InputObject $WarnMessage
        }
        elseif ($Type -eq "CRIT" -or $Type -eq "Crit" -or $Type -eq "crit" -or $Type -eq "critical") {
            $CritMessage = "["+(Get-Date -Format $this.format)+"] [CRITICAL] "+$Message
            Write-Output $CritMessage
            Out-File $this.logFilePath -Append -InputObject $CritMessage
        }
        else {
            $TypeMessage = "["+(Get-Date -Format $this.format)+"] [$Type] "+$Message
            Write-Output $TypeMessage
            Out-File $this.logFilePath -Append -InputObject $TypeMessage
        }
    }

}