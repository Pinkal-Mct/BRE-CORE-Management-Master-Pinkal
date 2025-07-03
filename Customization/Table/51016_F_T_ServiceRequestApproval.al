table 51016 "FM Service Request Approval"

{
    Caption = 'FM Service Request Approval';
    DataClassification = ToBeClassified;
    fields
    {
        field(51001; "Contact Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51002; "Contact Phone"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51003; "Contact Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51004; "Service Request ID"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51005; "Status"; Option)
        {
            OptionMembers = Pending,Approved,Rejected;
            DataClassification = ToBeClassified;
        }
        field(52001; "Requested Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Service Request ID") { Clustered = true; }
    }
}