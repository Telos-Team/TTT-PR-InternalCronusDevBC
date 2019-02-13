table 50001 "TTT-PR TableFilterExample1"
{
    Caption = 'Table Filter Example 1';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "TTT-PR LineNo"; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(2; "TTT-PR ObjectID"; Integer)
        {
            Caption = 'Object ID';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where ("Object Type" = const (Table));
        }
        field(3; "TTT-PR ObjectName"; Text[30])
        {
            Caption = 'Object Name';
            FieldClass = FlowField;
            CalcFormula = lookup (AllObjWithCaption."Object Name" where ("Object ID" = field ("TTT-PR ObjectID")));
            Editable = false;
        }
        field(4; "TTT-PR FilterString"; TableFilter)
        {
            Caption = 'Table Filter';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "TTT-PR LineNo")
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