table 50000 "TTT-PR ObjectRunner"
{
    Caption = 'Object Runner';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TTT-PR ObjectType"; Integer)
        {
            Caption = 'Object Type';
            DataClassification = CustomerContent;
        }
        field(2; "TTT-PR ObjectID"; Integer)
        {
            Caption = 'Object ID';
            DataClassification = CustomerContent;
        }
        field(3; "TTT-PR ObjectName"; Text[50])
        {
            Caption = 'Object Name';
            DataClassification = CustomerContent;
        }
        field(4; "TTT-PR ObjectCaption"; Text[249])
        {
            Caption = 'Object Caption';
            DataClassification = CustomerContent;
        }
        field(5; "TTT-PR ObjectTypeName"; Text[50])
        {
            Caption = 'Object Type Name';
            DataClassification = CustomerContent;
        }
        field(6; "TTT-PR ObjectSubType"; Text[50])
        {
            Caption = 'Object Sub Type';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "TTT-PR ObjectType", "TTT-PR ObjectID")
        {
            Clustered = true;
        }
    }


    trigger OnInsert();
    begin
    end;

    trigger OnModify();
    begin
    end;

    trigger OnDelete();
    begin
    end;

    trigger OnRename();
    begin
    end;

    procedure FillTable(var parvarrecObject: Record "TTT-PR ObjectRunner");
    var
        locrecAllObjWithCaption: Record AllObjWithCaption;
    begin
        if parvarrecObject.GetFilter("TTT-PR ObjectType") <> '' then
            locrecAllObjWithCaption.SetFilter("Object Type", parvarrecObject.GetFilter("TTT-PR ObjectType"));
        if parvarrecObject.GetFilter("TTT-PR ObjectID") <> '' then
            locrecAllObjWithCaption.SetFilter("Object ID", parvarrecObject.GetFilter("TTT-PR ObjectID"));
        clear(parvarrecObject);
        parvarrecObject.DeleteAll(false);

        locrecAllObjWithCaption.FindSet();
        repeat
            parvarrecObject."TTT-PR ObjectType" := locrecAllObjWithCaption."Object Type";
            parvarrecObject."TTT-PR ObjectID" := locrecAllObjWithCaption."Object ID";
            parvarrecObject."TTT-PR ObjectName" := locrecAllObjWithCaption."Object Name";
            parvarrecObject."TTT-PR ObjectCaption" := locrecAllObjWithCaption."Object Caption";
            parvarrecObject."TTT-PR ObjectTypeName" := CopyStr(Format(locrecAllObjWithCaption."Object Type"), 1, MaxStrLen(parvarrecObject."TTT-PR ObjectTypeName"));
            parvarrecObject."TTT-PR ObjectSubType" := locrecAllObjWithCaption."Object Subtype";
            parvarrecObject.Insert(false);
        until locrecAllObjWithCaption.Next() = 0;
        clear(parvarrecObject);
        parvarrecObject."TTT-PR ObjectType" := locrecAllObjWithCaption."Object Type"::Page;
        parvarrecObject."TTT-PR ObjectID" := 99999;
        if parvarrecobject.find('=<') then;
    end;

    procedure RunObject();
    var
        locrecAllObjWithCaption: Record AllObjWithCaption;
        loctmprecAllObjWithCaption: Record AllObjWithCaption temporary;
        locrecPageMetaData: Record "Page Metadata";
        locpagInspector: Page "TTT-PR SysVirtTblInspector";
    begin
        case "TTT-PR ObjectType" of
            locrecAllObjWithCaption."Object Type"::Codeunit:
                codeunit.Run("TTT-PR ObjectID");
            locrecAllObjWithCaption."Object Type"::Page:
                page.Run("TTT-PR ObjectID");
            locrecAllObjWithCaption."Object Type"::Report:
                Report.Run("TTT-PR ObjectID");
            locrecAllObjWithCaption."Object Type"::XMLport:
                Xmlport.Run("TTT-PR ObjectID");
            locrecAllObjWithCaption."Object Type"::Table,
            locrecAllObjWithCaption."Object Type"::TableData:
                begin
                    // Find pages using Object ID as SourceTable
                    locrecPageMetaData.SetRange(SourceTable, "TTT-PR ObjectID");
                    if locrecPageMetaData.IsEmpty() then begin
                        loctmprecAllObjWithCaption."Object Type" := loctmprecAllObjWithCaption."Object Type"::Page;
                        loctmprecAllObjWithCaption."Object ID" := page::"TTT-PR SysVirtTblInspector";
                    end else begin
                        locrecPageMetaData.findset();
                        repeat
                            if locrecAllObjWithCaption.get(locrecAllObjWithCaption."Object Type"::page, locrecPageMetaData.id) then begin
                                loctmprecAllObjWithCaption := locrecAllObjWithCaption;
                                loctmprecAllObjWithCaption.Insert(false);
                            end;
                        until locrecPageMetaData.Next() = 0;
                        loctmprecAllObjWithCaption."Object Type" := loctmprecAllObjWithCaption."Object Type"::Page;
                        loctmprecAllObjWithCaption."Object ID" := page::"TTT-PR SysVirtTblInspector";
                        loctmprecAllObjWithCaption."Object Name" := 'TTT-PR Table Inspector';
                        loctmprecAllObjWithCaption."Object Caption" := loctmprecAllObjWithCaption."Object Name";
                        if loctmprecAllObjWithCaption.Insert(false) then;

                        Clear(loctmprecAllObjWithCaption);
                        if loctmprecAllObjWithCaption.count() > 1 then
                            if page.RunModal(page::Objects, loctmprecAllObjWithCaption) = "Action"::LookupOK then;
                    end;
                    if loctmprecAllObjWithCaption."Object ID" = page::"TTT-PR SysVirtTblInspector" then begin
                        locpagInspector.PrepareTable("TTT-PR ObjectID");
                        locpagInspector.Run();
                    end else
                        page.Run(loctmprecAllObjWithCaption."Object ID");
                end;
            else
                error('Cannot run %1 object', locrecAllObjWithCaption."Object Type");
        end;
    end;

    procedure ShowFieldList();
    var
        locrecAllObj: Record AllObj;
        locrecField: Record Field;
    begin
        if not ("TTT-PR ObjectType" in [locrecAllObj."Object Type"::Table, locrecAllObj."Object Type"::TableData]) then
            exit;
        locrecField.SetRange(TableNo, "TTT-PR ObjectID");
        page.run(page::"Fields Lookup", locrecField);
    end;

    procedure SetFilterNormal();
    begin
        rec.SetFilter("TTT-PR ObjectID", '%1..%2|%3..%4', 1, 49999, 10000, 1999999999);
    end;

    procedure SetFilterDev();
    begin
        rec.SetRange("TTT-PR ObjectID", 50000, 99999);
    end;

    procedure SetFilterSysVirt();
    begin
        rec.SetFilter("TTT-PR ObjectID", '%1..', 2000000000);
    end;

}