table 51251 "Equipment Master"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Equipment ID";

    fields
    {
        field(51251; "Equipment ID"; Code[20])
        {
            Caption = 'Equipment ID';
            DataClassification = ToBeClassified;
        }
        field(51252; "Equipment Name"; Text[100])
        {
            Caption = 'Equipment Name';
            DataClassification = ToBeClassified;
        }
        field(51253; "Equipment Description"; Text[250])
        {
            Caption = 'Equipment Description';
            DataClassification = ToBeClassified;
        }
        field(51254; "OEM ID"; Text[100])
        {
            Caption = 'OEM ID';
            DataClassification = ToBeClassified;
            TableRelation = "OEM Master"."OEM ID";

            trigger OnValidate()
            var
                OEMMaster: Record "OEM Master";
            begin
                OEMMaster.SetRange("OEM ID", "OEM ID");
                if OEMMaster.FindFirst() then begin
                    "OEM Name" := OEMMaster."OEM Name";
                    "Equipment Category" := OEMMaster."Equipment Category";
                end else begin
                    "Equipment Category" := '';
                    "OEM Name" := '';
                end;
            end;
        }
        field(51255; "OEM Name"; Text[100])
        {
            Caption = 'OEM Name';
            DataClassification = ToBeClassified;
            TableRelation = "OEM Master"."OEM Name";
        }
        field(51256; "Equipment Category"; Text[50])
        {
            Caption = 'Equipment Category';
            DataClassification = ToBeClassified;
            TableRelation = "OEM Master"."Equipment Category";
        }
        field(51257; "Unit of Measurement"; Code[20])
        {
            Caption = 'Unit of Measurement';
            DataClassification = ToBeClassified;
            tableRelation = "Unit of Measure"."Code";
        }
        field(51258; "Default Warranty Period"; Code[20])
        {
            Caption = 'Default Warranty Period (Months)';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Equipment ID", "Equipment Name")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then begin
            Rec."Equipment ID" := noseries.GetNextNo(noSeriesSetup."Equipment ID Nos.");
        end else
            Error('No. Series Setup not found for Construction Project Nos.');

        // Rec."Created By" := UserId();
    end;
}