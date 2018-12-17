table 50013 "TTTPR Nav2BcRecord"
{
    Description = 'TTTPR Nav2BC Record';
    Caption = 'Nav2BC Record';
    DataCaptionFields = "TTTPR Company", "TTTPR TableNo", "TTTPR RecordNo";
    DataClassification = CustomerContent;
    LookupPageId = "TTTPR Nav2BcRecords";
    DrillDownPageId = "TTTPR Nav2BcRecords";

    fields
    {
        field(1; "TTTPR TemplateCode"; Code[20])
        {
            Caption = 'Template Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "TTTPR Nav2BcTemplate";
        }
        field(2; "TTTPR Company"; Text[30])
        {
            Caption = 'Company';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(3; "TTTPR TableNo"; Integer)
        {
            Caption = 'Table No.';
            NotBlank = true;
            DataClassification = SystemMetadata;
        }
        field(4; "TTTPR RecordNo"; Integer)
        {
            Caption = 'Record No.';
            NotBlank = true;
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "TTTPR TemplateCode", "TTTPR Company", "TTTPR TableNo", "TTTPR RecordNo")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure GetFieldValue(parintFieldNo: Integer): Text
    var
        locrecData: Record "TTTPR Nav2BcData";
    begin
        locrecData.SetRange("TTTPR TemplateCode", "TTTPR TemplateCode");
        locrecData.SetRange("TTTPR Company", "TTTPR Company");
        locrecData.SetRange("TTTPR RecordNo", "TTTPR RecordNo");
        if locrecData.FindFirst() then
            if parintFieldNo > 1 then
                if locrecdata.Next(parintFieldNo - 1) <> parintFieldNo - 1 then
                    exit('');
        exit(locrecData."TTTPR FieldValue");
    end;

    procedure GetFieldHeader(parintFieldNo: Integer): Text
    var
        locrecData: Record "TTTPR Nav2BcData";
    begin
        locrecData.SetRange("TTTPR TemplateCode", "TTTPR TemplateCode");
        locrecData.SetRange("TTTPR Company", "TTTPR Company");
        locrecData.SetRange("TTTPR RecordNo", 0);
        if locrecData.FindFirst() then
            if parintFieldNo > 1 then
                if locrecdata.Next(parintFieldNo - 1) <> parintFieldNo - 1 then
                    exit('');
        exit(locrecData."TTTPR FieldValue");
    end;

    procedure GetFieldVisible(parintFieldNo: Integer): Boolean
    begin
        exit(GetFieldHeader(parintFieldNo) <> '');
    end;
}
