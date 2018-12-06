xmlport 50000 "TTTPR Nav2BcImportData"
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
            tableelement("TTTPR Nav2BcData"; "TTTPR Nav2BcData")
            {
                XmlName = 'Import';
                fieldelement(Company; "TTTPR Nav2BcData"."TTTPR Company")
                {
                }
                fieldelement(TableNo; "TTTPR Nav2BcData"."TTTPR TableNo")
                {
                    MinOccurs = Zero;
                }
                fieldelement(RecordNo; "TTTPR Nav2BcData"."TTTPR RecordNo")
                {
                    MinOccurs = Zero;
                }
                fieldelement(FieldNo; "TTTPR Nav2BcData"."TTTPR FieldNo")
                {
                    MinOccurs = Zero;
                }
                fieldelement(FieldType; "TTTPR Nav2BcData"."TTTPR FieldType")
                {
                    MinOccurs = Zero;
                }
                fieldelement(FieldLength; "TTTPR Nav2BcData"."TTTPR FieldLength")
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
                        IF STRLEN(FieldValue) <= MAXSTRLEN("TTTPR Nav2BcData"."TTTPR FieldValue") THEN
                            "TTTPR Nav2BcData"."TTTPR FieldValue" := FieldValue
                        ELSE BEGIN
                            "TTTPR Nav2BcData"."TTTPR BlobValue".CREATEOUTSTREAM(locstrmOut);
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
                    "TTTPR Nav2BcData"."TTTPR TemplateCode" := codTemplate;
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
        lblPostMessageLbl: Label 'Count %1\Time %2';

    procedure SetTemplateCode(parcodTemplateCode: Text)
    begin
        codTemplate := CopyStr(parcodTemplateCode, 1, MaxStrLen(codTemplate));
    end;
}
