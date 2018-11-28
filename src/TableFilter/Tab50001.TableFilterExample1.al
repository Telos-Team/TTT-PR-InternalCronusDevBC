table 50001 TTTPRTableFilterExample1
{
    Caption = 'Table Filter Example 1';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "TTTPR LineNo"; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(2; "TTTPR ObjectID"; Integer)
        {
            Caption = 'Object ID';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where ("Object Type" = const (Table));
        }
        field(3; "TTTPR ObjectName"; Text[30])
        {
            Caption = 'Object Name';
            FieldClass = FlowField;
            CalcFormula = lookup (AllObjWithCaption."Object Name" where ("Object ID" = field ("TTTPR ObjectID")));
            Editable = false;
        }
        field(4; "TTTPR FilterString"; TableFilter)
        {
            Caption = 'Table Filter';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "TTTPR LineNo")
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