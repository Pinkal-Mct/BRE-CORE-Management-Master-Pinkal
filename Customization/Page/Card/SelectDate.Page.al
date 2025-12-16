page 50985 "Select Date"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = None;
    Extensible = false;

    layout
    {
        area(Content)
        {
            field(Date; selectedDate)
            {
                ApplicationArea = All;
                Caption = 'Select Date';
                ToolTip = 'Select a date';

                trigger OnValidate()
                begin
                    if selectedDate > Today() then begin
                        Message('The selected date cannot be in the future.');
                        selectedDate := 0D;
                    end;
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if CloseAction = Action::OK then
            if selectedDate = 0D then begin
                Message('Please select a date before proceeding.');
                exit(false);
            end;
    end;

    procedure GetDate(): Date;
    begin
        exit(selectedDate);
    end;

    var
        selectedDate: Date;
}