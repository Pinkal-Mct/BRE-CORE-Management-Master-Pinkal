table 50925 "Payment Mode2"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(50100; "Payment Series"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';

        }

        field(50101; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';

        }

        field(50102; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';

        }

        field(50103; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';

        }

        field(50104; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';



            // trigger OnValidate()
            // begin
            //     if Rec."Due Date" <> xRec."Due Date" then begin
            //         if Rec."Due Date" = Today() then
            //             Rec."Payment Status" := Rec."Payment Status"::"Due"
            //         else if Rec."Due Date" < Today() then
            //             Rec."Payment Status" := Rec."Payment Status"::"Overdue"
            //         else
            //             Rec."Payment Status" := Rec."Payment Status";

            //         Modify();
            //     end;
            // end;


            // trigger OnValidate()
            // begin
            //     // Check if the Due Date matches today's date
            //     if Rec."Due Date" = Today() then begin
            //         Rec."Payment Status" := Rec."Payment Status"::"Due"; // Update Payment Status to "Due"
            //                                                              //  else 
            //                                                              //     // Reset the Payment Status if Due Date does not match
            //                                                              //     Rec."Payment Status" := Rec."Payment Status"::" "; // Or any default status
            //     end;

            //     // // Ensure the changes are saved

            //     if Rec."Due Date" <= Today() then begin
            //         if Rec."Due Date" = Today() then
            //             Rec."Payment Status" := Rec."Payment Status"::"Due" // Update Payment Status to "Due"
            //         else
            //             Rec."Payment Status" := Rec."Payment Status"::"Overdue"; // Update Payment Status to "Overdue"
            //     end;
            //     Modify();
            // end;

        }



        field(50105; "Payment Mode"; Text[100])
        {
            Caption = 'Payment Mode';
            TableRelation = "Payment Type"."Payment Method";

            trigger OnValidate()
            var
                paymentschedule: Record "Payment Schedule2";
            begin

                if Rec."Payment Mode" = 'Cheque' then begin
                    Rec."Cheque Status" := Rec."Cheque Status"::"Cheque Received";
                    Rec.Modify();
                end;

                paymentschedule.SetRange("payment Series", Rec."Payment Series");
                paymentschedule.SetRange("Contract ID", Rec."Contract ID");
                if paymentschedule.FindSet() then
                    repeat
                        paymentschedule."Payment Mode" := Rec."Payment Mode";
                        paymentschedule.Modify();
                    until paymentschedule.Next() = 0;

            end;
        }

        field(50106; "Cheque Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cheque Number';

            trigger OnValidate()
            var
                pdcTransRec: Record "PDC Transaction";
                paymentGridRec: Record "Payment Mode2";
                paymentschedule: Record "Payment Schedule2";
            begin
                paymentGridRec.SetRange("Cheque Number", Rec."Cheque Number");
                paymentGridRec.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
                if paymentGridRec.FindFirst() then
                    Error('This cheque number has already been used.');


                pdcTransRec.SetRange("payment Series", Rec."Payment Series");
                pdcTransRec.SetRange("Contract ID", Rec."Contract ID");
                if pdcTransRec.FindSet() then begin
                    pdcTransRec."Cheque Number" := Rec."Cheque Number";
                    pdcTransRec.Modify();
                end;

                paymentschedule.SetRange("payment Series", Rec."Payment Series");
                paymentschedule.SetRange("Contract ID", Rec."Contract ID");
                if paymentschedule.FindSet() then
                    repeat
                        paymentschedule."Cheque Number" := Rec."Cheque Number";
                        paymentschedule.Modify();
                    until paymentschedule.Next() = 0;
            end;
        }

        field(50107; "Deposit Bank"; Code[100])
        {
            Caption = 'Deposit Bank';
            TableRelation = "Bank Account"; // You can add a TableRelation here if required

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
                pdcTransRec: Record "PDC Transaction";
            begin
                // When a Deposit Bank is selected (i.e., a Bank Account No. is provided)
                if "Deposit Bank" <> '' then
                    // Attempt to find the Bank Account using the No. from the Deposit Bank
                    if BankAccountRec.Get("Deposit Bank") then
                        "Deposit Bank" := BankAccountRec."Name"; // Populating the Name field from the Bank Account table

                pdcTransRec.SetRange("payment Series", Rec."Payment Series");
                pdcTransRec.SetRange("Contract ID", Rec."Contract ID");
                if pdcTransRec.FindSet() then begin
                    pdcTransRec."Bank Name" := Rec."Deposit Bank";
                    pdcTransRec.Modify();
                end;
            end;
        }

        field(50108; "Deposit Status"; Option)
        {
            OptionMembers = "-","N","Y";
            Caption = 'Deposit Status';
        }

        field(50112; "Payment Status"; Enum "Payment Status")
        {
            //OptionMembers = "Scheduled","Due","Received","Overdue","Cancelled";
            Caption = 'Payment Status';

            trigger OnValidate()
            var
                paymentmode2Grid: Record "Payment Mode2";
                paymentschedule2: Record "Payment Schedule2";
                CashReceiptJournalCodeunit: Codeunit 50514;
                Email: Codeunit "Send Payment Receipt";
                emailrec: Codeunit "Send PaymentMode Email";
                azureBlobUploader: Codeunit "Azure AD Blob Storage";
                TempBlob: Codeunit "Temp Blob";
                RecRef: RecordRef;
                fileName: Text[250];
                uploadResult: Text[250];
                folderName: Text;
                // AzureBlobUploader: Codeunit "Azure Blob Management";
                // InStream: InStream;
                // FileName: Text;
                // SASUrlBase: Text;
                // SASUrlWithFileName: Text;
                // // UploadResult: Text;
                // ValidFormats: List of [Text];
                // FileExtension: Text[10];
                // FileSize: Decimal;
                // ConfigRecord: Record AzureConfiguration;
                ReportID: Integer; // Your report ID
                // FieldRef1: FieldRef;
                // FieldRef2: FieldRef;
                OutStream: OutStream;
                // documentattachment: Codeunit UploadAttachment;
                // azureConfig: Record AzureConfiguration;
                inStream: InStream;
            begin
                case Rec."Payment Status" of
                    Rec."Payment Status"::Received:
                        begin
                            // if Rec."Payment Mode" = 'Bank Transfer' then begin
                            //     if Rec."Deposit Bank" = '' then begin
                            //         Error('Deposite Bank must be filled when payment mode is bank transfer');
                            //     end;
                            // end;

                            if Rec."Payment Mode" = 'Cheque' then
                                Rec."Cheque Status" := Rec."Cheque Status"::Cleared;

                            // Rec."Cheque Status" := Rec."Cheque Status"::Cleared;
                            CashReceiptJournalCodeunit.CreateCashReceiptJournal(Rec);
                            Email.SendEmail(Rec);
                            emailrec.SendEmail(Rec);

                            // if not ConfigRecord.FindFirst() then
                            //     Error('Azure configuration is missing. Please set up the SAS URL in the Azure Configuration table.');
                            // ValidFormats.Add('.png');
                            // ValidFormats.Add('.jpg');
                            // ValidFormats.Add('.jpeg');

                            // SASUrlBase := ConfigRecord."SAS URL";
                            // FileExtension := '.pdf';
                            ReportID := 50112;
                            //  RecRef.Open(DATABASE::"Sales Header"); // Open the table reference
                            // RecRef.GetTable(Rec);
                            paymentmode2Grid.Reset();
                            paymentmode2Grid.SetRange("Tenant ID", Rec."Tenant ID");
                            paymentmode2Grid.SetRange("Contract ID", Rec."Contract ID"); // Ensure filtering on unique ID
                            paymentmode2Grid.SetRange("Payment Series", Rec."Payment Series"); // Add this line to filter by Payment Series

                            if not paymentmode2Grid.FindFirst() then
                                Error('Not avavilable');
                            RecRef.GetTable(paymentmode2Grid);
                            RecRef.GetTable(Rec);
                            TempBlob.CreateOutStream(OutStream);
                            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);
                            TempBlob.CreateInStream(inStream);

                            // TempBlob.CreateInStream(InStream);
                            fileName := 'Invoice_' + Format(Rec."Contract ID") + Rec."Payment Series" + '.pdf';
                            // SASUrlWithFileName := StrSubstNo('%1/%2?%3', CopyStr(SASUrlBase, 1, StrPos(SASUrlBase, '?') - 1), FileName, CopyStr(SASUrlBase, StrPos(SASUrlBase, '?') + 1));
                            // UploadResult := documentattachment.UploadDocumentToBlobStorage(SASUrlWithFileName, FileName, InStream);
                            // Rec."View Invoice" := FileName;
                            // Rec."View Reciept document URL" := UploadResult;

                            folderName := 'Payment Receipt';
                            uploadResult := CopyStr(azureBlobUploader.UploadDocumentToBlob(inStream, fileName, folderName), 1, 250);
                            if fileName <> '' then begin
                                Rec."View Invoice" := fileName;
                                Rec."View Reciept document URL" := uploadResult;
                                Rec.Modify();
                                Message('File uploaded successfully: %1', fileName);
                            end;
                            Rec.Modify();
                            paymentschedule2.SetRange("payment Series", Rec."Payment Series");
                            paymentschedule2.SetRange("Contract ID", Rec."Contract ID");
                            if paymentschedule2.FindSet() then
                                repeat
                                    paymentschedule2.Validate("Payment Status", Format(Rec."Payment Status"));
                                    paymentschedule2.Modify();
                                until paymentschedule2.Next() = 0
                        end;
                    Rec."Payment Status"::Cancelled:
                        begin
                            emailrec.SendEmailCancelled(Rec); // Call for Cancelled status
                            Rec.Validate("Cheque Status", Rec."Cheque Status"::Retrieved);
                            // Rec."Cheque Status" := Rec."Cheque Status"::Retrieved;
                        end;
                    Rec."Payment Status"::Overdue:
                        emailrec.SendEmailOverdue(Rec); // Call for Overdue status
                end;
            end;

            // trigger OnValidate()
            // var
            //     emailrec: Codeunit "Send PaymentMode Email";

            // begin
            //     // Check the status and call the appropriate email procedure
            //     if Rec."Payment Status" = Rec."Payment Status"::Received then begin
            //         emailrec.SendEmail(Rec); // Call for Received status

            //     end

            //     else if Rec."Payment Status" = Rec."Payment Status"::Cancelled then begin
            //         emailrec.SendEmailCancelled(Rec); // Call for Cancelled status
            //     end

            //     else if Rec."Payment Status" = Rec."Payment Status"::Overdue then begin
            //         emailrec.SendEmailOverdue(Rec); // Call for Overdue status
            //     end;
            // end;
        }

        field(50113; "Cheque Status"; Enum "PDC Status Type Enum")
        {
            // OptionMembers = "-","Cheque Received","Cleared","Deposited","Due & cheque not deposited","Retrieved","Returned","Replaced & Received","Deferred";
            Caption = 'Cheque Status';


            trigger OnValidate()
            var
                pdcTransRec: Record "PDC Transaction";
            begin
                if (Rec."Cheque Status" in [Rec."Cheque Status"::Cleared, Rec."Cheque Status"::Deposited, Rec."Cheque Status"::Returned]) then
                    Rec."Deposit Status" := Rec."Deposit Status"::"Y"
                else
                    Rec."Deposit Status" := Rec."Deposit Status"::"N";


                // Update Payment Status based on Cheque Status
                if (Rec."Cheque Status" = Rec."Cheque Status"::Cleared) then
                    Rec."Payment Status" := Rec."Payment Status"::"Received";


                pdcTransRec.SetRange("payment Series", Rec."Payment Series");
                pdcTransRec.SetRange("Contract ID", Rec."Contract ID");
                if pdcTransRec.FindSet() then begin
                    // pdcTransRec.Validate("Cheque Status", Rec."Cheque Status");
                    pdcTransRec."Cheque Status" := Rec."Cheque Status";
                    pdcTransRec.Modify();
                end;
            end;

        }

        field(50114; "Invoice #"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice #';
        }

        field(50115; "Receipt #"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt #';
        }

        field(50116; "Old Cheque #"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Old Cheque #';
        }

        field(50117; "Upload Cheque"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'Upload Cheque';
            InitValue = 'Upload Cheque';
        }


        field(50118; "Download"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Download';
            InitValue = 'Download';
        }

        field(50120; "View"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'View';
            InitValue = 'View';
        }

        field(50119; "View Revenue Details"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Revenue Details';
            InitValue = 'View Revenue Details';
        }
        field(50121; "View Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
            trigger OnValidate()
            var
                pdcTransRec: Record "PDC Transaction";
            begin
                pdcTransRec.SetRange("payment Series", Rec."Payment Series");
                pdcTransRec.SetRange("Contract ID", Rec."Contract ID");
                if pdcTransRec.FindSet() then begin
                    pdcTransRec."View Document URL" := Rec."View Document URL";
                    pdcTransRec.Modify();
                end;
            end;
        }


        field(50123; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Mode2".Amount where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }

        field(50912; "Total VAT Amount"; Decimal)
        {
            Caption = 'Total VAT Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Mode2"."VAT Amount" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }
        field(50913; "Total Amount Including VAT"; Decimal)
        {
            Caption = 'Total Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Mode2"."Amount Including VAT" where("Contract ID" = field("Contract ID"), "Tenant ID" = field("Tenant ID")));
        }

        field(50110; "Tenant Id"; Code[20])
        {
            Caption = 'Tenant Id';
        }


        field(50111; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
        }

        field(50122; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50124; "Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50125; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                paymentModeRec: Record "Payment Mode";
                paymentGridRec: Record "Payment Mode2";
                pdcTransRec: Record "PDC Transaction";
                sendRejectionToLeaseTeam: Codeunit 50511;
                approvalflow: Codeunit 50510;
                AllApproved: Boolean;
                AnyPending: Boolean;
                AnyRejected: Boolean;
                CurrApproved: Boolean;
                CurrRejected: Boolean;
                CurrAnyPending: Boolean;
            begin
                pdcTransRec.SetRange("payment Series", Rec."Payment Series");
                pdcTransRec.SetRange("Contract ID", Rec."Contract ID");
                if pdcTransRec.FindSet() then
                    repeat
                        pdcTransRec."Approval Status" := Rec."Approval Status";
                        pdcTransRec.Modify();
                    until pdcTransRec.Next() = 0;

                // Fetch the Parent Record (Main Payment Mode Card)
                if paymentModeRec.Get(Rec."Contract ID") then begin

                    AllApproved := false;
                    AnyPending := false;
                    CurrApproved := false;
                    CurrAnyPending := false;
                    AnyRejected := false;
                    CurrRejected := false;

                    // Check if all grid records have "Approved" status
                    paymentGridRec.SetRange("Contract ID", Rec."Contract ID");
                    paymentGridRec.SetFilter("Entry No.", '<>%1', Rec."Entry No.");


                    if paymentGridRec.FindSet() then begin
                        // paymentGridRec.Init();
                        repeat
                            if (paymentGridRec."Approval Status" = paymentGridRec."Approval Status"::Approved) then
                                // AnyPending := false;
                                AllApproved := true
                            // AnyRejected := false;
                            else
                                if paymentGridRec."Approval Status" = paymentGridRec."Approval Status"::Pending then
                                    AnyPending := true
                                // AllApproved := false;
                                // AnyRejected := false;
                                else
                                    if paymentGridRec."Approval Status" = paymentGridRec."Approval Status"::Rejected then
                                        // AnyPending := false;
                                        // AllApproved := false;
                                        AnyRejected := true


                        until paymentGridRec.Next() = 0;

                        if (Rec."Approval Status" = Rec."Approval Status"::Approved) then begin
                            CurrAnyPending := false;
                            CurrApproved := true;
                            CurrRejected := false;
                        end
                        else
                            if Rec."Approval Status" = Rec."Approval Status"::Pending then begin
                                CurrAnyPending := true;
                                CurrApproved := false;
                                CurrRejected := false;
                            end
                            else
                                if Rec."Approval Status" = Rec."Approval Status"::Rejected then begin
                                    CurrAnyPending := false;
                                    CurrApproved := false;
                                    CurrRejected := true;
                                end;

                    end;

                    if AllApproved and CurrApproved and (not CurrRejected and not AnyRejected) and (not CurrAnyPending and not AnyPending) then begin
                        paymentModeRec."Approval Status" := paymentModeRec."Approval Status"::Approved;
                        paymentModeRec."On-hold" := paymentModeRec."On-hold"::"False";
                        paymentModeRec.Modify();
                        approvalflow.SendPaymentModeApprovalToFinanceManger(Format(paymentModeRec."Contract ID"), paymentModeRec."Tenant Id", paymentModeRec."Contract ID", false);
                    end
                    else
                        if AnyPending or CurrAnyPending then begin
                            paymentModeRec."On-hold" := paymentModeRec."On-hold"::"True";
                            paymentModeRec."Approval Status" := paymentModeRec."Approval Status"::Pending;
                            paymentModeRec.Modify();
                        end
                        else
                            if AnyRejected and CurrRejected and (not AllApproved and not CurrApproved) and (not AnyPending and not CurrAnyPending) then begin
                                paymentModeRec."Approval Status" := paymentModeRec."Approval Status"::Rejected;
                                paymentModeRec."On-hold" := paymentModeRec."On-hold"::"True";
                                paymentModeRec.Modify();
                                sendRejectionToLeaseTeam.SendPaymentRejectionToLeaseManager(paymentModeRec."Contract ID", paymentModeRec."Tenant Id", paymentModeRec."Contract ID");
                            end
                            else
                                if (AllApproved or CurrApproved) and (AnyRejected or CurrRejected) and (not AnyPending and not CurrAnyPending) then begin
                                    paymentModeRec."Approval Status" := paymentModeRec."Approval Status"::"On-Hold";
                                    paymentModeRec."On-hold" := paymentModeRec."On-hold"::"True";
                                    paymentModeRec.Modify();
                                    sendRejectionToLeaseTeam.SendPaymentRejectionToLeaseManager(paymentModeRec."Contract ID", paymentModeRec."Tenant Id", paymentModeRec."Contract ID");
                                end;
                    paymentModeRec.Modify();
                end;
            end;
        }

        field(50126; "Reason"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50127; "IsUpdated"; Option)
        {
            // DataClassification = ToBeClassified;
            OptionMembers = " ","Yes","No";
        }

        field(50128; "Approve/Decline Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50129; "Tenant Name"; Text[100])
        {
            Caption = 'Tenant Name';
        }

        field(50130; "Tenant Email"; Text[100])
        {
            Caption = 'Tenant Email';
        }

        field(50131; "Payment Received Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50132; "View Invoice"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Invoice';
        }
        field(50133; "View Reciept document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View Document URL';
        }

        field(50134; "Payment Reminder"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Reminder';
            Editable = false;

        }
        field(50929; "Credit Note No."; Code[100])
        {
            //OptionMembers = "0%","5%";
            DataClassification = ToBeClassified;
            Caption = 'Credit Note No.';
        }

        field(50935; "Credit Note Amount"; Decimal)
        {
            //OptionMembers = "0%","5%";
            DataClassification = ToBeClassified;
            Caption = 'Credit Note Amount';
        }
        field(50936; "Final Rent Amount"; Decimal)
        {
            //OptionMembers = "0%","5%";
            DataClassification = ToBeClassified;
            Caption = 'Final Rent Amount';
        }
        field(50937; "FinalRentAmountIncludingVAT"; Decimal)
        {
            //OptionMembers = "0%","5%";    
            DataClassification = ToBeClassified;
            Caption = 'Final Rent Amount Including VAT';
        }
        field(50938; "PortalSidePaymentProcessing"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Portal Side Payment Processing';
        }


    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Payment Series", "Amount")
        {
            Caption = 'Dropdown';

        }

    }


    // procedure UpdateStatusForDueDate()
    // var
    //     SubGridRec: Record "Payment Mode2"; // Replace "Payment" with the actual subgrid table
    // begin
    //     // Filter the subgrid records to match today's date
    //     if SubGridRec.FindSet() then begin
    //         repeat
    //             if SubGridRec."Due Date" = Today() then begin
    //                 // Update the status to "Due"
    //                 SubGridRec."Payment Status" := SubGridRec."Payment Status"::"Due";
    //                 SubGridRec.Modify();
    //             end;
    //         until SubGridRec.Next() = 0;
    //     end;
    // end;



    // trigger OnAfterValidate()
    // begin
    //     if Rec."Due Date" = Today() then begin
    //         Rec."Payment Status" := Rec."Payment Status"::"Due";
    //         Modify();
    //     end;
    // end;





    trigger OnInsert()
    begin
        if Rec."Payment Mode" = 'Cheque' then
            if DelChr(Rec."Cheque Number", '=', ' ') = '' then
                Error('Cheque Number cannot be blank when Payment Mode is Cheque.');

    end;

    trigger OnModify()
    var
        emailrec: Codeunit "Send PaymentMode Email";
    begin
        // ✅ Check if Payment Status has changed
        if Rec."Payment Status" <> xRec."Payment Status" then
            case Rec."Payment Status" of
                Rec."Payment Status"::Received:
                    emailrec.SendEmail(Rec);
                Rec."Payment Status"::Cancelled:
                    emailrec.SendEmailCancelled(Rec);
                Rec."Payment Status"::Overdue:
                    emailrec.SendEmailOverdue(Rec);
            end;
    end;
}
