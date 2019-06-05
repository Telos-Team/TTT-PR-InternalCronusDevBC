table 50001 "TTT-PR TableFilterExample1"
{
    Caption = 'Table Filter Example 1';
    DataClassification = CustomerContent;

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
            trigger OnValidate();
            begin
                CalcFields("TTT-PR ObjectName", "TTT-PR ObjectCaption");
            end;

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
        field(5; "TTT-PR ObjectCaption"; Text[50])
        {
            Caption = 'Object Caption';
            FieldClass = FlowField;
            CalcFormula = lookup (AllObjWithCaption."Object Caption" where ("Object ID" = field ("TTT-PR ObjectID")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "TTT-PR LineNo")
        {
            Clustered = true;
        }
    }

    procedure FilterStringOnAssistEdit(): Boolean
    begin
        TestField("TTT-PR ObjectID");
        exit(EditTableFilter(FieldNo("TTT-PR ObjectID"), FieldNo("TTT-PR FilterString")));
    end;

    procedure EditTableFilter(parintTableNoFieldNo: Integer; parintFilterStringFieldNo: Integer): Boolean
    var
        loccuTableFilterMgt: Codeunit "TTT-PR TableFilterMgt";
        locrrTable: RecordRef;
    begin
        locrrTable.GetTable(rec);
        if not loccuTableFilterMgt.EditTableFilterByFieldNos(parintTableNoFieldNo, parintFilterStringFieldNo, locrrTable) then
            exit;
        locrrTable.SetTable(rec);
        exit(true);
    end;

    procedure ShowTableFilter(parintTableNo: Integer; parintFilterStringFieldNo: Integer)
    var
        loccuTableFilterMgt: Codeunit "TTT-PR TableFilterMgt";
        locrrTable: RecordRef;
    begin
        locrrTable.GetTable(rec);
        loccuTableFilterMgt.ShowTableFilter(parintTableNo, parintFilterStringFieldNo, locrrTable);
    end;
}
