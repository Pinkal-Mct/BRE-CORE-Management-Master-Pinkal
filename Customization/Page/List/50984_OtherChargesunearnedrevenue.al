page 50984 "OtherCharges-UnearnedRevenue"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Other Charges UnearnedRevenue";
    Caption = 'Revenue Item';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the internal document number for the record.';
                }
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;
                    Caption = 'Item Type';
                    ToolTip = 'Specifies the type of item related to this revenue allocation entry.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Entry No.';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Displays the unique entry number generated for the record.';
                }
            }
        }
    }


    var
        No: Integer;

    procedure SetNo(pNo: Integer)
    begin
        No := pNo;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."No." := No;
        exit(true);
    end;
}