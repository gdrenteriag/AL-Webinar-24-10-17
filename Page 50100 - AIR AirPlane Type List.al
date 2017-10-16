page 50100 "AIR Airplane Type List"
{
    PageType = List;
    SourceTable = "AIR Airplane type";
    Editable = false;
    SourceTableView = sorting (Popularity) order (descending);
    
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
            Action(GetAirplaneTypes)
            {
                CaptionML = ENU = 'Update';
                ToolTipML = ENU = 'Update airplanes types from ICAO webservice';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Image = UpdateXML;
                
                trigger OnAction();
                var
                    ICAOFunctions: Codeunit "AIR ICAO Functions";
                begin
                    ICAOFunctions.GetAirplaneTypes();
                    //Message('List was updated with %1 airplanes types',Count);
                end;
            }
            
            Action(CreateItem)
            {
                CaptionML = ENU = 'New item';
                ToolTipML = ENU = 'Create new item for selected airplane type';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Image = NewItem;
                Enabled = CreateItemActionEnabled;
                
                trigger OnAction();
                var
                    AirplaneFunctions: Codeunit "AIR Airplane Functions";
                begin
                    AirplaneFunctions.RunCreateNewItem(Rec);
                end;
            }
            
        }
    }
    var
        //CreateItemActionEnabled: Boolean;
        [InDataSet] CreateItemActionEnabled: Boolean;
        
    trigger OnAfterGetRecord();
    begin
        CreateItemActionEnabled := "ICAO Code" <> '';
    end;

    trigger OnInit();
    begin
       //SetCurrentKey(Popularity);
       //SetAscending(Popularity,false);
    end;

    trigger OnOpenPage();
    var
        SetFilterOnPropDownPage : Codeunit "GEN SetFilter On DropDown Page";
        Notifications: Codeunit "AIR Notifications";
    begin
       if SetFilterOnPropDownPage.HasFilter then
            SetFilter(Description,SetFilterOnPropDownPage.GetFilter);
       If IsEmpty then
          Notifications.ShowNotificationWhenAirplaneTypesIsEmpty();
    end;

}