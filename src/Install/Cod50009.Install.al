codeunit 50009 "TTT-PR CoreInstall"
{
    // <TTT001>
    //   Created.
    // </TTT001>

    Description = 'TTT Core Install. Object handles app install routines';
    Subtype = Install;

    var
        cuModuleInfoWrapper: Codeunit "TTT-PR CoreModuleInfoWrapper";

    trigger OnInstallAppPerDatabase();
    begin
        if cuModuleInfoWrapper.IsFreshInstall() then
            HandleFreshInstallDB()
        else
            HandleReinstallDB();
    end;

    trigger OnInstallAppPerCompany();
    begin
        if cuModuleInfoWrapper.IsFreshInstall() then
            HandleFreshInstallComp()
        else
            HandleReinstallComp();
    end;

    local procedure HandleFreshInstallDB();
    begin
        // Do work needed the first time this extension is ever installed for this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was install
        // - Initial data setup for use
    end;

    local procedure HandleReinstallDB();
    begin
        // Do work needed when reinstalling the same version of this extension back on this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was reinstalled
        // - Data 'patchup' work, for example, detecting if new 'base' records have been changed while you have been working 'offline'.
        // - Setup 'welcome back' messaging for next user access.
    end;

    local procedure HandleFreshInstallComp();
    begin
        // Do work needed the first time this extension is ever installed for this company.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was install
        // - Initial data setup for use
    end;

    local procedure HandleReinstallComp();
    begin
        // Do work needed when reinstalling the same version of this extension back on this company.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was reinstalled
        // - Data 'patchup' work, for example, detecting if new 'base' records have been changed while you have been working 'offline'.
        // - Setup 'welcome back' messaging for next user access.
    end;
}