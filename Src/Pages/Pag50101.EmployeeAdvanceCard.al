page 50101 "Employee Advance Card"
{
    Caption = 'Employee Advance Card';
    PageType = Card;
    SourceTable = "Employee Advance Header";
    // ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }

                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }

                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
            }

            group(Amounts)
            {
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }

                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                }
            }

            group(RemarksSection)
            {
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }

            part(AdvanceLines; "Employee Advance Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Request No." = field("Request No.");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Total Amount");
    end;
}