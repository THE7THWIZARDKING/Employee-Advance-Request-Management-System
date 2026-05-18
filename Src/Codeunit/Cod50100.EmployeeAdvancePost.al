codeunit 50130 "Employee Advance Post"
{
    procedure PostAdvance(var AdvanceHeader: Record "Employee Advance Header")
    var
        PostedAdvanceHeader: Record "Posted Advance Header";
    begin

        // Validate status
        if AdvanceHeader.Status <> AdvanceHeader.Status::Approved then
            Error('Only approved requests can be posted.');

        // Validate total
        if AdvanceHeader."Total Amount" <= 0 then
            Error('Total Amount must be greater than zero.');

        // Prevent duplicate posting
        PostedAdvanceHeader.Reset();
        PostedAdvanceHeader.SetRange("Request No.", AdvanceHeader."Request No.");

        if PostedAdvanceHeader.FindFirst() then
            Error('This request has already been posted.');

        // Create posted record
        PostedAdvanceHeader.Init();

        PostedAdvanceHeader.TransferFields(AdvanceHeader);

        PostedAdvanceHeader."Request No." := AdvanceHeader."Request No.";
        PostedAdvanceHeader."Total Amount" := AdvanceHeader."Total Amount";

        PostedAdvanceHeader."Posted No." := 'POST-' + AdvanceHeader."Request No.";
        PostedAdvanceHeader."Posted Date" := Today;

        PostedAdvanceHeader.Insert();

        // Update original document
        AdvanceHeader.Status := AdvanceHeader.Status::Posted;
        AdvanceHeader.Modify();

        Message(
            'Request %1 posted successfully.',
            AdvanceHeader."Request No.");
    end;
}