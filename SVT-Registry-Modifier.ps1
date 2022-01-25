

####  Usage #### 
# Start powershell as admin
# Run script   .\SVT-Registry-Modifier.ps1
# SVT-Update -CheckOnly True     ( this will only check the values against the spreadsheet, not set them.
# SVT-Update -CheckOnly False    ( this will check and set the values ) 




function SVT-Registry-Updater {

param (

 [parameter(Mandatory=$true)]
 [ValidateNotNullOrEmpty()]$Path,

 [parameter(Mandatory=$true)]
 [ValidateNotNullOrEmpty()]$Name,

[parameter(Mandatory=$true)]
 [ValidateNotNullOrEmpty()]$Value

 
)


try {

    # Tests to see if the registry path exists.  If it's not, it will add the path, then add the values.  

    if(!(Test-Path $Path)){ 
    
        New-Item -Path $Path -Force | Out-Null
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null
         
        $notFound = 'Not Found: Creating registry ' + $Path + " with value " + $Value
        $notFound
}



    else {

        # If the path is found, it will set the value. 

        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null}

        $Found = 'Found: Creating registry ' + $Path + " with value " + $Value
        $Found
    
     }


catch {

    # If the updating fails for any reason, print failed and the Path. 

    $failed = 'Adding or Updating Failed.  Please manually verify ' + $Path
    $failed

}

}

function SVT-Reg-Check {


        Import-Csv -Path .\RegTest.csv | ForEach-Object{

        try {

            if(!(Test-Path $($_.Path))){

                if ((Get-ItemProperty -Path $($_.Path) -Name $($_.Name) | select -exp $($_.Name)) -eq $($_.Value)) {

                    $message = 'Pass: ' + $($_.Path) + ' ' + $($_.Name) + ' ' +  $($_.Value)
                    $message
    
                }

                else {

                    $message = 'Missing: ' + $($_.Path) + ' ' + $($_.Name) + ' ' +  $($_.Value)
                    $message

                }

            }


       }

            Catch {
    
                # If a call to functions is missing a path, name or Value, it will fail. 

                $message = 'Could not create. No value provided to be set' + $Path
                $message
        }
    }

}

# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force



####  Usage #### 
# Start powershell as admin
# Run script   .\SVT-Registry-Modifier.ps1
# SVT-Update -CheckOnly True     ( this will only check the values against the spreadsheet, not set them.
# SVT-Update -CheckOnly False    ( this will check and set the values ) 



function SVT-Update {

    Param(
    [Parameter(Mandatory,
    ValueFromPipeline)]
    [string[]]
    $CheckOnly
)

    if ($CheckOnly -eq "False"){


        Import-Csv -Path .\RegTest.csv | ForEach-Object{
       
        try {

            SVT-Registry-Updater -Path $($_.Path) -Name $($_.Name)  -Value $($_.Value)
            

        }

        catch {

             # If a call to functions is missing a path, name or Value, it will fail. 

            $message = 'Could not create. No value provided to be set' + $Path
            $message
        
        
        }

        

        }

}

    else {
    
            SVT-Reg-Check
    
        }

    
}







