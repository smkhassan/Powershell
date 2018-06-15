If($PSVersionTable.PSVersion.Major -lt 5)
{
    LogError "The following casino shall be updated: $($Global:setupConfiguration["GENERAL SETTINGS"]["CASINO_LOCATOR_NAME"])"
 
    $fileName = "KB3191564-x64.cab"
    $filePath = "C:\Temp\"
    $remoteFilePath = "$($Global:globalVariables.executionPath)\$fileName"
    LogMessage $filePath
    LogMessage $remoteFilePath
    
    
 if(!(Test-Path -Path $filePath )){
    New-Item -ItemType directory -Path $filePath
}

Copy-Item -Path $remoteFilePath  -Destination $filePath
 

#Start-Process "C:\Temp\Win8.1AndW2K12R2-KB3191564-x64.msu" "/q /norestart" -Wait

$architecture=gwmi win32_processor | select -first 1 | select addresswidth 
if ($architecture.addresswidth -eq "64")
{ Invoke-Command  {
    dism.exe /online /add-package /PackagePath:C:\Temp\KB3191564-x64.cab /norestart
    #Remove-Item c:\temp\KB3191564-x64.cab
 
 
    } } elseif 
    ($architecture.addresswidth -eq "32"){ throw "Error Message" }

 }