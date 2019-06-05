page 50017 "TTT-PR WsTestCockpit"
{
    Caption = 'WsTest Cockpit';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "TTT-PR WsTestCredential";
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
                field("TTT-PR Url"; "TTT-PR Url")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Username"; "TTT-PR Username")
                {
                    ApplicationArea = All;
                    Width = 10;
                }
                field("TTT-PR AccessKey"; "TTT-PR AccessKey")
                {
                    ApplicationArea = All;
                    Width = 10;
                }
                field("TTT-PR DomainName"; "TTT-PR DomainName")
                {
                    ApplicationArea = All;
                    Width = 5;
                }
                field("TTT-PR Password"; "TTT-PR Password")
                {
                    ApplicationArea = All;
                    Width = 10;
                }
            }
        }
    }

    actions
    {
        area(Processing)
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
            action(CallWs)
            {
                Caption = 'Call Ws';
                ApplicationArea = All;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
                begin
                    loccuHttp.CallWsSimpleStringTestor("TTT-PR Url", txtService, txtMethod, txtParamName, txtParamValue, "TTT-PR Username", "TTT-PR AccessKey", "TTT-PR DomainName", "TTT-PR Password");
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
                    loccuSpec.CallWsSimpleText("TTT-PR Url", "TTT-PR Username", "TTT-PR AccessKey");
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
                    loccuSpec.CallWsSimpleTextVar("TTT-PR Url", "TTT-PR Username", "TTT-PR AccessKey");
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
                    loccuSpec.CallWsSimpleTextVars("TTT-PR Url", "TTT-PR Username", "TTT-PR AccessKey");
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
                    loccuSpec.CallWsDateTimeDiff("TTT-PR Url", "TTT-PR Username", "TTT-PR AccessKey");
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
