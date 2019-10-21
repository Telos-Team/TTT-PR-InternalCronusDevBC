codeunit 50023 "TTT-PR WsTestTheServices"
{
    procedure SimpleText(partxtInput: Text): Text // Web2BC
    begin
        exit(partxtInput);
    end;

    procedure SimpleTextVar(var parvartxtInput: Text)
    begin
        parvartxtInput := 'ACK-' + parvartxtInput;
    end;

    procedure SimpleTextVars(partxtInput: Text; var parvartxtOutput1: Text; var parvartxtOutput2: Text): Text
    begin
        parvartxtOutput1 := '1' + parvartxtOutput1;
        parvartxtOutput2 := '2' + parvartxtOutput2;
        exit(partxtInput);
    end;

    procedure SimpleTextDanish(var parvartxtInput: Text)
    begin
        parvartxtInput := 'æøåÆØÅ-' + parvartxtInput;
    end;

    procedure DateTimeDiff(pardtInput: DateTime; var parvardtOutput: DateTime) Diff: Integer
    begin
        parvardtOutput := CurrentDateTime();
        Diff := parvardtOutput - pardtInput;
    end;

}
