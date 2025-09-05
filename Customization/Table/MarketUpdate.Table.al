table 52004 "Market Update"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Update ID"; Integer) { AutoIncrement = true; }
        field(2; "Title"; Text[100]) { }
        field(3; "Description"; Text[250]) { }
        field(4; "Category"; Option)
        {
            OptionMembers = " ","Price Trends","New Projects","Regulations";
        }
        field(5; "Publish Date"; Date) { }
        field(6; "Active"; Boolean) { }
    }


    keys
    {
        key(PK; "Update ID")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    var
        MarketUpdateMgt: Codeunit "Market Update Mgt.";
    begin
        // Only send email when Active checkbox is checked
        if Rec.Active then
            MarketUpdateMgt.SendMarketUpdates(Rec);
    end;
}
