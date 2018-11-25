table 50000 "TTTPRObjectRunner"
{
    Caption = 'Object Runner';
    DataClassification = CustomerContent;

    fields
    {
        field(1; ObjectType; Integer)
        {
            Caption = 'Object Type';
            DataClassification = CustomerContent;
        }
        field(2; ObjectID; Integer)
        {
            Caption = 'Object ID';
            DataClassification = CustomerContent;
        }
        field(3; ObjectName; Text[50])
        {
            Caption = 'Object Name';
            DataClassification = CustomerContent;
        }
        field(4; ObjectCaption; Text[249])
        {
            Caption = 'Object Caption';
            DataClassification = CustomerContent;
        }
        field(5; ObjectTypeName; Text[50])
        {
            Caption = 'Object Type Name';
            DataClassification = CustomerContent;
        }
        field(6; ObjectSubType; Text[50])
        {
            Caption = 'Object Sub Type';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; ObjectType, ObjectID)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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

    procedure FillTable(var parvarrecObject: Record TTTPRObjectRunner);
    var
        locrecAllObjWithCaption: Record AllObjWithCaption;
    begin
        if parvarrecObject.GetFilter(ObjectType) <> '' then
            locrecAllObjWithCaption.SetFilter("Object Type", parvarrecObject.GetFilter(ObjectType));
        if parvarrecObject.GetFilter(ObjectID) <> '' then
            locrecAllObjWithCaption.SetFilter("Object ID", parvarrecObject.GetFilter(ObjectID));
        clear(parvarrecObject);
        parvarrecObject.DeleteAll(false);

        locrecAllObjWithCaption.FindSet();
        repeat
            parvarrecObject.ObjectType := locrecAllObjWithCaption."Object Type";
            parvarrecObject.ObjectID := locrecAllObjWithCaption."Object ID";
            parvarrecObject.ObjectName := locrecAllObjWithCaption."Object Name";
            parvarrecObject.ObjectCaption := locrecAllObjWithCaption."Object Caption";
            parvarrecObject.ObjectTypeName := CopyStr(Format(locrecAllObjWithCaption."Object Type"), 1, MaxStrLen(parvarrecObject.ObjectTypeName));
            parvarrecObject.ObjectSubType := locrecAllObjWithCaption."Object Subtype";
            parvarrecObject.Insert(false);
        until locrecAllObjWithCaption.Next() = 0;
        clear(parvarrecObject);
        parvarrecObject.ObjectType := locrecAllObjWithCaption."Object Type"::Table;
        parvarrecObject.ObjectID := 2000000000;
        if parvarrecobject.find('=>') then;
    end;

    procedure RunObject();
    var
        locrecAllObjWithCaption: Record AllObjWithCaption;
        loctmprecAllObjWithCaption: Record AllObjWithCaption temporary;
        locrecPageMetaData: Record "Page Metadata";
        locpagInspector: Page TTTPRSysVirtTblInspector;
    begin
        case ObjectType of
            locrecAllObjWithCaption."Object Type"::Codeunit:
                codeunit.Run(ObjectID);
            locrecAllObjWithCaption."Object Type"::Page:
                page.Run(ObjectID);
            locrecAllObjWithCaption."Object Type"::Report:
                Report.Run(ObjectID);
            locrecAllObjWithCaption."Object Type"::XMLport:
                Xmlport.Run(ObjectID);
            locrecAllObjWithCaption."Object Type"::Table,
            locrecAllObjWithCaption."Object Type"::TableData:
                begin
                    // Find pages using Object ID as SourceTable
                    locrecPageMetaData.SetRange(SourceTable, ObjectID);
                    if locrecPageMetaData.IsEmpty then begin
                        loctmprecAllObjWithCaption."Object Type" := loctmprecAllObjWithCaption."Object Type"::Page;
                        loctmprecAllObjWithCaption."Object ID" := page::TTTPRSysVirtTblInspector;
                    end else begin
                        locrecPageMetaData.findset;
                        repeat
                            if locrecAllObjWithCaption.get(locrecAllObjWithCaption."Object Type"::page, locrecPageMetaData.id) then begin
                                loctmprecAllObjWithCaption := locrecAllObjWithCaption;
                                loctmprecAllObjWithCaption.Insert(false);
                            end;
                        until locrecPageMetaData.Next = 0;
                        loctmprecAllObjWithCaption."Object Type" := loctmprecAllObjWithCaption."Object Type"::Page;
                        loctmprecAllObjWithCaption."Object ID" := page::TTTPRSysVirtTblInspector;
                        loctmprecAllObjWithCaption."Object Name" := 'TTTPR Table Inspector';
                        loctmprecAllObjWithCaption."Object Caption" := loctmprecAllObjWithCaption."Object Name";
                        if loctmprecAllObjWithCaption.Insert(false) then;

                        Clear(loctmprecAllObjWithCaption);
                        if loctmprecAllObjWithCaption.count > 1 then
                            if page.RunModal(page::Objects, loctmprecAllObjWithCaption) = "Action"::LookupOK then;
                    end;
                    if loctmprecAllObjWithCaption."Object ID" = page::TTTPRSysVirtTblInspector then begin
                        locpagInspector.PrepareTable(ObjectID);
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
        if not (ObjectType in [locrecAllObj."Object Type"::Table, locrecAllObj."Object Type"::TableData]) then
            exit;
        locrecField.SetRange(TableNo, ObjectID);
        page.run(page::fields, locrecField);
    end;

    procedure SetFilterNormal();
    begin
        rec.SetFilter(ObjectID, '%1..%2|%3..%4', 1, 49999, 10000, 1999999999);
    end;

    procedure SetFilterDev();
    begin
        rec.SetRange(ObjectID, 50000, 99999);
    end;

    procedure SetFilterSysVirt();
    begin
        rec.SetFilter(ObjectID, '%1..', 2000000000);
    end;

}