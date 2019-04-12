pageextension 50000 "TTT-PR IT Role Center" extends "Administrator Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Embedding)
        {
            action("TTT-PR ObjectRunnerEmbedding")
            {
                ApplicationArea = All;
                Caption = 'Show Object Runner';
                ToolTip = 'Show the Object Runner List';
                Image = SuggestNumber;
                RunObject = Page "TTT-PR ObjectRunnerList";
            }
        }

        addfirst(Processing)
        {
            action("TTT-PR Testor")
            {
                Caption = 'TTTPR Testor';
                ToolTip = 'TTTPR Testor';
                ApplicationArea = All;
                Image = "Table";
                RunObject = codeunit "TTT-PR GraphTests";
            }
            group("TTT-PR MainGroupProcessing")
            {
                Caption = 'TTTPR', Comment = 'Dont translate this!', Locked = true;
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
                        action("TTT-PR TableFilterRecRefProcessing")
                        {
                            Caption = 'Table Filter RecRef';
                            ToolTip = 'Show RecRef Table Filter';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page "TTT-PR TableFilterExRecRef";
                            RunPageMode = Edit;
                        }
                    }

                    group("TTT-PR Translation")
                    {
                        Caption = 'Translation';
                        ToolTip = 'Translation functionality';
                        Image = SuggestTables;

                        action("TTT-PR TranslationWorksheetProcessing")
                        {
                            Caption = 'Show Translation Worksheet';
                            ToolTip = 'Show the Translation Worksheet';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page "TTT-PR TranslationWorksheet";
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
                Caption = 'TTTPR';
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
                action("TTT-PR TableFilterExampleRecRefSections")
                {
                    Caption = 'Show Table Filter (RecRef)';
                    ToolTip = 'Show the RecordRef Table Filter example';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTT-PR TableFilterExRecRef";
                    RunPageMode = Edit;
                }

                action("TTT-PR TranslationSections")
                {
                    Caption = 'Show Translation Worksheet';
                    ToolTip = 'Show the Translation Worksheet';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTT-PR TranslationWorksheet";
                    RunPageMode = Edit;
                }

            }
        }
    }

}