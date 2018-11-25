table 50003 TTTPRTranslationLine
{
    Caption = 'TTTPR Translation Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; TranslationCode; Code[20])
        {
            Caption = 'Translation Code';
            DataClassification = CustomerContent;
            TableRelation = TTTPRTranslationProject;
        }
        field(2; LineNo; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; SourceContent; Blob)
        {
            Caption = 'Source Content';
            DataClassification = CustomerContent;
        }
        field(4; SourceText; Text[250])
        {
            Caption = 'Source Text';
            DataClassification = CustomerContent;
        }
        field(5; TransUnitId; Text[250])
        {
            Caption = 'Trans Unit ID';
            DataClassification = CustomerContent;
        }
        field(6; Translate; Boolean)
        {
            Caption = 'Translate';
            DataClassification = CustomerContent;
        }
        field(7; MaxLength; Integer)
        {
            Caption = 'Max Length';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(8; DeveloperNote; Text[250])
        {
            Caption = 'Developer Note';
            DataClassification = CustomerContent;
        }
        field(9; XliffGeneratorNote; Text[250])
        {
            Caption = 'Xliff Generator Note';
            DataClassification = CustomerContent;
        }
        field(10; TargetLanguageFilter; Text[10])
        {
            Caption = 'Target Language Filter';
            FieldClass = FlowFilter;
        }
        field(11; TargetTranslationFound; Boolean)
        {
            Caption = 'Target Translation Found';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist (TTTPRTranslatedLine where (TranslationCode = field (TranslationCode), TranslationLineNo = field (LineNo)));
        }

    }

    keys
    {
        key(PK; TranslationCode, LineNo)
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