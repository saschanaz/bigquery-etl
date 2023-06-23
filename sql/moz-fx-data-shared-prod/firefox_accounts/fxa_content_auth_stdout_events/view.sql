-----
--- ** DEPRECATION NOTICE **
---
--- There is currently an ongoing effort to deprecate this view
--- please use `firefox_accounts.fxa_all_events` view instead
--- in new queries.
---
--- Please filter on `fxa_log` field to limit your results
--- to events coming only from a specific fxa server like so:
--- WHERE fxa_log IN ('auth', 'stdout', ...)
--- Options include:
---   content
---   auth
---   stdout
---   oauth -- this has been deprecated and merged into fxa_auth_event
---   auth_bounce
--- to replicate results of this view use:
--- WHERE fxa_log IN (
---  'content',
---  'auth',
--   'stdout'
--- )
-----
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_content_auth_stdout_events`
AS
WITH content AS (
  SELECT
    jsonPayload.logger,
    jsonPayload.fields.event_type,
    jsonPayload.fields.app_version,
    jsonPayload.fields.os_name,
    jsonPayload.fields.os_version,
    jsonPayload.fields.country,
    CAST(NULL AS STRING) AS country_code,
    jsonPayload.fields.language,
    jsonPayload.fields.user_id,
    jsonPayload.fields.device_id,
    jsonPayload.fields.user_properties,
    jsonPayload.fields.event_properties,
    `timestamp`,
    receiveTimestamp,
    TIMESTAMP_MILLIS(CAST(jsonPayload.fields.time AS INT64)) AS event_time,
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_content_events_v1`
),
  --
auth AS (
  SELECT
    jsonPayload.logger,
    jsonPayload.fields.event_type,
    jsonPayload.fields.app_version,
    jsonPayload.fields.os_name,
    jsonPayload.fields.os_version,
    jsonPayload.fields.country,
    JSON_VALUE(jsonPayload.fields.event_properties, "$.country_code") AS country_code,
    jsonPayload.fields.language,
    jsonPayload.fields.user_id,
    jsonPayload.fields.device_id,
    jsonPayload.fields.user_properties,
    jsonPayload.fields.event_properties,
    `timestamp`,
    receiveTimestamp,
    TIMESTAMP_MILLIS(CAST(jsonPayload.fields.time AS INT64)) AS event_time,
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_auth_events_v1`
),
  --
stdout AS (
  SELECT
    jsonPayload.logger,
    jsonPayload.fields.event_type,
    jsonPayload.fields.app_version,
    jsonPayload.fields.os_name,
    jsonPayload.fields.os_version,
    CAST(NULL AS STRING) AS country,
    jsonPayload.fields.country_code,
    jsonPayload.fields.language,
    jsonPayload.fields.user_id,
    jsonPayload.fields.device_id,
    jsonPayload.fields.user_properties,
    jsonPayload.fields.event_properties,
    `timestamp`,
    receiveTimestamp,
    TIMESTAMP_MILLIS(CAST(jsonPayload.fields.time AS INT64)) AS event_time,
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_stdout_events_v1`
),
  --
unioned AS (
  SELECT
    *
  FROM
    auth
  UNION ALL
  SELECT
    *
  FROM
    content
  UNION ALL
  SELECT
    *
  FROM
    stdout
)
  --
SELECT
  * EXCEPT (user_properties, event_properties),
  JSON_VALUE(user_properties, "$.utm_term") AS utm_term,
  JSON_VALUE(user_properties, "$.utm_source") AS utm_source,
  JSON_VALUE(user_properties, "$.utm_medium") AS utm_medium,
  JSON_VALUE(user_properties, "$.utm_campaign") AS utm_campaign,
  JSON_VALUE(user_properties, "$.utm_content") AS utm_content,
  JSON_VALUE(user_properties, "$.ua_version") AS ua_version,
  JSON_VALUE(user_properties, "$.ua_browser") AS ua_browser,
  JSON_VALUE(user_properties, "$.entrypoint") AS entrypoint,
  JSON_VALUE(user_properties, "$.entrypoint_experiment") AS entrypoint_experiment,
  JSON_VALUE(user_properties, "$.entrypoint_variation") AS entrypoint_variation,
  JSON_VALUE(user_properties, "$.flow_id") AS flow_id,
  JSON_VALUE(event_properties, "$.service") AS service,
  JSON_VALUE(event_properties, "$.email_type") AS email_type,
  JSON_VALUE(event_properties, "$.email_provider") AS email_provider,
  JSON_VALUE(event_properties, "$.oauth_client_id") AS oauth_client_id,
  JSON_VALUE(event_properties, "$.connect_device_flow") AS connect_device_flow,
  JSON_VALUE(event_properties, "$.connect_device_os") AS connect_device_os,
  JSON_VALUE(user_properties, "$.sync_device_count") AS sync_device_count,
  JSON_VALUE(user_properties, "$.sync_active_devices_day") AS sync_active_devices_day,
  JSON_VALUE(user_properties, "$.sync_active_devices_week") AS sync_active_devices_week,
  JSON_VALUE(user_properties, "$.sync_active_devices_month") AS sync_active_devices_month,
  JSON_VALUE(event_properties, "$.email_sender") AS email_sender,
  JSON_VALUE(event_properties, "$.email_service") AS email_service,
  JSON_VALUE(event_properties, "$.email_template") AS email_template,
  JSON_VALUE(event_properties, "$.email_version") AS email_version,
  JSON_VALUE(event_properties, "$.subscription_id") AS subscription_id,
  JSON_VALUE(event_properties, "$.plan_id") AS plan_id,
  JSON_VALUE(event_properties, "$.previous_plan_id") AS previous_plan_id,
  JSON_VALUE(event_properties, "$.subscribed_plan_ids") AS subscribed_plan_ids,
  JSON_VALUE(event_properties, "$.product_id") AS product_id,
  JSON_VALUE(event_properties, "$.previous_product_id") AS previous_product_id,
  -- `promotionCode` was renamed `promotion_code` in stdout logs.
  COALESCE(
    JSON_VALUE(event_properties, "$.promotion_code"),
    JSON_VALUE(event_properties, "$.promotionCode")
  ) AS promotion_code,
  JSON_VALUE(event_properties, "$.payment_provider") AS payment_provider,
  JSON_VALUE(event_properties, "$.provider_event_id") AS provider_event_id,
  JSON_VALUE(event_properties, "$.checkout_type") AS checkout_type,
  JSON_VALUE(event_properties, "$.source_country") AS source_country,
  -- `source_country` was renamed `country_code_source` in stdout logs.
  COALESCE(
    JSON_VALUE(event_properties, "$.country_code_source"),
    JSON_VALUE(event_properties, "$.source_country")
  ) AS country_code_source,
  JSON_VALUE(event_properties, "$.error_id") AS error_id,
  CAST(JSON_VALUE(event_properties, "$.voluntary_cancellation") AS BOOL) AS voluntary_cancellation,
FROM
  unioned
-- Commented out for now, to restore FxA Looker dashboards
-- Once dashboards have been migrated to use fxa_all_events view
-- this will be uncommented to see if we can pick up any other usage
-- of this view.
-- See DENG-582 for more info.
-- WHERE
--   ERROR(
--     'VIEW DEPRECATED - This view will be completely deleted after 9th of February 2023, please use `fxa_all_events` with filter on `fxa_log` instead. See DENG-582 for more info.'
--   )
