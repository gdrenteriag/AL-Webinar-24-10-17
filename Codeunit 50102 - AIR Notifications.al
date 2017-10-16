codeunit 50102 "AIR Notifications"
{
    trigger OnRun();
    begin
    end;
    
    procedure GetNotificationGUID(): Text;
    begin
        exit('7b5c0621-bc48-4e9a-b790-493761b56877')
    end;
    
    [EventSubscriber(ObjectType::Page,31,'OnOpenPageEvent','',true,true)]
    local procedure NotifyAboutNewAppOnOpenItemListPage(var Rec: Record Item);
    var
        AirPlaneType: Record "AIR Airplane type";
    begin
        if AirPlaneType.IsEmpty then
            ShowNotificationWhenAIRappIsNotSetuped;
    end;

    procedure ShowNotificationWhenAIRappIsNotSetuped();
    var
        MyNotification: Notification;
    begin
        with MyNotification do begin
            Id := GetNotificationGUID;
            Message := 'You have installed new App. But it is not setuped yet. Do you want to setup it now?';
            Scope := NotificationScope::LocalScope;
            AddAction('Yes',Codeunit::"AIR Notifications Actions",'RunAIRSetup');
            AddAction('Learn more',Codeunit::"AIR Notifications Actions",'LearnMoreAboutApp');
            Send;
        end;
    end;
    
    procedure ShowNotificationWhenAirplaneTypesIsEmpty();
    var
        MyNotification: Notification;
    begin
        with MyNotification do begin
            Id := GetNotificationGUID;
            Message := 'Seems, like list is empty. You can fill it in one click';
            Scope := NotificationScope::LocalScope;
            AddAction('Make me happy',Codeunit::"AIR Notifications Actions",'UpdateAirPlanesTypeList');
            Send;
        end;
    end;
    
    procedure ShowNotificationAfterAirplaneTypesWereUpdated();
    var
        MyNotification: Notification;
        AirplaneTypes: Record "AIR Airplane type";
    begin
        with MyNotification do begin
            Id := GetNotificationGUID;
            Message := STRSUBSTNO('List was updated with %1 airplanes types',AirplaneTypes.Count);
            Scope := NotificationScope::LocalScope;
            Send;
        end;
    end;
    
    
    
}