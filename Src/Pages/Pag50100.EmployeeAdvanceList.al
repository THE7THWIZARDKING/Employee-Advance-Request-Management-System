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
                    ShowMandatory = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    // ShowMandatory = true;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    // ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    // ShowMandatory = true;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    // ShowMandatory = true;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                    // ShowMandatory = true;
                }
                field("Remarks"; Rec."Remarks")
                {
                    ApplicationArea = All;
                    // ShowMandatory = true;

                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total Amount");
    end;
}
