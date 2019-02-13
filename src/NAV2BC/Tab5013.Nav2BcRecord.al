table 50013 "TTT-PR Nav2BcRecord"
{
    Description = 'TTTPR Nav2BC Record';
    Caption = 'Nav2BC Record';
    DataCaptionFields = "TTT-PR Company", "TTT-PR TableNo", "TTT-PR RecordNo";
    DataClassification = CustomerContent;
    LookupPageId = "TTT-PR Nav2BcRecords";
    DrillDownPageId = "TTT-PR Nav2BcRecords";

    fields
    {
        field(1; "TTT-PR TemplateCode"; Code[20])
        {
            Caption = 'Template Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "TTT-PR Nav2BcTemplate";
        }
        field(2; "TTT-PR Company"; Text[30])
        {
            Caption = 'Company';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(3; "TTT-PR TableNo"; Integer)
        {
            Caption = 'Table No.';
            NotBlank = true;
            DataClassification = SystemMetadata;
        }
        field(4; "TTT-PR RecordNo"; Integer)
        {
            Caption = 'Record No.';
            NotBlank = true;
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "TTT-PR TemplateCode", "TTT-PR Company", "TTT-PR TableNo", "TTT-PR RecordNo")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure GetFieldValue(parintFieldNo: Integer): Text
    var
        locrecData: Record "TTT-PR Nav2BcData";
    begin
        locrecData.SetRange("TTT-PR TemplateCode", "TTT-PR TemplateCode");
        locrecData.SetRange("TTT-PR Company", "TTT-PR Company");
        locrecData.SetRange("TTT-PR RecordNo", "TTT-PR RecordNo");
        if locrecData.FindFirst() then
            if parintFieldNo > 1 then
                if locrecdata.Next(parintFieldNo - 1) <> parintFieldNo - 1 then
                    exit('');
        exit(locrecData."TTT-PR FieldValue");
    end;

    procedure GetFieldHeader(parintFieldNo: Integer): Text
    var
        locrecData: Record "TTT-PR Nav2BcData";
    begin
        locrecData.SetRange("TTT-PR TemplateCode", "TTT-PR TemplateCode");
        locrecData.SetRange("TTT-PR Company", "TTT-PR Company");
        locrecData.SetRange("TTT-PR RecordNo", 0);
        if locrecData.FindFirst() then
            if parintFieldNo > 1 then
                if locrecdata.Next(parintFieldNo - 1) <> parintFieldNo - 1 then
                    exit('');
        exit(locrecData."TTT-PR FieldValue");
    end;

    procedure GetFieldVisible(parintFieldNo: Integer): Boolean
    begin
        exit(GetFieldHeader(parintFieldNo) <> '');
    end;
}
