table 50009 TTTPRMenuNode
{
    Caption = 'TTTPR Menu Node';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; MenuSuiteCode; Code[20])
        {
            Caption = 'Menu Suite Code';
            DataClassification = SystemMetadata;
        }

        field(2; Id; Guid)
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }

        field(3; Type; Option)
        {
            Caption = 'Type';
            DataClassification = SystemMetadata;
            OptionMembers = Root,Menu,Group,Item;
        }

        field(4; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }

        field(10; FirstChild; Guid)
        {
            Caption = 'First Child';
            DataClassification = SystemMetadata;
            TableRelation = TTTPRMenuNode.Id WHERE (MenuSuiteCode = FIELD (MenuSuiteCode));
            ValidateTableRelation = true;
        }

        field(11; ParentNodeId; Guid)
        {
            Caption = 'Parent Node Id';
            DataClassification = SystemMetadata;
            TableRelation = TTTPRMenuNode.Id WHERE (MenuSuiteCode = FIELD (MenuSuiteCode));
            ValidateTableRelation = true;
        }

        field(12; NextNodeId; Guid)
        {
            Caption = 'Next Node Id';
            DataClassification = SystemMetadata;
            TableRelation = TTTPRMenuNode.Id WHERE (MenuSuiteCode = FIELD (MenuSuiteCode));
            ValidateTableRelation = true;
        }

        field(13; MemberOfMenu; Guid)
        {
            Caption = 'Member of Menu';
            DataClassification = SystemMetadata;
            TableRelation = TTTPRMenuNode.Id WHERE (MenuSuiteCode = FIELD (MenuSuiteCode));
            ValidateTableRelation = true;
        }

        field(20; RunObjectType; Option)
        {
            Caption = 'Run Object Type';
            DataClassification = SystemMetadata;
            OptionMembers = Page,Codeunit,XmlPort,Report;
        }

        field(21; RunObjectId; Integer)
        {
            Caption = 'Run Object Id';
            DataClassification = SystemMetadata;
        }

        field(30; Visible; Boolean)
        {
            Caption = 'Visible';
            DataClassification = SystemMetadata;
        }

        field(31; Enabled; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = SystemMetadata;
        }

        field(40; ApplicationArea; Text[30])
        {
            Caption = 'Application Area';
            DataClassification = SystemMetadata;
        }

        field(41; DepartmentCategory; Text[30])
        {
            Caption = 'Department Category';
            DataClassification = SystemMetadata;
        }

        field(50; IsShortcut; Boolean)
        {
            Caption = 'Is Shortcut';
            DataClassification = SystemMetadata;
        }

        field(51; Image; Integer)
        {
            Caption = 'Image';
            DataClassification = SystemMetadata;
        }

    }

    keys
    {
        key(PK; MenuSuiteCode, Id)
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