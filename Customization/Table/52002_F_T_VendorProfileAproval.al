table 52002 "Approval Vendor Profile"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Vendor ID";
    fields
    {
        field(52013; "Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }

        field(52001; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
        }

        field(52002; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(52003; "Profile ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Profile ID';
        }

        field(52005; Country; Text[30])
        {
            Caption = 'Country';
            Editable = false;
        }
        field(52006; Emirate; Enum Emirates)
        {
            Caption = 'Emirate';
            Editable = false;
        }
        field(52007; Community; Text[30])
        {
            Caption = 'Community';
            Editable = false;
        }
        field(52008; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            Editable = false;
        }
        field(52009; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            Editable = false;
        }
        field(52010; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            Editable = false;
        }
        field(52011; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
        }
        field(52012; "Vendor Type"; Option)
        {
            OptionMembers = " ","Domestic","Non-Domestic";
            Caption = 'Vendor Type';
        }
    }
    keys
    {
        key(PK; "Profile ID")
        {
            Clustered = false;
        }
    }


    trigger OnInsert()
    var
        approvalrequest: Codeunit "Approval Vendor Profile";
    begin
        approvalrequest.SendApprovalrequest(Rec);
    end;

}
