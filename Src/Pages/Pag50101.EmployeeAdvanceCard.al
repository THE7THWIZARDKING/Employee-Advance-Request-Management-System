page 50101 "Employee Advance Card"
{
    Caption = 'Employee Advance Card';
    PageType = Card;
    SourceTable = "Employee Advance Header";
    UsageCategory = Documents;
    ApplicationArea = All;


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

                    ShowMandatory = true;
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

                    // Editable = false;
                }
            }

            group(RemarksSection)
            {
                Caption = 'Remarks';
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;

                    MultiLine = true;
                    ShowMandatory = Rec.Status = Rec.Status::"Pending Approval";
                    // trigger OnValidate()
                    // begin
                    //     CurrPage.SaveRecord();
                    // end;
                }

            }

            part(AdvanceLines; "Employee Advance Subform")
            {

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

                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                ApplicationArea = All;


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

                Caption = 'Approve Request';
                Image = Approve;
                ApplicationArea = All;


                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::"Pending Approval" then
                        Error('Only Pending Approval requests can be approved.');

                    if Rec."Total Amount" <= 0 then
                        Error('Total Amount must be greater than zero.');

                    Rec."Approved Amount" := Rec."Total Amount";
                    Rec.Status := Rec.Status::Approved;

                    // Rec.Modify();
                    Rec.Modify(true);

                    Message('Request %1 approved successfully.', Rec."Request No.");
                end;
            }

            // action("Reject Request")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Reject Request';
            //     Image = Reject;

            //     trigger OnAction()
            //     begin
            //         if Rec.Status <> Rec.Status::"Pending Approval" then
            //             Error('Only Pending Approval requests can be rejected.');

            //         if Rec.Remarks = '' then
            //             Error('Remarks must be entered before rejection.');

            //         Rec.Status := Rec.Status::Rejected;

            //         Rec.Modify();

            //         Message('Request %1 rejected.', Rec."Request No.");
            //     end;
            // }


            action("Reject Request")
            {

                Caption = 'Reject Request';
                Image = Reject;
                ApplicationArea = All;


                trigger OnAction()
                begin
                    CurrPage.SaveRecord();

                    if Rec.Status <> Rec.Status::"Pending Approval" then
                        Error('Only Pending Approval requests can be rejected.');

                    if Rec.Remarks = ' ' then
                        Error('Remarks must be entered before rejection.');

                    Rec.Status := Rec.Status::Rejected;
                    Rec.Modify(true);

                    Message('Request %1 rejected.', Rec."Request No.");
                end;
            }
            action("Post Request")
            {

                Caption = 'Post Request';
                Image = Post;
                ApplicationArea = All;



                trigger OnAction()
                var
                    AdvancePost: Codeunit "Employee Advance Post";
                begin
                    AdvancePost.PostAdvance(Rec);
                end;
                // trigger OnAction()
                // var
                //     PostedAdvanceHeader: Record "Posted Advance Header";
                // begin
                //     if Rec.Status <> Rec.Status::Approved then
                //         Error('Only approved requests can be posted.');

                //     if Rec."Total Amount" <= 0 then
                //         Error('Total Amount must be greater than zero.');

                //     PostedAdvanceHeader.Reset();
                //     PostedAdvanceHeader.SetRange("Request No.", Rec."Request No.");

                //     if PostedAdvanceHeader.FindFirst() then
                //         Error('This request has already been posted.');

                //     PostedAdvanceHeader.Init();

                //     PostedAdvanceHeader.TransferFields(Rec);

                //     PostedAdvanceHeader."Posted No." := 'POST-' + Rec."Request No.";
                //     PostedAdvanceHeader."Posted Date" := Today;

                //     PostedAdvanceHeader.Insert();

                //     Rec.Status := Rec.Status::Posted;
                //     Rec.Modify();

                //     Message('Request %1 posted successfully.', Rec."Request No.");
                // end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Total Amount");
    end;
}