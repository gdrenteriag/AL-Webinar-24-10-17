page 50100 "Airplane Type List"
{
    PageType = List;
    SourceTable = "Airplane type";
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