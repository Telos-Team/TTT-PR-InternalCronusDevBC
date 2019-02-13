codeunit 50017 "TTT-PR CoreSessionWrapper"
{
    trigger OnRun()
    begin

    end;

    procedure GetSessionApplicationArea(): Text
    begin
        exit(Session.ApplicationArea());
    end;
}