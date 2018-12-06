table 50011 "TTTPR Nav2BcData"
{
    Description = 'TTTPR Nav2BC Data';
    Caption = 'Nav2BC Data';
    DataCaptionFields = "TTTPR Company", "TTTPR TableNo", "TTTPR RecordNo", "TTTPR FieldNo";
    DataClassification = CustomerContent;

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
        field(5; "TTTPR FieldNo"; Integer)
        {
            Caption = 'Field No.';
            NotBlank = true;
            DataClassification = SystemMetadata;
        }
        field(6; "TTTPR FieldType"; Text[30])
        {
            Caption = 'Field Type';
            DataClassification = SystemMetadata;
        }
        field(7; "TTTPR FieldLength"; Integer)
        {
            Caption = 'Field Length';
            DataClassification = SystemMetadata;
        }
        field(8; "TTTPR FieldValue"; Text[80])
        {
            Caption = 'Field Value';
            DataClassification = CustomerContent;
        }
        field(9; "TTTPR BlobValue"; BLOB)
        {
            Caption = 'Blob Value';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "TTTPR TemplateCode", "TTTPR Company", "TTTPR TableNo", "TTTPR RecordNo", "TTTPR FieldNo")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}
