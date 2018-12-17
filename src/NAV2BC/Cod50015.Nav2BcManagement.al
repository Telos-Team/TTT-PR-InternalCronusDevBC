codeunit 50015 "TTTPR Nav2BcManagement"
{
    Description = 'TTTPR Nav2Bc Management';
    Subtype = Normal;

    trigger OnRun()
    begin
    end;

    procedure ImportData(parrecTempl: Record "TTTPR Nav2BcTemplate")
    var
        locxmlImport: XmlPort "TTTPR Nav2BcImportData";
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
            locxmlImport.SetTemplateCode(parrecTempl."TTTPR Code");
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

    procedure SplitData(parrecTempl: Record "TTTPR Nav2BcTemplate")
    var
        locrecTempl: Record "TTTPR Nav2BcTemplate";
        locrecData: Record "TTTPR Nav2BcData";
        locrecData2: Record "TTTPR Nav2BcData";
        locrecAllObj: Record AllObjWithCaption;
        loccuTiming: Codeunit "TTTPR Nav2BcTiming";
        locdlgWindow: Dialog;
        loclblActionLbl: Label 'Action: #1############################\Company: #2############################\Table: #3############################';
        loclblSplittingLbl: Label 'Splitting data...';
    begin
        loccuTiming.StartTimer();
        locrecData.SetRange("TTTPR TemplateCode", parrecTempl."TTTPR Code");
        locrecData.FindSet();
        if GuiAllowed() then begin
            locdlgWindow.Open(loclblActionLbl);
            locdlgWindow.Update(1, loclblSplittingLbl);
        end;
        repeat
            if not locrecTempl.Get(StrSubstNo('%1%2', locrecData."TTTPR TemplateCode", locrecData."TTTPR TableNo")) then begin
                if GuiAllowed() then begin
                    locdlgWindow.Update(2, locrecData."TTTPR Company");
                    locdlgWindow.Update(3, locrecData."TTTPR TableNo");
                end;
                locrecTempl.Init();
                locrecTempl.Validate("TTTPR Code", StrSubstNo('%1%2', locrecData."TTTPR TemplateCode", locrecData."TTTPR TableNo"));
                if locrecAllObj.Get(locrecAllObj."Object Type"::Table, locrecData."TTTPR TableNo") then
                    locrectempl."TTTPR Description" := locrecAllObj."Object Name";
                locrecTempl.Insert(true);
            end;
            locrecData2 := locrecData;
            locrecData2."TTTPR TemplateCode" := locrectempl."TTTPR Code";
            locrecData2.Insert();
        until locrecData.Next() = 0;
        if GuiAllowed() then
            locdlgWindow.Close();
        loccuTiming.ShowDuration();
    end;

    procedure InsertData(var parvarrecTempl: Record "TTTPR Nav2BcTemplate")
    var
        locrecData: Record "TTTPR Nav2BcData";
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
        locrecData.SetRange("TTTPR TemplateCode", parvarrecTempl."TTTPR Code");
        if parvarrecTempl.GetFilter("TTTPR CompanyFilter") <> '' then
            locrecData.SetFilter("TTTPR Company", parvarrecTempl.GetFilter("TTTPR CompanyFilter"));
        locrecData.SetFilter("TTTPR RecordNo", '>%1', 0);
        locrecData.FindSet();
        repeat
            if locrecAllObj.Get(locrecAllObj."Object Type"::Table, locrecData."TTTPR TableNo") then begin
                if (locrecData."TTTPR TableNo" <> locintLastTableNo) or (locrecData."TTTPR RecordNo" <> locintLastRecordNo) then begin
                    if locintLastRecordNo <> 0 then
                        if locrrTable.Insert(false) then;
                    locintLastTableNo := locrecData."TTTPR TableNo";
                    locintLastRecordNo := locrecData."TTTPR RecordNo";
                    locrrTable.Close();
                    locrrTable.Open(locrecData."TTTPR TableNo");
                end;
                if locrrTable.FieldExist(locrecData."TTTPR FieldNo") then begin
                    locfrField := locrrTable.Field(locrecData."TTTPR FieldNo");
                    case locfrField.Type() of
                        fieldtype::Code:
                            locfrField.Value := locrecData."TTTPR FieldValue";
                        fieldtype::Text:
                            locfrField.Value := locrecData."TTTPR FieldValue";
                        fieldtype::Integer,
                        fieldtype::Option:
                            begin
                                evaluate(locintEmpty, locrecData."TTTPR FieldValue");
                                locfrField.Value := locintEmpty;
                            end;
                        fieldtype::Decimal:
                            begin
                                evaluate(locdecEmpty, locrecData."TTTPR FieldValue");
                                locfrField.Value := locdecEmpty;
                            end;
                        fieldtype::Date:
                            begin
                                evaluate(locdatEmpty, locrecData."TTTPR FieldValue");
                                locfrField.Value := locdatEmpty;
                            end;
                        fieldtype::Time:
                            begin
                                evaluate(loctimEmpty, locrecData."TTTPR FieldValue");
                                locfrField.Value := loctimEmpty;
                            end;
                        fieldtype::DateTime:
                            begin
                                evaluate(locdtEmpty, locrecData."TTTPR FieldValue");
                                locfrField.Value := locdtEmpty;
                            end;
                        fieldtype::DateFormula:
                            begin
                                evaluate(locdfEmpty, locrecData."TTTPR FieldValue");
                                locfrField.Value := locdfEmpty;
                            end;
                        fieldtype::Boolean:
                            begin
                                evaluate(locbooEmpty, locrecData."TTTPR FieldValue");
                                locfrField.Value := locbooEmpty;
                            end;
                        else
                            Error('Unmanaged field type: %1 %2 %3 %4 %5', locrecData."TTTPR TableNo", locrecdata."TTTPR RecordNo", locrecData."TTTPR FieldNo", locfrField.Type());
                    end;
                end;
            end;
        until locrecData.Next() = 0;
        if locrrTable.Insert(false) then;
    end;

    procedure ShowData(parrecTempl: Record "TTTPR Nav2BcTemplate")
    var
        locrecData: Record "TTTPR Nav2BcData";
        loctmprecRecords: Record "TTTPR Nav2BcRecord" temporary;
        locintRecCount: Integer;
        i: Integer;
    begin
        locrecData.SetRange("TTTPR TemplateCode", parrecTempl."TTTPR Code");
        if not locrecData.FindLast() then
            exit;
        locintRecCount := locrecData."TTTPR RecordNo";
        for i := 1 to locintRecCount do begin
            loctmprecRecords.Init();
            loctmprecRecords."TTTPR TemplateCode" := locrecData."TTTPR TemplateCode";
            loctmprecRecords."TTTPR Company" := locrecData."TTTPR Company";
            loctmprecRecords."TTTPR TableNo" := locrecData."TTTPR TableNo";
            loctmprecRecords."TTTPR RecordNo" := i;
            loctmprecRecords.Insert(false);
        end;
        loctmprecRecords.FindSet();
        page.Run(0, loctmprecRecords);
    end;
}