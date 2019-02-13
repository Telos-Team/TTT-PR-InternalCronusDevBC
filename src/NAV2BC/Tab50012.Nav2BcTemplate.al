table 50012 "TTT-PR Nav2BcTemplate"
{
    Description = 'TTTPR Nav2Bc Template';
    Caption = 'Nav2Bc Template';
    DataCaptionFields = "TTT-PR Code", "TTT-PR Description";
    DataClassification = CustomerContent;
    LookupPageId = "TTT-PR Nav2BcTemplates";
    DrillDownPageId = "TTT-PR Nav2BcTemplates";

    fields
    {
        field(1; "TTT-PR Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "TTT-PR Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "TTT-PR DataLines"; Integer)
        {
            Caption = 'Data Lines';
            FieldClass = FlowField;
            CalcFormula = Count ("TTT-PR Nav2BcData" where (
                "TTT-PR TemplateCode" = field ("TTT-PR Code"),
                "TTT-PR Company" = field ("TTT-PR CompanyFilter")));
            Editable = false;
            BlankZero = true;
        }
        field(4; "TTT-PR CompanyFilter"; Text[30])
        {
            Caption = 'Company Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "TTT-PR Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        locrecData: Record "TTT-PR Nav2BcData";
    begin
        locrecData.SetRange("TTT-PR TemplateCode", "TTT-PR Code");
        locrecData.DeleteAll(true);
    end;

    procedure ImportData()
    var
        loccuMgt: Codeunit "TTT-PR Nav2BcManagement";
    begin
        loccuMgt.ImportData(Rec);
    end;

    procedure SplitData()
    var
        loccuMgt: Codeunit "TTT-PR Nav2BcManagement";
    begin
        loccuMgt.SplitData(Rec);
    end;

    procedure InsertData()
    var
        loccuMgt: Codeunit "TTT-PR Nav2BcManagement";
    begin
        loccuMgt.InsertData(Rec);
    end;

    procedure ShowRecords()
    var
        loccuMgt: Codeunit "TTT-PR Nav2BcManagement";
    begin
        loccuMgt.ShowData(rec);
    end;
}