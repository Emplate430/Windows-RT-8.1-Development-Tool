param(
  [Parameter(Mandatory = $true,
                    Position = 0,
                    ValueFromPipelineByPropertyName = $true)]
  [String[]]$KBNumbers="",
 
  [Parameter(Mandatory = $false,
                    Position = 1,
                    ValueFromPipelineByPropertyName = $true)]
  [String]$LogFile=""
)

[Boolean]$ErrFound = $false
$ComputerName = $env:COMPUTERNAME

Foreach ($KBNumber in $KBNumbers) {
  try {
    0 + $KBNumber | Out-Null 
  }
  catch{ 
    "Parameter error:  '$KBNumber' is not allowed. Specify one or more numeric KBNumbers separated by commas but no spaces. Do not precede numbers with 'KB'."
    ""
    "Script execution failed"
    $ExitCode = 1001
    ""
    "Local Machine Time:  " + (Get-Date -Format G)
    "Exit Code: " + $ExitCode
    Exit $ExitCode
  } 
}

"Computer Name: " + $ComputerName                 
""
"-------------------------------------------------------------------------------"
"-                        UNINSTALLING INFECTED UPDATES                        -"
"-------------------------------------------------------------------------------"

$hotfixes = Get-WmiObject -ComputerName $ComputerName -Class Win32_QuickFixEngineering | select hotfixid            

Foreach ($KBNumber in $KBNumbers) {
  "Checking whether KB$KBNumber needs to be uninstalled."
  $KBID = "KB"+$KBNumber
  if($hotfixes -match $KBID) {
      Write-host "Found KB$KBNumber. Uninstalling..."
      $UninstallString = "cmd.exe /c wusa.exe /uninstall /KB:$KBNumber /quiet /norestart"
      "Executing '($UninstallString)'"
      ([WMICLASS]"\\$ComputerName\ROOT\CIMV2:win32_process").Create($UninstallString) | out-null            
 
      while (@(Get-Process wusa -computername $ComputerName -ErrorAction SilentlyContinue).Count -ne 0) {
          Start-Sleep 3
          Write-Host "Waiting for the update removal to finish..."
      }
    Write-Host "Completed the uninstallation of KB$KBNumber."
  }
  else {            
    Write-Host "KB$KBNumber is not installed, so no uninstall is needed."
  }            
  "-------------------------------------------------------------------------------"
}

$time = 30
$comment = "Windows RT 8.1 will reboot in 30 seconds."
$reboot = @("/r", "/t", $time, "/m", "\\$server", "/c", $comment)

& shutdown $reboot