namespace BRECOREManagementMastermegha.BRECOREManagementMastermegha;

page 51751 "Vendor Profile Api"
{
    APIGroup = 'vendor';
    APIPublisher = 'RealeststeDev';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'vendorProfileApi';
    DelayedInsert = true;
    EntityName = 'vendorProfile';
    EntitySetName = 'vendorProfiles';
    PageType = API;
    SourceTable = "Facility Vendor Profiles";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(accountName; Rec."Account Name")
                {
                    Caption = 'Account Name';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(address3; Rec."Address 3")
                {
                    Caption = 'Address 3';
                }
                field(applicationMethod; Rec."Application Method")
                {
                    Caption = 'Application Method';
                }
                field(areaCode; Rec."Area Code")
                {
                    Caption = 'Area Code';
                }
                field(balanceLCY; Rec."Balance (LCY)")
                {
                    Caption = 'Balance (LCY)';
                }
                field(balanceDueLCY; Rec."Balance Due (LCY)")
                {
                    Caption = 'Balance Due (LCY)';
                }
                field(bankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }
                field(bankBranch; Rec."Bank Branch")
                {
                    Caption = 'Bank Branch';
                }
                field(bankDocContainerID; Rec."Bank Doc Container ID")
                {
                    Caption = 'Bank Doc Container ID';
                }
                field(bankInfoVerified; Rec."Bank Info Verified")
                {
                    Caption = 'Bank Info Verified';
                }
                field(bankName; Rec."Bank Name")
                {
                    Caption = 'Bank Name';
                }
                field(baseCalendarCode; Rec."Base Calendar Code")
                {
                    Caption = 'Base Calendar Code';
                }
                field(blockPaymentTolerance; Rec."Block Payment Tolerance")
                {
                    Caption = 'Block Payment Tolerance';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(cashFlowPaymentTermsCode; Rec."Cash Flow Payment Terms Code")
                {
                    Caption = 'Cash Flow Payment Terms Code';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(community; Rec.Community)
                {
                    Caption = 'Community';
                }
                field(companySizeCode; Rec."Company Size Code")
                {
                    Caption = 'Company Size Code';
                }
                field(corporateTaxRegistration; Rec."Corporate Tax Registration")
                {
                    Caption = 'Corporate Tax Registration';
                }
                field(country; Rec.Country)
                {
                    Caption = 'Country';
                }
                field(creditorNo; Rec."Creditor No.")
                {
                    Caption = 'Creditor No.';
                }
                field(designation; Rec.Designation)
                {
                    Caption = 'Designation';
                }
                field(disableSearchByName; Rec."Disable Search by Name")
                {
                    Caption = 'Disable Search by Name';
                }
                field(documentSendingProfile; Rec."Document Sending Profile")
                {
                    Caption = 'Document Sending Profile';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(ecNumber; Rec."EC Number")
                {
                    Caption = 'EC Number';
                }
                field(emailAddress; Rec."Email Address")
                {
                    Caption = 'Email Address';
                }
                field(emirate; Rec.Emirate)
                {
                    Caption = 'Emirate';
                }
                field(emiratesID; Rec."Emirates ID")
                {
                    Caption = 'Emirates ID';
                }
                field(expiryDate; Rec."Expiry Date")
                {
                    Caption = 'Expiry Date';
                }
                field(homePage; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }
                field(iban; Rec.IBAN)
                {
                    Caption = 'IBAN';
                }
                field(ibanCertificate; Rec."IBAN Certificate")
                {
                    Caption = 'IBAN Certificate';
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                    Caption = 'IC Partner Code';
                }
                field(issueDate; Rec."Issue Date")
                {
                    Caption = 'Issue Date';
                }
                field(issuingAuthority; Rec."Issuing Authority")
                {
                    Caption = 'Issuing Authority';
                }
                field(landlineNumber; Rec."Landline Number")
                {
                    Caption = 'Landline Number';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(leadTimeCalculation; Rec."Lead Time Calculation")
                {
                    Caption = 'Lead Time Calculation';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(mobilePhoneNo; Rec."Mobile Phone No.")
                {
                    Caption = 'Mobile Phone No.';
                }
                field(number; Rec.Number)
                {
                    Caption = 'Number';
                }
                field(ourAccountNo; Rec."Our Account No.")
                {
                    Caption = 'Our Account No.';
                }
                field(overReceiptCode; Rec."Over-Receipt Code")
                {
                    Caption = 'Over-Receipt Code';
                }
                field(ownersDesignation; Rec."Owners Designation")
                {
                    Caption = 'Designation';
                }
                field(ownersName; Rec."Owners Name")
                {
                    Caption = 'Name';
                }
                field(pOBox; Rec."P.O.Box")
                {
                    Caption = 'P.O.Box';
                }
                field(partnerType; Rec."Partner Type")
                {
                    Caption = 'Partner Type';
                }
                field(passportNumber; Rec."Passport Number")
                {
                    Caption = 'Passport Number';
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                    Caption = 'Payment Method Code';
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(preferredBankAccountCode; Rec."Preferred Bank Account Code")
                {
                    Caption = 'Preferred Bank Account Code';
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method';
                }
                field(priceIncludingVAT; Rec."Price Including VAT")
                {
                    Caption = 'Price Including VAT';
                }
                field(primaryContactCode; Rec."Primary Contact Code")
                {
                    Caption = 'Primary Contact Code';
                }
                field(primaryEmailAddress; Rec."Primary Email Address")
                {
                    Caption = 'Primary Email Address';
                }
                field(priority; Rec.Priority)
                {
                    Caption = 'Priority';
                }
                field(privacyBlocked; Rec."Privacy Blocked")
                {
                    Caption = 'Privacy Blocked';
                }
                field(profileID; Rec."Profile ID")
                {
                    Caption = 'Profile ID';
                }
                field(profileMobileNo; Rec."Profile Mobile No.")
                {
                    Caption = 'Mobile No.';
                }
                field(profileName; Rec."Profile Name")
                {
                    Caption = 'Profile Name';
                }
                field(profileNationality; Rec."Profile Nationality")
                {
                    Caption = 'Nationality';
                }
                field(purchaserCode; Rec."Purchaser Code")
                {
                    Caption = 'Purchaser Code';
                }
                field(receiveEDocumentTo; Rec."Receive E-Document To")
                {
                    Caption = 'Receive E-Document To';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(swiftCode; Rec."SWIFT Code")
                {
                    Caption = 'SWIFT Code';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(tradeLicenseExpiryDate; Rec."Trade License Expiry Date")
                {
                    Caption = 'Trade License Expiry Date';
                }
                field(tradeLicenseIssueDate; Rec."Trade License Issue Date")
                {
                    Caption = 'Trade License Issue Date';
                }
                field(tradeLicenseNumber; Rec."Trade License Number")
                {
                    Caption = 'Trade License Number';
                }
                field(tradeLicenseIssuingAuthority; Rec."TradeLicense IssuingAuthority")
                {
                    Caption = 'Trade License Issuing Authority';
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                }
                field(vatRegistrationNumber; Rec."VAT Registration Number")
                {
                    Caption = 'VAT Registration Number';
                }
                field(vendorID; Rec."Vendor ID")
                {
                    Caption = 'Vendor ID';
                }
                field(vendorName; Rec."Vendor Name")
                {
                    Caption = 'Vendor Name';
                }
                field(vendorType; Rec."Vendor Type")
                {
                    Caption = 'Vendor Type';
                }
                field(verificationDate; Rec."Verification Date")
                {
                    Caption = 'Verification Date';
                }
            }
        }
    }
}
