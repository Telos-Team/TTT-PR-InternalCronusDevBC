table 50003 "TTT-PR TranslationLine"
{
    Caption = 'TTTPR Translation Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TTT-PR TranslationCode"; Code[20])
        {
            Caption = 'Translation Code';
            DataClassification = CustomerContent;
            TableRelation = "TTT-PR TranslationProject";
        }
        field(2; "TTT-PR LineNo"; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "TTT-PR SourceContent"; Blob)
        {
            Caption = 'Source Content';
            DataClassification = CustomerContent;
        }
        field(4; "TTT-PR SourceText"; Text[250])
        {
            Caption = 'Source Text';
            DataClassification = CustomerContent;
        }
        field(5; "TTT-PR TransUnitId"; Text[250])
        {
            Caption = 'Trans Unit ID';
            DataClassification = CustomerContent;
        }
        field(6; "TTT-PR Translate"; Boolean)
        {
            Caption = 'Translate';
            DataClassification = CustomerContent;
        }
        field(7; "TTT-PR MaxLength"; Integer)
        {
            Caption = 'Max Length';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(8; "TTT-PR DeveloperNote"; Text[250])
        {
            Caption = 'Developer Note';
            DataClassification = CustomerContent;
        }
        field(9; "TTT-PR XliffGeneratorNote"; Text[250])
        {
            Caption = 'Xliff Generator Note';
            DataClassification = CustomerContent;
        }
        field(10; "TTT-PR TargetLanguageFilter"; Text[10])
        {
            Caption = 'Target Language Filter';
            FieldClass = FlowFilter;
        }
        field(11; "TTT-PR TargetTranslationFound"; Boolean)
        {
            Caption = 'Target Translation Found';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist ("TTT-PR TranslatedLine" where ("TTT-PR TranslationCode" = field ("TTT-PR TranslationCode"), "TTT-PR TranslationLineNo" = field ("TTT-PR LineNo")));
        }

    }

    keys
    {
        key(PK; "TTT-PR TranslationCode", "TTT-PR LineNo")
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