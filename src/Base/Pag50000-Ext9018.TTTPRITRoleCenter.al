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
            action("TTTPRObjectRunnerEmbedding")
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
            group(TTTPRMainGroupProcessing)
            {
                Caption = 'TTTPR', Comment = 'Dont translate this!', Locked = true;
                ToolTip = 'TTTPR functionality';

                group(TTTPRGroupProcessing)
                {
                    Caption = 'TTTPR', Comment = 'Dont translate this!', Locked = true;
                    ToolTip = 'TTTPR functionality';
                    Image = WorkCenter;

                    group(ObjectsGroupProcessing)
                    {
                        Caption = 'Objects';
                        ToolTip = 'Object functionality';
                        Image = SuggestTables;

                        action("ObjectRunnerProcessing")
                        {
                            Caption = 'Show Object Runner';
                            ToolTip = 'Show the Object Runner List';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page "TTTPRObjectRunnerList";
                        }
                    }
                    group(TableFilterGroupProcessing)
                    {
                        Caption = 'Table Filter';
                        ToolTip = 'Table Filter functionality';
                        Image = SuggestTables;

                        action("TableFilterSimpleProcessing")
                        {
                            Caption = 'Table Filter Simple';
                            ToolTip = 'Show Simple Table Filter';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page TTTPRTableFilterExampleSimple;
                            RunPageMode = Edit;
                        }
                        action("TableFilterRecRefProcessing")
                        {
                            Caption = 'Table Filter RecRef';
                            ToolTip = 'Show RecRef Table Filter';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page TTTPRTableFilterExampleRecRef;
                            RunPageMode = Edit;
                        }
                    }

                    group(Translation)
                    {
                        Caption = 'Translation';
                        ToolTip = 'Translation functionality';
                        Image = SuggestTables;

                        action("TranslationWorksheetProcessing")
                        {
                            Caption = 'Show Translation Worksheet';
                            ToolTip = 'Show the Translation Worksheet';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page TTTPRTranslationWorksheet;
                            RunPageMode = Edit;
                        }
                    }
                }
            }
        }

        addfirst(Sections)
        {
            group(TTTPRGroupSections)
            {
                Caption = 'TTTPR';
                ToolTip = 'TTTPR Elements';
                Image = Dimensions;
                action("ObjectRunnerSections")
                {
                    Caption = 'Show Object Runner';
                    ToolTip = 'Show the Object Runner List';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTTPRObjectRunnerList";
                }

                action("TableFilterExampleSimpleSections")
                {
                    Caption = 'Show Table Filter (Simple)';
                    ToolTip = 'Show the simple Table Filter example';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTTPRTableFilterExampleSimple";
                    RunPageMode = Edit;
                }
                action("TableFilterExampleRecRefSections")
                {
                    Caption = 'Show Table Filter (RecRef)';
                    ToolTip = 'Show the RecordRef Table Filter example';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTTPRTableFilterExampleRecRef";
                    RunPageMode = Edit;
                }

                action("TranslationSections")
                {
                    Caption = 'Show Translation Worksheet';
                    ToolTip = 'Show the Translation Worksheet';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page TTTPRTranslationWorksheet;
                    RunPageMode = Edit;
                }

            }
        }
    }

    var
        myInt: Integer;
}