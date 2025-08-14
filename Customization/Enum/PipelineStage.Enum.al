enum 51259 "Pipeline Stage"
{
    Extensible = false; // Must be false as per requirements
    Caption = 'Sales Pipeline Stage';

    value(0; Inquiry)
    {
        Caption = 'Inquiry';
    }
    value(1; OfferSubmitted)
    {
        Caption = 'Offer Submitted';
    }
    value(2; Negotiation)
    {
        Caption = 'Negotiation';
    }
    value(3; Contracting)
    {
        Caption = 'Contracting';
    }
    value(4; Won)
    {
        Caption = 'Won';
    }
    value(5; Lost)
    {
        Caption = 'Lost';
    }
}