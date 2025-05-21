table 50962 "Revenue Recognition Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50123; "RR_No."; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(50100; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }

        field(50101; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
        }
        field(50102; "Contract Id"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Id';
        }

        field(50103; "Contract Tenure"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Tenure';
        }

        field(50104; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
        }

        field(50105; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';
        }

        field(50106; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
        }

        field(50107; "Grace Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Grace Days';
        }

        field(50108; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Termination Date';
        }

        field(50109; "Suspension Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Suspension Start Date';
        }

        field(50110; "Suspension End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Suspension End Date';
        }

        field(50111; "Multi Year Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Multi Year Start Date';
        }

        field(50112; "Multi Year End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Multi Year End Date';
        }

        field(50113; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
        }

        field(50114; "Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Annual Amount';
        }
        field(50126; "Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Annual Amount';
        }

        field(50115; "Posting Month"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Month';
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = January,February,March,April,May,June,July,August,September,October,November,December;
        }

        field(50116; "Posting Year"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Year';
        }

        field(50117; "Posting Period"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Period';
        }

        field(50118; "No Of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No Of Days';
        }

        field(50119; "Per Day Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Per Day Amount';
        }

        field(50120; "Total Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Value';
        }

        field(50121; "Owner Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner Name';
        }

        field(50122; "Owner Share"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner Share';
        }
        field(50125; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
        }

        field(50128; "Total Contract Amount"; Decimal)
        {
            Editable = false;
            Caption = 'Total Contract Amount';
        }

        field(50129; "Total Annual Amount"; Decimal)
        {
            Editable = false;
            Caption = 'Total Annual Amount';
        }

        field(50130; "Total Final Annual Amount"; Decimal)
        {
            Editable = false;
            Caption = 'Total Final Annual Amount';
        }
        field(50127; "Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Type';
        }

        field(50131; "Total Amounts"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
        }

        field(50132; "Total Contract Amounts"; Decimal)
        {
            Editable = false;
            Caption = 'Total Contract Amount';
        }

        field(50133; "Total Annual Amounts"; Decimal)
        {
            Editable = false;
            Caption = 'Total Annual Amount';
        }
        field(50134; "Total Final Annual Amounts"; Decimal)
        {
            Editable = false;
            Caption = 'Total Final Annual Amount';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
