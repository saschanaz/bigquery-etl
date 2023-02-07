-- Generated via ./bqetl generate glean_usage
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.focus_android.baseline`
AS
SELECT
  "org_mozilla_focus" AS normalized_app_id,
  additional_properties,
  client_info,
  document_id,
  events,
  metadata,
  metrics,
  normalized_app_name,
  normalized_channel,
  normalized_country_code,
  normalized_os,
  normalized_os_version,
  ping_info,
  sample_id,
  submission_timestamp
FROM
  `moz-fx-data-shared-prod.org_mozilla_focus.baseline`
UNION ALL
SELECT
  "org_mozilla_focus_beta" AS normalized_app_id,
  additional_properties,
  client_info,
  document_id,
  events,
  metadata,
  STRUCT(
    metrics.counter,
    metrics.datetime,
    metrics.jwe,
    metrics.labeled_counter,
    metrics.labeled_rate,
    metrics.string,
    metrics.timespan,
    metrics.url,
    metrics.text,
    metrics.uuid
  ) AS metrics,
  normalized_app_name,
  normalized_channel,
  normalized_country_code,
  normalized_os,
  normalized_os_version,
  ping_info,
  sample_id,
  submission_timestamp
FROM
  `moz-fx-data-shared-prod.org_mozilla_focus_beta.baseline`
UNION ALL
SELECT
  "org_mozilla_focus_nightly" AS normalized_app_id,
  additional_properties,
  client_info,
  document_id,
  events,
  metadata,
  STRUCT(
    metrics.counter,
    metrics.datetime,
    metrics.jwe,
    metrics.labeled_counter,
    metrics.labeled_rate,
    metrics.string,
    metrics.timespan,
    metrics.url,
    metrics.text,
    metrics.uuid
  ) AS metrics,
  normalized_app_name,
  normalized_channel,
  normalized_country_code,
  normalized_os,
  normalized_os_version,
  ping_info,
  sample_id,
  submission_timestamp
FROM
  `moz-fx-data-shared-prod.org_mozilla_focus_nightly.baseline`
