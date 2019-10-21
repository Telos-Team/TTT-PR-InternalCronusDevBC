codeunit 50026 "TTT-PR WsTestInstaller"
{
    procedure InstallWs(parintObjectType: Integer; parintObjectId: Integer; partxtServiceName: Text; parbooPublish: Boolean): Text
    var
        locrecAllObj: Record AllObjWithCaption;
        locrecWs: Record "Tenant Web Service";
    begin
        locrecAllObj.Get(locrecAllObj."Object Type"::Codeunit, parintObjectId);
        if locrecWs.Get(parintObjectType, partxtServiceName) then
            if locrecWs."Object ID" <> parintObjectId then
                locrecWs.FieldError("Object ID")
            else
                exit(GetSoapUrl(locrecWs));
        locrecWs.Init();
        locrecWs.Validate("Object Type", parintObjectType);
        locrecWs.Validate("Service Name", CopyStr(partxtServiceName, 1, MaxStrLen(locrecWs."Service Name")));
        locrecWs.Validate("Object ID", parintObjectId);
        if parbooPublish then
            locrecws.Validate(Published, parbooPublish);
        locrecWs.Insert(true);

        exit(GetSoapUrl(locrecWs));
    end;

    procedure InstallCodeunitWs(parintObjectId: Integer; partxtServiceName: Text; parbooPublish: Boolean): Text
    var
        locrecAllObj: Record AllObjWithCaption;
    begin
        exit(InstallWs(locrecAllObj."Object Type"::Codeunit, parintObjectId, partxtServiceName, parbooPublish));
    end;

    procedure InstallPageWs(parintObjectId: Integer; partxtServiceName: Text; parbooPublish: Boolean): Text
    var
        locrecAllObj: Record AllObjWithCaption;
    begin
        exit(InstallWs(locrecAllObj."Object Type"::Page, parintObjectId, partxtServiceName, parbooPublish));
    end;

    procedure GetSoapUrl(parrecWs: Record "Tenant Web Service"): Text
    begin
        case parrecWs."Object Type" of
            parrecWs."Object Type"::Codeunit:
                exit(GetUrl(ClientType::SOAP, CompanyName(), ObjectType::Codeunit, parrecWs."Object ID", parrecWs));
            parrecWs."Object Type"::Page:
                exit(GetUrl(ClientType::SOAP, CompanyName(), ObjectType::Page, parrecWs."Object ID", parrecWs));
        end;
    end;

}
