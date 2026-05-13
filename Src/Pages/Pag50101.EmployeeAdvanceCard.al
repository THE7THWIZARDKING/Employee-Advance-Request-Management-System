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

    actions
    {
        area(Processing)
        {
            action("Send for Approval")
            {
                ApplicationArea = All;
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;

                trigger OnAction()
                var
                    AdvanceLine: Record "Employee Advance Line";
                begin
                    if Rec.Status <> Rec.Status::Open then
                        Error('Only Open requests can be sent for approval.');

                    AdvanceLine.SetRange("Request No.", Rec."Request No.");

                    if not AdvanceLine.FindFirst() then
                        Error('Cannot send request without lines.');

                    if Rec."Total Amount" <= 0 then
                        Error('Total Amount must be greater than zero.');

                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec.Modify();

                    Message('Request %1 sent for approval.', Rec."Request No.");
                end;
            }

            action("Approve Request")
            {
                ApplicationArea = All;
                Caption = 'Approve Request';
                Image = Approve;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::"Pending Approval" then
                        Error('Only Pending Approval requests can be approved.');

                    if Rec."Total Amount" <= 0 then
                        Error('Total Amount must be greater than zero.');

                    Rec."Approved Amount" := Rec."Total Amount";
                    Rec.Status := Rec.Status::Approved;

                    Rec.Modify();

                    Message('Request %1 approved successfully.', Rec."Request No.");
                end;
            }

            action("Reject Request")
            {
                ApplicationArea = All;
                Caption = 'Reject Request';
                Image = Reject;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::"Pending Approval" then
                        Error('Only Pending Approval requests can be rejected.');

                    if Rec.Remarks = '' then
                        Error('Remarks must be entered before rejection.');

                    Rec.Status := Rec.Status::Rejected;

                    Rec.Modify();

                    Message('Request %1 rejected.', Rec."Request No.");
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Total Amount");
    end;
}