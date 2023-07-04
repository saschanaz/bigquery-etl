-- This is counting how many times a specific event in a flow occured,
-- this is not proper funnel analysis.
SELECT
  @submission_date AS submission_date,
  flow_id,
  COUNT(flow_event) AS total_flow_events_count,
  COUNTIF(
    flow_event.category = 'fxa_email_first' AND flow_event.`event` = 'submit'
  ) AS emails_submitted,
  COUNTIF(
    flow_event.category = 'fxa_email_first' AND flow_event.`event` = 'engage'
  ) AS emails_engaged,
  COUNTIF(
    flow_event.category = 'fxa_reg' AND flow_event.`event` = 'view'
  ) AS registrations_started,
  COUNTIF(
    flow_event.category = 'fxa_reg' AND flow_event.`event` = 'complete'
  ) AS registrations_complete,
  COUNTIF(
    flow_event.category = 'fxa_login' AND flow_event.`event` = 'view'
  ) AS logins_started,
  COUNTIF(
    flow_event.category = 'fxa_login' AND flow_event.`event` = 'complete'
  ) AS logins_complete,
FROM
  firefox_accounts_derived.fxa_flows_v1,
  UNNEST(flow_events) AS flow_event
WHERE
  submission_date = @submission_date
GROUP BY
  flow_id
