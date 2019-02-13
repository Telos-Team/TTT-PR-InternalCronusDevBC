table 50010 "TTT-PR MenuNodeTranslation"
{
    Caption = 'TTTPR Menu Node Translation';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "TTT-PR MenuSuiteCode"; Code[20])
        {
            Caption = 'Menu Suite Code';
            DataClassification = SystemMetadata;
            TableRelation = "TTT-PR MenuSuite"."TTT-PR Code";
            ValidateTableRelation = true;
        }

        field(2; "TTT-PR MenuNodeId"; Guid)
        {
            Caption = 'Menu Node Id';
            DataClassification = SystemMetadata;
            TableRelation = "TTT-PR MenuNode"."TTT-PR Id" WHERE ("TTT-PR MenuSuiteCode" = FIELD ("TTT-PR MenuSuiteCode"));
            ValidateTableRelation = true;
        }

        field(3; "TTT-PR Language"; Code[20])
        {
            Caption = 'Language';
            DataClassification = SystemMetadata;
        }

    }

    keys
    {
        key(PK; "TTT-PR MenuSuiteCode", "TTT-PR MenuNodeId", "TTT-PR Language")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;

}