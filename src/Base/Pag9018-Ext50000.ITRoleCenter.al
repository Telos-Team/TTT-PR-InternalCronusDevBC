pageextension 50000 "TTTPR IT Role Center" extends "Administrator Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Embedding)
        {
            action("TTTPR ObjectRunnerEmbedding")
            {
                ApplicationArea = All;
                Caption = 'Show Object Runner';
                ToolTip = 'Show the Object Runner List';
                Image = SuggestNumber;
                RunObject = Page "TTTPRObjectRunnerList";
            }
        }

        addfirst(Processing)
        {
            action("TTTPR Testor")
            {
                Caption = 'TTTPR Testor';
                ToolTip = 'TTTPR Testor';
                ApplicationArea = All;
                Image = "Table";
                RunObject = codeunit "TTTPR GraphTests";
            }
            group("TTTPR MainGroupProcessing")
            {
                Caption = 'TTTPR', Comment = 'Dont translate this!', Locked = true;
                ToolTip = 'TTTPR functionality';

                group("TTTPR GroupProcessing")
                {
                    Caption = 'TTTPR', Comment = 'Dont translate this!', Locked = true;
                    ToolTip = 'TTTPR functionality';
                    Image = WorkCenter;

                    group("TTTPR ObjectsGroupProcessing")
                    {
                        Caption = 'Objects';
                        ToolTip = 'Object functionality';
                        Image = SuggestTables;

                        action("TTTPR ObjectRunnerProcessing")
                        {
                            Caption = 'Show Object Runner';
                            ToolTip = 'Show the Object Runner List';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page "TTTPRObjectRunnerList";
                        }
                    }
                    group("TTTPR TableFilterGroupProcessing")
                    {
                        Caption = 'Table Filter';
                        ToolTip = 'Table Filter functionality';
                        Image = SuggestTables;

                        action("TTTPR TableFilterSimpleProcessing")
                        {
                            Caption = 'Table Filter Simple';
                            ToolTip = 'Show Simple Table Filter';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page "TTTPR TableFilterExampleSimple";
                            RunPageMode = Edit;
                        }
                        action("TTTPR TableFilterRecRefProcessing")
                        {
                            Caption = 'Table Filter RecRef';
                            ToolTip = 'Show RecRef Table Filter';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page "TTTPR TableFilterExampleRecRef";
                            RunPageMode = Edit;
                        }
                    }

                    group("TTTPR Translation")
                    {
                        Caption = 'Translation';
                        ToolTip = 'Translation functionality';
                        Image = SuggestTables;

                        action("TTTPR TranslationWorksheetProcessing")
                        {
                            Caption = 'Show Translation Worksheet';
                            ToolTip = 'Show the Translation Worksheet';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page "TTTPR TranslationWorksheet";
                            RunPageMode = Edit;
                        }
                    }
                }
            }
        }

        addfirst(Sections)
        {
            group("TTTPR GroupSections")
            {
                Caption = 'TTTPR';
                ToolTip = 'TTTPR Elements';
                Image = Dimensions;
                action("TTTPR ObjectRunnerSections")
                {
                    Caption = 'Show Object Runner';
                    ToolTip = 'Show the Object Runner List';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTTPRObjectRunnerList";
                }

                action("TTTPR TableFilterExampleSimpleSections")
                {
                    Caption = 'Show Table Filter (Simple)';
                    ToolTip = 'Show the simple Table Filter example';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTTPR TableFilterExampleSimple";
                    RunPageMode = Edit;
                }
                action("TTTPR TableFilterExampleRecRefSections")
                {
                    Caption = 'Show Table Filter (RecRef)';
                    ToolTip = 'Show the RecordRef Table Filter example';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTTPR TableFilterExampleRecRef";
                    RunPageMode = Edit;
                }

                action("TTTPR TranslationSections")
                {
                    Caption = 'Show Translation Worksheet';
                    ToolTip = 'Show the Translation Worksheet';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTTPR TranslationWorksheet";
                    RunPageMode = Edit;
                }

            }
        }
    }

    var
        myInt: Integer;
}