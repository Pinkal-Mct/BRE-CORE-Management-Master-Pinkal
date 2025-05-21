codeunit 50106 GenerateConsolidatedInvoices
{
    trigger OnRun()

    // procedure GenerateConsolidatedInvoicesDirectly()
    var
        paymentScheudle2: Record "Payment Schedule2";
        SalesHeader: Record "Sales Header";
        newsalesheader: Record "Sales Header";
        todaydate: Date;
        paymentschedul1: Record "Payment Schedule";
        paymentScheudle3: Record "Payment Schedule2";
        newsalesheader1: Record "Sales Header";
        SalesHeader1: Record "Sales Header";
        currentdate: Date;
        paymentschedulcard: Record "Payment Schedule";
        salesreciveablesetup: Record "Sales & Receivables Setup";
        paymentschedule2grid: Record "Payment Schedule2";
        customercard: Record Customer;
        salesheader1card: Record "Sales Header";
        slaesheader1card1: Record "Sales Header";
        paymentschedulecardpage: Record "Payment Schedule";

    begin
        todaydate := Today();
        //todaydate := 20250705D;
        // todaydate := 20260530D;
        //todaydate := 20260228D;
        //todaydate := 20251129D; // for first installment date
        currentdate := Today();

        //////////// START REACTIVATION CONTRACT ////////////////////////
        paymentScheudle3.SetFilter("Due Date", '<%1', todaydate);
        //paymentScheudle3.SetFilter("Workflow Frequency Date", '<%1', todaydate);
        paymentScheudle3.SetRange("Contract Status", 'Active');
        if paymentScheudle3.FindSet() then
            repeat
                if paymentScheudle3.Invoiced = false then begin


                    //   SalesHeader.SetRange("Sell-to Customer No.", paymentScheudle3."Tenant ID");
                    // SalesHeader1.SetRange("No.", paymentScheudle3."Invoice ID");
                    SalesHeader1.SetRange("Contract ID", paymentScheudle3."Contract ID");
                    SalesHeader1.SetRange("Overdue Invoice", 'Reactive');
                    SalesHeader1.SetRange("Due Date", currentdate);
                    SalesHeader1.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
                    if SalesHeader1.FindSet() then begin

                        createSalesLines(SalesHeader1, paymentScheudle3);
                    end
                    else begin
                        newsalesheader1 := CreateSalesInvoice(paymentScheudle3."Tenant ID", currentdate, paymentScheudle3."Contract ID", paymentScheudle3."Tenant Name", paymentScheudle3."Property Classification");
                        customercard.SetRange("No.", newsalesheader1."Sell-to Customer No.");
                        if customercard.FindSet() then begin
                            if newsalesheader1."Property Classification" <> '' then begin
                                customercard.Validate("Gen. Bus. Posting Group", newsalesheader1."Property Classification");
                                customercard.Validate("Customer Posting Group", newsalesheader1."Property Classification");
                                customercard.Modify();
                            end
                        end;
                        if newsalesheader1."Property Classification" <> '' then begin
                            newsalesheader1."Gen. Bus. Posting Group" := newsalesheader1."Property Classification";
                            newsalesheader1."Customer Posting Group" := newsalesheader1."Property Classification";
                            newsalesheader1.Modify();
                        end;
                        createSalesLines(newsalesheader1, paymentScheudle3);
                    end;

                    newsalesheader1."Overdue Invoice" := 'Reactive';
                    // newsalesheader1."Posting No. Series" := salesreciveablesetup."Posted Invoice Nos.";
                    newsalesheader1.Modify();

                    paymentScheudle3.Invoiced := true;
                    paymentScheudle3."Invoice ID" := newsalesheader1."No.";
                    paymentScheudle3."Overdue Invoice" := newsalesheader1."Overdue Invoice";
                    paymentScheudle3.Modify();



                end;


            until paymentScheudle3.Next() = 0;

        //////////////////////// END REACTIVATION CONTRACT /////////////////////////////

        ///////////////////////  START SUSPENDED CONTRACT & REGULAR INVOICE FLOW ////////////////////////////
        paymentScheudle2.SetRange("Contract start date", todaydate);
        paymentScheudle2.SetRange("Due Date", todaydate);
        //paymentScheudle2.SetRange("Workflow Frequency Date", todaydate);

        if paymentScheudle2.FindSet() then
            repeat
                if paymentScheudle2."Contract Status" = 'Terminated' then begin
                    exit;
                end else begin
                    // add below code for create invoice 
                    paymentschedul1.SetRange("Contract ID", paymentScheudle2."Contract ID");
                    paymentschedul1.SetFilter("Contract Status", 'Suspended');
                    if paymentschedul1.FindSet() then begin
                        paymentScheudle2."Contract Status" := paymentschedul1."Contract Status";
                        paymentScheudle2.Modify();
                    end else begin
                        if paymentScheudle2.Invoiced = false then begin
                            //   SalesHeader.SetRange("Sell-to Customer No.", paymentScheudle2."Tenant ID");
                            SalesHeader.SetRange("Contract ID", paymentScheudle2."Contract ID");
                            SalesHeader.SetRange("Due Date", paymentScheudle2."Due Date");
                            SalesHeader.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
                            if SalesHeader.FindSet() then begin

                                createSalesLines(SalesHeader, paymentScheudle2);
                            end
                            else begin
                                newsalesheader := CreateSalesInvoice(paymentScheudle2."Tenant ID", paymentScheudle2."Due Date", paymentScheudle2."Contract ID", paymentScheudle2."Tenant Name", paymentScheudle2."Property Classification");
                                customercard.SetRange("No.", newsalesheader."Sell-to Customer No.");
                                if customercard.FindSet() then begin
                                    if newsalesheader."Property Classification" <> '' then begin
                                        customercard.Validate("Gen. Bus. Posting Group", newsalesheader."Property Classification");
                                        customercard.Validate("Customer Posting Group", newsalesheader."Property Classification");
                                        customercard.Modify();
                                    end
                                end;
                                if newsalesheader."Property Classification" <> '' then begin
                                    newsalesheader."Gen. Bus. Posting Group" := newsalesheader."Property Classification";
                                    newsalesheader."Customer Posting Group" := newsalesheader."Property Classification";
                                    newsalesheader.Modify();
                                end;
                                createSalesLines(newsalesheader, paymentScheudle2);
                            end;

                            // newsalesheader."Posting No. Series" := salesreciveablesetup."Posted Invoice Nos.";
                            // newsalesheader.Modify();
                            paymentScheudle2.Invoiced := true;
                            paymentScheudle2."Invoice ID" := newsalesheader."No.";
                            paymentScheudle2.Modify();

                        end;
                    end;
                end;


            until paymentScheudle2.Next() = 0 else begin

            /////////////////////////// Below code FOR WORKFLOW FREQUENCY ////////////////////////////////////
            paymentschedule2grid.SetRange("Workflow frequency date", todaydate);
            //paymentschedule2grid.SetRange("Due Date", todaydate);
            if paymentschedule2grid.FindSet() then
                repeat
                    if paymentschedule2grid."Contract Status" = 'Terminated' then begin
                        exit;
                    end else begin
                        // add below code for create invoice 
                        paymentschedulecardpage.SetRange("Contract ID", paymentschedule2grid."Contract ID");
                        paymentschedulecardpage.SetFilter("Contract Status", 'Suspended');
                        if paymentschedulecardpage.FindSet() then begin
                            paymentschedule2grid."Contract Status" := paymentschedulecardpage."Contract Status";
                            paymentschedule2grid.Modify();
                        end else begin
                            if paymentschedule2grid.Invoiced = false then begin
                                //   SalesHeader.SetRange("Sell-to Customer No.", paymentschedule2grid."Tenant ID");
                                salesheader1card.SetRange("Contract ID", paymentschedule2grid."Contract ID");
                                salesheader1card.SetRange("Due Date", paymentschedule2grid."Due Date");
                                salesheader1card.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
                                if salesheader1card.FindSet() then begin

                                    createSalesLines(salesheader1card, paymentschedule2grid);
                                end
                                else begin
                                    slaesheader1card1 := CreateSalesInvoice(paymentschedule2grid."Tenant ID", paymentschedule2grid."Due Date", paymentschedule2grid."Contract ID", paymentschedule2grid."Tenant Name", paymentschedule2grid."Property Classification");
                                    customercard.SetRange("No.", slaesheader1card1."Sell-to Customer No.");
                                    if customercard.FindSet() then begin
                                        if slaesheader1card1."Property Classification" <> '' then begin
                                            customercard.Validate("Gen. Bus. Posting Group", slaesheader1card1."Property Classification");
                                            customercard.Validate("Customer Posting Group", slaesheader1card1."Property Classification");
                                            customercard.Modify();
                                        end
                                    end;
                                    if slaesheader1card1."Property Classification" <> '' then begin
                                        slaesheader1card1."Gen. Bus. Posting Group" := slaesheader1card1."Property Classification";
                                        slaesheader1card1."Customer Posting Group" := slaesheader1card1."Property Classification";
                                        slaesheader1card1.Modify();
                                    end;
                                    createSalesLines(slaesheader1card1, paymentschedule2grid);
                                end;

                                // slaesheader1card1."Posting No. Series" := salesreciveablesetup."Posted Invoice Nos.";
                                // slaesheader1card1.Modify();
                                paymentschedule2grid.Invoiced := true;
                                paymentschedule2grid."Invoice ID" := slaesheader1card1."No.";
                                paymentschedule2grid.Modify();

                            end;
                        end;
                    end;


                until paymentschedule2grid.Next() = 0;
        end;

        ////////////// END ///////////////////////////////
    end;




    procedure CreateSalesInvoice(TenantID: Code[20]; DueDate: Date; ContractID: Integer; TenantName: Text[100]; PropertyClassification: Text[100]): Record "Sales Header"
    var
        salesHeader: Record "Sales Header";
        salesReciveable: Record "Sales & Receivables Setup";
        noseries: Codeunit "No. Series";
        customercard: Record Customer;
    begin
        salesHeader.Init();
        if salesReciveable.FindSet() then
            salesHeader."No." := noseries.GetNextNo(salesReciveable."Invoice Nos.", Today, true);
        salesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        salesHeader."Sell-to Customer No." := TenantID;
        salesHeader."Bill-to Customer No." := TenantID;
        salesHeader."Bill-to Name" := TenantName;
        salesHeader."Sell-to Customer Name" := TenantName;
        salesHeader."Due Date" := DueDate;
        salesHeader."Contract ID" := ContractID;
        salesHeader."Tenant Name" := TenantName;
        salesHeader."Document Date" := Today;
        salesHeader."Posting Date" := Today;
        salesHeader."Shipment Date" := Today;
        salesHeader."Posting No. Series" := salesReciveable."Posted Invoice Nos.";
        salesHeader."Property Classification" := PropertyClassification;
        salesHeader.Insert();

        exit(salesHeader);

    end;

    procedure createSalesLines(salesheader1: Record "Sales Header"; newpaymentschedule2: Record "Payment Schedule2")
    var
        saleline: Record "Sales Line";
        newSaleslines: Record "Sales Line";
        item: Record Item;
        salesTaxCalculate: Codeunit "Sales Tax Calculate";
        currency: Record Currency;
        vatpostingsetup: Record "VAT Posting Setup";
    begin


        saleline.Init();
        saleline."Document Type" := saleline."Document Type"::Invoice;

        newSaleslines.SetRange("Document No.", salesheader1."No.");
        newSaleslines.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
        newSaleslines.SetRange("Contract ID", salesheader1."Contract ID");
        newSaleslines.SetCurrentKey("Line No.");
        if newSaleslines.FindLast() then begin
            saleline."Line No." := newSaleslines."Line No." + 1000;
        end
        else begin
            saleline."Line No." := 1000;
        end;
        saleline."Document No." := salesheader1."No.";
        saleline."Contract ID" := salesheader1."Contract ID";
        saleline.Type := saleline.Type::Item;
        saleline."Sell-to Customer No." := salesheader1."Sell-to Customer No.";
        item.SetRange(Description, newpaymentschedule2."Secondary Item Type");
        if item.FindSet() then begin
            // if newpaymentschedule2."Property Classification" <> '' then begin
            //     item.SetRange(Description, newpaymentschedule2."Secondary Item Type");
            //     item.SetRange("Primary Classification Type", newpaymentschedule2."Property Classification");
            //     if item.FindSet() then begin
            //         saleline."No." := item."No.";
            //         saleline.Description := item.Description;
            //         saleline."Gen. Prod. Posting Group" := item."Gen. Prod. Posting Group";
            //         saleline."VAT Prod. Posting Group" := item."VAT Prod. Posting Group";
            //         saleline."Unit of Measure Code" := item."Base Unit of Measure";
            //     end;
            // end else begin
            saleline."No." := item."No.";
            saleline.Description := item.Description;
            saleline."Gen. Prod. Posting Group" := item."Gen. Prod. Posting Group";
            saleline."VAT Prod. Posting Group" := item."VAT Prod. Posting Group";
            saleline."Unit of Measure Code" := item."Base Unit of Measure";
            //end;

        end;
        saleline."Quantity (Base)" := 1;
        saleline.Quantity := 1;
        saleline."Unit Price" := newpaymentschedule2."Amount";
        saleline."Line Amount" := saleline.Quantity * saleline."Unit Price";
        saleline.Amount := saleline.Quantity * saleline."Unit Price";
        saleline."Qty. to Invoice" := 1;
        saleline."Qty. to Ship" := 1;
        saleline."Qty. to Invoice" := 1;
        saleline."Qty. to Invoice (Base)" := 1;
        saleline."Outstanding Qty. (Base)" := 1;
        saleline."Outstanding Quantity" := 1;
        saleline."VAT Base Amount" := newpaymentschedule2."VAT Amount";
        saleline."Amount Including VAT" := saleline."Line Amount" + newpaymentschedule2."VAT Amount";
        saleline."Outstanding Amount" := saleline.Quantity * saleline."Unit Price";
        saleline."Outstanding Amount (LCY)" := saleline.Quantity * saleline."Unit Price";


        saleline.Insert();

        Clear(saleline);
    end;






}