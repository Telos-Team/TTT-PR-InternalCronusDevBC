# TTTPR-InternalCronusDevBC
## TTTPR's own development database functionality

### Remark:
- Target is *Internal* (as opposed to *Extension*) 

### Todos:
| Todo | Priority |
| :---- | :------: |
| Test web services | 3
| Convert BH | 9
| Barcode creator | 9
| Test Excel speed | 9
| File access, blobs | 1
| TableFilter using RecRef | 1
| TableFilter using FilterPageBuilder | 1
| Enumerate object numbers in VS Code | 3
| Sign app file | 1

### Notes / remember:
| Note | Comment |
|:---- | :------ |
| Sync/Recreate | Switch using launch.json
| Extension/Internal | Switch using app.json
| Role Center Page | Must restart service tier? or log out
| ApplicationArea, UsageCategory, AccessByPermission, DataClassification | Mandatory for visibility and searchability
| Functions [External]
| Dates: yyyymmddD
| CodeAnalysis | Use either settings.json or workspace file

### Links:
| Name | Link | Comment |
|:---- | :--- | :------ |
| Signing | https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-sign-extension | Mandatory for BC
| Destructive table changes | https://github.com/Microsoft/AL/issues/1595 https://github.com/Microsoft/AL/issues/1499
| CSV | https://demiliani.com/2018/08/20/dynamics-365-business-central-parsing-a-csv-file-using-csv-buffer/
| Config package | https://demiliani.com/2018/08/22/dynamics-365-business-central-loading-configuration-packages-from-al/
| Web service publication | https://demiliani.com/2018/09/05/dynamics-365-business-central-publishing-a-web-service-from-extensions/


## BC Limitations:
| Limitation | Comment |
| :--------- | :------ |
| Pages on system / virtual tables
| RecRef.Open() on system / virtual table numbers | Can use named variable and GetTable or RecordID, lots can't be used
| Dotnet variables | Use replacement types (JSON, XML, TextBuilder) or Azure Functions
| Dotnet Control-Add-ins | Use javascript add-ins
| Multilanguage properties | Use XLIFF files
| Certain file manipulations
| Field name and size changes (destructive changes) | Use Obsolete
| File.Open and most functions in codeunit "File Management" | Use stream and/or Azure Storage

