tableextension 51501 "Fixed Asset" extends "Fixed Asset"
{
    DataCaptionFields = "No.";
    fields
    {
        field(51501; "Property Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Registration"."Property ID";
        }
        field(51502; "Unit No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No." where("Property ID" = field("Property Code"));
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
        field(51524; "QR-Code ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Barcode;

        }
        field(51525; "QR-Code Generated?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51526; "Barcode Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","QR Code","Code128";
        }
        field(51527; "QR-Code Image"; Media)
        {
            DataClassification = ToBeClassified;
        }
        // field(51528; "Asset ID"; Code[20])
        // {
        //     Caption = 'Asset ID';
        //     DataClassification = ToBeClassified;
        // }
        field(51259; "Asset Name"; Text[100])
        {
            Caption = 'Asset Name';
            DataClassification = ToBeClassified;
        }
        field(51260; "Asset Type Code"; Code[20])
        {
            Caption = 'Asset Type Code';
            DataClassification = ToBeClassified;
            TableRelation = "Asset Type".code;

            trigger OnValidate()
            var
                AssetType: Record "Asset Type";
            begin
                AssetType.SetRange(Code, "Asset Type Code");
                if AssetType.FindFirst() then begin
                    "Asset Type Description" := AssetType.Description;
                end else begin
                    "Asset Type Description" := '';
                end;
            end;
        }
        field(51261; "Asset Type Description"; Text[100])
        {
            Caption = 'Asset Type';
            DataClassification = ToBeClassified;
            TableRelation = "Asset Type".Description;
        }
        field(51262; "Owned By"; Text[100])
        {
            Caption = 'Owned By';
            DataClassification = ToBeClassified;
        }

        field(51263; "Additional Note"; Text[250])
        {
            Caption = 'Additional Note';
            DataClassification = ToBeClassified;
        }

        field(51264; "Upload Image"; Text[100])
        {
            Caption = 'Upload Image';
            DataClassification = ToBeClassified;
        }
        field(51265; "Sub-Equipment ID"; Text[100])
        {
            Caption = 'Sub-Equipment ID';
            DataClassification = ToBeClassified;
            TableRelation = "Sub-Equipment"."Sub-Equipment ID";

            trigger OnValidate()
            var
                SubEquipmentMaster: Record "Sub-Equipment";
                EquipmentMaster: Record "Equipment Master";
            begin
                SubEquipmentMaster.SetRange("Sub-Equipment ID", "Sub-Equipment ID");
                if SubEquipmentMaster.FindFirst() then begin
                    "Sub-Equipment Name" := SubEquipmentMaster."Sub-Equipment Name";
                    "Equipment Id" := SubEquipmentMaster."Equipment ID";
                    "Equipment Name" := SubEquipmentMaster."Equipment Name";
                end else begin
                    "Sub-Equipment Name" := '';
                    "Equipment Id" := '';
                    "Equipment Name" := '';
                end;

                EquipmentMaster.SetRange("Equipment ID", "Equipment Id");
                if EquipmentMaster.FindFirst() then begin
                    "OEM Id" := EquipmentMaster."OEM ID";
                    "OEM Name" := EquipmentMaster."OEM Name";
                    "Equipment Category" := EquipmentMaster."Equipment Category";
                end else begin
                    "OEM Id" := '';
                    "OEM Name" := '';
                    "Equipment Category" := '';
                end;
            end;
        }
        field(51266; "Equipment Id"; Code[20])
        {
            Caption = 'Equipment Id';
            DataClassification = ToBeClassified;
            TableRelation = "Sub-Equipment"."Equipment ID";
        }
        field(51267; "Equipment Name"; Text[100])
        {
            Caption = 'Equipment Name';
            DataClassification = ToBeClassified;
            TableRelation = "Sub-Equipment"."Equipment Name";
        }
        field(51268; "Sub-Equipment Name"; Text[100])
        {
            Caption = 'Sub-Equipment Name';
            DataClassification = ToBeClassified;
            TableRelation = "Sub-Equipment"."Sub-Equipment Name";
        }
        field(51269; "OEM Id"; Text[100])
        {
            Caption = 'OEM Id';
            DataClassification = ToBeClassified;
            TableRelation = "Equipment Master"."OEM ID";

            // trigger OnValidate()
            // var
            //     OEMMaster: Record "OEM Master";
            // begin
            //     OEMMaster.SetRange("OEM ID", "OEM ID");
            //     if OEMMaster.FindFirst() then begin
            //         "OEM Name" := OEMMaster."OEM Name";
            //         "Equipment Category" := OEMMaster."Equipment Category";
            //     end else begin
            //         "Equipment Category" := '';
            //         "OEM Name" := '';
            //     end;
            // end;
        }
        field(51270; "OEM Name"; Text[100])
        {
            Caption = 'OEM Name';
            DataClassification = ToBeClassified;
            TableRelation = "Equipment Master"."OEM Name";
        }
        field(51271; "Equipment Category"; Text[50])
        {
            Caption = 'Equipment Category';
            DataClassification = ToBeClassified;
            TableRelation = "Equipment Master"."Equipment Category";
        }


    }

    keys

    {
        key(PK; "Property Code", "Asset Type Code")
        {
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

}