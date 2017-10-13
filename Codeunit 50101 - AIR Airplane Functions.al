codeunit 50101 "AIR Airplane Functions"
{
    trigger OnRun();
    begin
    end;
    
    procedure RunCreateNewItem(var AirplaneType : Record "AIR Airplane type");
    var
        Item: Record Item;
        ItemTemplate: Record "Item Template";
    begin
        //if ItemTemplate.NewItemFromTemplate(Item) then begin
        //    COPY(Item);
        //end;
        if AirplaneType."ICAO Code" = '' then
           exit;
           
        Item.INIT;
        Item.Description := AirplaneType.Description;
        Item."AIR Airplane Type" := AirplaneType."ICAO Code";
        if not Item.Insert(true) then
            exit;
        Page.Run(Page::"Item card",Item);
        
    end;
    
    procedure ShowCurrentFlightsForAirplaneType(AirplaneType:Code[20]);
    begin
        Hyperlink(STRSUBSTNO('https://flightaware.com/live/aircrafttype/%1',AirplaneType));
    end;
    
    
    
    
    
}