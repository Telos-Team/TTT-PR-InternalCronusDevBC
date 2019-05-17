page 50014 "TTT-PR PageTestWizard"
{
    Description = 'This is a kind of template to easily create wizards';
    Caption = 'PageTestWizard';
    PageType = NavigatePage;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(Banner)
            {
                Editable = false;
                Visible = booBannerVisible;
                group(InProgressMedia)
                {
                    ShowCaption = false;
                    Visible = enumStep <> enumStep::Finish;
                    field("MediaResourceInProgress"; recMediaResourceInProgress."Media Reference")
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                    }
                }
                group(FinishMedia)
                {
                    ShowCaption = false;
                    Visible = enumStep = enumStep::Finish;
                    field("MediaResourceFinish"; recMediaResourceFinish."Media Reference")
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                    }
                }
                field("CurrentStepInProgress"; enumStep)
                {
                    ShowCaption = false;
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
            }

            group(FirstStep)
            {
                Visible = enumStep = enumStep::First;

                group("Part1")
                {
                    Caption = 'Welcome';

                    group("Part1.1")
                    {
                        Caption = 'Introduction';
                        InstructionalText = 'Bla.Bla.Bla';
                    }

                    group("Part1.2")
                    {
                        Caption = 'Terms';
                        InstructionalText = 'yes yes yes';

                        group("Part1.2.1")
                        {
                            Caption = 'More terms';
                            InstructionalText = 'do this...';
                        }
                    }

                    group("Part1.3")
                    {
                        Caption = 'Mandatory choice';
                        InstructionalText = 'do that...';
                        field(SelectThis; booSelectThis)
                        {
                            Caption = 'Accept terms';
                            ApplicationArea = All;
                            MultiLine = true;
                            Editable = true;

                            trigger OnValidate()
                            begin
                                ResetControls();
                            end;
                        }
                    }
                }
            }
            group(SecondStep)
            {
                Visible = enumStep = enumStep::Second;

                group("Part2")
                {
                    Caption = 'Hi there';
                    InstructionalText = 'More text...';
                    group("Part2.1")
                    {
                        Caption = 'Second terms';
                        InstructionalText = 'do that...';
                    }
                }
            }

            group(ThirdStep)
            {
                Visible = enumStep = enumStep::Third;

                group("Part3")
                {
                    Caption = 'Again...';
                    InstructionalText = 'Even more text...';
                    group("Part3.1")
                    {
                        Caption = 'Third terms';
                        InstructionalText = 'and then...';
                    }
                }
            }

            group(FinishStep)
            {
                Visible = enumStep = enumStep::Finish;

                group("Last")
                {
                    Caption = 'The end';
                    InstructionalText = 'That is it...';
                    group("Part4.1")
                    {
                        Caption = 'and that is that!';
                        InstructionalText = 'Press finish to end wizard.';
                    }
                }
            }
        }
        area(Factboxes)
        {
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionBack)
            {
                Caption = 'Back';
                ApplicationArea = All;
                Enabled = booBackEnabled;
                Visible = booBackEnabled;
                Image = PreviousRecord;
                InFooterBar = true;

                trigger OnAction();
                begin
                    PerformBackStep();
                end;
            }
            action(ActionNext)
            {
                Caption = 'Next';
                ApplicationArea = All;
                Enabled = booNextEnabled and booSelectThis;
                Visible = booNextEnabled;
                Image = NextRecord;
                InFooterBar = true;

                trigger OnAction();
                begin
                    PerformNextStep();
                end;
            }
            action(ActionFinish)
            {
                Caption = 'Finish';
                ApplicationArea = All;
                Enabled = booFinishEnabled;
                Visible = booFinishEnabled;
                Image = Approve;
                InFooterBar = true;

                trigger OnAction();
                begin
                    FinishUpAndLeave();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        InitializeControls();
    end;

    trigger OnOpenPage()
    begin
    end;

    var
        recMediaResourceInProgress: Record "Media Resources";
        recMediaResourceFinish: Record "Media Resources";
        booBannerVisible: Boolean;
        booSelectThis: Boolean;
        booBackEnabled: Boolean;
        booNextEnabled: Boolean;
        booFinishEnabled: Boolean;
        enumStep: Enum "TTT-PR PageTestWizardStep";
        lblAssistedSetupTxt: Label 'AssistedSetup-NoText-400px.png', Locked = true, Comment = 'Used for top banner image';
        lblAssistedSetupDoneTxt: Label 'AssistedSetupDone-NoText-400px.png', Locked = true, Comment = 'Used for top banner image';

    local procedure InitializeControls()
    begin
        enumStep := enumStep::First;
        ResetControls();
        UpdateBannerVisibility();
    end;

    local procedure ResetControls()
    begin
        booBackEnabled := enumStep > enumStep::First;
        booNextEnabled := enumStep < enumStep::Finish;
        booFinishEnabled := enumStep = enumStep::Finish;
    end;

    local procedure UpdateBannerVisibility()
    var
        locrecMediaRepoInProgress: Record "Media Repository";
        locrecMediaRepoFinish: Record "Media Repository";
    begin
        booBannerVisible := true;
        if locrecMediaRepoInProgress.Get(lblAssistedSetupTxt, Format(CurrentClientType())) then
            if recMediaResourceInProgress.Get(locrecMediaRepoInProgress."Media Resources Ref") then;
        if locrecMediaRepoFinish.Get(lblAssistedSetupDoneTxt, Format(CurrentClientType())) then
            if recMediaResourceFinish.Get(locrecMediaRepoFinish."Media Resources Ref") then;
    end;

    local procedure PerformBackStep()
    var
        locintTestor: Integer;
    begin
        repeat
            enumStep -= 1;
        until not Evaluate(locintTestor, Format(enumStep));
        ResetControls();
    end;

    local procedure PerformNextStep()
    var
        locintTestor: Integer;
    begin
        repeat
            enumStep += 1;
        until not Evaluate(locintTestor, Format(enumStep));
        ResetControls();
    end;

    local procedure FinishUpAndLeave()
    begin
        CurrPage.Close();
    end;
}
