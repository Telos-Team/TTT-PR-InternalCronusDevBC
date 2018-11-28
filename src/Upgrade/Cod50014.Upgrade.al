codeunit 50014 "TTTPR CoreUpgrade"
{
    // <TTT001>
    //   Created.
    // </TTT001>

    Description = 'TTT Core Upgrade. Object handles upgrade routines';
    Subtype = Upgrade;

    // CHECK -> UPGRADE -> VALIDATE

    var
        cuModuleInfoWrapper: Codeunit "TTTPR CoreModuleInfoWrapper";
}