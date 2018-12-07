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
        loctxtClientFilename: Text;
        locstrmIn: InStream;
        locbooOK: Boolean;
        locdlgWindow: Dialog;
        loclblActionLbl: Label 'Action: #1############################\Action: #2############################';
        loclblUploadingLbl: Label 'Uploading data...';
        loclblImportingLbl: Label 'Importing data...';
    begin
        locdlgWindow.Open(loclblActionLbl);
        locdlgWindow.Update(1, loclblUploadingLbl);
        loctxtClientFilename := 'C:\Data\Temp\Nav2Bc.txt';
        locbooOK := UploadIntoStream('Select a file to upload', '', '', loctxtClientFilename, locstrmIn);

        locdlgWindow.Update(2, loclblImportingLbl);
        locxmlImport.SetTemplateCode(parrecTempl."TTTPR Code");
        locxmlImport.TextEncoding(TextEncoding::MSDos);
        locxmlImport.SetSource(locstrmIn);
        locxmlImport.Import();

        locdlgWindow.Close();
    end;

    procedure SplitData(parrecTempl: Record "TTTPR Nav2BcTemplate")
    var
        locrecTempl: Record "TTTPR Nav2BcTemplate";
        locrecData: Record "TTTPR Nav2BcData";
        locrecData2: Record "TTTPR Nav2BcData";
    begin
        locrecData.SetRange("TTTPR TemplateCode", parrecTempl."TTTPR Code");
        locrecData.FindSet();
        repeat
            if not locrecTempl.Get(StrSubstNo('%1%2', locrecData."TTTPR TemplateCode", locrecData."TTTPR TableNo")) then begin
                locrecTempl.Init();
                locrecTempl.Validate("TTTPR Code", StrSubstNo('%1%2', locrecData."TTTPR TemplateCode", locrecData."TTTPR TableNo"));
                locrecTempl.Insert(true);
            end;
            locrecData2 := locrecData;
            locrecData2."TTTPR TemplateCode" := locrectempl."TTTPR Code";
            locrecData2.Insert();
        until locrecData.Next() = 0;
    end;

    procedure InsertData(parrecTempl: Record "TTTPR Nav2BcTemplate")
    var
        locrecData: Record "TTTPR Nav2BcData";
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
        locrecData.SetRange("TTTPR TemplateCode", parrecTempl."TTTPR Code");
        locrecData.FindSet();
        repeat
            if (locrecData."TTTPR TableNo" <> locintLastTableNo) or (locrecData."TTTPR RecordNo" <> locintLastRecordNo) then begin
                if locintLastRecordNo <> 0 then
                    locrrTable.Insert(false);
                locintLastTableNo := locrecData."TTTPR TableNo";
                locintLastRecordNo := locrecData."TTTPR RecordNo";
                locrrTable.Close();
                locrrTable.Open(locrecData."TTTPR TableNo");
            end;
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
        until locrecData.Next() = 0;
    end;
}