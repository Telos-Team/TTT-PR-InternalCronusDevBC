table 50004 TTTPRTranslatedLine
{
    Caption = 'TTTPR Translated Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; TranslationCode; Code[20])
        {
            Caption = 'Translation Code';
            DataClassification = CustomerContent;
            TableRelation = TTTPRTranslationProject;
        }
        field(2; TranslationLineNo; Integer)
        {
            Caption = 'Translation Line No.';
            DataClassification = CustomerContent;
        }
        field(3; TargetLanguage; Text[10])
        {
            Caption = 'Target Language';
            DataClassification = CustomerContent;
        }
        field(4; TargetContent; Blob)
        {
            Caption = 'Target Content';
            DataClassification = CustomerContent;
        }
        field(5; TargetText; Text[250])
        {
            Caption = 'Target Text';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; TranslationCode, TranslationLineNo, TargetLanguage)
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