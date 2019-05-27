page 50026 "TTT-PR PalWsTest"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowVersion)
            {
                Caption = 'Show Version';
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    loccuTest: Codeunit "TTT-PR PalWsTest";
                begin
                    loccuTest.ShowVersion();
                end;
            }
            action(AuthenticateUser)
            {
                Caption = 'Authenticate User';
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    loccuTest: Codeunit "TTT-PR PalWsTest";
                begin
                    loccuTest.AuthenticateUser();
                end;
            }
            action(ListEnvironments)
            {
                Caption = 'List Environments';
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    loccuTest: Codeunit "TTT-PR PalWsTest";
                begin
                    loccuTest.ListEnvironments();
                end;
            }
            action(ListCompanies)
            {
                Caption = 'List Companies';
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    loccuTest: Codeunit "TTT-PR PalWsTest";
                begin
                    loccuTest.ListCompanies();
                end;
            }
            action(InsertRecord)
            {
                Caption = 'Insert Record';
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    loccuTest: Codeunit "TTT-PR PalWsTest";
                begin
                    loccuTest.InsertRecord();
                end;
            }
        }
    }
}