codeunit 50012 "TTTPR CoreLicenseStateWrapper"
{
    // <TTT001>
    //   Created.
    // </TTT001>

    Description = 'TTT Tenant License State Wrapper';

    var
        cuTenantLicenseState: Codeunit "Tenant License State";
        optState: Option Evaluation,Trial,Paid,Warning,Suspended,Deleted,,,,LockedOut;

    procedure GetLicenseState(): Option optState
    begin
        if IsEvaluation() then
            exit(optState::Evaluation);
        if IsTrial() then
            exit(optState::Trial);
        if IsPaid() then
            exit(optState::Paid);
        if IsTrial() then
            exit(optState::Warning);
        if IsTrial() then
            exit(optState::Suspended);
        if IsTrial() then
            exit(optState::Deleted);
        if IsTrial() then
            exit(optState::LockedOut);
    end;

    procedure GetLicenseStateText(): Text
    begin
        optState := GetLicenseState();
        exit(Format(optState, 0, '<Text>'));
    end;

    procedure GetLicenseStateDays(): Integer
    begin
        optState := GetLicenseState();
        exit(cuTenantLicenseState.GetPeriod(optState));
    end;

    procedure GetLicenseStateDescription(): Text
    var
        loclblDescLbl: Label '%1 (%2)';
    begin
        exit(StrSubstNo(loclblDescLbl, GetLicenseStateText(), GetLicenseStateDays()));
    end;

    procedure IsEvaluation(): Boolean
    begin
        exit(cuTenantLicenseState.GetPeriod(optState::Evaluation) > -1);
    end;

    procedure IsTrial(): Boolean
    begin
        exit(cuTenantLicenseState.GetPeriod(optState::Trial) > -1);
    end;

    procedure IsPaid(): Boolean
    begin
        exit(cuTenantLicenseState.GetPeriod(optState::Paid) > -1);
    end;

    procedure IsWarning(): Boolean
    begin
        exit(cuTenantLicenseState.GetPeriod(optState::Warning) > -1);
    end;

    procedure IsSuspended(): Boolean
    begin
        exit(cuTenantLicenseState.GetPeriod(optState::Suspended) > -1);
    end;

    procedure IsDeleted(): Boolean
    begin
        exit(cuTenantLicenseState.GetPeriod(optState::Deleted) > -1);
    end;

    procedure IsLockedOut(): Boolean
    begin
        exit(cuTenantLicenseState.GetPeriod(optState::LockedOut) > -1);
    end;

}