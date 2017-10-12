page 50100 "AIR Airplane Type List"
{
    PageType = List;
    SourceTable = "AIR Airplane type";
    Editable = false;
    SourceTableView = sorting (Popularity) order (descending);
    
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field ("ICAO Code";"ICAO Code")
                {
                    ApplicationArea = All;
                }
                field (Description;Description)
                {
                    ApplicationArea = All;
                }
                field (Popularity;Popularity)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
        }
    }
    
    actions
    {
        area(processing)
        {
            Action(GetAirplaneTypes)
            {
                CaptionML = ENU = 'Update';
                ToolTipML = ENU = 'Update airplanes types from ICAO webservice';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Image = UpdateXML;
                
                trigger OnAction();
                var
                    ICAOFunctions: Codeunit "AIR ICAO Functions";
                begin
                    ICAOFunctions.GetAirplaneTypes();
                    CurrPage.Update;
                    if FindFirst then
                        Message('List was updated with %1 airplanes types',Count);
                        
                end;
            }
        }
    }
}