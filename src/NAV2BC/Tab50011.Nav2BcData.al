table 50011 "TTT-PR Nav2BcData"
{
    Description = 'TTTPR Nav2BC Data';
    Caption = 'Nav2BC Data';
    DataCaptionFields = "TTT-PR Company", "TTT-PR TableNo", "TTT-PR RecordNo", "TTT-PR FieldNo";
    DataClassification = CustomerContent;
    LookupPageId = "TTT-PR Nav2BcData";
    DrillDownPageId = "TTT-PR Nav2BcData";

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
        field(5; "TTT-PR FieldNo"; Integer)
        {
            Caption = 'Field No.';
            NotBlank = true;
            DataClassification = SystemMetadata;
        }
        field(6; "TTT-PR FieldType"; Text[30])
        {
            Caption = 'Field Type';
            DataClassification = SystemMetadata;
        }
        field(7; "TTT-PR FieldLength"; Integer)
        {
            Caption = 'Field Length';
            DataClassification = SystemMetadata;
        }
        field(8; "TTT-PR FieldValue"; Text[80])
        {
            Caption = 'Field Value';
            DataClassification = CustomerContent;
        }
        field(9; "TTT-PR BlobValue"; BLOB)
        {
            Caption = 'Blob Value';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "TTT-PR TemplateCode", "TTT-PR Company", "TTT-PR TableNo", "TTT-PR RecordNo", "TTT-PR FieldNo")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}
