table 50012 "TTTPR Nav2BcTemplate"
{
    Description = 'TTTPR Nav2Bc Template';
    Caption = 'Nav2Bc Template';
    DataCaptionFields = "TTTPR Code", "TTTPR Description";
    DataClassification = CustomerContent;
    LookupPageId = "TTTPR Nav2BcTemplates";
    DrillDownPageId = "TTTPR Nav2BcTemplates";

    fields
    {
        field(1; "TTTPR Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "TTTPR Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "TTTPR DataLines"; Integer)
        {
            Caption = 'Data Lines';
            FieldClass = FlowField;
            CalcFormula = Count ("TTTPR Nav2BcData" where ("TTTPR TemplateCode" = field ("TTTPR Code")));
            Editable = false;
            BlankZero = true;
        }
    }

    keys
    {
        key(Key1; "TTTPR Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        locrecData: Record "TTTPR Nav2BcData";
    begin
        locrecData.SetRange("TTTPR TemplateCode", "TTTPR Code");
        locrecData.DeleteAll(true);
    end;

    procedure ImportData()
    var
        loccuMgt: Codeunit "TTTPR Nav2BcManagement";
    begin
        loccuMgt.ImportData(Rec);
    end;

    procedure SplitData()
    var
        loccuMgt: Codeunit "TTTPR Nav2BcManagement";
    begin
        loccuMgt.SplitData(Rec);
    end;

    procedure InsertData()
    var
        loccuMgt: Codeunit "TTTPR Nav2BcManagement";
    begin
        loccuMgt.InsertData(Rec);
    end;
}

