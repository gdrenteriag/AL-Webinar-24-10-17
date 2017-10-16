codeunit 50103 "AIR Notifications Actions"
{
    trigger OnRun();
    begin
    end;
    
    procedure RunAIRSetup(var MyNotification : Notification);
    begin
        Page.Run(Page::"AIR Airplane Type List");
    end;
    
    procedure LearnMoreAboutApp(var MyNotification : Notification);
    begin
        PlayVideo('https://www.youtube.com/embed/3MgjS3DTB_0');
    end;
    
    local procedure PlayVideo(Url: Text);
    var
        VideoLink: Page "Video link";
        ClientTypeMgt: Codeunit ClientTypeManagement;
    begin
        if ClientTypeMgt.IsCommonWebClientType then
            begin
                VideoLink.SetURL(Url);
                VideoLink.RunModal;
        end else
            Hyperlink(Url);
    end;
    
    procedure UpdateAirPlanesTypeList(var MyNotification : Notification);
    var
        ICAOFunctions: Codeunit "AIR ICAO Functions";        
    begin
        ICAOFunctions.GetAirplaneTypes();
    end;
    
    
    
}