--need to add app name
--is_suspicious_device_client
WITH mobile_clients_last_seen AS (
  --Fenix
  SELECT
    'Fenix' AS source,
    sample_id,
    submission_date,
    client_id,
    first_seen_date,
    normalized_channel,
    normalized_os,
    normalized_version,
    locale,
    country,
    isp,
    is_dau,
    is_wau,
    is_mau
  FROM
    `moz-fx-data-shared-prod.fenix.baseline_clients_last_seen`
  WHERE
    submission_date = @submission_date
  UNION ALL
  --Firefox iOS
  SELECT
    'Firefox iOS' AS source,
    sample_id,
    submission_date,
    client_id,
    first_seen_date,
    normalized_channel,
    normalized_os,
    normalized_version,
    locale,
    country,
    isp,
    is_dau,
    is_wau,
    is_mau
  FROM
    `moz-fx-data-shared-prod.firefox_ios.baseline_clients_last_seen`
  WHERE
    submission_date = @submission_date
  UNION ALL
  --Klar Android
  SELECT
    'Klar Android' AS source,
    sample_id,
    submission_date,
    client_id,
    first_seen_date,
    normalized_channel,
    normalized_os,
    normalized_version,
    locale,
    country,
    isp,
    is_dau,
    is_wau,
    is_mau
  FROM
    `moz-fx-data-shared-prod.klar_android.baseline_clients_last_seen`
  WHERE
    submission_date = @submission_date
  UNION ALL
  --Klar iOS
  SELECT
    'Klar iOS' AS source,
    sample_id,
    submission_date,
    client_id,
    first_seen_date,
    normalized_channel,
    normalized_os,
    normalized_version,
    locale,
    country,
    isp,
    is_dau,
    is_wau,
    is_mau
  FROM
    `moz-fx-data-shared-prod.klar_ios.baseline_clients_last_seen`
  WHERE
    submission_date = @submission_date
  UNION ALL
  --Focus Android
  SELECT
    'Focus Android' AS source,
    sample_id,
    submission_date,
    client_id,
    first_seen_date,
    normalized_channel,
    normalized_os,
    normalized_version,
    locale,
    country,
    isp,
    is_dau,
    is_wau,
    is_mau
  FROM
    `moz-fx-data-shared-prod.focus_android.baseline_clients_last_seen`
  WHERE
    submission_date = @submission_date
  UNION ALL
  --Focus iOS
  SELECT
    'Focus iOS' AS source,
    sample_id,
    submission_date,
    client_id,
    first_seen_date,
    normalized_channel,
    normalized_os,
    normalized_version,
    locale,
    country,
    isp,
    is_dau,
    is_wau,
    is_mau
  FROM
    `moz-fx-data-shared-prod.focus_ios.baseline_clients_last_seen`
  WHERE
    submission_date = @submission_date
),
mobile_attribution AS (
  --Fenix
  SELECT
    'Fenix' AS source,
    client_id,
    sample_id,
    adjust_network,
    adjust_campaign,
    adjust_ad_group,
    adjust_creative,
    play_store_attribution_campaign,
    play_store_attribution_source,
    play_store_attribution_medium,
    meta_attribution_app
  FROM
    `moz-fx-data-shared-prod.fenix_derived.firefox_android_clients_v1` --which types of ones are in here?
  UNION ALL
  --Firefox iOS
  SELECT
    'Firefox iOS' AS source,
    client_id,
    sample_id,
    adjust_network,
    adjust_campaign,
    adjust_ad_group,
    adjust_creative,
  --google play store all null
    NULL AS play_store_attribution_campaign,
    NULL AS play_store_attribution_source,
    NULL AS play_store_attribution_medium,
    NULL AS meta_attribution_app
  FROM
  --Klar Android
  UNION ALL
  SELECT
    'Klar Android' AS source,
    client_id,
    sample_id,
    ? AS adjust_network,
    ? AS adjust_campaign,
    ? AS adjust_ad_group,
    ? AS adjust_creative,
    NULL AS play_store_attribution_campaign,
    NULL AS play_store_attribution_source,
    NULL AS play_store_attribution_medium,
    NULL AS meta_attribution_app
  FROM --?
  UNION ALL
  --Klar iOS
  SELECT
    'Klar iOS' AS source,
    client_id,
    sample_id,
    ? AS adjust_network,
    ? AS adjust_campaign,
    ? AS adjust_ad_group,
    ? AS adjust_creative,
    NULL AS play_store_attribution_campaign,
    NULL AS play_store_attribution_source,
    NULL AS play_store_attribution_medium,
    NULL AS meta_attribution_app
  FROM
  UNION ALL
  --Focus Android
  SELECT
    'Focus Android' AS source,
    client_id,
    sample_id,
    ? AS adjust_network,
    ? AS adjust_campaign,
    ? AS adjust_ad_group,
    ? AS adjust_creative,
    NULL AS play_store_attribution_campaign,
    NULL AS play_store_attribution_source,
    NULL AS play_store_attribution_medium,
    NULL AS meta_attribution_app
  FROM
  UNION ALL
  --Focus iOS
  SELECT
    'Focus iOS' AS source,
    NULL AS play_store_attribution_campaign,
    NULL AS play_store_attribution_source,
    NULL AS play_store_attribution_medium,
    NULL AS meta_attribution_app
  FROM
  UNION ALL
  --
  SELECT
    NULL AS play_store_attribution_campaign,
    NULL AS play_store_attribution_source,
    NULL AS play_store_attribution_medium,
    NULL AS meta_attribution_app
  FROM
),
SELECT
  cls.submission_date,
  cls.client_id,
  cls.source,
  cls.sample_id,
  cls.first_seen_date,
  cls.normalized_channel,
  cls.normalized_os,
  cls.normalized_version,
  cls.locale,
  cls.country,
  cls.isp,
  cls.is_dau,
  cls.is_wau,
  cls.is_mau,
  attr.adjust_network,
  attr.adjust_campaign,
  attr.adjust_ad_group,
  attr.adjust_creative,
  attr.play_store_attribution_campaign,
  attr.play_store_attribution_source,
  attr.play_store_attribution_medium,
  attr.meta_attribution_app
FROM
  mobile_clients_last_seen cls
LEFT JOIN
  mobile_attribution attr
  USING (client_id, source)
