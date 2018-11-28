table 50009 "TTTPR MenuNode"
{
    Caption = 'TTTPR Menu Node';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "TTTPR MenuSuiteCode"; Code[20])
        {
            Caption = 'Menu Suite Code';
            DataClassification = SystemMetadata;
        }

        field(2; "TTTPR Id"; Guid)
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }

        field(3; "TTTPR Type"; Option)
        {
            Caption = 'Type';
            DataClassification = SystemMetadata;
            OptionMembers = Root,Menu,Group,Item;
        }

        field(4; "TTTPR Name"; Text[50])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }

        field(10; "TTTPR FirstChild"; Guid)
        {
            Caption = 'First Child';
            DataClassification = SystemMetadata;
            TableRelation = "TTTPR MenuNode"."TTTPR Id" WHERE ("TTTPR MenuSuiteCode" = FIELD ("TTTPR MenuSuiteCode"));
            ValidateTableRelation = true;
        }

        field(11; "TTTPR ParentNodeId"; Guid)
        {
            Caption = 'Parent Node Id';
            DataClassification = SystemMetadata;
            TableRelation = "TTTPR MenuNode"."TTTPR Id" WHERE ("TTTPR MenuSuiteCode" = FIELD ("TTTPR MenuSuiteCode"));
            ValidateTableRelation = true;
        }

        field(12; "TTTPR NextNodeId"; Guid)
        {
            Caption = 'Next Node Id';
            DataClassification = SystemMetadata;
            TableRelation = "TTTPR MenuNode"."TTTPR Id" WHERE ("TTTPR MenuSuiteCode" = FIELD ("TTTPR MenuSuiteCode"));
            ValidateTableRelation = true;
        }

        field(13; "TTTPR MemberOfMenu"; Guid)
        {
            Caption = 'Member of Menu';
            DataClassification = SystemMetadata;
            TableRelation = "TTTPR MenuNode"."TTTPR Id" WHERE ("TTTPR MenuSuiteCode" = FIELD ("TTTPR MenuSuiteCode"));
            ValidateTableRelation = true;
        }

        field(20; "TTTPR RunObjectType"; Option)
        {
            Caption = 'Run Object Type';
            DataClassification = SystemMetadata;
            OptionMembers = Page,Codeunit,XmlPort,Report;
        }

        field(21; "TTTPR RunObjectId"; Integer)
        {
            Caption = 'Run Object Id';
            DataClassification = SystemMetadata;
        }

        field(30; "TTTPR Visible"; Boolean)
        {
            Caption = 'Visible';
            DataClassification = SystemMetadata;
        }

        field(31; "TTTPR Enabled"; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = SystemMetadata;
        }

        field(40; "TTTPR ApplicationArea"; Text[30])
        {
            Caption = 'Application Area';
            DataClassification = SystemMetadata;
        }

        field(41; "TTTPR DepartmentCategory"; Text[30])
        {
            Caption = 'Department Category';
            DataClassification = SystemMetadata;
        }

        field(50; "TTTPR IsShortcut"; Boolean)
        {
            Caption = 'Is Shortcut';
            DataClassification = SystemMetadata;
        }

        field(51; "TTTPR Image"; Integer)
        {
            Caption = 'Image';
            DataClassification = SystemMetadata;
        }

    }

    keys
    {
        key(PK; "TTTPR MenuSuiteCode", "TTTPR Id")
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