# Windows-Registry-Bulk-Editor

PowerShell Script that allows you to set alist of registry values using a cvs list. There is also a function that you can check to see if registry values are set using the same csv list.


## Usage
```Start powershell as admin
Run script   .\SVT-Registry-Modifier.ps1
SVT-Update -CheckOnly True     ( this will only check the values against the spreadsheet, not set them. )
SVT-Update -CheckOnly False    ( this will check and set the values)

