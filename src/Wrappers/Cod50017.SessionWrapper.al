codeunit 50017 "TTTPR CoreSessionWrapper"
{
    trigger OnRun()
    begin

    end;

    procedure GetSessionApplicationArea(): Text
    begin
        exit(Session.ApplicationArea());
    end;
}