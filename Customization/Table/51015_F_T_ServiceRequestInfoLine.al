table 51015 "Service Request Info Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(51001; "Line No."; Integer)
        {
            DataClassification = SystemMetadata;
        }

        field(51002; "Inspection ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        // field(51003; "Asset ID"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Linked Asset ID';
        // }

        field(51004; "Inspection Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(51005; "Inspector Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(51006; "Inspection Type"; Option)
        {
            OptionMembers = Routine,Safety,Warranty,PM;
            OptionCaption = 'Routine, Safety, Warranty, Preventive';
            DataClassification = ToBeClassified;
        }

        field(51007; "Inspection Status"; Option)
        {
            OptionMembers = Pending,Passed,Failed;
            OptionCaption = 'Pending, Passed, Failed';
            DataClassification = ToBeClassified;
        }

        field(51008; "Observation Status"; Text[250])
        {
            DataClassification = ToBeClassified;
        }


        field(51010; "Reference Document"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51011; "Service Request ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Inspection ID", "Line No.")
        {
            Clustered = true;
        }

    }
}
