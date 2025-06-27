table 51255 "Sub-Equipment"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Sub-Equipment ID";
    fields
    {
        field(51251; "Sub-Equipment ID"; Code[20])
        {
            Caption = 'Sub-Equipment ID';
            DataClassification = ToBeClassified;
        }
        field(51252; "Sub-Equipment Name"; Text[100])
        {
            Caption = 'Sub-Equipment Name';
            DataClassification = ToBeClassified;
        }
        field(51253; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(51254; "Equipment ID"; Text[100])
        {
            Caption = 'Equipment ID';
            DataClassification = ToBeClassified;
            TableRelation = "Equipment Master"."Equipment ID";

            trigger OnValidate()
            var
                EquipmentMaster: Record "Equipment Master";
            begin
                EquipmentMaster.SetRange("Equipment ID", "Equipment ID");
                if EquipmentMaster.FindFirst() then begin
                    "Equipment Name" := EquipmentMaster."Equipment Name";
                end else begin
                    "Equipment Name" := '';
                end;
                ;
            end;
        }
        field(51255; "Equipment Name"; Text[100])
        {
            Caption = 'Equipment Name';
            DataClassification = ToBeClassified;
            TableRelation = "Equipment Master"."Equipment Name";
        }
        field(51256; "Critical Component"; Boolean)
        {
            Caption = 'Critical Component';
            DataClassification = ToBeClassified;
        }
        field(51257; "Maintenance Frequency"; Text[50])
        {
            Caption = 'Maintenance Frequency';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Sub-Equipment ID", "Sub-Equipment Name")
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
            Rec."Sub-Equipment ID" := noseries.GetNextNo(noSeriesSetup."Sub-Equipment ID Nos.");
        end else
            Error('No. Series Setup not found for Construction Project Nos.');
    end;
}
