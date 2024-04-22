--- Query generated via sql_generators.active_users.
WITH todays_metrics AS (
  SELECT
    client_id,
    BIT_COUNT(days_visited_1_uri_bits) >= 21 AS is_core_active_v1,
    CASE
    WHEN BIT_COUNT(days_visited_1_uri_bits)
      BETWEEN 1
      AND 6
      THEN 'infrequent_user'
    WHEN BIT_COUNT(days_visited_1_uri_bits)
      BETWEEN 7
      AND 13
      THEN 'casual_user'
    WHEN BIT_COUNT(days_visited_1_uri_bits)
      BETWEEN 14
      AND 20
      THEN 'regular_user'
    WHEN BIT_COUNT(days_visited_1_uri_bits) >= 21
      THEN 'core_user'
    ELSE 'other'
    END AS segment,
    'Firefox Desktop' AS app_name,
    app_version AS app_version,
    normalized_channel AS channel,
    IFNULL(country, '??') country,
    city,
    COALESCE(REGEXP_EXTRACT(locale, r'^(.+?)-'), locale, NULL) AS locale,
    first_seen_date,
    EXTRACT(YEAR FROM first_seen_date) AS first_seen_year,
    os,
    COALESCE(
      `mozfun.norm.windows_version_info`(os, normalized_os_version, windows_build_number),
      normalized_os_version
    ) AS os_version,
    COALESCE(
      CAST(NULLIF(SPLIT(normalized_os_version, ".")[SAFE_OFFSET(0)], "") AS INTEGER),
      0
    ) AS os_version_major,
    COALESCE(
      CAST(NULLIF(SPLIT(normalized_os_version, ".")[SAFE_OFFSET(1)], "") AS INTEGER),
      0
    ) AS os_version_minor,
    submission_date,
    COALESCE(
      scalar_parent_browser_engagement_total_uri_count_normal_and_private_mode_sum,
      scalar_parent_browser_engagement_total_uri_count_sum
    ) AS uri_count,
    is_default_browser,
    distribution_id,
    attribution.source AS attribution_source,
    attribution.medium AS attribution_medium,
    attribution.medium IS NOT NULL
    OR attribution.source IS NOT NULL AS attributed,
    ad_clicks_count_all AS ad_click,
    search_count_organic AS organic_search_count,
    search_count_all AS search_count,
    search_with_ads_count_all AS search_with_ads,
    active_hours_sum
  FROM
    `moz-fx-data-shared-prod.telemetry.clients_last_seen`
  WHERE
    submission_date = @submission_date
)
SELECT
  todays_metrics.* EXCEPT (
    client_id,
    ad_click,
    organic_search_count,
    search_count,
    search_with_ads,
    uri_count,
    active_hours_sum,
    first_seen_date
  ),
  COUNTIF(is_daily_user) AS daily_users,
  COUNTIF(is_weekly_user) AS weekly_users,
  COUNTIF(is_monthly_user) AS monthly_users,
  COUNTIF(is_dau) AS dau,
  COUNTIF(is_wau) AS wau,
  COUNTIF(is_mau) AS mau,
  SUM(ad_click) AS ad_clicks,
  SUM(organic_search_count) AS organic_search_count,
  SUM(search_count) AS search_count,
  SUM(search_with_ads) AS search_with_ads,
  SUM(uri_count) AS uri_count,
  SUM(active_hours_sum) AS active_hours,
FROM
  todays_metrics
GROUP BY
  app_version,
  attribution_medium,
  attribution_source,
  attributed,
  city,
  country,
  distribution_id,
  first_seen_year,
  is_default_browser,
  locale,
  app_name,
  channel,
  os,
  os_version,
  os_version_major,
  os_version_minor,
  submission_date,
  segment
