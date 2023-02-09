-- Generated via ./bqetl generate glean_usage
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.baseline`
AS
SELECT
  "mozillavpn" AS normalized_app_id,
  additional_properties,
  client_info,
  document_id,
  events,
  metadata,
  STRUCT(
    metrics.datetime,
    metrics.labeled_counter,
    metrics.string,
    metrics.timespan,
    STRUCT(SAFE_CAST(NULL AS INTEGER) AS glean_validation_metrics_ping_count) AS counter
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
  `moz-fx-data-shared-prod.mozillavpn.baseline`
UNION ALL
SELECT
  "org_mozilla_firefox_vpn" AS normalized_app_id,
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
  `moz-fx-data-shared-prod.org_mozilla_firefox_vpn.baseline`
