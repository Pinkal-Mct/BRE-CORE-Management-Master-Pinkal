table 53115 "Customer Eligibility"
{
    DataClassification = ToBeClassified;
    Caption = 'Customer Eligibility';
    fields
    {
        field(53100; "Customer Eligibility ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53101; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53102; "National ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53103; "DOB/Reg. No"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53104; "Phone"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(53105; "Email"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(53106; "Project"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53107; "Unit Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53108; "Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53109; "PEP Flag"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53110; "Sanctions Result"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53111; "Documents"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53112; "Risk Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53113; "Income Bracket"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53114; "Source of Funds"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53115; "Status"; Option)
        {
            OptionMembers = " ","Pending","Approved","Rejected";
            DataClassification = ToBeClassified;
        }
        field(53116; "Approver"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53117; "Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "customer Eligibility ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then
            Rec."customer Eligibility ID" := noseries.GetNextNo(noSeriesSetup."Customer Eligibility ID Nos.")
        else
            Error('No. Series Setup not found for Customer Eligibility ID Nos.');

        // Rec."Created By" := CopyStr(UserId(), 1, StrLen(UserId()));
        // Rec."Created Date" := Today;
    end;
}