pageextension 50101 "AIR Item List Extension" extends "Item List"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnOpenPage(); 
    var
        AirPlaneType: Record "AIR Airplane type";
        Notification : Codeunit "AIR Notifications";
    begin
        if AirPlaneType.IsEmpty then
            Notification.ShowNotificationWhenAIRappIsNotSetuped;
    end;
    
}