codeunit 50018 "TTT-PR SessionSettingsWrapper"
{
    trigger OnRun()
    begin

    end;

    var
        Settings: SessionSettings;

    procedure MyProcedure()
    begin
        Settings.Init();
        Settings.Company();
        Settings.LanguageId();
        Settings.LocaleId();
        Settings.ProfileAppId();
        Settings.ProfileId();
        Settings.ProfileSystemScope();
        Settings.RequestSessionUpdate(true);
        Settings.TimeZone()
    end;
}