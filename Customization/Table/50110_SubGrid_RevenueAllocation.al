table 50110 "Revenue Allocation SubGrid"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
            Editable = false;
        }
        field(50101; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
            Editable = false;
        }
        field(50102; "Contract Id"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Id';
            Editable = false;
        }
        field(50103; "Contract Tenure"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Tenure';
            Editable = false;
        }
        field(50104; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
            Editable = false;
        }
        field(50105; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
            Editable = false;
        }
        field(50106; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
            Editable = false;
        }

        field(50107; "Grace Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Grace Days';
            Editable = false;
        }
        field(50108; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Termination Date';
            Editable = false;
        }
        field(50109; "Suspension Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Suspension Start Date';
            Editable = false;
        }
        field(50110; "Suspension End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Suspension End Date';
            Editable = false;
        }
        field(50111; "Multi Year Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Multi Year Start Date';
            Editable = false;
        }
        field(50112; "Multi Year End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Multi Year End Date';
            Editable = false;
        }
        field(50113; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
            Editable = false;
        }
        field(50114; "Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Annual Amount';
            Editable = false;
        }
        field(50115; "Posting Month"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Month';
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = January,February,March,April,May,June,July,August,September,October,November,December;
            Editable = false;
        }
        field(50116; "Posting Year"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Year';
            Editable = false;
        }
        field(50117; "Posting Period"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Period';
            Editable = false;
        }
        field(50118; "No Of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No Of Days';
            Editable = false;
        }
        field(50119; "Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Per Day Rent';
            Editable = false;
        }
        field(50120; "Total Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Value';
            Editable = false;
        }
        field(50121; "Owner Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner Name';
            Editable = false;
        }
        field(50122; "Owner Share"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner Share';
            Editable = false;
        }
        field(50123; "Header No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Header No.';
            Editable = false;
        }
        field(50124; "Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Annual Amount';
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Header No.", "Line No.")
        {
            Clustered = true;
        }

    }

}
