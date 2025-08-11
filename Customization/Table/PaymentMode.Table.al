table 50924 "Payment Mode"
{
    DataClassification = ToBeClassified;


    fields
    {

        field(50103; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Schedule"."Contract ID";
            // AutoIncrement = true;
            Caption = 'Contract ID';
            trigger OnValidate()
            var
                payschedule: Record "Payment Schedule";
                Tenancycontract: Record "Tenancy Contract";
            begin

                payschedule.SetRange("Contract ID", Rec."Contract ID");
                if payschedule.FindFirst() then
                    "Tenant Id" := payschedule."Tenant Id"
                else
                    "Tenant Id" := '';

                Tenancycontract.SetRange("Contract ID", Rec."Contract ID");
                if Tenancycontract.FindFirst() then begin
                    "Tenant Name" := Tenancycontract."Customer Name";
                    "Tenant Email" := Tenancycontract."Email Address";
                    "Contract Start date" := Tenancycontract."Contract Start Date";
                    "Contract End date" := Tenancycontract."Contract End Date";
                    "Payment Reminder" := Tenancycontract."Payment Reminder";

                end else begin
                    "Tenant Name" := '';
                    "Tenant Email" := '';
                    "Contract Start date" := 0D;
                    "Contract End date" := 0D;
                end;
                EvaluatePaymentSchedule();
                GetNextSequenceNo();

            end;
        }

        field(50916; "Contract Start date"; Date)
        {
            Caption = 'Contract Start date';
            DataClassification = ToBeClassified;
        }
        field(50911; "Contract End date"; Date)
        {
            Caption = 'Contract End date';
            DataClassification = ToBeClassified;
        }


        field(50101; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Id';
            TableRelation = "Payment Schedule"."Contract ID";
            Editable = false; // Make it read-only for the user

        }

        field(50501; "Approval Status"; Option)
        {
            // DataClassification = ToBeClassified;
            OptionMembers = " ","Pending","Approved","On-Hold","Rejected";
            trigger OnValidate()
            var
                paymentGridRec: Record "Payment Mode2";
                paymentSeriesRec: Record "Payment Mode2";
                PdcTransRec: Record "PDC Transaction";
                sendRejectionToLeaseTeam: Codeunit 50511;
                approvalPending: Boolean;
                Isrejected: Boolean;
            //  IsApproved: Boolean;
            begin
                if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
                    paymentGridRec.SetRange("Contract ID", Rec."Contract ID");
                    if paymentGridRec.FindSet() then
                        repeat
                            paymentGridRec."Approval Status" := paymentGridRec."Approval Status"::Approved;

                            paymentGridRec.Modify();
                            // **Update related PDC Transactions for each Payment Series**
                            pdcTransRec.SetRange("Payment Series", paymentGridRec."Payment Series");
                            pdcTransRec.SetRange("Contract ID", Rec."Contract ID");
                            if pdcTransRec.FindSet() then
                                repeat
                                    pdcTransRec."Approval Status" := pdcTransRec."Approval Status"::Approved;
                                    pdcTransRec.Modify();
                                until pdcTransRec.Next() = 0;
                        until paymentGridRec.Next() = 0;

                    Rec."On-hold" := Rec."On-hold"::"False";
                    // IsApproved := true;
                end;
                if Rec."Approval Status" = Rec."Approval Status"::Rejected then begin
                    paymentGridRec.SetRange("Contract ID", Rec."Contract ID");
                    if paymentGridRec.FindSet() then
                        repeat
                            paymentGridRec."Approval Status" := paymentGridRec."Approval Status"::Rejected;
                            paymentGridRec.Modify();
                        until paymentGridRec.Next() = 0;
                    Rec."On-hold" := Rec."On-hold"::"True";
                end;

                if Rec."On-hold" = Rec."On-hold"::"True" then begin
                    approvalPending := false;
                    Isrejected := false;
                    paymentSeriesRec.SetRange("Contract ID", Rec."Contract ID");
                    paymentSeriesRec.SetRange("Tenant Id", Rec."Tenant Id");
                    if paymentSeriesRec.FindSet() then
                        repeat
                            if paymentSeriesRec."Approval Status" = paymentSeriesRec."Approval Status"::Pending then begin
                                approvalPending := true;
                                break;
                            end
                            else
                                if paymentSeriesRec."Approval Status" = paymentSeriesRec."Approval Status"::Rejected then
                                    Isrejected := true;

                        until paymentSeriesRec.Next() = 0;
                    // Exit if there are any "Pending" approval statuses
                    if ApprovalPending then
                        exit;

                    if approvalPending = false and Isrejected = true then
                        sendRejectionToLeaseTeam.SendPaymentRejectionToLeaseManager(paymentSeriesRec."Contract ID", paymentSeriesRec."Tenant Id", paymentSeriesRec."Contract ID");
                end;
            end;
        }

        field(50502; "On-hold"; Option)
        {
            // DataClassification = ToBeClassified;
            OptionMembers = " ","True","False";
        }

        field(50503; "Isupdated"; Option)
        {
            // DataClassification = ToBeClassified;
            OptionMembers = " ","True","False";
        }

        field(50129; "Tenant Name"; Text[100])
        {
            Caption = 'Tenant Name';
        }

        field(50130; "Tenant Email"; Text[100])
        {
            Caption = 'Tenant Email';
        }



        field(50133; "Combine Payment Series"; Text[150])
        {
            DataClassification = ToBeClassified;

        }

        field(50132; "Combine Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }


        field(50134; "Combine Payment Mode"; Text[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Type"."Payment Method";
        }

        field(50135; "Combine Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }


        field(50136; "Combine VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }


        field(50137; "Combine Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50131; "Change Payment Mode"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Type"."Payment Method";
        }

        field(50128; "Change Payment Series"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50150; "Payment Reminder"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Reminder';
            Editable = false;

        }


    }

    keys
    {
        key(PK; "Contract ID")
        {
            Clustered = true;
        }


    }


    procedure EvaluatePaymentSchedule()
    var
        PaymentScheduleRec: Record "Payment Schedule2";
        PaymentScheduleRec2: Record "Payment Schedule2";
        MergedRecord: Record "Payment Mode2";

        TotalAmount: Decimal;
        TotalVAT: Decimal;
        GrandTotal: Decimal;
        NewPaymentCode: Code[20];
        SequenceNo: Integer;
        MinDueDate: Date;
        DueDateList: List of [Date]; // List to store due dates
        i: Integer; // Declare the variable 'i' for the loop
        SortedDueDateList: List of [Date]; // List for sorted due dates
        TempDate: Date;
        PaymentStatus: Enum "Payment Status";
    begin
        // Initialize totals
        TotalAmount := 0;
        TotalVAT := 0;
        GrandTotal := 0;

        // Filter by Proposal ID and Tenant ID
        //PaymentScheduleRec.SetRange("Proposal ID", Rec."Proposal ID");
        PaymentScheduleRec.SetRange("Tenant ID", Rec."Tenant ID");
        PaymentScheduleRec.SetRange("Contract ID", Rec."Contract ID");

        // Collect unique due dates
        if PaymentScheduleRec.FindSet() then
            repeat
                MinDueDate := PaymentScheduleRec."Due Date";
                if not DueDateList.Contains(MinDueDate) then
                    DueDateList.Add(MinDueDate);
            until PaymentScheduleRec.Next() = 0;

        // Sort the DueDateList
        while DueDateList.Count() > 0 do begin
            TempDate := DueDateList.Get(1); // Assume the first date is the smallest
            for i := 2 to DueDateList.Count() do
                if DueDateList.Get(i) < TempDate then
                    TempDate := DueDateList.Get(i); // Update if a smaller date is found

            SortedDueDateList.Add(TempDate); // Add the smallest date to the sorted list
            DueDateList.Remove(TempDate); // Remove the smallest date from the original list
        end;

        // Process each due date in the sorted order
        for i := 1 to SortedDueDateList.Count() do begin
            MinDueDate := SortedDueDateList.Get(i);

            // Reset totals for the next group of records
            TotalAmount := 0;
            TotalVAT := 0;
            GrandTotal := 0;

            // Set the filter to process the records for this due date
            PaymentScheduleRec2.SetRange("Due Date", MinDueDate);
            // PaymentScheduleRec2.SetRange("Proposal ID", Rec."Proposal ID");
            PaymentScheduleRec2.SetRange("Tenant ID", Rec."Tenant ID");
            PaymentScheduleRec2.SetRange("Contract ID", Rec."Contract ID");

            if PaymentScheduleRec2.FindSet() then
                repeat
                    TotalAmount += PaymentScheduleRec2."Amount";
                    TotalVAT += PaymentScheduleRec2."VAT Amount";
                    GrandTotal += PaymentScheduleRec2."Amount Including VAT";
                until PaymentScheduleRec2.Next() = 0;

            SequenceNo := GetNextSequenceNo();
            NewPaymentCode := GeneratePaymentCode(SequenceNo);

            // Check for existing record
            MergedRecord.Reset();
            // MergedRecord.SetRange("Proposal ID", Rec."Proposal ID");
            MergedRecord.SetRange("Tenant ID", Rec."Tenant ID");
            MergedRecord.SetRange("Contract ID", Rec."Contract ID");
            MergedRecord.SetRange("Due Date", MinDueDate);

            if not MergedRecord.FindFirst() then begin
                // Insert a new merged record for the current due date
                MergedRecord.Init();
                // MergedRecord."Proposal ID" := Rec."Proposal ID";
                MergedRecord."Tenant ID" := Rec."Tenant ID";
                MergedRecord."Contract ID" := Rec."Contract ID";
                MergedRecord."Tenant Email" := Rec."Tenant Email";
                MergedRecord."Tenant Name" := Rec."Tenant Name";
                MergedRecord."Payment Series" := NewPaymentCode;
                MergedRecord."Amount" := TotalAmount;
                MergedRecord."VAT Amount" := TotalVAT;
                MergedRecord."Amount Including VAT" := GrandTotal;
                MergedRecord."Due Date" := MinDueDate;
                MergedRecord."Payment Status" := PaymentStatus::Scheduled;
                MergedRecord."Payment Reminder" := Rec."Payment Reminder";

                MergedRecord.Insert();
                Clear(MergedRecord);
            end
        end;
    end;




    local procedure GeneratePaymentCode(SequenceNumber: Integer): Code[20]
    var
        PaymentCodeText: Text;
    begin
        PaymentCodeText := 'PAY' + PadStr(Format(SequenceNumber), 2, '0');
        exit(CopyStr(PaymentCodeText, 1, 20));
    end;

    // local procedure GeneratePaymentCode(SequenceNumber: Integer): Code[20]
    // begin
    //     exit('PAY' + PadStr(Format(SequenceNumber), 2, '0'));
    // end;

    local procedure PadStr(Input: Text[20]; Length: Integer; PaddingChar: Char): Text[20]
    begin
        while StrLen(Input) < Length do
            Input := PaddingChar + Input;
        exit(Input);
    end;

    local procedure GetNextSequenceNo(): Integer
    var
        MergedRecord: Record "Payment Mode2";
        MaxSequence: Integer;
        LastSequence: Text[10];
    begin
        MergedRecord.Reset();
        MergedRecord.SetRange("Contract ID", Rec."Contract ID");
        //MergedRecord.SetRange("Proposal ID", Rec."Proposal ID");

        if MergedRecord.FindSet() then
            repeat
                // Extract the numeric part of the Payment Series
                LastSequence := CopyStr(MergedRecord."Payment Series", 4, StrLen(MergedRecord."Payment Series"));
                if Evaluate(MaxSequence, LastSequence) and (MaxSequence > MaxSequence) then
                    MaxSequence := MaxSequence;
            until MergedRecord.Next() = 0
        else
            MaxSequence := 0; // Default to 0 if no records are found

        exit(MaxSequence + 1);
    end;





    trigger OnDelete()
    var
    begin
        Deletepaymetnscheudlesubpage();

    end;

    procedure Deletepaymetnscheudlesubpage()
    var
        Paymentmodesubpage: Record "Payment Mode2";
    begin
        //  Paymentschedulesubpage.SetRange("PS ID", Rec."PS Id");
        Paymentmodesubpage.SetRange("Contract ID", Rec."Contract ID");
        // Paymentmodesubpage.SetRange("Proposal ID", Rec."Proposal ID");

        if Paymentmodesubpage.FindSet() then
            repeat
                Paymentmodesubpage.DeleteAll();
            until Paymentmodesubpage.Next() = 0;
    end;
}


