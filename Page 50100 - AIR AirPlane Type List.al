page 50100 "AIR Airplane Type List"
{
    PageType = List;
    SourceTable = "AIR Airplane type";
    Editable = false;
    
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
            Action(ActionName)
            {
                trigger OnAction();
                begin
                end;
            }
        }
    }
}