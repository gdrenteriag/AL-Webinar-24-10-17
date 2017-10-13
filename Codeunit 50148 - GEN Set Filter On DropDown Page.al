codeunit 50148 "GEN SetFilter On DropDown Page"
{
    SingleInstance = true;
    
    trigger OnRun();
    begin
    
    end;
    
    var
        FilterToSetOnDropDownPage: Text[250];
        
    procedure SetFilter(FilterText : Text);
    begin
        if FilterText = '' then
            exit;
        FilterToSetOnDropDownPage := FilterText;
        
    end;
    
    procedure GetFilter(): Text;
    begin
        exit(FilterToSetOnDropDownPage);
    end;
    
    procedure HasFilter () :Boolean;
    begin
        exit(FilterToSetOnDropDownPage <> '');
    end;
    
    procedure ClearFilter ();
    begin
        Clear(FilterToSetOnDropDownPage);
    end;
}