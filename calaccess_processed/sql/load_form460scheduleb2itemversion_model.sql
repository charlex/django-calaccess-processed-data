INSERT INTO calaccess_processed_form460scheduleb2itemversion (
    filing_version_id,
    line_item,
    lender_code,
    lender_committee_id,
    lender_title,
    lender_lastname,
    lender_firstname,
    lender_name_suffix,
    lender_city,
    lender_state,
    lender_zip,
    lender_employer,
    lender_occupation,
    lender_is_self_employed,
    treasurer_title,
    treasurer_lastname,
    treasurer_firstname,
    treasurer_name_suffix,
    treasurer_city,
    treasurer_state,
    treasurer_zip,
    intermediary_title,
    intermediary_lastname,
    intermediary_firstname,
    intermediary_name_suffix,
    intermediary_city,
    intermediary_state,
    intermediary_zip,
    amount_guaranteed_this_period,
    balance_outstanding_to_date,
    cumulative_ytd_amount,
    loan_date,
    transaction_id,
    memo_reference_number,
    reported_on_b1
)
SELECT 
    filing_version.id AS filing_version_id,
    loan."LINE_ITEM" AS line_item,
    UPPER(loan."ENTITY_CD") as lender_code,
    TRIM(
        REPLACE(
            REGEXP_REPLACE(
                UPPER(loan."CMTE_ID"),
                'I\.?[CD]\.?:?',
                ''
            ),
            '#',
            ''
        )
    ) AS lender_committee_id,
    UPPER(loan."LNDR_NAMT") AS lender_title,
    UPPER(loan."LNDR_NAML") AS lender_lastname,
    UPPER(loan."LNDR_NAMF") AS lender_firstname,
    UPPER(loan."LNDR_NAMS") AS lender_name_suffix,
    UPPER(loan."LOAN_CITY") AS lender_city,
    UPPER(loan."LOAN_ST") AS lender_state,
    UPPER(loan."LOAN_ZIP4") AS lender_zip,
    UPPER(loan."LOAN_EMP") AS lender_employer,
    UPPER(loan."LOAN_OCC") AS lender_occupation,
    CASE UPPER(loan."LOAN_SELF")
        WHEN 'Y' THEN true
        WHEN 'X' THEN true
        ELSE false 
    END AS lender_is_self_employed,
    UPPER(loan."TRES_NAMT") AS treasurer_title,
    UPPER(loan."TRES_NAML") AS treasurer_lastname,
    UPPER(loan."TRES_NAMF") AS treasurer_firstname,
    UPPER(loan."TRES_NAMS") AS treasurer_name_suffix,
    UPPER(loan."TRES_CITY") AS treasurer_city,
    UPPER(loan."TRES_ST") AS treasurer_state,
    UPPER(loan."TRES_ZIP4") AS treasurer_zip,
    UPPER(loan."INTR_NAMT") AS intermediary_title,
    UPPER(loan."INTR_NAML") AS intermediary_lastname,
    UPPER(loan."INTR_NAMF") AS intermediary_firstname,
    UPPER(loan."INTR_NAMS") AS intermediary_name_suffix,
    UPPER(loan."INTR_CITY") AS intermediary_city,
    UPPER(loan."INTR_ST") AS intermediary_state,
    UPPER(loan."INTR_ZIP4") AS intermediary_zip,
    loan."LOAN_AMT1" AS amount_guaranteed_this_period,
    loan."LOAN_AMT2" AS balance_outstanding_to_date,
    loan."LOAN_AMT3" AS cumulative_ytd_amount,
    loan."LOAN_DATE1" AS loan_date,
    loan."TRAN_ID" AS transaction_id,
    loan."MEMO_REFNO" AS memo_reference_number,
    false as reported_on_b1
FROM "LOAN_CD" loan
JOIN calaccess_processed_form460filingversion filing_version
ON loan."FILING_ID" = filing_version.filing_id
AND loan."AMEND_ID" = filing_version.amend_id
WHERE loan."FORM_TYPE" = 'B2'
AND loan."LOAN_TYPE" = ''
AND loan."LOAN_DATE1" >= '2000-12-22'
-- Also include loan guarantor items from the older version
-- of Schedule B, Part 1
UNION
SELECT
    filing_version.id AS filing_version_id,
    loan."LINE_ITEM" AS line_item,
    UPPER(loan."ENTITY_CD") as lender_code,
    TRIM(
        REPLACE(
            REGEXP_REPLACE(
                UPPER(loan."CMTE_ID"),
                'I\.?[CD]\.?:?',
                ''
            ),
            '#',
            ''
        )
    ) AS lender_committee_id,
    UPPER(loan."LNDR_NAMT") AS lender_title,
    UPPER(loan."LNDR_NAML") AS lender_lastname,
    UPPER(loan."LNDR_NAMF") AS lender_firstname,
    UPPER(loan."LNDR_NAMS") AS lender_name_suffix,
    UPPER(loan."LOAN_CITY") AS lender_city,
    UPPER(loan."LOAN_ST") AS lender_state,
    UPPER(loan."LOAN_ZIP4") AS lender_zip,
    UPPER(loan."LOAN_EMP") AS lender_employer,
    UPPER(loan."LOAN_OCC") AS lender_occupation,
    CASE UPPER(loan."LOAN_SELF")
        WHEN 'Y' THEN true
        WHEN 'X' THEN true
        ELSE false 
    END AS lender_is_self_employed,
    UPPER(loan."TRES_NAMT") AS treasurer_title,
    UPPER(loan."TRES_NAML") AS treasurer_lastname,
    UPPER(loan."TRES_NAMF") AS treasurer_firstname,
    UPPER(loan."TRES_NAMS") AS treasurer_name_suffix,
    UPPER(loan."TRES_CITY") AS treasurer_city,
    UPPER(loan."TRES_ST") AS treasurer_state,
    UPPER(loan."TRES_ZIP4") AS treasurer_zip,
    UPPER(loan."INTR_NAMT") AS intermediary_title,
    UPPER(loan."INTR_NAML") AS intermediary_lastname,
    UPPER(loan."INTR_NAMF") AS intermediary_firstname,
    UPPER(loan."INTR_NAMS") AS intermediary_name_suffix,
    UPPER(loan."INTR_CITY") AS intermediary_city,
    UPPER(loan."INTR_ST") AS intermediary_state,
    UPPER(loan."INTR_ZIP4") AS intermediary_zip,
    loan."LOAN_AMT1" AS amount_guaranteed_this_period,
    loan."LOAN_AMT2" AS balance_outstanding_to_date,
    loan."LOAN_AMT3" AS cumulative_ytd_amount,
    loan."LOAN_DATE1" AS loan_date,
    loan."TRAN_ID" AS transaction_id,
    loan."MEMO_REFNO" AS memo_reference_number,
    true as reported_on_b1
FROM "LOAN_CD" loan
JOIN calaccess_processed_form460filingversion filing_version
ON loan."FILING_ID" = filing_version.filing_id
AND loan."AMEND_ID" = filing_version.amend_id
WHERE loan."FORM_TYPE" = 'B1'
AND loan."LOAN_TYPE" = 'B1G';