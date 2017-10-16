codeunit 50100 "AIR ICAO Functions"
{
    trigger OnRun();
    begin
    end;
    
    var
    
    procedure GetAirplaneTypes();
    var
        AirplaneNotifications: Codeunit "AIR Notifications";        
    begin
        GetAirplaneTypesFromIATACodes();
        AirplaneNotifications.ShowNotificationAfterAirplaneTypesWereUpdated;       
    end;
    
    local procedure GetAirplaneTypesFromIATACodes();
    var
        Arguments: Record "GEN WebService Argument";
    begin
        InitArguments(Arguments,'icaoaircrafts/aircrafticaocodes');
        if not CallWebService(Arguments) then
            exit;
        SaveResultInAirplaneTypeTable(Arguments);
    end;
    
    local procedure InitArguments(var Arguments: Record "GEN WebService Argument" temporary; APIRequest: Text);
    var
    begin
        with Arguments do begin
            URL := STRSUBSTNO('%1%2',GetBaseURL,APIRequest);
            //URL := STRSUBSTNO('%1%2?api_key=%3',GetBaseURL,APIRequest,GetAPIKey);
            RestMethod := RestMethod::Get;
        end;
    end;
    
    local procedure CallWebService(var Arguments: Record "GEN WebService Argument" temporary) Success : Boolean
    var
        WebService: Codeunit "GEN WebService Call Functions";
    begin
        Success := WebService.CallWebService(Arguments);
    end;
    
    local procedure GetBaseURL(): Text;
    var
    begin
        exit('https://getbridgeapp.co/api/');
    end;
    
    /*
    local procedure GetAPIKey(): Text;
    var
    begin
        exit('00000000-0000-0000-0000-000000000000'); //change for setup
    end;
    */
    
    local procedure SaveResultInAirplaneTypeTable(var Arguments: Record "GEN WebService Argument" temporary)
    var
        AirplaneType: Record "AIR Airplane type";
        WebService: Codeunit "GEN WebService Call Functions";
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        i: Integer;
        ResponseInTextFormat: Text;
    begin
    
        AirplaneType.DeleteAll;
        
        ResponseInTextFormat := Arguments.GetResponseContentAsText;
        
        if not JsonArray.ReadFrom(ResponseInTextFormat) then
            Error('Invalid response, expected an JSON array as root object');
            
        for i := 0 to JsonArray.Count - 1 do
        begin
            JsonArray.Get(i,JsonToken);
            JsonObject := JsonToken.AsObject;
            
            with AirplaneType do begin
                INIT;
                "ICAO Code" := WebService.GetJsonValueAsText(JsonObject,'code');
                Description := WebService.GetJsonValueAsText(JsonObject,'aircraft_type');
                Popularity := WebService.GetJsonValueAsDecimal(JsonObject,'popularity_percent');
                Insert;
            end;
        end;
        
    end;
    
    
    
    
    
}