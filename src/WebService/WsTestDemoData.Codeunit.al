/// <summary>
/// The functions for creating demo data for the WsTest module.
/// </summary>
codeunit 50032 "TTT-PR WsTestDemoData"
{
    /// <summary>
    /// Inserts a web service endpoint into the table.
    /// </summary
    /// <returns>Returns true if Endpoint was inserted.</returns>
    procedure InsertWsEndpoint(parcodCode: Code[50]; partxtDescription: Text[100]; partxtUrl: Text[250]; partxtEnvironment: Text[250]): Boolean
    var
        locrecWsEndpoint: Record "TTT-PR WsTestEndpoint";
    begin
        locrecWsEndpoint.Init();
        locrecWsEndpoint.Validate("TTT-PR Code", parcodCode);
        locrecWsEndpoint.Validate("TTT-PR Description", partxtDescription);
        locrecWsEndpoint.Validate("TTT-PR Url", partxtUrl);
        locrecWsEndpoint.Validate("TTT-PR Environment", partxtEnvironment);
        locrecWsEndpoint.Insert(true);
        exit(true);
    end;

    /// <summary>
    /// Inserts a web service credential into the table.
    /// </summary
    /// <returns>Returns true if Credential was inserted.</returns>
    procedure InsertWsCredential(parcodCode: Code[50]; partxtDescription: Text[100]; partxtUsername: Text[50]; partxtPassword: Text[50]; partxtDomainName: Text[50]): Boolean
    var
        locrecWsCredential: Record "TTT-PR WsTestCredential";
    begin
        locrecWsCredential.Init();
        locrecWsCredential.Validate("TTT-PR Code", parcodCode);
        locrecWsCredential.Validate("TTT-PR Description", partxtDescription);
        locrecWsCredential.Validate("TTT-PR Username", partxtUsername);
        locrecWsCredential.Validate("TTT-PR Password", partxtPassword);
        locrecWsCredential.Validate("TTT-PR DomainName", partxtDomainName);
        locrecWsCredential.Insert(true);
        exit(true);
    end;

    /// <summary>
    /// Inserts a web service link into the table.
    /// </summary
    /// <returns>Returns true if Link was inserted.</returns>
    procedure InsertWsLink(parcodCode: Code[50]; partxtDescription: Text[100]; parcodEndpoint: Code[50]; parcodCredential: Code[50]; parenumAuthenticationType: Enum "TTT-PR WsTestAuthenticationType"; parbooOK: Boolean): Boolean
    var
        locrecWsLink: Record "TTT-PR WsTestConnection";
    begin
        CheckLinkCode(parcodCode);

        locrecWsLink.Init();
        locrecWsLink.Validate("TTT-PR Code", parcodCode);
        locrecWsLink.Validate("TTT-PR Description", partxtDescription);
        locrecWsLink.Validate("TTT-PR EndpointCode", parcodEndpoint);
        locrecWsLink.Validate("TTT-PR CredentialCode", parcodCredential);
        locrecWsLink.Validate("TTT-PR OK", parbooOK);
        locrecWsLink.Validate("TTT-PR AuthenticationType", parenumAuthenticationType);
        locrecWsLink.Insert(true);
        exit(true);
    end;

    /// <summary>
    /// Check if the code has been used. In which case a suffix-number will be added.
    /// </summary>
    local procedure CheckLinkCode(var parvarcodCode: Code[50])
    var
        locrecWsLink: Record "TTT-PR WsTestConnection";
        locintNewKey: Integer;
        locintTestor: Integer;
    begin
        locrecWsLink.SetFilter("TTT-PR Code", parvarcodCode + '*');
        if not locrecWsLink.FindSet() then
            exit;
        repeat
            locintTestor := 1;
            if StrLen(locrecWsLink."TTT-PR Code") = StrLen(parvarcodCode) then
                locintNewKey := 1
            else begin
                locintTestor := 0;
                if Evaluate(locintTestor, CopyStr(locrecWsLink."TTT-PR Code", StrLen(parvarcodCode) + 1)) then
                    if locintTestor >= locintNewKey then
                        locintNewKey := locintTestor + 1;
            end;
        until (locrecWsLink.Next() = 0) or (locintTestor = 0);
        if locintNewKey > 0 then
            parvarcodCode := StrSubstNo('%1%2', parvarcodCode, locintNewKey);
    end;

    procedure InsertDemoDataPR()
    begin
        InsertWsEndpoint('D13_WIN', '', 'http://BC135:7047/NAV/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'http://bc135/NAV/');
        InsertWsEndpoint('D13_NUP', '', 'http://BC135:7047/NAV/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'http://bc135/NAV/');
        InsertWsEndpoint('D14_WIN', '', 'http://BC145:7047/NAV/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'http://bc135/NAV/');
        InsertWsEndpoint('D14_NUP', '', 'http://BC145:7047/NAV/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'http://bc135/NAV/');
        InsertWsEndpoint('D15_WIN', '', 'http://BC150:7047/NAV/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'http://bc135/NAV/');
        InsertWsEndpoint('D15_NUP', '', 'http://BC150:7047/NAV/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'http://bc135/NAV/');
        InsertWsEndpoint('OP13_WIN', '', 'http://CLT020PR:13032/Cronus_Dev_BC/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'http://localhost:8080/Cronus_Dev_BC');
        InsertWsEndpoint('OP13_NUP', '', 'http://CLT020PR:13032/Cronus_Dev_BC_NUP/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'http://localhost:8080/Cronus_Dev_BC_NUP');
        InsertWsEndpoint('OP13_UNP', '', 'http://CLT020PR:13012/Cronus_Dev_BC_UNP/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'http://localhost:8080/Cronus_Dev_BC_UN');
        InsertWsEndpoint('SP', '', 'https://api.businesscentral.dynamics.com/v1.0/8ca4b31c-0d2d-4c60-8dea-e388d27fcb71/Sandbox/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'https://businesscentral.dynamics.com/8ca4b31c-0d2d-4c60-8dea-e388d27fcb71/sandbox');
        InsertWsEndpoint('S14', '', 'https://api.businesscentral.dynamics.com/v1.0/8ca4b31c-0d2d-4c60-8dea-e388d27fcb71/Sandbox14/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'https://businesscentral.dynamics.com/8ca4b31c-0d2d-4c60-8dea-e388d27fcb71/sandbox14');
        InsertWsEndpoint('S15', '', 'https://api.businesscentral.dynamics.com/v1.0/8ca4b31c-0d2d-4c60-8dea-e388d27fcb71/Sandbox15/WS/CRONUS%20Danmark%20A%2FS/Codeunit/WsTest', 'https://businesscentral.dynamics.com/8ca4b31c-0d2d-4c60-8dea-e388d27fcb71/sandbox15');

        InsertWsCredential('NAV_WAK', '', 'NAV', 'Py/BrAocs17iwicWYsYOvy7S341hKctO624v3Sib31k=', '');
        InsertWsCredential('NAV_PWD', '', 'NAV', 'Password1', '');
        InsertWsCredential('NAV_DOM_WAK', '', 'NAV', 'GGb3gBq/VfGp5IB70QZ9znrgYTR0+3NI3tWlCtUqFqM=', 'CLT020PR');
        InsertWsCredential('NAV_DOM_PWD', '', 'NAV', 'Password1', 'CLT020PR');
        InsertWsCredential('DOM_NAV_WAK', '', 'CLT020PR\NAV', 'GGb3gBq/VfGp5IB70QZ9znrgYTR0+3NI3tWlCtUqFqM=', '');
        InsertWsCredential('DOM_NAV_PWD', '', 'CLT020PR\NAV', 'Password1', '');
        InsertWsCredential('DOM_PR_WAK', '', 'CLT020PR\PR', '/Z7uN2qFnLsGqTSG4D5xW94L80/knLXUFr0LWg6tGzY=', '');
        InsertWsCredential('DOM_PR_PWD', '', 'CLT020PR\PR', 'pwd', '');
        InsertWsCredential('ADMINP_WAK', '', 'ADMIN', '1FohaxATp9wsI4KbhWhI4Gon2Trgey5MsmLQBOyDH2g=', '');
        InsertWsCredential('ADMINP_PWD', '', 'ADMIN', 'Tel0ste@m', '');
        InsertWsCredential('ADMIN14_WAK', '', 'ADMIN', '7afcZz1v4oXKZN9IekfxEGq7UVXJxsUVO68v6TdY4Ic=', '');
        InsertWsCredential('ADMIN14_PWD', '', 'ADMIN', 'Tel0ste@m', '');
        InsertWsCredential('ADMIN15_WAK', '', 'ADMIN', 'vNOcA34Bdba1A4cvn/wgNukWHkI2rCGEpMzIASDTt+E=', '');
        InsertWsCredential('ADMIN15_PWD', '', 'ADMIN', 'Tel0ste@m', '');
        InsertWsCredential('ARP_WAK', '', 'AR', '7/Ns0r0MH17wQUHnHDygSVB3qQHnEs9Jjttyc8ppudo=', '');
        InsertWsCredential('ARP_PWD', '', 'AR', 'Password1', '');
        InsertWsCredential('AR14_WAK', '', 'AR', 'HDVR3EBuQf6p0I9Fxp5TldXHYo7WrqVPxnIywdpxBO0=', '');
        InsertWsCredential('AR14_PWD', '', 'AR', 'Password1', '');

        InsertWsLink('D13-D13_NUP_BAS', 'Docker13->Docker13', 'D13_NUP', 'NAV_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('D13-D13_NUP_BAS', 'Docker13->Docker13', 'D13_NUP', 'NAV_PWD', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('D13-D13_WIN_BAS', 'Docker13->Docker13', 'D13_WIN', 'NAV_WAK', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('D13-D13_WIN_BAS', 'Docker13->Docker13', 'D13_WIN', 'NAV_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('D13-OP13_NUP_BAS', 'Docker13->OnPrem13', 'OP13_NUP', 'NAV_PWD', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('D13-S14_BAS', 'Docker13->Saas14', 'S14', 'ADMIN14_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('D13-S14_BAS', 'Docker13->Saas14', 'S14', 'ADMIN14_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('D13-S14_BAS', 'Docker13->Saas14', 'S14', 'AR14_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('D13-S14_BAS', 'Docker13->Saas14', 'S14', 'AR14_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('D13-SP_BAS', 'Docker13->Saas14 P', 'SP', 'ADMINP_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('D13-SP_BAS', 'Docker13->Saas14 P', 'SP', 'ADMINP_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('D13-SP_BAS', 'Docker13->Saas14 P', 'SP', 'ARP_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('D13-SP_BAS', 'Docker13->Saas14 P', 'SP', 'ARP_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);

        InsertWsLink('OP13-D13_NUP_BAS', 'OnPrem13->Docker13', 'D13_NUP', 'DOM_PR_WAK', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('OP13-D13_WIN_BAS', 'OnPrem13->Docker13', 'D13_WIN', 'DOM_PR_WAK', "TTT-PR WsTestAuthenticationType"::Basic, false);

        InsertWsLink('OP13-OP13_NUP_BAS', 'OnPrem13->OnPrem13', 'OP13_NUP', 'NAV_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('OP13-OP13_NUP_BAS', 'OnPrem13->OnPrem13', 'OP13_NUP', 'NAV_PWD', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('OP13-OP13_NUP_BAS', 'OnPrem13->OnPrem13', 'OP13_NUP', 'DOM_NAV_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('OP13-OP13_NUP_BAS', 'OnPrem13->OnPrem13', 'OP13_NUP', 'DOM_NAV_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('OP13-OP13_NUP_BAS', 'OnPrem13->OnPrem13', 'OP13_NUP', 'DOM_PR_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('OP13-OP13_NUP_BAS', 'OnPrem13->OnPrem13', 'OP13_NUP', 'DOM_PR_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);

        InsertWsLink('OP13-OP13_UNP_BAS', 'OnPrem13->OnPrem13', 'OP13_UNP', 'NAV_WAK', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('OP13-OP13_UNP_BAS', 'OnPrem13->OnPrem13', 'OP13_UNP', 'NAV_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('OP13-OP13_UNP_WIN', 'OnPrem13->OnPrem13', 'OP13_UNP', 'NAV_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP13-OP13_UNP_WIN', 'OnPrem13->OnPrem13', 'OP13_UNP', 'NAV_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP13-OP13_UNP_WIN', 'OnPrem13->OnPrem13', 'OP13_UNP', 'NAV_DOM_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP13-OP13_UNP_WIN', 'OnPrem13->OnPrem13', 'OP13_UNP', 'NAV_DOM_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP13-OP13_UNP_WIN', 'OnPrem13->OnPrem13', 'OP13_UNP', 'DOM_NAV_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP13-OP13_UNP_WIN', 'OnPrem13->OnPrem13', 'OP13_UNP', 'DOM_NAV_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);

        InsertWsLink('OP13-OP13_WIN_BAS', 'OnPrem13->OnPrem13', 'OP13_WIN', 'NAV_WAK', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('OP13-OP13_WIN_BAS', 'OnPrem13->OnPrem13', 'OP13_WIN', 'NAV_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('OP13-OP13_WIN_WIN', 'OnPrem13->OnPrem13', 'OP13_WIN', 'NAV_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP13-OP13_WIN_WIN', 'OnPrem13->OnPrem13', 'OP13_WIN', 'NAV_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP13-OP13_WIN_WIN', 'OnPrem13->OnPrem13', 'OP13_WIN', 'NAV_DOM_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP13-OP13_WIN_WIN', 'OnPrem13->OnPrem13', 'OP13_WIN', 'NAV_DOM_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP13-OP13_WIN_WIN', 'OnPrem13->OnPrem13', 'OP13_WIN', 'DOM_NAV_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP13-OP13_WIN_WIN', 'OnPrem13->OnPrem13', 'OP13_WIN', 'DOM_NAV_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);

        InsertWsLink('OP13-S14_BAS', 'OnPrem13->Saas14', 'S14', 'ADMIN14_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('OP13-S14_BAS', 'OnPrem13->Saas14', 'S14', 'ADMIN14_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('OP13-S14_BAS', 'OnPrem13->Saas14', 'S14', 'AR14_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('OP13-S14_BAS', 'OnPrem13->Saas14', 'S14', 'AR14_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('OP13-SP_BAS', 'OnPrem13->Saas14 P', 'SP', 'ADMINP_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('OP13-SP_BAS', 'OnPrem13->Saas14 P', 'SP', 'ADMINP_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('OP13-SP_BAS', 'OnPrem13->Saas14 P', 'SP', 'ARP_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('OP13-SP_BAS', 'OnPrem13->Saas14 P', 'SP', 'ARP_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);

        InsertWsLink('OP14-OP13_UNP_DEF', 'OnPrem14->OnPrem13 TBD', 'OP13_UNP', '', "TTT-PR WsTestAuthenticationType"::Default, false);
        InsertWsLink('OP14-OP13_UNP_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_UNP', 'NAV_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP14-OP13_UNP_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_UNP', 'NAV_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP14-OP13_UNP_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_UNP', 'NAV_DOM_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP14-OP13_UNP_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_UNP', 'NAV_DOM_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP14-OP13_UNP_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_UNP', 'DOM_NAV_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP14-OP13_UNP_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_UNP', 'DOM_NAV_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);

        InsertWsLink('OP14-OP13_WIN_DEF', 'OnPrem14->OnPrem13 TBD', 'OP13_WIN', '', "TTT-PR WsTestAuthenticationType"::Default, false);
        InsertWsLink('OP14-OP13_WIN_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_WIN', 'NAV_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP14-OP13_WIN_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_WIN', 'NAV_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP14-OP13_WIN_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_WIN', 'NAV_DOM_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP14-OP13_WIN_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_WIN', 'NAV_DOM_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP14-OP13_WIN_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_WIN', 'DOM_NAV_WAK', "TTT-PR WsTestAuthenticationType"::Windows, false);
        InsertWsLink('OP14-OP13_WIN_WIN', 'OnPrem14->OnPrem13 TBD', 'OP13_WIN', 'DOM_NAV_PWD', "TTT-PR WsTestAuthenticationType"::Windows, false);

        InsertWsLink('S14-S14_BAS', 'Saas14->Saas14', 'S14', 'ADMIN14_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('S14-S14_BAS', 'Saas14->Saas14', 'S14', 'ADMIN14_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('S14-S14_BAS', 'Saas14->Saas14', 'S14', 'AR14_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('S14-S14_BAS', 'Saas14->Saas14', 'S14', 'AR14_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('S14-SP_BAS', 'Saas14->Saas14 P', 'SP', 'ADMINP_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('S14-SP_BAS', 'Saas14->Saas14 P', 'SP', 'ADMINP_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);
        InsertWsLink('S14-SP_BAS', 'Saas14->Saas14 P', 'SP', 'ARP_WAK', "TTT-PR WsTestAuthenticationType"::Basic, true);
        InsertWsLink('S14-SP_BAS', 'Saas14->Saas14 P', 'SP', 'ARP_PWD', "TTT-PR WsTestAuthenticationType"::Basic, false);

    end;
}
