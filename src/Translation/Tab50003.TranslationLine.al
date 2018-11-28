table 50003 "TTTPR TranslationLine"
{
    Caption = 'TTTPR Translation Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TTTPR TranslationCode"; Code[20])
        {
            Caption = 'Translation Code';
            DataClassification = CustomerContent;
            TableRelation = "TTTPR TranslationProject";
        }
        field(2; "TTTPR LineNo"; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "TTTPR SourceContent"; Blob)
        {
            Caption = 'Source Content';
            DataClassification = CustomerContent;
        }
        field(4; "TTTPR SourceText"; Text[250])
        {
            Caption = 'Source Text';
            DataClassification = CustomerContent;
        }
        field(5; "TTTPR TransUnitId"; Text[250])
        {
            Caption = 'Trans Unit ID';
            DataClassification = CustomerContent;
        }
        field(6; "TTTPR Translate"; Boolean)
        {
            Caption = 'Translate';
            DataClassification = CustomerContent;
        }
        field(7; "TTTPR MaxLength"; Integer)
        {
            Caption = 'Max Length';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(8; "TTTPR DeveloperNote"; Text[250])
        {
            Caption = 'Developer Note';
            DataClassification = CustomerContent;
        }
        field(9; "TTTPR XliffGeneratorNote"; Text[250])
        {
            Caption = 'Xliff Generator Note';
            DataClassification = CustomerContent;
        }
        field(10; "TTTPR TargetLanguageFilter"; Text[10])
        {
            Caption = 'Target Language Filter';
            FieldClass = FlowFilter;
        }
        field(11; "TTTPR TargetTranslationFound"; Boolean)
        {
            Caption = 'Target Translation Found';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist ("TTTPR TranslatedLine" where ("TTTPR TranslationCode" = field ("TTTPR TranslationCode"), "TTTPR TranslationLineNo" = field ("TTTPR LineNo")));
        }

    }

    keys
    {
        key(PK; "TTTPR TranslationCode", "TTTPR LineNo")
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