table 50010 "TTTPR MenuNodeTranslation"
{
    Caption = 'TTTPR Menu Node Translation';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "TTTPR MenuSuiteCode"; Code[20])
        {
            Caption = 'Menu Suite Code';
            DataClassification = SystemMetadata;
            TableRelation = "TTTPR MenuSuite"."TTTPR Code";
            ValidateTableRelation = true;
        }

        field(2; "TTTPR MenuNodeId"; Guid)
        {
            Caption = 'Menu Node Id';
            DataClassification = SystemMetadata;
            TableRelation = "TTTPR MenuNode"."TTTPR Id" WHERE ("TTTPR MenuSuiteCode" = FIELD ("TTTPR MenuSuiteCode"));
            ValidateTableRelation = true;
        }

        field(3; "TTTPR Language"; Code[20])
        {
            Caption = 'Language';
            DataClassification = SystemMetadata;
        }

    }

    keys
    {
        key(PK; "TTTPR MenuSuiteCode", "TTTPR MenuNodeId", "TTTPR Language")
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