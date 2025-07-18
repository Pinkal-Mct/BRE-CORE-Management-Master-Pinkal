table 52001 "Facility Vendor Profiles"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Vendor ID";
    fields
    {
        field(52001; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
            TableRelation = Vendor."No.";
            // TableRelation = Vendor."No.";
            //TableRelation = Vendor."No." WHERE("Vendor Category" = FILTER('Property Management System' | 'Brokers and Commission Agent'));

            trigger OnValidate()
            var
                vendor: Record Vendor;
            begin
                vendor.SetRange("No.", Rec."Vendor ID");
                if vendor.FindSet() then begin
                    Rec."Vendor ID" := vendor."No.";
                    "Vendor Name" := vendor."Name";
                    "Search Name" := vendor."Search Name";
                    "Blocked" := Vendor."Blocked";
                    "Privacy Blocked" := Vendor."Privacy Blocked";
                    "IC Partner Code" := Vendor."IC Partner Code";
                    "Purchaser Code" := Vendor."Purchaser Code";
                    "Responsibility Center" := Vendor."Responsibility Center";
                    "Disable Search by Name" := Vendor."Disable Search by Name";
                    "Company Size Code" := Vendor."Company Size Code";
                    "Last Date Modified" := Vendor."Last Date Modified";
                    "Document Sending Profile" := Vendor."Document Sending Profile";
                    "Balance (LCY)" := Vendor."Balance (LCY)";
                    "Balance Due (LCY)" := Vendor."Balance Due (LCY)";
                    Address := Vendor.Address;
                    "Address 2" := Vendor."Address 2";
                    "Country" := Vendor.Country;
                    "Emirate" := vendor.Emirate;
                    "Community" := vendor.Community;
                    "Phone No." := Vendor."Phone No.";
                    "Mobile Phone No." := Vendor."Mobile Phone No.";
                    "E-Mail" := Vendor."E-Mail";
                    "Our Account No." := Vendor."Our Account No.";
                    "Primary Contact Code" := Vendor."Primary Contact No.";
                    "VAT Registration No." := Vendor."VAT Registration No.";
                    "Price Calculation Method" := Vendor."Price Calculation Method";
                    "Price Including VAT" := Vendor."Prices Including VAT";
                    "Application Method" := Vendor."Application Method";
                    "Payment Terms Code" := Vendor."Payment Terms Code";
                    "Payment Method Code" := Vendor."Payment Method Code";
                    Priority := Vendor.Priority;
                    "Block Payment Tolerance" := Vendor."Block Payment Tolerance";
                    "Preferred Bank Account Code" := Vendor."Preferred Bank Account Code";
                    "Partner Type" := Vendor."Partner Type";
                    "Cash Flow Payment Terms Code" := Vendor."Cash Flow Payment Terms Code";
                    "Creditor No." := Vendor."Creditor No.";
                    "Location Code" := Vendor."Location Code";
                    "Shipment Method Code" := Vendor."Shipment Method Code";
                    "Lead Time Calculation" := Vendor."Lead Time Calculation";
                    "Base Calendar Code" := Vendor."Base Calendar Code";
                    "Over-Receipt Code" := Vendor."Over-Receipt Code";
                end else begin
                    "Vendor ID" := '';
                    "Vendor Name" := '';
                    "Search Name" := '';
                    "Blocked" := "Blocked"::" ";
                    "Privacy Blocked" := false;
                    "IC Partner Code" := '';
                    "Purchaser Code" := '';
                    "Responsibility Center" := '';
                    "Disable Search by Name" := false;
                    "Company Size Code" := '';
                    "Last Date Modified" := 0D;
                    "Document Sending Profile" := '';
                    "Balance (LCY)" := 0;
                    "Balance Due (LCY)" := 0;
                    Address := '';
                    "Address 2" := '';
                    "Country" := '';
                    "Phone No." := '';
                    "Mobile Phone No." := '';
                    "E-Mail" := '';
                    "Home Page" := '';
                    "Our Account No." := '';
                    "Primary Contact Code" := '';
                    "VAT Registration No." := '';
                    "Price Calculation Method" := "Price Calculation Method"::" ";
                    "Price Including VAT" := false;
                    "Application Method" := "Application Method"::"Manual";
                    "Payment Terms Code" := '';
                    "Payment Method Code" := '';
                    Priority := 0;
                    "Block Payment Tolerance" := false;
                    "Preferred Bank Account Code" := '';
                    "Partner Type" := "Partner Type"::" ";
                    "Cash Flow Payment Terms Code" := '';
                    "Creditor No." := '';
                    "Location Code" := '';
                    "Shipment Method Code" := '';
                    "Base Calendar Code" := '';
                    "Over-Receipt Code" := '';
                end;
            end;
        }

        field(52002; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Name';
            Editable = false;
        }

        field(52003; "Blocked"; Enum "Vendor Blocked")
        {
            DataClassification = ToBeClassified;
            Caption = 'Blocked';
            Editable = false;
        }
        field(52004; "Balance (LCY)"; Decimal)
        {
            Caption = 'Balance (LCY)';
            Editable = false;
        }

        field(52005; "Balance Due (LCY)"; Decimal)
        {
            Caption = 'Balance Due (LCY)';
            Editable = false;
        }
        field(52006; Address; Text[100])
        {
            Caption = 'Address';
            Editable = false;
        }
        field(52007; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            Editable = false;
        }
        field(52008; Country; Text[30])
        {
            Caption = 'Country';
            Editable = false;
        }
        field(52009; Emirate; Enum Emirates)
        {
            Caption = 'Emirate';
            Editable = false;
        }
        field(52010; Community; Text[30])
        {
            Caption = 'Community';
            Editable = false;
        }
        field(52011; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            Editable = false;
        }
        field(52012; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            Editable = false;
        }
        field(52013; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            Editable = false;
        }
        field(52014; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            Editable = false;
        }
        field(52015; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
            Editable = false;
        }
        field(52016; "Primary Contact Code"; Code[80])
        {
            Caption = 'Primary Contact Code';
            Editable = false;
        }

        field(52017; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            Editable = false;
        }
        field(52018; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
            Editable = false;
        }
        field(52019; "Price Including VAT"; Boolean)
        {
            Caption = 'Price Including VAT';
            Editable = false;
        }

        field(52020; "Application Method"; Enum "Application Method")
        {
            DataClassification = ToBeClassified;
            Caption = 'Application Method';
            Editable = false;
        }
        field(52021; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            Editable = false;
        }
        field(52022; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            Editable = false;
        }
        field(52023; Priority; Integer)
        {
            Caption = 'Priority';
            Editable = false;
        }
        field(52024; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
            Editable = false;
        }
        field(52025; "Preferred Bank Account Code"; Code[100])
        {
            Caption = 'Preferred Bank Account Code';
            Editable = false;
        }
        field(52026; "Partner Type"; Enum "Partner Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Partner Type';
            Editable = false;
        }
        field(52027; "Cash Flow Payment Terms Code"; Code[100])
        {
            Caption = 'Cash Flow Payment Terms Code';
            Editable = false;
        }
        field(52028; "Creditor No."; Code[100])
        {
            Caption = 'Creditor No.';
            Editable = false;
        }
        field(52029; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
        }
        field(52030; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            Editable = false;
        }
        field(52031; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
            Editable = false;
        }
        field(52032; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            Editable = false;
        }
        field(52033; "Over-Receipt Code"; Code[20])
        {
            Caption = 'Over-Receipt Code';
            Editable = false;
        }
        field(52034; "Receive E-Document To"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receive E-Document To';
            OptionMembers = " ","Purchase Order","Purchase Invoice";
            Editable = false;
        }

        field(52035; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';
            Editable = false;
        }
        field(52036; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }

        field(52037; "Document Sending Profile"; Code[20])
        {
            Caption = 'Document Sending Profile';
            Editable = false;
        }

        field(52038; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
            Editable = false;
        }
        field(52039; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            Editable = false;
        }
        field(52040; "Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            Editable = false;
        }

        field(52041; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
        }

        field(52042; "Disable Search by Name"; Boolean)
        {
            Caption = 'Disable Search by Name';
            Editable = false;
        }
        field(52043; "Company Size Code"; Code[20])
        {
            Caption = 'Company Size Code';
            Editable = false;
        }

        //////////////////////////////////// FACILITY FIELDS///////////////////////////////////////////////////////////
        field(52044; "Address 3"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Address 3';
        }
        field(52045; "P.O.Box"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'P.O.Box';
        }
        field(52046; "Profile ID"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Profile ID';


        }
        field(52047; "Profile Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Profile Name';
        }
        field(52048; "Designation"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Designation';
        }
        field(52049; "Profile Mobile No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile No.';
        }
        field(52050; "Profile Nationality"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nationality';
        }
        field(52051; "Email Address"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email Address';
        }
        field(52052; "TradeLicense IssuingAuthority"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Trade License Issuing Authority';
        }
        field(52053; "Trade License Number"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Trade License Number';
        }
        field(52054; "Trade License Issue Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Trade License Issue Date';
        }
        field(52055; "Trade License Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Trade License Expiry Date';

            trigger OnValidate()
            var
                emailrec: Codeunit "Send Expiry Date Email";
            begin

                if (Rec."Trade License Expiry Date" - 30) = Today then
                    emailrec.SendEmail(Rec);
            end;
        }
        field(52056; "VAT Registration Number"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Registration Number';
        }
        field(52057; "Corporate Tax Registration"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Corporate Tax Registration';
        }
        field(52058; "EC Number"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'EC Number';
        }
        field(52059; "Issuing Authority"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Issuing Authority';
        }
        field(52060; "Issue Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Issue Date';
        }
        field(52061; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Expiry Date';

            trigger OnValidate()
            var
                emailrec: Codeunit "Send Expiry Date Email";
            begin

                if (Rec."Expiry Date" - 30) = Today then
                    emailrec.SendEmailss(Rec);
            end;
        }
        field(52062; "Owners Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(52063; "Owners Designation"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Designation';
        }
        field(52064; "Emirates ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirates ID';
        }
        field(52065; "Passport Number"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Passport Number';
        }
        field(52066; "Vendor Type"; Option)
        {
            OptionMembers = " ","Domestic","Non-Domestic";
            Caption = 'Vendor Type';
        }
        field(52067; "Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }

        //////////////////////////////////// FACILITY FIELDS///////////////////////////////////////////////////////////

        // ✅ New Bank Info Fields
        field(51001; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = ToBeClassified;
        }
        field(51002; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(51003; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
        }
        field(51004; "Bank Branch"; Text[100])
        {
            Caption = 'Bank Branch';
            DataClassification = ToBeClassified;
        }
        field(51005; "IBAN"; Text[34])
        {
            Caption = 'IBAN';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if CopyStr(Rec."IBAN", 1, 2) = 'AE' then
                    if StrLen(Rec."IBAN") <> 23 then
                        Error('UAE IBAN must be 23 characters and start with "UAE".');

                if not (StrLen(Rec."IBAN") in [15 .. 34]) then
                    Error('IBAN must be between 15 and 34 characters.');
            end;
        }
        field(51006; "SWIFT Code"; Text[11])
        {
            Caption = 'SWIFT Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (StrLen("SWIFT Code") <> 8) and (StrLen("SWIFT Code") <> 11) then
                    Error('SWIFT/BIC must be 8 or 11 characters.');
            end;

        }
        field(51007; "Bank Doc Container ID"; Guid)
        {
            Caption = 'Bank Doc Container ID';
            DataClassification = ToBeClassified;
        }
        field(51008; "Bank Info Verified"; Boolean)
        {
            Caption = 'Bank Info Verified';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Bank Info Verified" then
                    "Verification Date" := Today();
            end;
        }
        field(51009; "Verification Date"; Date)
        {
            Caption = 'Verification Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51010; "IBAN Certificate"; Text[250])
        {
            Caption = 'IBAN Certificate';
            DataClassification = ToBeClassified;
        }
        field(51011; Code; Text[30])
        {
            DataClassification = ToBeClassified;
            ToolTip = 'Landline Code';

        }
        field(51012; "Area Code"; Text[30])
        {
            DataClassification = ToBeClassified;
            ToolTip = 'Area Code';
        }
        field(51013; "Number"; Text[30])
        {
            DataClassification = ToBeClassified;
            ToolTip = 'Number';
        }
        field(51014; City; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(51015; "Landline Number"; Text[30])
        {
            DataClassification = ToBeClassified;
            ToolTip = 'Landline Number';
        }

        field(51016; "Primary Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51017; Module; Enum "Module Enum")
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Profile ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Profile ID", "Profile Name")
        {

        }
    }

    trigger OnDelete()
    var
    begin
        DeleteVendorprofiledocumentgrid();
        DeleteVendorbusinessprofilegrid();
        DeleteVendorSignedContractDocument();
    end;

    procedure DeleteVendorprofiledocumentgrid()
    var
        Vendorprofiledocumentgrid: Record "Vendor Profile Document Grid";
    begin
        Vendorprofiledocumentgrid.SetRange("Profile ID", Rec."Profile ID");
        if Vendorprofiledocumentgrid.FindSet() then begin
            Vendorprofiledocumentgrid.DeleteAll();
        end
    end;

    procedure DeleteVendorbusinessprofilegrid()
    var
        vendorbusinessprofilegrid: Record "vendor Business Profile";
    begin
        vendorbusinessprofilegrid.SetRange("Profile ID", Rec."Profile ID");
        if vendorbusinessprofilegrid.FindSet() then begin
            vendorbusinessprofilegrid.DeleteAll();
        end
    end;

    procedure DeleteVendorSignedContractDocument()
    var
        VendorSignedDocument: Record VendorSignedContractDocument;
    begin
        VendorSignedDocument.SetRange("Vendor Profile ID", Rec."Profile ID");
        if VendorSignedDocument.FindSet() then begin
            VendorSignedDocument.DeleteAll();
        end;

    end;


}
