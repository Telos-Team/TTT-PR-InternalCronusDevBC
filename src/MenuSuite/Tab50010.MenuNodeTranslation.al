table 50010 TTTPRMenuNodeTranslation
{
    Caption = 'TTTPR Menu Node Translation';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; MenuSuiteCode; Code[20])
        {
            Caption = 'Menu Suite Code';
            DataClassification = SystemMetadata;
            TableRelation = TTTPRMenuSuite.Code;
            ValidateTableRelation = true;
        }

        field(2; MenuNodeId; Guid)
        {
            Caption = 'Menu Node Id';
            DataClassification = SystemMetadata;
            TableRelation = TTTPRMenuNode.Id WHERE (MenuSuiteCode = FIELD (MenuSuiteCode));
            ValidateTableRelation = true;
        }

        field(3; Language; Code[20])
        {
            Caption = 'Language';
            DataClassification = SystemMetadata;
        }

    }

    keys
    {
        key(PK; MenuSuiteCode, MenuNodeId, Language)
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