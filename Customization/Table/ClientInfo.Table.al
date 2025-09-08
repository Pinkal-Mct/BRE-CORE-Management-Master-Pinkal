table 53114 "Client Info"
{
    DataClassification = ToBeClassified;
    Caption = 'Client Info';
    fields
    {
        field(53100; "Client Info ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53101; "Client Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53102; "Email"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(53103; "Mobile No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(53105; "Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53106; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53107; "Created By"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53108; "Assigned Sales Person"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53110; "Nationality"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53111; "Company Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53112; "Preferred Language"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(53113; "Emirates ID/Passport Number"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53114; "Visa Status"; Enum "Visa Status")
        {
            DataClassification = ToBeClassified;
        }
        field(53115; "Source of Funds"; Enum "Source of Funds")
        {
            DataClassification = ToBeClassified;
        }
        field(53116; "Mortgage Pre-Approval Status"; Option)
        {
            OptionMembers = " ","Yes","No";
        }
        field(53117; "TAX Registration_VAT"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53118; "RERA Broker ID"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(53119; "Preferred Sale Type"; Enum "Preferred Sales Type")
        {
            DataClassification = ToBeClassified;
        }
        field(53120; "Other"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53121; "Campaign Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53122; "Position/Role"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53123; "Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53124; "Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53125; "Country/Region Code"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Code;
        }
        field(53126; "Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code".Code WHERE("Country/Region Code" = FIELD("Country/Region Code"));
        }
        field(53127; "City"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"), Code = FIELD("Post Code"));
        }
        field(53128; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Client Info ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Client Info ID", "Client Name")
        {

        }
    }
    trigger OnInsert()
    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then
            Rec."Client Info ID" := noseries.GetNextNo(noSeriesSetup."Client Info ID Nos.")
        else
            Error('No. Series Setup not found for Client Info ID Nos.');
        Rec."Created By" := CopyStr(UserId(), 1, StrLen(UserId()));
        Rec."Created Date" := Today;
    end;
}