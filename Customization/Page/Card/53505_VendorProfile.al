page 53505 VendorProfile
{
    PageType = Card;
    SourceTable = "Facility Vendor Profiles";
    Caption = 'Vendor Profile';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(VendorDetails)
            {
                Caption = 'Vendor Details';
                field("Vendor ID"; Rec."Vendor ID")
                {
                    Caption = 'Vendor ID';
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        vendorrecord: record Vendor;
                    begin
                        vendorrecord.SetRange("No.", Rec."Vendor ID");
                        if vendorrecord.FindSet() then begin
                            Rec."Vendor Name" := vendorrecord.Name;
                            Rec."Email Address" := vendorrecord."E-Mail";
                            Rec.Address := vendorrecord.Address;
                            Rec."Landline Number" := vendorrecord."Phone No.";
                            Rec.City := vendorrecord.City;
                            Rec."Landline Number" := vendorrecord."Phone No.";
                        end else begin
                            Rec."Vendor Name" := '';
                            Rec.Address := '';
                            Rec."Landline Number" := '';
                            Rec."Email Address" := '';
                            Rec.City := '';
                        end;
                    end;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Vendor Type"; Rec."Vendor Type")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Type';
                    // Editable = false;
                    ShowMandatory = true;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                    Caption = 'Email Address';
                    Editable = false;
                    ShowMandatory = true;
                }

                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }

                group(Address)
                {
                    Caption = 'Address';
                    field(Address1; Rec.Address)
                    {
                        Caption = 'Address Line 1';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        Caption = 'Address Line 2';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Address 3"; Rec."Address 3")
                    {
                        Caption = 'Address Line 3';
                        ApplicationArea = All;
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = All;
                        Caption = 'City';
                    }
                    field("P.O.Box"; Rec."P.O.Box")
                    {
                        ApplicationArea = All;
                        Caption = 'P.O.Box';
                    }
                    field(Code; Rec.Code)
                    {
                        Caption = 'Landline Code';
                        ApplicationArea = All;
                    }
                    field("Landline Number"; Rec."Landline Number")
                    {
                        Caption = 'Landline Number';
                        ApplicationArea = All;
                    }

                }

            }
            group(PrimaryContact)
            {
                Caption = 'Primary Contact';
                field("Primary Contact Profile ID"; Rec."Profile ID")
                {
                    ApplicationArea = All;
                    Caption = 'Profile ID';
                    Editable = false;
                }

                field("Primary Contact Name"; Rec."Profile Name")
                {
                    ApplicationArea = All;
                    Caption = 'Profile Name';
                }

                field("Primary Contact Designation"; Rec.Designation)
                {
                    ApplicationArea = All;
                    Caption = 'Designation';
                }

                field("Primary Contact Mobile Code"; Rec."Area Code")
                {
                    ApplicationArea = All;
                    Caption = 'Mobile Area Code';
                }

                field("Primary Contact Mobile No."; Rec.Number)
                {
                    ApplicationArea = All;
                    Caption = 'Mobile Number';
                }

                field("Primary Contact Nationality"; Rec."Profile Nationality")
                {
                    ApplicationArea = All;
                    Caption = 'Nationality';
                }

                field("Primary Contact Email"; Rec."Primary Email Address")
                {
                    ApplicationArea = All;
                    Caption = 'Email Address';
                }
            }
            group("Vendor Statutory registration and license Details")
            {
                // Trade License Section
                group("Trade License")
                {
                    field("Trade License Issuing Authority"; Rec."TradeLicense IssuingAuthority")
                    {
                        ApplicationArea = All;
                        Caption = 'Trade License Issuing Authority';
                    }

                    field("Trade License Number"; Rec."Trade License Number")
                    {
                        ApplicationArea = All;
                        Caption = 'Trade License Number';
                    }

                    field("Trade License Issue Date"; Rec."Trade License Issue Date")
                    {
                        ApplicationArea = All;
                        Caption = 'Trade License Issue Date';
                    }

                    field("Trade License Expiry Date"; Rec."Trade License Expiry Date")
                    {
                        ApplicationArea = All;
                        Caption = 'Trade License Expiry Date';
                    }


                }
                field("VAT Registration Number"; Rec."VAT Registration Number")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Registration Number';
                }

                field("Corporate Tax Registration Number"; Rec."Corporate Tax Registration")
                {
                    ApplicationArea = All;
                    Caption = 'Corporate Tax Registration Number';
                }
                // Establishment Details Section
                group("Establishment Details")
                {
                    field("EC Number"; Rec."EC Number")
                    {
                        ApplicationArea = All;
                        Caption = 'EC Number';
                    }

                    field("Issuing Authority"; Rec."Issuing Authority")
                    {
                        ApplicationArea = All;
                        Caption = 'Issuing Authority';
                    }

                    field("EC Issue Date"; Rec."Issue Date")
                    {
                        ApplicationArea = All;
                        Caption = 'Issue Date';
                    }

                    field("EC Expiry Date"; Rec."Expiry Date")
                    {
                        ApplicationArea = All;
                        Caption = 'Expiry Date';
                    }
                }
            }
            group("Owners/Partners/Authorised Signatory Details")
            {
                field("Owners Name"; Rec."Owners Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name (Optional)';
                    ToolTip = 'Mandatory if vendor agreement is initiated by the company.';
                }

                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    Caption = 'Designation';
                    ToolTip = 'Mandatory if vendor agreement is initiated by the company.';
                }

                field("Emirates ID"; Rec."Emirates ID")
                {
                    ApplicationArea = All;
                    Caption = 'Emirates ID';
                    TableRelation = Emirate."Emirate Name";
                    ToolTip = 'Mandatory if vendor agreement is initiated by the company.';
                }

                field("Passport Number"; Rec."Passport Number")
                {
                    ApplicationArea = All;
                    Caption = 'Passport Number';
                    ToolTip = 'Mandatory if vendor agreement is initiated by the company.';
                }
            }
            group("Bank Account Details & IBAN Certificate")
            {
                field("Bank Account Number"; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Account Number';
                }

                field("Bank Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Account Name';
                }

                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Name';
                }

                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Branch';
                }

                field("IBAN"; Rec."IBAN")
                {
                    ApplicationArea = All;
                    Caption = 'IBAN';
                }

                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = All;
                    Caption = 'SWIFT Code';
                }
            }

            part(VendorProfileDocumentGrid; "Vendor Profile Document Grid")
            {
                ApplicationArea = All;
                Caption = 'Vendor Documents';
                Visible = true;
                SubPageLink = "Profile ID" = field("Profile ID");
            }
            group("Vendor Business Profile")
            {
                Caption = 'Vendor Business Profile';
                part(VendorBusinessProfileSM; "Vendor Business Profile SM")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Business Profile';
                    Visible = not isFacilityVendor;
                    SubPageLink = "Profile ID" = field("Profile ID");
                }
            }

            part(VendorBusinessProfileFM; "Vendor Business Profile FM")
            {
                ApplicationArea = All;
                Caption = 'Vendor Business Profile';
                Visible = isFacilityVendor;
                SubPageLink = "Profile ID" = field("Profile ID");
                UpdatePropagation = Both;
            }
            part("Vendor Document Upload Grid"; "Vendor Document Upload Grid")
            {
                ApplicationArea = All;
                Caption = 'Vendor Documents';
                Visible = true;
                SubPageLink = "Profile ID" = field("Profile ID");
            }
            part("Vendor Signed Contract Document"; "Vendor Signed ContractDocument")
            {
                ApplicationArea = All;
                Caption = 'Vendor Signed Contract Document';
                Visible = not isFacilityVendor;
                SubPageLink = "Vendor Profile ID" = field("Profile ID");
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(Vendorprofile)
            {
                ApplicationArea = All;
                Caption = 'Vendor Profile Approval';
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                var
                    ApprovalVendorprofile: Record "Approval Vendor Profile";
                begin
                    // Ensure current record is fetched
                    if not Rec.Get(Rec."Profile ID") then
                        Error('Vendor profile for Vendor ID %1 not found.', Rec."Profile ID");

                    // Validate required fields
                    if Rec."Profile ID" = '' then
                        Error('Vendor ID must be specified');

                    ApprovalVendorprofile.SetRange("Profile ID", Rec."Profile ID");
                    if ApprovalVendorprofile.FindSet() then begin
                        // Modify existing approval record
                        ApprovalVendorprofile."Profile ID" := Rec."Profile ID";
                        ApprovalVendorprofile."Vendor ID" := Rec."Vendor ID";
                        ApprovalVendorprofile."Status" := Rec."Status";
                        ApprovalVendorprofile."Vendor Name" := Rec."Vendor Name";
                        ApprovalVendorprofile."Country" := Rec."Country";
                        ApprovalVendorprofile."Emirate" := Rec."Emirate";
                        ApprovalVendorprofile."Community" := Rec."Community";
                        ApprovalVendorprofile."Phone No." := Rec."Phone No.";
                        ApprovalVendorprofile."Mobile Phone No." := Rec."Mobile Phone No.";
                        ApprovalVendorprofile."E-Mail" := Rec."E-Mail";
                        ApprovalVendorprofile."Location Code" := Rec."Location Code";
                        ApprovalVendorprofile."Vendor Type" := Rec."Vendor Type";
                        ApprovalVendorprofile.Modify();
                        Message('Approval Request Modified successfully!');
                    end else begin
                        // Insert new approval record
                        ApprovalVendorprofile.Init();
                        ApprovalVendorprofile."Profile ID" := Rec."Profile ID";
                        ApprovalVendorprofile."Vendor ID" := Rec."Vendor ID";
                        ApprovalVendorprofile."Status" := Rec."Status";
                        ApprovalVendorprofile."Vendor Name" := Rec."Vendor Name";
                        ApprovalVendorprofile."Country" := Rec."Country";
                        ApprovalVendorprofile."Emirate" := Rec."Emirate";
                        ApprovalVendorprofile."Community" := Rec."Community";
                        ApprovalVendorprofile."Phone No." := Rec."Phone No.";
                        ApprovalVendorprofile."Mobile Phone No." := Rec."Mobile Phone No.";
                        ApprovalVendorprofile."E-Mail" := Rec."E-Mail";
                        ApprovalVendorprofile."Location Code" := Rec."Location Code";
                        ApprovalVendorprofile."Vendor Type" := Rec."Vendor Type";
                        ApprovalVendorprofile.Insert(true);
                        Message('Approval Request Sent successfully!');
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SelectTemplate(Rec);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Rec.TestField("Vendor ID");
        Rec.TestField("Vendor Name");
        Rec.TestField("Vendor Type");
        Rec.TestField("Email Address");
        CurrPage.VendorProfileDocumentGrid.Page.SetProfileID(Rec."Profile ID");
        CurrPage.VendorBusinessProfileSM.Page.SetProfileID(Rec."Profile ID");
        CurrPage."Vendor Signed Contract Document".Page.SetProfileID(Rec."Profile ID");
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage.VendorProfileDocumentGrid.Page.SetProfileID(Rec."Profile ID");
        CurrPage.VendorBusinessProfileSM.Page.SetProfileID(Rec."Profile ID");
        CurrPage."Vendor Signed Contract Document".Page.SetProfileID(Rec."Profile ID");

        CurrPage.Update(false);
    end;

    trigger OnAfterGetRecord()
    begin
        CurrPage.VendorProfileDocumentGrid.Page.SetProfileID(Rec."Profile ID");
        CurrPage.VendorBusinessProfileSM.Page.SetProfileID(Rec."Profile ID");
        CurrPage."Vendor Signed Contract Document".Page.SetProfileID(Rec."Profile ID");
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if Rec.Module = Rec.Module::FM then
            isFacilityVendor := true
        else
            isFacilityVendor := false;
    end;

    var
        isFacilityVendor: Boolean;


    procedure SelectTemplate(var pVendorProfile: Record "Facility Vendor Profiles")
    var
        VendorProfileTemplate: Record "Vendor Profile Template";
    begin
        if VendorProfileTemplate.FindSet() then begin
            if VendorProfileTemplate.Count() > 1 then begin
                if Page.RunModal(53761, VendorProfileTemplate) = Action::LookupOK then begin
                    CreateVendorProfile(pVendorProfile, VendorProfileTemplate);
                end;
            end
            else begin
                CreateVendorProfile(pVendorProfile, VendorProfileTemplate);
            end;
        end;
    end;

    procedure CreateVendorProfile(var pVendorProfile: Record "Facility Vendor Profiles"; pVendorProfileTemplate: Record "Vendor Profile Template")
    var
        noSeries: Codeunit "No. Series";
    begin
        pVendorProfile."Profile ID" := noSeries.GetNextNo(pVendorProfileTemplate."No. Series", Today(), true);
        pVendorProfile.Module := pVendorProfileTemplate.Module;
    end;

}