tableextension 51501 "Fixed Asset" extends "Fixed Asset"
{
    fields
    {
        field(51501; "Property Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Registration"."Property ID";
        }
        field(51502; "Unit No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51503; "Contact Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(51504; "Contact Email"; text[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(51505; "Contact No."; text[20])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(51506; "Location Description"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51507; "Emirate"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Emirate".ID;
        }
        field(51508; "Community"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Community".ID;
        }

        field(51509; "Purchase Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51510; "Warranty Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51511; "Warranty End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51512; "Under AMC"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51513; "AMC Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51514; "AMC End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51515; "AMC Vendor"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor"."No.";
        }
        field(51516; "Insurance Provider"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51517; "Insurance Policy No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51518; "Insurance Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(51519; "Insurance End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51520; "Insured Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51521; "Maintenance Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Monthly","Quarterly","Bi-Annually","Annually";
        }
        field(51522; "Maintenance Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51523; "Previous Service Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51524; "Barcode ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Barcode;
        }
        field(51525; "Barcode Generated?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51526; "Barcode Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","QR Code","Code128";
        }
        field(51527; "Barcode Image"; Media)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Property Code")
        {

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}