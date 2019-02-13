table 50008 "TTT-PR MenuSuite"
{
    Caption = 'TTTPR Menu Suite';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "TTT-PR Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
            TableRelation = "TTT-PR MenuSuite"."TTT-PR Code";
            ValidateTableRelation = true;
        }

        field(2; "TTT-PR Name"; Text[50])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }

        field(3; "TTT-PR Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }

        field(4; "TTT-PR Content"; Blob)
        {
            Caption = 'Content';
            DataClassification = SystemMetadata;
        }

        field(5; "TTT-PR Id"; Integer)
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }

        field(6; "TTT-PR Date"; Blob)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
        }

        field(7; "TTT-PR Time"; Blob)
        {
            Caption = 'Time';
            DataClassification = SystemMetadata;
        }

        field(8; "TTT-PR VersionList"; Blob)
        {
            Caption = 'Version List';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "TTT-PR Code")
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