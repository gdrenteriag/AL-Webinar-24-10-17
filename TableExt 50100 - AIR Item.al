tableextension 50100 "AIR Item" extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50150;"AIR Airplane Type";Code[20])
        {
            CaptionML = ENU = 'Airplane Type';
            TableRelation = "AIR Airplane type"."ICAO Code";
            ValidateTableRelation = true;
            trigger OnValidate();
            begin
                UpdateDescriptionFromAirPlaneType;
            end;
        }
    }
    
    local procedure UpdateDescriptionFromAirPlaneType();
    var
        AirplaneType: Record "AIR Airplane type";
    begin
        if "AIR Airplane Type" = '' then
            exit;
            
        AirplaneType.Get("AIR Airplane Type");
        Description := AirplaneType.Description;
    end;
}