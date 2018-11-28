table 50004 "TTTPR TranslatedLine"
{
    Caption = 'TTTPR Translated Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TTTPR TranslationCode"; Code[20])
        {
            Caption = 'Translation Code';
            DataClassification = CustomerContent;
            TableRelation = "TTTPR TranslationProject";
        }
        field(2; "TTTPR TranslationLineNo"; Integer)
        {
            Caption = 'Translation Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "TTTPR TargetLanguage"; Text[10])
        {
            Caption = 'Target Language';
            DataClassification = CustomerContent;
        }
        field(4; "TTTPR TargetContent"; Blob)
        {
            Caption = 'Target Content';
            DataClassification = CustomerContent;
        }
        field(5; "TTTPR TargetText"; Text[250])
        {
            Caption = 'Target Text';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "TTTPR TranslationCode", "TTTPR TranslationLineNo", "TTTPR TargetLanguage")
        {
            Clustered = true;
        }
    }

    var

    trigger OnInsert();
    begin
    end;

    trigger OnModify();
    begin
    end;

    trigger OnDelete();
    begin
    end;

    trigger OnRename();
    begin
    end;

}