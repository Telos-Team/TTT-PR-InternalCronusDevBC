codeunit 50007 "TTTPRObjectManagement"
{
    Description = 'TTTPR';
    Subtype = Normal;

    trigger OnRun();
    begin
    end;

    var

    procedure OpenRecordRef(parintTableNo: Integer; parbooTemporary: Boolean; var parvarrrTable: RecordRef): Boolean
    var
        locvarTable: Variant;
    begin
        if parintTableNo < 2000000000 then begin
            parvarrrTable.Open(parintTableNo, parbooTemporary);
            exit(true);
        end;
        if GetSystemVirtualTableVariant(parintTableNo, parbooTemporary, locvarTable) then begin
            parvarrrTable.Open(locvarTable);
            exit(true);
        end else begin
            Message('Possible (app) error with RecRef.Open("System/Virtual Table" %1', parintTableNo);
            parvarrrTable.Open(parintTableNo, parbooTemporary);
        end;
    end;

    procedure GetSystemVirtualTableVariant1(parintTableNo: Integer; parbooTemporay: Boolean; var parvarvarTable: Variant): Boolean;
    var
        locrecPermissionSet: Record "Permission Set";
        loctmprecPermissionSet: Record "Permission Set" temporary;
        locrecPermission: Record "Permission";
        loctmprecPermission: Record "Permission" temporary;
    begin
        case parintTableNo of
            database::Object:
                exit(false);
            database::"Permission Set":
                if parbooTemporay then
                    parvarvarTable := loctmprecPermissionSet
                else
                    parvarvarTable := locrecPermissionSet;
            database::"Permission":
                if parbooTemporay then
                    parvarvarTable := loctmprecPermission
                else
                    parvarvarTable := locrecPermission;
        end;
    end;

    procedure ConstructGetSystemVirtualTableVariantAL();
    var
        locrecAllObjWithCaption: Record AllObjWithCaption;
        loctmprecAllObjWithCaption: Record AllObjWithCaption temporary;
        locrecTempBlob: Record TempBlob temporary;
        loctbResult: TextBuilder;
        locstrmIn: InStream;
        locstrmOut: OutStream;
        loctxtClientFilename: Text;
        loctxtSafeObjectName: Text;
    begin
        locrecAllObjWithCaption.SetRange("Object Type", locrecAllObjWithCaption."Object Type"::Table);
        locrecAllObjWithCaption.FilterGroup(0);
        locrecAllObjWithCaption.SetFilter("Object ID", '%1..', 2000000000);
        locrecAllObjWithCaption.FindSet();
        repeat
            if not (locrecAllObjWithCaption."Object ID" in [
                Database::Object,
                Database::Drive,
                Database::"File",
                Database::"Table Information",
                Database::"System Object",
                Database::Printer,
                Database::"License Information",
                Database::"Permission Range",
                Database::Database,
                Database::"SID - Account ID",
                Database::"Send-To Program",
                Database::"Style Sheet",
                Database::"Object Metadata",
                Database::"Web Service",
                2000000081, // "Upgrade Blob Storage"
                2000000082, // Report Layout"
                Database::"Debugger Breakpoint",
                Database::"Debugger Call Stack",
                Database::"Debugger Variable",
                Database::"Debugger Watch Value",
                Database::"Server Instance",
                Database::"Document Service",
                Database::"User Property",
                Database::Device,
                Database::"Table Synch. Setup",
                Database::"Event Subscription",
                Database::"Table Relations Metadata",
                Database::"NAV App Object Metadata",
                Database::"NAV App Data Archive",
                Database::"Database Locks",
                2000000159, // "Data Sensitivity";
                Database::"NAV App",
                Database::"NAV App Dependencies",
                Database::"NAV App Capabilities",
                Database::"NAV App Object Prerequisites",
                Database::"Aggregate Permission Set",
                Database::"Configuration Package File",
                Database::"Page Table Field",
                Database::"Table Field Types",
                //Database::"Finish Design Save Mode",
                2000000176, // "NAV App Resource";
                2000000177, // "Tenant Profile";
                Database::"Media Set",
                Database::Media,
                2000000186, // "Profile Page Metadata";
                2000000187, // "Tenant Profile Page Metadata";
                2000000188, // "User Page Metadata";
                Database::"Entitlement Set",
                Database::Entitlement,
                2000000192, // "Page Control Field";
                2000000193, // "Api Web Service";
                Database::"Webhook Notification",
                Database::"Membership Entitlement",
                Database::"Token Cache",
                Database::"Page Documentation",
                Database::"Webhook Subscription"
            ]) then begin
                loctmprecAllObjWithCaption := locrecAllObjWithCaption;
                loctmprecAllObjWithCaption.Insert(false);
            end;
        until locrecAllObjWithCaption.Next() = 0;

        loctbResult.AppendLine(
            '    procedure GetSystemVirtualTableVariant(parintTableNo : Integer; parbooTemporay : Boolean; var parvarvarTable : Variant) : Boolean;');
        loctbResult.AppendLine(
            '    var');

        loctmprecAllObjWithCaption.FindSet();
        repeat

            loctxtSafeObjectName := DelChr(loctmprecAllObjWithCaption."Object Name", '=', ' -.');
            loctbResult.AppendLine(
                    strsubstno('        locrec%1 : Record "%2";', loctxtSafeObjectName, loctmprecAllObjWithCaption."Object Name"));
            loctbResult.AppendLine(
                    strsubstno('        loctmprec%1 : Record "%2" temporary;', loctxtSafeObjectName, loctmprecAllObjWithCaption."Object Name"));
        until loctmprecAllObjWithCaption.Next() = 0;

        loctbResult.AppendLine('    begin');
        loctbResult.AppendLine('        Clear(parvarvarTable);');
        loctbResult.AppendLine('        case parintTableNo of');
        loctbResult.AppendLine('            database::Object :');
        loctbResult.AppendLine('                exit(false);');

        loctmprecAllObjWithCaption.FindSet();
        repeat
            loctxtSafeObjectName := DelChr(loctmprecAllObjWithCaption."Object Name", '=', ' -.');
            loctbResult.AppendLine(
                    StrSubstNo('            database::"%1" :', loctmprecAllObjWithCaption."Object Name"));
            loctbResult.AppendLine(
                    StrSubstNo('                if parbooTemporay then'));
            loctbResult.AppendLine(
                    StrSubstNo('                    parvarvarTable := loctmprec%1', loctxtSafeObjectName));
            loctbResult.AppendLine(
                    StrSubstNo('                else'));
            loctbResult.AppendLine(
                    StrSubstNo('                    parvarvarTable := locrec%1;', loctxtSafeObjectName));
        until loctmprecAllObjWithCaption.Next() = 0;

        loctbResult.AppendLine('        end;');
        loctbResult.AppendLine('        exit(parvarvarTable.IsRecord);');
        loctbResult.AppendLine('    end;');

        Message('%1', loctbResult.ToText());

        locrecTempBlob.Blob.CreateOutStream(locstrmOut);
        locstrmOut.Write(loctbResult.ToText());
        locrecTempBlob.Blob.CreateInStream(locstrmIn);
        DownloadFromStream(locstrmIn, 'Select a file', '', '', loctxtClientFilename);
    end;

    procedure GetSystemVirtualTableVariant(parintTableNo: Integer; parbooTemporay: Boolean; var parvarvarTable: Variant): Boolean;
    var
        locrecPermissionSet: Record "Permission Set";
        loctmprecPermissionSet: Record "Permission Set" temporary;
        locrecPermission: Record "Permission";
        loctmprecPermission: Record "Permission" temporary;
        locrecCompany: Record "Company";
        loctmprecCompany: Record "Company" temporary;
        locrecDate: Record "Date";
        loctmprecDate: Record "Date" temporary;
        locrecSession: Record "Session";
        loctmprecSession: Record "Session" temporary;
        locrecInteger: Record "Integer";
        loctmprecInteger: Record "Integer" temporary;
        locrecAllObj: Record "AllObj";
        loctmprecAllObj: Record "AllObj" temporary;
        locrecField: Record "Field";
        loctmprecField: Record "Field" temporary;
        locrecLicensePermission: Record "License Permission";
        loctmprecLicensePermission: Record "License Permission" temporary;
        locrecWindowsLanguage: Record "Windows Language";
        loctmprecWindowsLanguage: Record "Windows Language" temporary;
        locrecCodeCoverage: Record "Code Coverage";
        loctmprecCodeCoverage: Record "Code Coverage" temporary;
        locrecAccessControl: Record "Access Control";
        loctmprecAccessControl: Record "Access Control" temporary;
        locrecAllObjWithCaption: Record "AllObjWithCaption";
        loctmprecAllObjWithCaption: Record "AllObjWithCaption" temporary;
        locrecKey: Record "Key";
        loctmprecKey: Record "Key" temporary;
        locrecUserDefaultStyleSheet: Record "User Default Style Sheet";
        loctmprecUserDefaultStyleSheet: Record "User Default Style Sheet" temporary;
        locrecRecordLink: Record "Record Link";
        loctmprecRecordLink: Record "Record Link" temporary;
        locrecAddin: Record "Add-in";
        loctmprecAddin: Record "Add-in" temporary;
        locrecProfile: Record "Profile";
        loctmprecProfile: Record "Profile" temporary;
        locrecUserPersonalization: Record "User Personalization";
        loctmprecUserPersonalization: Record "User Personalization" temporary;
        locrecProfileMetadata: Record "Profile Metadata";
        loctmprecProfileMetadata: Record "Profile Metadata" temporary;
        locrecUserMetadata: Record "User Metadata";
        loctmprecUserMetadata: Record "User Metadata" temporary;
        locrecChart: Record "Chart";
        loctmprecChart: Record "Chart" temporary;
        locrecPageDataPersonalization: Record "Page Data Personalization";
        loctmprecPageDataPersonalization: Record "Page Data Personalization" temporary;
        //locrecDebuggerWatch: Record "Debugger Watch";
        //loctmprecDebuggerWatch: Record "Debugger Watch" temporary;
        locrecActiveSession: Record "Active Session";
        loctmprecActiveSession: Record "Active Session" temporary;
        locrecSessionEvent: Record "Session Event";
        loctmprecSessionEvent: Record "Session Event" temporary;
        locrecUser: Record "User";
        loctmprecUser: Record "User" temporary;
        locrecTableMetadata: Record "Table Metadata";
        loctmprecTableMetadata: Record "Table Metadata" temporary;
        locrecCodeUnitMetadata: Record "CodeUnit Metadata";
        loctmprecCodeUnitMetadata: Record "CodeUnit Metadata" temporary;
        locrecPageMetadata: Record "Page Metadata";
        loctmprecPageMetadata: Record "Page Metadata" temporary;
        locrecReportMetadata: Record "Report Metadata";
        loctmprecReportMetadata: Record "Report Metadata" temporary;
        locrecQueryMetadata: Record "Query Metadata";
        loctmprecQueryMetadata: Record "Query Metadata" temporary;
        //locrecNAVAppTenantApp: Record "NAV App Tenant App";
        //loctmprecNAVAppTenantApp: Record "NAV App Tenant App" temporary;
        locrecNAVAppInstalledApp: Record "NAV App Installed App";
        loctmprecNAVAppInstalledApp: Record "NAV App Installed App" temporary;
        locrecTimeZone: Record "Time Zone";
        loctmprecTimeZone: Record "Time Zone" temporary;
        locrecTenantPermissionSet: Record "Tenant Permission Set";
        loctmprecTenantPermissionSet: Record "Tenant Permission Set" temporary;
        locrecTenantPermission: Record "Tenant Permission";
        loctmprecTenantPermission: Record "Tenant Permission" temporary;
        locrecTenantWebService: Record "Tenant Web Service";
        loctmprecTenantWebService: Record "Tenant Web Service" temporary;
        locrecNAVAppTenantAddIn: Record "NAV App Tenant Add-In";
        loctmprecNAVAppTenantAddIn: Record "NAV App Tenant Add-In" temporary;
        locrecScheduledTask: Record "Scheduled Task";
        loctmprecScheduledTask: Record "Scheduled Task" temporary;
        locrecAllProfile: Record "All Profile";
        loctmprecAllProfile: Record "All Profile" temporary;
        locrecODataEdmType: Record "OData Edm Type";
        loctmprecODataEdmType: Record "OData Edm Type" temporary;
        locrecMediaResources: Record "Media Resources";
        loctmprecMediaResources: Record "Media Resources" temporary;
        locrecTenantMediaSet: Record "Tenant Media Set";
        loctmprecTenantMediaSet: Record "Tenant Media Set" temporary;
        locrecTenantMedia: Record "Tenant Media";
        loctmprecTenantMedia: Record "Tenant Media" temporary;
        locrecTenantMediaThumbnails: Record "Tenant Media Thumbnails";
        loctmprecTenantMediaThumbnails: Record "Tenant Media Thumbnails" temporary;
        locrecTenantLicenseState: Record "Tenant License State";
        loctmprecTenantLicenseState: Record "Tenant License State" temporary;
        locrecObjectOptions: Record "Object Options";
        loctmprecObjectOptions: Record "Object Options" temporary;
    begin
        Clear(parvarvarTable);
        case parintTableNo of
            database::Object:
                exit(false);
            database::"Permission Set":
                if parbooTemporay then
                    parvarvarTable := loctmprecPermissionSet
                else
                    parvarvarTable := locrecPermissionSet;
            database::"Permission":
                if parbooTemporay then
                    parvarvarTable := loctmprecPermission
                else
                    parvarvarTable := locrecPermission;
            database::"Company":
                if parbooTemporay then
                    parvarvarTable := loctmprecCompany
                else
                    parvarvarTable := locrecCompany;
            database::"Date":
                if parbooTemporay then
                    parvarvarTable := loctmprecDate
                else
                    parvarvarTable := locrecDate;
            database::"Session":
                if parbooTemporay then
                    parvarvarTable := loctmprecSession
                else
                    parvarvarTable := locrecSession;
            database::"Integer":
                if parbooTemporay then
                    parvarvarTable := loctmprecInteger
                else
                    parvarvarTable := locrecInteger;
            database::"AllObj":
                if parbooTemporay then
                    parvarvarTable := loctmprecAllObj
                else
                    parvarvarTable := locrecAllObj;
            database::"Field":
                if parbooTemporay then
                    parvarvarTable := loctmprecField
                else
                    parvarvarTable := locrecField;
            database::"License Permission":
                if parbooTemporay then
                    parvarvarTable := loctmprecLicensePermission
                else
                    parvarvarTable := locrecLicensePermission;
            database::"Windows Language":
                if parbooTemporay then
                    parvarvarTable := loctmprecWindowsLanguage
                else
                    parvarvarTable := locrecWindowsLanguage;
            database::"Code Coverage":
                if parbooTemporay then
                    parvarvarTable := loctmprecCodeCoverage
                else
                    parvarvarTable := locrecCodeCoverage;
            database::"Access Control":
                if parbooTemporay then
                    parvarvarTable := loctmprecAccessControl
                else
                    parvarvarTable := locrecAccessControl;
            database::"AllObjWithCaption":
                if parbooTemporay then
                    parvarvarTable := loctmprecAllObjWithCaption
                else
                    parvarvarTable := locrecAllObjWithCaption;
            database::"Key":
                if parbooTemporay then
                    parvarvarTable := loctmprecKey
                else
                    parvarvarTable := locrecKey;
            database::"User Default Style Sheet":
                if parbooTemporay then
                    parvarvarTable := loctmprecUserDefaultStyleSheet
                else
                    parvarvarTable := locrecUserDefaultStyleSheet;
            database::"Record Link":
                if parbooTemporay then
                    parvarvarTable := loctmprecRecordLink
                else
                    parvarvarTable := locrecRecordLink;
            database::"Add-in":
                if parbooTemporay then
                    parvarvarTable := loctmprecAddin
                else
                    parvarvarTable := locrecAddin;
            database::"Profile":
                if parbooTemporay then
                    parvarvarTable := loctmprecProfile
                else
                    parvarvarTable := locrecProfile;
            database::"User Personalization":
                if parbooTemporay then
                    parvarvarTable := loctmprecUserPersonalization
                else
                    parvarvarTable := locrecUserPersonalization;
            database::"Profile Metadata":
                if parbooTemporay then
                    parvarvarTable := loctmprecProfileMetadata
                else
                    parvarvarTable := locrecProfileMetadata;
            database::"User Metadata":
                if parbooTemporay then
                    parvarvarTable := loctmprecUserMetadata
                else
                    parvarvarTable := locrecUserMetadata;
            database::"Chart":
                if parbooTemporay then
                    parvarvarTable := loctmprecChart
                else
                    parvarvarTable := locrecChart;
            database::"Page Data Personalization":
                if parbooTemporay then
                    parvarvarTable := loctmprecPageDataPersonalization
                else
                    parvarvarTable := locrecPageDataPersonalization;
            // database::"Debugger Watch":
            //     if parbooTemporay then
            //         parvarvarTable := loctmprecDebuggerWatch
            //     else
            //         parvarvarTable := locrecDebuggerWatch;
            database::"Active Session":
                if parbooTemporay then
                    parvarvarTable := loctmprecActiveSession
                else
                    parvarvarTable := locrecActiveSession;
            database::"Session Event":
                if parbooTemporay then
                    parvarvarTable := loctmprecSessionEvent
                else
                    parvarvarTable := locrecSessionEvent;
            database::"User":
                if parbooTemporay then
                    parvarvarTable := loctmprecUser
                else
                    parvarvarTable := locrecUser;
            database::"Table Metadata":
                if parbooTemporay then
                    parvarvarTable := loctmprecTableMetadata
                else
                    parvarvarTable := locrecTableMetadata;
            database::"CodeUnit Metadata":
                if parbooTemporay then
                    parvarvarTable := loctmprecCodeUnitMetadata
                else
                    parvarvarTable := locrecCodeUnitMetadata;
            database::"Page Metadata":
                if parbooTemporay then
                    parvarvarTable := loctmprecPageMetadata
                else
                    parvarvarTable := locrecPageMetadata;
            database::"Report Metadata":
                if parbooTemporay then
                    parvarvarTable := loctmprecReportMetadata
                else
                    parvarvarTable := locrecReportMetadata;
            database::"Query Metadata":
                if parbooTemporay then
                    parvarvarTable := loctmprecQueryMetadata
                else
                    parvarvarTable := locrecQueryMetadata;
            // database::"NAV App Tenant App":
            //     if parbooTemporay then
            //         parvarvarTable := loctmprecNAVAppTenantApp
            //     else
            //         parvarvarTable := locrecNAVAppTenantApp;
            database::"NAV App Installed App":
                if parbooTemporay then
                    parvarvarTable := loctmprecNAVAppInstalledApp
                else
                    parvarvarTable := locrecNAVAppInstalledApp;
            database::"Time Zone":
                if parbooTemporay then
                    parvarvarTable := loctmprecTimeZone
                else
                    parvarvarTable := locrecTimeZone;
            database::"Tenant Permission Set":
                if parbooTemporay then
                    parvarvarTable := loctmprecTenantPermissionSet
                else
                    parvarvarTable := locrecTenantPermissionSet;
            database::"Tenant Permission":
                if parbooTemporay then
                    parvarvarTable := loctmprecTenantPermission
                else
                    parvarvarTable := locrecTenantPermission;
            database::"Tenant Web Service":
                if parbooTemporay then
                    parvarvarTable := loctmprecTenantWebService
                else
                    parvarvarTable := locrecTenantWebService;
            database::"NAV App Tenant Add-In":
                if parbooTemporay then
                    parvarvarTable := loctmprecNAVAppTenantAddIn
                else
                    parvarvarTable := locrecNAVAppTenantAddIn;
            database::"Scheduled Task":
                if parbooTemporay then
                    parvarvarTable := loctmprecScheduledTask
                else
                    parvarvarTable := locrecScheduledTask;
            database::"All Profile":
                if parbooTemporay then
                    parvarvarTable := loctmprecAllProfile
                else
                    parvarvarTable := locrecAllProfile;
            database::"OData Edm Type":
                if parbooTemporay then
                    parvarvarTable := loctmprecODataEdmType
                else
                    parvarvarTable := locrecODataEdmType;
            database::"Media Resources":
                if parbooTemporay then
                    parvarvarTable := loctmprecMediaResources
                else
                    parvarvarTable := locrecMediaResources;
            database::"Tenant Media Set":
                if parbooTemporay then
                    parvarvarTable := loctmprecTenantMediaSet
                else
                    parvarvarTable := locrecTenantMediaSet;
            database::"Tenant Media":
                if parbooTemporay then
                    parvarvarTable := loctmprecTenantMedia
                else
                    parvarvarTable := locrecTenantMedia;
            database::"Tenant Media Thumbnails":
                if parbooTemporay then
                    parvarvarTable := loctmprecTenantMediaThumbnails
                else
                    parvarvarTable := locrecTenantMediaThumbnails;
            database::"Tenant License State":
                if parbooTemporay then
                    parvarvarTable := loctmprecTenantLicenseState
                else
                    parvarvarTable := locrecTenantLicenseState;
            database::"Object Options":
                if parbooTemporay then
                    parvarvarTable := loctmprecObjectOptions
                else
                    parvarvarTable := locrecObjectOptions;
        end;
        exit(parvarvarTable.IsRecord());
    end;

}
