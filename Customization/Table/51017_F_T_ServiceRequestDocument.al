table 51017 "FM Service Request Documents"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(51001; "Service Request ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(51002; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(51003; "Document Type"; Option)
        {
            OptionMembers = Photo,Inspection,Report,Invoice,Other;
            OptionCaption = ' ,Photo,Inspection Report,FM Report,Invoice,Other';
            DataClassification = ToBeClassified;
        }

        field(51004; "File Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(51005; "File Extension"; Text[10])
        {
            DataClassification = ToBeClassified;
        }


        field(51006; "Upload Document"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(51007; "View"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(51008; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51009; "Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Service Request ID", "Entry No.") { Clustered = true; }
    }

}
