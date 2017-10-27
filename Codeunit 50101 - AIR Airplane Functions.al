codeunit 50101 "AIR Airplane Functions"
{
    trigger OnRun();
    begin
    end;
    
    procedure RunCreateNewItem(var AirplaneType : Record "AIR Airplane type");
    var
        //Item: Record Item;
        //ItemTemplate: Record "Item Template";
        ItemCreateWizard: page "AIR Create Item Wizard";
    begin
        //if ItemTemplate.NewItemFromTemplate(Item) then begin
        //    COPY(Item);
        //end;

        /* if AirplaneType."ICAO Code" = '' then
            exit;
            
        Item.INIT;
        Item.Description := AirplaneType.Description;
        Item."AIR Airplane Type" := AirplaneType."ICAO Code";
        if not Item.Insert(true) then
            exit;
        Page.Run(Page::"Item card",Item); */
        ItemCreateWizard.InitParameters(AirplaneType);
        ItemCreateWizard.Run;
    end;
    
    procedure ShowCurrentFlightsForAirplaneType(AirplaneType:Code[20]);
    var
    begin
        Hyperlink(STRSUBSTNO('https://flightaware.com/live/aircrafttype/%1',AirplaneType));    
    end;
    
    [EventSubscriber(ObjectType::Table,Database::Item,'OnAfterValidateEvent','Description',true,true)]
    local procedure OnItemAfterValidateDescription(var Rec: Record Item; var xRec: Record Item; currFieldNo: Integer)
    var
        SetFilterOnDropDownPage: Codeunit "GEN SetFilter On DropDown Page";
    begin
        SetFilterOnDropDownPage.SetFilter(CreateFilterFromItemDescription(Rec));
    end;
    
    procedure CreateFilterFromItemDescription(Rec: Record Item): Text;
    var
        CopyTo: Integer;
    begin
        CopyTo := STRPOS(Rec."Description",' ');
        if CopyTo <> 0 then
            exit(STRSUBSTNO('%1*',Copystr(Rec."Description",1,CopyTo)));
    end;
    
    
    
    
}