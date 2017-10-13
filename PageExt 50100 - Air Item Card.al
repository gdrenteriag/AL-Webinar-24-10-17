pageextension 50100 "AIR Item Card" extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Product Group Code")
        {
            field("AIR Airplane Type";"AIR Airplane Type")
            {
                ApplicationArea = All;
                LookupPageId = "AIR Airplane Type List";
            }
        }
    }
    
    actions
    {
        // Add changes to page actions here
        addbefore(Warehouse)
        {
            Action(ShowLiveFlights)
            {
                ApplicationArea = ALL;
                CaptionML = ENU = 'Live Flights';
                ToolTipML = ENU = 'Show live flight of current airplane type';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Map;
                PromotedOnly = false;
                
                trigger OnAction();
                var
                    AIRFunctions: Codeunit "AIR Airplane Functions";
                begin
                    if "AIR Airplane Type" <> '' then
                        AIRFunctions.ShowCurrentFlightsForAirplaneType("AIR Airplane Type")
                    else
                        Message('Fill Airplane Type');
                end;
                
            }
        }
        
    }
    
    var
    
    
    trigger OnOpenPage();
    var
        SetFilterOnDropDownPage: Codeunit "GEN SetFilter On DropDown Page";
    begin
        SetFilterOnDropDownPage.ClearFilter;
    end;
    
    trigger OnClosePage();
    var
        SetFilterOnDropDownPage: Codeunit "GEN SetFilter On DropDown Page";
    begin
        SetFilterOnDropDownPage.ClearFilter;
    end;
    
    trigger OnAfterGetCurrRecord();
    var
        SetFilterOnDropDownPage: Codeunit "GEN SetFilter On DropDown Page";
        AirplaneFunctions : Codeunit "AIR Airplane Functions";
    begin
        if CurrPage.Editable then
            SetFilterOnDropDownPage.SetFilter(AirplaneFunctions.CreateFilterFromItemDescription(Rec));
    end;    
    
}