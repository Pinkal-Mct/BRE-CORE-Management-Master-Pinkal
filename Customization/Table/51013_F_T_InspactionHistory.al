table 51013 "FM Inspection History"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(51001; "Service Request ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51002; "Inspection ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(51003; "Inspection Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(51004; "Inspector Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(51005; "Inspection Type"; Option)
        {
            OptionMembers = Routine,Safety,Warranty,PM;
            OptionCaption = '  , Routine, Safety, Warranty, Preventive';
            DataClassification = ToBeClassified;
        }

        field(51006; "Inspection Status"; Option)
        {
            OptionMembers = Pending,"Passed","Failed";
            OptionCaption = 'Pending, Passed, Failed';
            DataClassification = ToBeClassified;
        }

        field(51007; "Observation Status"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(51008; "Reference Document"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(51009; "Attachment Link"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(51010; "Asset ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Asset ID';
        }

    }

    keys
    {

        key(PK; "Service Request ID", "Inspection ID", "Asset ID") { Clustered = true; }


        key(AssetKey; "Asset ID", "Inspection Date") { }

    }
}
