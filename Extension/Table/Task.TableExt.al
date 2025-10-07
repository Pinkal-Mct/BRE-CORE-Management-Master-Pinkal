tableextension 51254 "Task" extends "To-do"
{
    fields
    {
        field(51253; "Custome Type"; Enum "Custom Task Type")
        {
            Caption = 'Task Type';
            DataClassification = ToBeClassified;
        }
        field(53140; "Threshold Value"; Decimal)
        {
            Caption = 'Threshold Value';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53110; "Budget Range (AED)"; Decimal)
        {
            Caption = 'Budget Range (AED)';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        modify("Contact No.")
        {
            trigger OnAfterValidate()
            var
                Contact: Record Contact;
            begin
                // Clear values first
                "Threshold Value" := 0;
                "Budget Range (AED)" := 0;

                // Populate if contact exists
                if "Contact No." <> '' then
                    if Contact.Get("Contact No.") then begin
                        "Threshold Value" := Contact."Threshold Value";
                        "Budget Range (AED)" := Contact."Budget Range (AED)";
                    end;
            end;
        }
    }
}