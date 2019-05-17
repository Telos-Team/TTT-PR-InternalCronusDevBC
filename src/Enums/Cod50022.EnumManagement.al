codeunit 50022 "TTT-PR EnumManagement"
{
    trigger OnRun()
    begin
    end;

    procedure Test1()
    var
        enm: Enum "ttt-pr enumTest1";
    begin
        message('1 %1', enm);
        message('2 %1', enm::MyNewValue);
        message('3 %1', format(enm, 0, '<Number>'));
        message('4 %1', "ttt-pr enumTest1"::MyNewValue);
        Clear(enm);
        Evaluate(enm, '2');
        message('5 %1', enm);
        Clear(enm);
        Evaluate(enm, '0');
        message('6 %1', enm);
        Clear(enm);
        Evaluate(enm, '');
        message('6 %1', enm);
    end;

    procedure Test2(parintValue: Integer; enm: Enum "ttt-pr enumTest1"): Boolean
    var
        loctxtValue: Text;
    begin
        loctxtValue := Format(parintValue);
        case true of
            Format(enm::MyExtraValue, 0, '<Number>') = loctxtValue:
                Message('Extra');
            else
                ;
        end;
    end;

    procedure Test3(parintValue: Integer; vnm: Variant): Boolean
    var
        loctxtValue: Text;
    begin
        loctxtValue := Format(parintValue);
    end;
}