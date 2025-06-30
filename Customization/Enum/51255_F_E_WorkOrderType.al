enum 51255 "FM Work Order Type"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Breakdown)
    {
        Caption = 'Breakdown';
    }
    value(2; Preventive)
    {
        Caption = 'Preventive';
    }
    value(3; Emergency)
    {
        Caption = 'Emergency';
    }
}