USE EnergyOperationsPlatform;
GO

INSERT INTO customer_types (customer_type_id, type_name) VALUES
(1, 'Utility'),
(2, 'Municipality'),
(3, 'Cooperative'),
(4, 'Commercial'),
(5, 'Government'),
(6, 'Industrial'),
(7, 'Telecommunications'),
(8, 'Transportation');
GO

INSERT INTO customer_statuses (customer_status_id, status_name) VALUES
(1, 'Active'),
(2, 'Pending'),
(3, 'Inactive'),
(4, 'Suspended'),
(5, 'Archived');
GO

INSERT INTO industries (industry_id, industry_name) VALUES
(1, 'Electric Utility'),
(2, 'Gas Utility'),
(3, 'Water Utility'),
(4, 'Telecommunications'),
(5, 'Municipal Services'),
(6, 'Transportation Infrastructure'),
(7, 'Industrial Operations'),
(8, 'Renewable Energy'),
(9, 'Public Works'),
(10, 'Construction Services');
GO

INSERT INTO contract_statuses (contract_status_id, status_name) VALUES
(1, 'Draft'),
(2, 'Pending Review'),
(3, 'Active'),
(4, 'Suspended'),
(5, 'Expired'),
(6, 'Terminated'),
(7, 'Archived');
GO

INSERT INTO contract_types (contract_type_id, type_name) VALUES
(1, 'Master Service'),
(2, 'Unit Price'),
(3, 'Time and Materials'),
(4, 'Fixed Price'),
(5, 'Emergency Response'),
(6, 'Maintenance'),
(7, 'Inspection'),
(8, 'Construction Support');
GO

INSERT INTO invoice_statuses (
    invoice_status_id,
    status_name,
    status_description,
    active_flag
) VALUES
(1, 'Draft', 'Invoice has been created but has not been submitted.', 1),
(2, 'Pending Review', 'Invoice is awaiting internal review.', 1),
(3, 'Pending Approval', 'Invoice requires approval before submission.', 1),
(4, 'Approved', 'Invoice has been approved for submission.', 1),
(5, 'Submitted', 'Invoice has been sent to the customer.', 1),
(6, 'Partially Paid', 'Partial payment has been received.', 1),
(7, 'Paid', 'Invoice has been paid in full.', 1),
(8, 'Rejected', 'Invoice has been rejected and requires correction.', 1),
(9, 'Voided', 'Invoice has been canceled and excluded from collection.', 1),
(10, 'Written Off', 'Invoice balance has been written off.', 1);
GO

INSERT INTO work_order_statuses (
    work_order_status_id,
    status_name,
    status_description,
    active_flag
) VALUES
(1, 'Open', 'Work order has been created and is available for scheduling.', 1),
(2, 'Scheduled', 'Work order has been assigned to a planned work date.', 1),
(3, 'Dispatched', 'Work order has been released to field operations.', 1),
(4, 'In Progress', 'Field work is actively being performed.', 1),
(5, 'Field Complete', 'Field work has been completed but not fully reviewed.', 1),
(6, 'Pending Review', 'Work order is awaiting operational or billing review.', 1),
(7, 'Ready for Billing', 'Work order has passed review and is available for billing.', 1),
(8, 'Closed', 'Work order has been fully processed and closed.', 1),
(9, 'Canceled', 'Work order was canceled before completion.', 1),
(10, 'On Hold', 'Work order is temporarily paused.', 1);
GO

INSERT INTO billable_charge_statuses (
    billable_charge_status_id,
    status_name,
    status_description,
    active_flag
) VALUES
(1, 'Captured', 'Charge was captured from daily reporting or source activity.', 1),
(2, 'Pending Validation', 'Charge requires validation before billing review.', 1),
(3, 'Validated', 'Charge has passed internal validation checks.', 1),
(4, 'Pending Approval', 'Charge requires customer or internal approval.', 1),
(5, 'Approved', 'Charge has been approved for invoicing.', 1),
(6, 'Rejected', 'Charge was rejected and should not be invoiced unless corrected.', 1),
(7, 'Ready for Invoice', 'Charge is approved and available for invoice creation.', 1),
(8, 'Invoiced', 'Charge has been assigned to an invoice line item.', 1),
(9, 'Voided', 'Charge was voided and excluded from billing.', 1),
(10, 'Adjusted', 'Charge was modified after review or correction.', 1);
GO