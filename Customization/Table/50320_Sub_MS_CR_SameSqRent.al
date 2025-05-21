table 50320 "CR Merge SameSqure SubPage"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50101; "MS_Merged Unit ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LeaseProposal: Record "Contract Renewal"; // Replace with the actual table name
            begin
                // Fetch the corresponding Lease Proposal Details record
                if LeaseProposal.Get("ID", "MS_Merged Unit ID") then begin
                    Rec."MS_Merged Unit ID" := LeaseProposal."Unit Name"; // Replace with actual field name in Lease Proposal table
                    Rec."MS_Start Date" := LeaseProposal."Contract Start Date";
                    Rec."MS_End Date" := LeaseProposal."Contract End Date";
                    Rec."MS_Unit Sq Ft" := LeaseProposal."Unit Sq. Feet";
                    Rec."MS_Rate per Sq.Ft" := LeaseProposal."Rent Amount";
                    // Calculate additional fields like Number of Days
                    Rec."MS_Number of Days" := Rec."MS_End Date" - Rec."MS_Start Date";

                    Modify(true); // Save the updated record
                end else
                    Error('No matching Lease Proposal found for the selected Unit ID.');
            end;
        }
        field(50102; "MS_Unit ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "MS_Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "MS_Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "MS_End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "MS_Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "MS_Unit Sq Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "MS_Rate per Sq.Ft"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "MS_Rent Increase %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "MS_Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "MS_Round off"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "MS_Final Annual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "MS_Per Day Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Merge SameSqure Rent1"; Code[100])
        {
            DataClassification = ToBeClassified;
            InitValue = 'Click Here For Get Data.';
            Caption = 'Click Here For Get Data.';
        }
        field(50115; "MS_Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50116; "PDR Revenue Allocation Link"; Code[20]) // Or another suitable data type
        {
            Caption = 'PDR Revenue Allocation Link';
            DataClassification = ToBeClassified;
        }

        field(50117; "TotalFinalAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Merge SameSqure SubPage"."MS_Final Annual Amount" where("Id" = field("Id")));
        }
        field(50118; "TotalAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Merge SameSqure SubPage"."MS_Annual Amount" where("Id" = field("Id")));
        }
        field(50119; "TotalRoundOff"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Merge SameSqure SubPage"."MS_Round off" where("Id" = field("Id")));
        }


        field(50120; "TotalFirstAnnualAmount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("CR Merge SameSqure SubPage"."MS_Final Annual Amount" where("Id" = field("Id"), MS_Year = const(1)));
        }
    }

    keys
    {
        key(PK; "ID", "MS_Line No.")
        {
            Clustered = true;
        }
    }
}
