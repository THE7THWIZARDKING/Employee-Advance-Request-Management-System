page 50100 "Employee Advance List"
{
    Caption = 'Employee Advance List';
    PageType = List;
    SourceTable = "Employee Advance Header";
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Employee Advance Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }

            }
        }

    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total Amount");
    end;
}
