codeunit 50023 "TTT-PR WsTestTheServices"
{
    procedure SimpleText(partxtInput: Text): Text
    begin
        exit(partxtInput);
    end;

    procedure SimpleTextVar(var parvartxtInput: Text)
    begin
    end;

    procedure DateTimeDiff(pardtInput: DateTime; var parvardtOutput: DateTime) Diff: Integer
    begin
        parvardtOutput := CurrentDateTime();
        Diff := parvardtOutput - pardtInput;
    end;
}
