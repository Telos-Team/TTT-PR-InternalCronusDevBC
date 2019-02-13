codeunit 50015 "TTT-PR Nav2BcManagement"
{
    Description = 'TTTPR Nav2Bc Management';
    Subtype = Normal;

    trigger OnRun()
    begin
    end;

    procedure ImportData(parrecTempl: Record "TTT-PR Nav2BcTemplate")
    var
        locxmlImport: XmlPort "TTT-PR Nav2BcImportData";
        locstrmIn: InStream;
        locbooOK: Boolean;
        locdlgWindow: Dialog;
        loctxtClientFilename: Text;
        loclblActionLbl: Label 'Action: #1############################\File: #2############################\Action: #3############################';
        loclblUploadingLbl: Label 'Uploading data...';
        loclblImportingLbl: Label 'Importing data...';
    begin
        if GuiAllowed() then begin
            locdlgWindow.Open(loclblActionLbl);
            locdlgWindow.Update(1, loclblUploadingLbl);
        end;

        locbooOK := UploadIntoStream('Select a file to upload', '', '', loctxtClientFilename, locstrmIn);
        if GuiAllowed() then
            locdlgWindow.Update(1, loclblUploadingLbl);
        while locbooOK do begin
            if GuiAllowed() then begin
                locdlgWindow.Update(1, '');
                locdlgWindow.Update(2, loctxtClientFilename);
                locdlgWindow.Update(3, loclblImportingLbl);
            end;
            locxmlImport.SetTemplateCode(parrecTempl."TTT-PR Code");
            locxmlImport.TextEncoding(TextEncoding::MSDos);
            locxmlImport.SetSource(locstrmIn);
            locbooOK := locxmlImport.Import();
            Commit();
            if GuiAllowed() then begin
                locdlgWindow.Update(1, loclblUploadingLbl);
                locdlgWindow.Update(3, '');
            end;
            locbooOK := UploadIntoStream('Select a file to upload', '', '', loctxtClientFilename, locstrmIn);
        end;

        locdlgWindow.Close();
    end;

    procedure SplitData(parrecTempl: Record "TTT-PR Nav2BcTemplate")
    var
        locrecTempl: Record "TTT-PR Nav2BcTemplate";
        locrecData: Record "TTT-PR Nav2BcData";
        locrecData2: Record "TTT-PR Nav2BcData";
        locrecAllObj: Record AllObjWithCaption;
        loccuTiming: Codeunit "TTT-PR Nav2BcTiming";
        locdlgWindow: Dialog;
        loclblActionLbl: Label 'Action: #1############################\Company: #2############################\Table: #3############################';
        loclblSplittingLbl: Label 'Splitting data...';
    begin
        loccuTiming.StartTimer();
        locrecData.SetRange("TTT-PR TemplateCode", parrecTempl."TTT-PR Code");
        locrecData.FindSet();
        if GuiAllowed() then begin
            locdlgWindow.Open(loclblActionLbl);
            locdlgWindow.Update(1, loclblSplittingLbl);
        end;
        repeat
            if not locrecTempl.Get(StrSubstNo('%1%2', locrecData."TTT-PR TemplateCode", locrecData."TTT-PR TableNo")) then begin
                if GuiAllowed() then begin
                    locdlgWindow.Update(2, locrecData."TTT-PR Company");
                    locdlgWindow.Update(3, locrecData."TTT-PR TableNo");
                end;
                locrecTempl.Init();
                locrecTempl.Validate("TTT-PR Code", StrSubstNo('%1%2', locrecData."TTT-PR TemplateCode", locrecData."TTT-PR TableNo"));
                if locrecAllObj.Get(locrecAllObj."Object Type"::Table, locrecData."TTT-PR TableNo") then
                    locrectempl."TTT-PR Description" := locrecAllObj."Object Name";
                locrecTempl.Insert(true);
            end;
            locrecData2 := locrecData;
            locrecData2."TTT-PR TemplateCode" := locrectempl."TTT-PR Code";
            locrecData2.Insert();
        until locrecData.Next() = 0;
        if GuiAllowed() then
            locdlgWindow.Close();
        loccuTiming.ShowDuration();
    end;

    procedure InsertData(var parvarrecTempl: Record "TTT-PR Nav2BcTemplate")
    var
        locrecData: Record "TTT-PR Nav2BcData";
        locrecAllObj: Record AllObjWithCaption;
        locrrTable: RecordRef;
        locfrField: FieldRef;
        locdfEmpty: DateFormula;
        locintLastTableNo: Integer;
        locintLastRecordNo: Integer;
        locintEmpty: Integer;
        locdecEmpty: Decimal;
        locbooEmpty: Boolean;
        locdatEmpty: Date;
        loctimEmpty: Time;
        locdtEmpty: DateTime;
    begin
        locrecData.SetRange("TTT-PR TemplateCode", parvarrecTempl."TTT-PR Code");
        if parvarrecTempl.GetFilter("TTT-PR CompanyFilter") <> '' then
            locrecData.SetFilter("TTT-PR Company", parvarrecTempl.GetFilter("TTT-PR CompanyFilter"));
        locrecData.SetFilter("TTT-PR RecordNo", '>%1', 0);
        locrecData.FindSet();
        repeat
            if locrecAllObj.Get(locrecAllObj."Object Type"::Table, locrecData."TTT-PR TableNo") then begin
                if (locrecData."TTT-PR TableNo" <> locintLastTableNo) or (locrecData."TTT-PR RecordNo" <> locintLastRecordNo) then begin
                    if locintLastRecordNo <> 0 then
                        if locrrTable.Insert(false) then;
                    locintLastTableNo := locrecData."TTT-PR TableNo";
                    locintLastRecordNo := locrecData."TTT-PR RecordNo";
                    locrrTable.Close();
                    locrrTable.Open(locrecData."TTT-PR TableNo");
                end;
                if locrrTable.FieldExist(locrecData."TTT-PR FieldNo") then begin
                    locfrField := locrrTable.Field(locrecData."TTT-PR FieldNo");
                    case locfrField.Type() of
                        fieldtype::Code:
                            locfrField.Value := locrecData."TTT-PR FieldValue";
                        fieldtype::Text:
                            locfrField.Value := locrecData."TTT-PR FieldValue";
                        fieldtype::Integer,
                        fieldtype::Option:
                            begin
                                evaluate(locintEmpty, locrecData."TTT-PR FieldValue");
                                locfrField.Value := locintEmpty;
                            end;
                        fieldtype::Decimal:
                            begin
                                evaluate(locdecEmpty, locrecData."TTT-PR FieldValue");
                                locfrField.Value := locdecEmpty;
                            end;
                        fieldtype::Date:
                            begin
                                evaluate(locdatEmpty, locrecData."TTT-PR FieldValue");
                                locfrField.Value := locdatEmpty;
                            end;
                        fieldtype::Time:
                            begin
                                evaluate(loctimEmpty, locrecData."TTT-PR FieldValue");
                                locfrField.Value := loctimEmpty;
                            end;
                        fieldtype::DateTime:
                            begin
                                evaluate(locdtEmpty, locrecData."TTT-PR FieldValue");
                                locfrField.Value := locdtEmpty;
                            end;
                        fieldtype::DateFormula:
                            begin
                                evaluate(locdfEmpty, locrecData."TTT-PR FieldValue");
                                locfrField.Value := locdfEmpty;
                            end;
                        fieldtype::Boolean:
                            begin
                                evaluate(locbooEmpty, locrecData."TTT-PR FieldValue");
                                locfrField.Value := locbooEmpty;
                            end;
                        else
                            Error('Unmanaged field type: %1 %2 %3 %4 %5', locrecData."TTT-PR TableNo", locrecdata."TTT-PR RecordNo", locrecData."TTT-PR FieldNo", locfrField.Type());
                    end;
                end;
            end;
        until locrecData.Next() = 0;
        if locrrTable.Insert(false) then;
    end;

    procedure ShowData(parrecTempl: Record "TTT-PR Nav2BcTemplate")
    var
        locrecData: Record "TTT-PR Nav2BcData";
        loctmprecRecords: Record "TTT-PR Nav2BcRecord" temporary;
        locintRecCount: Integer;
        i: Integer;
    begin
        locrecData.SetRange("TTT-PR TemplateCode", parrecTempl."TTT-PR Code");
        if not locrecData.FindLast() then
            exit;
        locintRecCount := locrecData."TTT-PR RecordNo";
        for i := 1 to locintRecCount do begin
            loctmprecRecords.Init();
            loctmprecRecords."TTT-PR TemplateCode" := locrecData."TTT-PR TemplateCode";
            loctmprecRecords."TTT-PR Company" := locrecData."TTT-PR Company";
            loctmprecRecords."TTT-PR TableNo" := locrecData."TTT-PR TableNo";
            loctmprecRecords."TTT-PR RecordNo" := i;
            loctmprecRecords.Insert(false);
        end;
        loctmprecRecords.FindSet();
        page.Run(0, loctmprecRecords);
    end;
}