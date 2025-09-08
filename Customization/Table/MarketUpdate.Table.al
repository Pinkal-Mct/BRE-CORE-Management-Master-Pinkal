table 52004 "Market Update"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(52001; "Update ID"; Integer) { AutoIncrement = true; }
        field(52002; "Title"; Text[100]) { }
        field(52003; "Description"; Text[250]) { }
        field(52004; "Category"; Option)
        {
            OptionMembers = " ","Price Trends","New Projects","Regulations";
        }
        field(52005; "Publish Date"; Date) { }
        field(52006; "Active"; Boolean) { }
        field(52007; "Last Sent Date"; Date) { }
        field(52008; "Created Date"; Date) { }
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
