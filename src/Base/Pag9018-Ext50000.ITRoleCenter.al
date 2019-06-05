pageextension 50000 "TTT-PR IT Role Center" extends "Administrator Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addfirst(Embedding)
        {
            action("TTT-PR ObjectRunnerEmbedding")
            {
                ApplicationArea = All;
                Caption = 'TTTPR Object Runner(emb)';
                ToolTip = 'TTTPR Object Runner Embedding';
                Image = SuggestNumber;
                RunObject = Page "TTT-PR ObjectRunnerList";
            }
        }

        addfirst(Creation)
        {
            action("TTT-PR ObjectRunnerCreationSingle")
            {
                Caption = 'TTTPR Object Runner(crt)';
                ToolTip = 'TTTPR Object Runner Creation';
                ApplicationArea = All;
                Image = "Table";
                RunObject = Page "TTT-PR ObjectRunnerList";
            }
        }
        addfirst(Navigation)
        {
            action("TTT-PR ObjectRunnerNavigationSingle")
            {
                Caption = 'TTTPR Object Runner(nav)';
                ToolTip = 'TTTPR Object Runner Navigation';
                ApplicationArea = All;
                Image = "Table";
                RunObject = Page "TTT-PR ObjectRunnerList";
            }
        }
        addfirst(Reporting)
        {
            action("TTT-PR ObjectRunnerReportingSingle")
            {
                Caption = 'TTTPR Object Runner(rep)';
                ToolTip = 'TTTPR Object Runner Reporting';
                ApplicationArea = All;
                Image = "Table";
                RunObject = Page "TTT-PR ObjectRunnerList";
            }
        }

        addfirst(Processing)
        {
            action("TTT-PR ObjectRunnerProcessingSingle")
            {
                Caption = 'TTTPR Object Runner(prc)';
                ToolTip = 'TTTPR Object Runner';
                ApplicationArea = All;
                Image = "Table";
                RunObject = Page "TTT-PR ObjectRunnerList";
            }
            group("TTT-PR MainGroupProcessing")
            {
                Caption = 'TTTPR Menu(prc)', Comment = 'Dont translate this!', Locked = true;
                ToolTip = 'TTTPR functionality';

                group("TTT-PR GroupProcessing")
                {
                    Caption = 'TTTPR', Comment = 'Dont translate this!', Locked = true;
                    ToolTip = 'TTTPR functionality';
                    Image = WorkCenter;

                    group("TTT-PR ObjectsGroupProcessing")
                    {
                        Caption = 'Objects';
                        ToolTip = 'Object functionality';
                        Image = SuggestTables;

                        action("TTT-PR ObjectRunnerProcessing")
                        {
                            Caption = 'Show Object Runner';
                            ToolTip = 'Show the Object Runner List';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page "TTT-PR ObjectRunnerList";
                        }
                    }
                    group("TTT-PR TableFilterGroupProcessing")
                    {
                        Caption = 'Table Filter';
                        ToolTip = 'Table Filter functionality';
                        Image = SuggestTables;

                        action("TTT-PR TableFilterSimpleProcessing")
                        {
                            Caption = 'Table Filter Simple';
                            ToolTip = 'Show Simple Table Filter';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page "TTT-PR TableFilterExSimple";
                            RunPageMode = Edit;
                        }
                    }

                    group("TTT-PR Misc")
                    {
                        Caption = 'Misc.';
                        ToolTip = 'Misc. functionality';
                        Image = Action;

                        action("TTT-PR HyperlinkWrapper")
                        {
                            Caption = 'Hyperlink Wrapper';
                            ToolTip = 'Run the Hyperlink Wrapper';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = codeunit "TTT-PR HyperlinkWrapper";
                        }
                    }
                }
            }
        }

        addfirst(Sections)
        {
            group("TTT-PR GroupSections")
            {
                Caption = 'TTTPR(sect)';
                ToolTip = 'TTTPR Elements';
                Image = Dimensions;
                action("TTT-PR ObjectRunnerSections")
                {
                    Caption = 'Show Object Runner';
                    ToolTip = 'Show the Object Runner List';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTT-PR ObjectRunnerList";
                }

                action("TTT-PR TableFilterExampleSimpleSections")
                {
                    Caption = 'Show Table Filter (Simple)';
                    ToolTip = 'Show the simple Table Filter example';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTT-PR TableFilterExSimple";
                    RunPageMode = Edit;
                }
            }
        }
    }
}