table 53506 "Lead Management"
{
    DataClassification = ToBeClassified;
    Caption = 'Lead Management';
    fields
    {
        field(53530; "Lead ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53531; "Lead Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53532; "Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53533; "Mobile No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53534; "Lead Source"; Enum "Lead Source ")
        {
            DataClassification = ToBeClassified;
        }
        field(53535; "Lead Status"; Enum "Lead Status")
        {
            DataClassification = ToBeClassified;
        }
        field(53536; "Expected Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53537; "Follow-up Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                TodayDate: Date;
            begin
                TodayDate := Today();

                // Optional: Prevent past date selection
                if ("Follow-up Date" <> 0D) and ("Follow-up Date" < TodayDate) then
                    Error('Follow-up Date cannot be in the past.');
            end;
        }
        field(53538; "Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53539; "Interst Area"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53540; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53541; "Created By"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53542; "Assigned Sales Person"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53543; "Disqualification Reason"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(53544; "Disqualification Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Lead ID")
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
            Rec."Lead ID" := noseries.GetNextNo(noSeriesSetup."Lead ID Nos.")
        else
            Error('No. Series Setup not found for Vendor Proposal Nos.');
        Rec."Created By" := CopyStr(UserId(), 1, StrLen(UserId()));
        Rec."Created Date" := Today;
    end;
}