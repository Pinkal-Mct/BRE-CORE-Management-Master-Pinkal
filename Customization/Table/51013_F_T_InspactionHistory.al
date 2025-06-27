table 51013 "FM Inspection History"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Inspection ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(2; "Inspection Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(3; "Inspector Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(4; "Inspection Type"; Option)
        {
            OptionMembers = Routine,Safety,Warranty,PM;
            OptionCaption = 'Routine, Safety, Warranty, Preventive';
            DataClassification = CustomerContent;
        }

        field(5; "Inspection Status"; Option)
        {
            OptionMembers = Pending,"Passed","Failed";
            OptionCaption = 'Pending, Passed, Failed';
            DataClassification = CustomerContent;
        }

        field(6; "Observation Status"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(7; "Reference Document"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(8; "Attachment Link"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(9; "Asset ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Linked Asset ID';
        }
    }

    keys
    {
        key(PK; "Inspection ID")
        {
            Clustered = true;
        }

        key(AssetKey; "Asset ID", "Inspection Date") { }
    }
}
