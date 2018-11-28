table 50008 "TTTPR MenuSuite"
{
    Caption = 'TTTPR Menu Suite';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "TTTPR Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
            TableRelation = "TTTPR MenuSuite"."TTTPR Code";
            ValidateTableRelation = true;
        }

        field(2; "TTTPR Name"; Text[50])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }

        field(3; "TTTPR Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }

        field(4; "TTTPR Content"; Blob)
        {
            Caption = 'Content';
            DataClassification = SystemMetadata;
        }

        field(5; "TTTPR Id"; Integer)
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }

        field(6; "TTTPR Date"; Blob)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
        }

        field(7; "TTTPR Time"; Blob)
        {
            Caption = 'Time';
            DataClassification = SystemMetadata;
        }

        field(8; "TTTPR VersionList"; Blob)
        {
            Caption = 'Version List';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "TTTPR Code")
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