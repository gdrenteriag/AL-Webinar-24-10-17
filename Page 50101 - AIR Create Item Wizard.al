page 50101 "AIR Create Item Wizard"
{
    CaptionML=ENU='Create new item';
    PageType = NavigatePage;
    SourceTable = Item;
    SourceTableTemporary=true;
    
    layout
    {
        area(content)
        {
            group(Group96)
            {
                CaptionML=ENU='';
                Editable=false;
                Visible=TopBannerVisible and not Step3Visible;
                field(MediaResourcesStandard;MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea=All;
                    Editable=false;
                    ShowCaption=false;
                }
            }
            group(Group98)
            {
                CaptionML=ENU='';
                Editable=false;
                Visible=TopBannerVisible and Step3Visible;
                field(MediaResourcesDone;MediaResourcesDone."Media Reference")
                {
                    ApplicationArea=Basic,Suite,Invoicing;
                    Editable=false;
                    ShowCaption=false;
                }
            }
            
            group(Step1)
            {
                Visible=Step1Visible;
                group("Welcome to create new item wizard")
                {
                    CaptionML=ENU='Welcome to create new item';
                    Visible=Step1Visible;
                    group(Group18)
                    {
                        CaptionML=ENU='';
                        InstructionalTextML=ENU='This wizard will help you to create new airplane';
                    }
                }
                group("Let's go!")
                {
                    CaptionML=ENU='Let''s go!';
                    group(Group22)
                    {
                        CaptionML=ENU='';
                        InstructionalTextML=ENU='Click on Next. Good luck!';
                    }
                }
            }
            
            group(Step2)
            {
                CaptionML=ENU='';
                InstructionalTextML=ENU='Please, fill next fields';
                Visible=Step2Visible;
                //You might want to add fields here

                field(Descriprion;Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("AIR Airplane Type";"AIR Airplane Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Base Unit of Measure";"Base Unit of Measure")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
/*                 field(Picture;Picture)
                {
                    ApplicationArea = All;
                } */
            }
            
            
            group(Step3)
            {
                Visible=Step3Visible;
                group(Group23)
                {
                    CaptionML=ENU='';
                    //InstructionalTextML=ENU='To view your airplane, click Finish';
                }
                group("That's it!")
                {
                    CaptionML=ENU='That''s it!';
                    group(Group25)
                    {
                        CaptionML=ENU='';
                        InstructionalTextML=ENU='To save this setup, choose Finish.';
                    }
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            Action(ActionBack)
            {
                ApplicationArea=All;
                CaptionML=ENU='Back';
                Enabled=BackActionEnabled;
                Image=PreviousRecord;
                InFooterBar=true;
                trigger OnAction();
                begin
                    NextStep(true);
                end;
            }
            Action(ActionNext)
            {
                ApplicationArea=All;
                CaptionML=ENU='Next';
                Enabled=NextActionEnabled;
                Image=NextRecord;
                InFooterBar=true;
                trigger OnAction();
                begin
                    NextStep(false);
                end;
            }
            Action(ActionFinish)
            {
                ApplicationArea=Basic,Suite,Invoicing;
                CaptionML=ENU='Finish';
                Enabled=FinishActionEnabled;
                Image=Approve;
                InFooterBar=true;
                trigger OnAction();
                begin
                    FinishAction;
                end;
            }
        }
    }
    trigger OnInit();
    begin
        LoadTopBanners;
    end;
    trigger OnOpenPage();
    var
        //Item: Record Item;
    begin
        INIT;
        //if Item.Get then begin
        //    TRANSFERFIELDS(Item);
        //end;
        Description := AirplaneType.Description;
        "AIR Airplane Type" := AirplaneType."ICAO Code";
        Insert;

        
        Step := Step::Start;
        EnableControls;
    end;
    var
        MediaRepositoryDone: Record 9400;
        MediaRepositoryStandard: Record 9400;
        MediaResourcesDone: Record 2000000182;
        MediaResourcesStandard: Record 2000000182;
        BackActionEnabled: Boolean;
        FinishActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        Step1Visible: Boolean;
        Step2Visible: Boolean;
        Step3Visible: Boolean;
        TopBannerVisible: Boolean;
        Step: Option Start,Step2,Finish;
        Item: Record "Item";
        AirplaneType: Record "AIR Airplane type";

    local procedure EnableControls();
    begin
        ResetControls;
        
        case Step of
            Step::Start:
                ShowStep1;
            Step::Step2:
                ShowStep2;
            Step::Finish:
                ShowStep3;
        end;
    end;
    
    local procedure SaveInDatabase();
    var
    begin
        //if not Item.Get then begin
        //    Item.INIT;
        //    Item.Insert;
        //end;
        
        Item.TRANSFERFIELDS(Rec,false);
        Item.insert(true);
        //COMMIT;
    end;
    
    
    local procedure FinishAction();
    begin
        SaveInDatabase;
        CurrPage.CLOSE;
        Page.Run(PAGE::"Item Card",Item)
    end;
    
    local procedure NextStep(Backwards : Boolean);
    begin
        if Backwards then
            Step := Step - 1
        else
            Step := Step + 1;
            
        EnableControls;
    end;
    
    local procedure ShowStep1();
    begin
        Step1Visible := true;
        
        FinishActionEnabled := false;
        BackActionEnabled := false;
    end;
    
    local procedure ShowStep2();
    begin
        Step2Visible := true;
    end;
    
    local procedure ShowStep3();
    begin
        Step3Visible := true;
        
        NextActionEnabled := false;
        FinishActionEnabled := true;
    end;
    
    local procedure ResetControls();
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;
        
        Step1Visible := false;
        Step2Visible := false;
        Step3Visible := false;
    end;
    
    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png',Format(CURRENTCLIENTTYPE)) and
            MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png',Format(CURRENTCLIENTTYPE))
        then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
                MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue;
    end;

    procedure InitParameters (var AirType: Record "AIR Airplane type");
    begin
        AirplaneType := AirType;
    end;
}