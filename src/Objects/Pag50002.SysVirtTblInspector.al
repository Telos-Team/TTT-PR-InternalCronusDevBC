page 50002 "TTTPRSysVirtTblInspector"
{
    PageType = List;
    SourceTable = Integer;
    Editable = false;
    SourceTableView = where (Number = filter (1 ..));
    Caption = 'System/Virtual Table Inspector';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(TableNo; intTableNo)
                {
                    Caption = 'Table No.';
                    ApplicationArea = All;
                }
                field(RecCount; intRecCount)
                {
                    Caption = 'Record Count';
                    ApplicationArea = All;
                }
                field(TableName; txtTableName)
                {
                    Caption = 'Table Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(TableCaption; txtTableCaption)
                {
                    Caption = 'Table Caption';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            repeater(Group)
            {
                Caption = 'Lines';
                field(LineNo; Number)
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;
                }
                field(Field1; GetFieldValue(intTableNo, 1, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 1);
                    ApplicationArea = All;
                }
                field(Field2; GetFieldValue(intTableNo, 2, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 2);
                    ApplicationArea = All;
                }
                field(Field3; GetFieldValue(intTableNo, 3, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 3);
                    ApplicationArea = All;
                }
                field(Field4; GetFieldValue(intTableNo, 4, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 4);
                    ApplicationArea = All;
                }
                field(Field5; GetFieldValue(intTableNo, 5, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 5);
                    ApplicationArea = All;
                }
                field(Field6; GetFieldValue(intTableNo, 6, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 6);
                    ApplicationArea = All;
                }
                field(Field7; GetFieldValue(intTableNo, 7, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 7);
                    ApplicationArea = All;
                }
                field(Field8; GetFieldValue(intTableNo, 8, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 8);
                    ApplicationArea = All;
                }
                field(Field9; GetFieldValue(intTableNo, 9, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 9);
                    ApplicationArea = All;
                }
                field(Field10; GetFieldValue(intTableNo, 10, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 10);
                    ApplicationArea = All;
                }
                field(Field11; GetFieldValue(intTableNo, 11, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 11);
                    ApplicationArea = All;
                }
                field(Field12; GetFieldValue(intTableNo, 12, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 12);
                    ApplicationArea = All;
                }
                field(Field13; GetFieldValue(intTableNo, 13, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 13);
                    ApplicationArea = All;
                }
                field(Field14; GetFieldValue(intTableNo, 14, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 14);
                    ApplicationArea = All;
                }
                field(Field15; GetFieldValue(intTableNo, 15, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 15);
                    ApplicationArea = All;
                }
                field(Field16; GetFieldValue(intTableNo, 16, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 16);
                    ApplicationArea = All;
                }
                field(Field17; GetFieldValue(intTableNo, 17, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 17);
                    ApplicationArea = All;
                }
                field(Field18; GetFieldValue(intTableNo, 18, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 18);
                    ApplicationArea = All;
                }
                field(Field19; GetFieldValue(intTableNo, 19, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 19);
                    ApplicationArea = All;
                }
                field(Field20; GetFieldValue(intTableNo, 20, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 20);
                    ApplicationArea = All;
                }
                field(Field21; GetFieldValue(intTableNo, 21, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 21);
                    ApplicationArea = All;
                }
                field(Field22; GetFieldValue(intTableNo, 22, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 22);
                    ApplicationArea = All;
                }
                field(Field23; GetFieldValue(intTableNo, 23, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 23);
                    ApplicationArea = All;
                }
                field(Field24; GetFieldValue(intTableNo, 24, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 24);
                    ApplicationArea = All;
                }
                field(Field25; GetFieldValue(intTableNo, 25, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 25);
                    ApplicationArea = All;
                }
                field(Field26; GetFieldValue(intTableNo, 26, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 26);
                    ApplicationArea = All;
                }
                field(Field27; GetFieldValue(intTableNo, 27, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 27);
                    ApplicationArea = All;
                }
                field(Field28; GetFieldValue(intTableNo, 28, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 28);
                    ApplicationArea = All;
                }
                field(Field29; GetFieldValue(intTableNo, 29, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 29);
                    ApplicationArea = All;
                }
                field(Field30; GetFieldValue(intTableNo, 30, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 30);
                    ApplicationArea = All;
                }
                field(Field31; GetFieldValue(intTableNo, 31, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 31);
                    ApplicationArea = All;
                }
                field(Field32; GetFieldValue(intTableNo, 32, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 32);
                    ApplicationArea = All;
                }
                field(Field33; GetFieldValue(intTableNo, 33, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 33);
                    ApplicationArea = All;
                }
                field(Field34; GetFieldValue(intTableNo, 34, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 34);
                    ApplicationArea = All;
                }
                field(Field35; GetFieldValue(intTableNo, 35, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 35);
                    ApplicationArea = All;
                }
                field(Field36; GetFieldValue(intTableNo, 36, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 36);
                    ApplicationArea = All;
                }
                field(Field37; GetFieldValue(intTableNo, 37, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 37);
                    ApplicationArea = All;
                }
                field(Field38; GetFieldValue(intTableNo, 38, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 38);
                    ApplicationArea = All;
                }
                field(Field39; GetFieldValue(intTableNo, 39, Number))
                {
                    CaptionClass = GetFieldHeader(intTableNo, 39);
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(actSelectTable)
            {
                Caption = 'Select Table';
                ToolTip = 'Select another table to show';
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = SuggestNumber;
                trigger OnAction();
                begin
                    SelectTable();
                end;
            }
            action(actUseCaptionName)
            {
                Caption = 'Use Caption/Name';
                ToolTip = 'Change header to show caption or name';
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = ShowSelected;
                trigger OnAction();
                begin
                    ChangeCaptionName();
                end;
            }
        }
    }

    var
        tmprecFields: Record Field temporary;
        rrTable: RecordRef;
        tmprrTable: RecordRef;
        intTableNo: Integer;
        intLastRecNo: Integer;
        intRecCount: Integer;
        txtTableName: Text;
        txtTableCaption: Text;
        booUseCaptionName: Boolean;

    trigger OnOpenPage();
    var
    begin
        if intTableNo = 0 then
            PrepareTable(Database::Field);
    end;

    local procedure SelectTable();
    var
        locrecAllObjWithCaption: Record AllObjWithCaption;
    begin
        if locrecAllObjWithCaption.get(locrecAllObjWithCaption."Object Type"::table, intTableNo) then;
        locrecAllObjWithCaption.SetRange("Object Type", locrecAllObjWithCaption."Object Type"::Table);
        locrecAllObjWithCaption.SetFilter("Object ID", '%1..', 2000000000);
        if page.RunModal(page::Objects, locrecAllObjWithCaption) <> action::LookupOK then
            exit;
        PrepareTable(locrecAllObjWithCaption."Object ID");
        CurrPage.Update(false);
    end;

    procedure ChangeCaptionName();
    begin
        booUseCaptionName := not booUseCaptionName;
        CurrPage.Update(false);
    end;

    procedure PrepareTable(parintTableNo: Integer);
    begin
        Clear(Rec);
        SetFilter(Number, '%1..', 1);
        Clear(intLastRecNo);

        rrTable.Close();
        rrTable.Open(parintTableNo);
        tmprrTable.Close();
        tmprrTable.Open(parintTableNo, true);
        tmprrTable.Reset();
        tmprrTable.DeleteAll(false);

        intTableNo := rrTable.Number();
        intRecCount := rrTable.Count();
        txtTableName := rrTable.Name();
        txtTableCaption := rrTable.Caption();

        PopulateFieldsTable(parintTableNo);
    end;

    local procedure PopulateFieldsTable(parintTableNo: Integer);
    var
        locrecFields: Record Field;
    begin
        Clear(tmprecFields);
        tmprecFields.DeleteAll(false);
        locrecFields.setrange(TableNo, parintTableNo);
        locrecFields.FindSet();
        repeat
            tmprecFields := locrecFields;
            tmprecFields.Insert(false);
        until locrecFields.Next() = 0;
    end;

    local procedure GetFieldFromIndex(parintFieldIndex: Integer): Boolean;
    begin
        Clear(tmprecFields);
        if parintFieldIndex > tmprecfields.Count() then
            exit(false);
        if tmprecFields.Next(parintFieldIndex) = parintFieldIndex then
            exit(true);
        clear(tmprecFields);
    end;

    local procedure GetFieldHeader(parintTableNo: Integer; parintFieldIndex: Integer): Text;
    begin
        if not GetFieldFromIndex(parintFieldIndex) then
            exit(StrSubstNo('(%1)', parintFieldIndex));
        if booUseCaptionName then
            exit(tmprecFields."Field Caption")
        else
            exit(tmprecFields.FieldName);
    end;

    local procedure GetFieldVisible(parintTableNo: Integer; parintFieldIndex: Integer): Boolean;
    begin
        if GetFieldFromIndex(parintFieldIndex) then
            exit(tmprecFields.Enabled);
    end;

    local procedure GetFieldValue(parintTableNo: Integer; parintFieldIndex: Integer; parintRecNo: Integer): Text;
    var
        locrecField: record Field;
        frField: FieldRef;
        frFieldFrom: FieldRef;
        frFieldTo: FieldRef;
        locintNext: Integer;
        locintNextResult: Integer;
    begin
        if not GetFieldFromIndex(parintFieldIndex) then
            exit('');

        locrecField := tmprecFields;
        locintNext := parintRecNo - intLastRecNo;
        locintNextResult := tmprrTable.Next(locintNext);
        if locintNextResult <> locintNext then begin
            locintnextResult := rrTable.Next(locintNext);
            if locintnextResult = locintNext then begin
                tmprecfields.Reset();
                tmprecFields.SetRange(Enabled, true);
                tmprecfields.FindSet();
                repeat
                    frFieldFrom := rrTable.Field(tmprecfields."No.");
                    frFieldTo := tmprrTable.Field(tmprecfields."No.");
                    if (tmprecFields.Class = tmprecFields.Class::FlowField) or (tmprecFields.Type = tmprecFields.Type::BLOB) then
                        frFieldFrom.CalcField();
                    frFieldTo.Value := frFieldFrom.Value();
                until tmprecFields.Next() = 0;
                tmprrTable.Insert(false);
                tmprecFields.Reset();
            end else begin
                SetRange(Number, 1, parintRecNo - 1);
                exit('');
            end;
        end;
        frField := tmprrTable.FieldIndex(parintFieldIndex);
        intLastRecNo := parintRecNo;
        tmprecFields := locrecField;
        exit(format(frField.Value()));
    end;

}
