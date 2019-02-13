table 50009 "TTT-PR MenuNode"
{
    Caption = 'TTTPR Menu Node';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "TTT-PR MenuSuiteCode"; Code[20])
        {
            Caption = 'Menu Suite Code';
            DataClassification = SystemMetadata;
        }

        field(2; "TTT-PR Id"; Guid)
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }

        field(3; "TTT-PR Type"; Option)
        {
            Caption = 'Type';
            DataClassification = SystemMetadata;
            OptionMembers = Root,Menu,Group,Item;
        }

        field(4; "TTT-PR Name"; Text[50])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }

        field(10; "TTT-PR FirstChild"; Guid)
        {
            Caption = 'First Child';
            DataClassification = SystemMetadata;
            TableRelation = "TTT-PR MenuNode"."TTT-PR Id" WHERE ("TTT-PR MenuSuiteCode" = FIELD ("TTT-PR MenuSuiteCode"));
            ValidateTableRelation = true;
        }

        field(11; "TTT-PR ParentNodeId"; Guid)
        {
            Caption = 'Parent Node Id';
            DataClassification = SystemMetadata;
            TableRelation = "TTT-PR MenuNode"."TTT-PR Id" WHERE ("TTT-PR MenuSuiteCode" = FIELD ("TTT-PR MenuSuiteCode"));
            ValidateTableRelation = true;
        }

        field(12; "TTT-PR NextNodeId"; Guid)
        {
            Caption = 'Next Node Id';
            DataClassification = SystemMetadata;
            TableRelation = "TTT-PR MenuNode"."TTT-PR Id" WHERE ("TTT-PR MenuSuiteCode" = FIELD ("TTT-PR MenuSuiteCode"));
            ValidateTableRelation = true;
        }

        field(13; "TTT-PR MemberOfMenu"; Guid)
        {
            Caption = 'Member of Menu';
            DataClassification = SystemMetadata;
            TableRelation = "TTT-PR MenuNode"."TTT-PR Id" WHERE ("TTT-PR MenuSuiteCode" = FIELD ("TTT-PR MenuSuiteCode"));
            ValidateTableRelation = true;
        }

        field(20; "TTT-PR RunObjectType"; Option)
        {
            Caption = 'Run Object Type';
            DataClassification = SystemMetadata;
            OptionMembers = Page,Codeunit,XmlPort,Report;
        }

        field(21; "TTT-PR RunObjectId"; Integer)
        {
            Caption = 'Run Object Id';
            DataClassification = SystemMetadata;
        }

        field(30; "TTT-PR Visible"; Boolean)
        {
            Caption = 'Visible';
            DataClassification = SystemMetadata;
        }

        field(31; "TTT-PR Enabled"; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = SystemMetadata;
        }

        field(40; "TTT-PR ApplicationArea"; Text[30])
        {
            Caption = 'Application Area';
            DataClassification = SystemMetadata;
        }

        field(41; "TTT-PR DepartmentCategory"; Text[30])
        {
            Caption = 'Department Category';
            DataClassification = SystemMetadata;
        }

        field(50; "TTT-PR IsShortcut"; Boolean)
        {
            Caption = 'Is Shortcut';
            DataClassification = SystemMetadata;
        }

        field(51; "TTT-PR Image"; Integer)
        {
            Caption = 'Image';
            DataClassification = SystemMetadata;
        }

    }

    keys
    {
        key(PK; "TTT-PR MenuSuiteCode", "TTT-PR Id")
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