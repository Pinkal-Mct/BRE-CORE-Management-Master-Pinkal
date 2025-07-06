table 53254 "Vendor Contract Approval"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;

    fields
    {
        field(50101; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            // AutoIncrement = true;    
            Editable = false;
            AutoIncrement = true;


        }
        field(50102; "Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(50103; "Created By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Created By';
        }

        field(50104; "Vendor Contract ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Contract ID';
        }
        field(50105; Remark; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remark';
        }

        field(50106; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor  ID';
        }

    }

    keys
    {
        key(PrimaryKey; "ID")
        {
            Clustered = false;
        }
        key(PK; SystemId)
        {
            Clustered = true;
        }
    }



}

