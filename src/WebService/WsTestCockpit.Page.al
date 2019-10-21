page 50017 "TTT-PR WsTestCockpit"
{
    Caption = 'WsTest Cockpit';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "TTT-PR WsTestConnection";
    Editable = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                InstructionalText = 'Start activating "Install Ws" which gives the Url, then select a "Call Ws" action.';

                field(CodeunitId; intCodeunitId)
                {
                    Caption = 'Codeunit Id';
                    ToolTip = 'This is the codeunit id that you wish to publish';
                    ApplicationArea = All;
                }
                field(Service; txtService)
                {
                    Caption = 'Service';
                    ToolTip = 'This is the name of the service to publish using "Tenant Web Service" table';
                    ApplicationArea = All;
                }
                field(Method; txtMethod)
                {
                    Caption = 'Method';
                    ToolTip = 'This is the name of the procedure that you wish to call from the published codeunit';
                    ApplicationArea = All;
                }
                field(ParamName; txtParamName)
                {
                    Caption = 'Parameter Name';
                    ToolTip = 'This is the name of the parameter in the procedure';
                    ApplicationArea = All;
                }
                field(ParamValue; txtParamValue)
                {
                    Caption = 'Parameter Value';
                    ToolTip = 'This is the value that you want to send in the parameter';
                    ApplicationArea = All;
                }
                field(Address; txtAddress)
                {
                    Caption = 'Address';
                    ToolTip = 'This is the address (url) of the service. The value is populated when installing the web service or when calling GetUrl(...)';
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = false;
                }
            }
            repeater(Lines)
            {
                field("TTT-PR Code"; "TTT-PR Code")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Description"; "TTT-PR Description")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR EndpointCode"; "TTT-PR EndpointCode")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR CredentialCode"; "TTT-PR CredentialCode")
                {
                    ApplicationArea = All;
                    Width = 5;
                }
                field("TTT-PR AuthenticationType"; "TTT-PR AuthenticationType")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR OK"; "TTT-PR OK")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Setup)
            {
                action(InstalWs)
                {
                    Caption = 'Install Ws';
                    ApplicationArea = All;
                    Image = "Action";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        loccuInstaller: Codeunit "TTT-PR WsTestInstaller";
                    begin
                        txtAddress := loccuInstaller.InstallCodeunitWs(intCodeunitId, txtService, true);
                    end;
                }
                action(SetupDemoDataPR)
                {
                    Caption = 'SetupDemoData (PR)';
                    ApplicationArea = All;
                    Image = "Action";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        loccuDemoData: Codeunit "TTT-PR WsTestDemoData";
                    begin
                        loccuDemoData.InsertDemoDataPR();
                    end;
                }
            }
            action(CallWsTestor)
            {
                Caption = 'Call Ws Testor';
                ApplicationArea = All;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    locrecEndpoint: Record "TTT-PR WsTestEndpoint";
                    locrecCredential: Record "TTT-PR WsTestCredential";
                    loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
                begin
                    locrecEndpoint.Get(Rec."TTT-PR EndpointCode");
                    locrecCredential.Get(Rec."TTT-PR CredentialCode");
                    loccuHttp.CallWsTestor(
                        locrecEndpoint."TTT-PR Url",
                        'WsTest', 'SimpleTxt',
                        txtParamName, txtParamValue,
                        locrecCredential."TTT-PR Username", locrecCredential."TTT-PR Password", locrecCredential."TTT-PR DomainName",
                        Rec."TTT-PR AuthenticationType");
                end;
            }
            action(CallSpecificSimpleText)
            {
                Caption = 'Call Specific Simple Text';
                ApplicationArea = All;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    loccuSpec: Codeunit "TTT-PR WsTestSpecifics";
                begin
                    loccuSpec.CallWsSimpleText(Rec);
                end;
            }
            action(CallSpecificSimpleTextVar)
            {
                Caption = 'Call Specific Simple Text Var';
                ApplicationArea = All;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    loccuSpec: Codeunit "TTT-PR WsTestSpecifics";
                begin
                    loccuSpec.CallWsSimpleTextVar(Rec);
                end;
            }
            action(CallSpecificSimpleTextVars)
            {
                Caption = 'Call Specific Simple Text Vars';
                ApplicationArea = All;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    loccuSpec: Codeunit "TTT-PR WsTestSpecifics";
                begin
                    loccuSpec.CallWsSimpleTextVars(Rec);
                end;
            }
            action(CallSpecificDtDiff)
            {
                Caption = 'Call Specific DateTime Diff';
                ApplicationArea = All;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    loccuSpec: Codeunit "TTT-PR WsTestSpecifics";
                begin
                    loccuSpec.CallWsDateTimeDiff(Rec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        intCodeunitId := Codeunit::"TTT-PR WsTestTheServices";
        txtService := 'WsTest';
        txtMethod := 'SimpleText';
        txtParamName := 'partxtInput';
        txtParamValue := 'Hello World!';
    end;

    var
        txtAddress: Text;
        txtService: Text;
        txtMethod: Text;
        txtParamName: Text;
        txtParamValue: Text;
        intCodeunitId: Integer;
}
