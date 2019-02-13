xmlport 50000 "TTT-PR Nav2BcImportData"
{
    Description = 'TTTPR Nav2Bc Import Data';
    Caption = 'Nav2Bc Import Data';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("TTT-PR Nav2BcData"; "TTT-PR Nav2BcData")
            {
                XmlName = 'Import';
                fieldelement(Company; "TTT-PR Nav2BcData"."TTT-PR Company")
                {
                }
                fieldelement(TableNo; "TTT-PR Nav2BcData"."TTT-PR TableNo")
                {
                    MinOccurs = Zero;
                }
                fieldelement(RecordNo; "TTT-PR Nav2BcData"."TTT-PR RecordNo")
                {
                    MinOccurs = Zero;
                }
                fieldelement(FieldNo; "TTT-PR Nav2BcData"."TTT-PR FieldNo")
                {
                    MinOccurs = Zero;
                }
                fieldelement(FieldType; "TTT-PR Nav2BcData"."TTT-PR FieldType")
                {
                    MinOccurs = Zero;
                }
                fieldelement(FieldLength; "TTT-PR Nav2BcData"."TTT-PR FieldLength")
                {
                    MinOccurs = Zero;
                }
                textelement(FieldValue)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    var
                        locstrmOut: OutStream;
                    begin
                        IF STRLEN(FieldValue) <= MAXSTRLEN("TTT-PR Nav2BcData"."TTT-PR FieldValue") THEN
                            "TTT-PR Nav2BcData"."TTT-PR FieldValue" := FieldValue
                        ELSE BEGIN
                            "TTT-PR Nav2BcData"."TTT-PR BlobValue".CREATEOUTSTREAM(locstrmOut);
                            locstrmOut.WRITE(FieldValue);
                        END;
                    end;
                }

                trigger OnAfterInsertRecord()
                begin
                    intCount += 1;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    "TTT-PR Nav2BcData"."TTT-PR TemplateCode" := codTemplate;
                end;
            }
        }
    }

    trigger OnPostXmlPort()
    begin
        dtFinish := CURRENTDATETIME();
        durTime := dtFinish - dtStart;
        if GuiAllowed() then
            MESSAGE(lblPostMessageLbl, intCount, durTime);
    end;

    trigger OnPreXmlPort()
    begin
        dtStart := CURRENTDATETIME();
    end;

    var
        intCount: Integer;
        codTemplate: Code[20];
        dtStart: DateTime;
        dtFinish: DateTime;
        durTime: Duration;
        lblPostMessageLbl: Label 'Import count: %1\Time: %2';

    procedure SetTemplateCode(parcodTemplateCode: Text)
    begin
        codTemplate := CopyStr(parcodTemplateCode, 1, MaxStrLen(codTemplate));
    end;
}
