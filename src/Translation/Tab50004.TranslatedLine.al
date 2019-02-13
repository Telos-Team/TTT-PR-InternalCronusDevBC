table 50004 "TTT-PR TranslatedLine"
{
    Caption = 'TTTPR Translated Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TTT-PR TranslationCode"; Code[20])
        {
            Caption = 'Translation Code';
            DataClassification = CustomerContent;
            TableRelation = "TTT-PR TranslationProject";
        }
        field(2; "TTT-PR TranslationLineNo"; Integer)
        {
            Caption = 'Translation Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "TTT-PR TargetLanguage"; Text[10])
        {
            Caption = 'Target Language';
            DataClassification = CustomerContent;
        }
        field(4; "TTT-PR TargetContent"; Blob)
        {
            Caption = 'Target Content';
            DataClassification = CustomerContent;
        }
        field(5; "TTT-PR TargetText"; Text[250])
        {
            Caption = 'Target Text';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "TTT-PR TranslationCode", "TTT-PR TranslationLineNo", "TTT-PR TargetLanguage")
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