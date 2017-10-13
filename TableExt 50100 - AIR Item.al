tableextension 50100 MyExtension extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50150;"AIR Airplane Type";Code[20])
        {
            CaptionML = ENU = 'Airplane Type';
            TableRelation = "AIR Airplane type"."ICAO Code";
            ValidateTableRelation = true;
        }
    }
    
    var
}