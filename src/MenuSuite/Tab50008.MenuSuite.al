table 50008 TTTPRMenuSuite
{
    Caption = 'TTTPR Menu Suite';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
            TableRelation = TTTPRMenuSuite.Code;
            ValidateTableRelation = true;
        }

        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }

        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }

        field(4; Content; Blob)
        {
            Caption = 'Content';
            DataClassification = SystemMetadata;
        }

        field(5; Id; Integer)
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }

        field(6; Date; Blob)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
        }

        field(7; Time; Blob)
        {
            Caption = 'Time';
            DataClassification = SystemMetadata;
        }

        field(8; VersionList; Blob)
        {
            Caption = 'Version List';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; Code)
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