SELECT
  submission_date,
  first_seen_date,
  distribution_id,
  locale,
  app_version,
  attribution_campaign,
  attribution_content,
  attribution_dlsource,
  attribution_medium,
  attribution_ua,
  normalized_channel,
  normalized_os,
  normalized_os_version,
  country,
  COUNTIF(is_dau) AS dau,
  COUNTIF(is_wau) AS wau,
  COUNTIF(is_mau) AS mau
FROM
  `moz-fx-data-shared-prod.telemetry_derived.desktop_engagement_clients_v1`
WHERE
  submission_date = @submission_date
GROUP BY
  submission_date,
  first_seen_date,
  distribution_id,
  locale,
  app_version,
  attribution_campaign,
  attribution_content,
  attribution_dlsource,
  attribution_medium,
  attribution_ua,
  normalized_channel,
  normalized_os,
  normalized_os_version,
  country
