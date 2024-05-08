WITH suppressions AS (
  -- Acoustic Suppression List
  SELECT DISTINCT
    LOWER(email) AS email,
    suppressed_timestamp,
    suppression_reason,
    "Acoustic" AS suppression_source,
  FROM
    `moz-fx-data-shared-prod.acoustic_external.suppression_list_v1`
  -- braze unsubscribes
  UNION DISTINCT
  SELECT
    LOWER(email_address) AS email,
    TIMESTAMP_SECONDS(time) AS suppressed_timestamp,
    "clicked header" AS suppression_reason,
    "Braze unsubscribe" AS suppression_source
  FROM
    `moz-fx-data-shared-prod.braze_external.unsubscribes_v1`
  -- braze hard bounces
  UNION DISTINCT
  SELECT
    LOWER(email_address) AS email,
    TIMESTAMP_SECONDS(time) AS suppressed_timestamp,
    "hard bounce" AS suppression_reason,
    "Braze hard bounce" AS suppression_source
  FROM
    `moz-fx-data-shared-prod.braze_external.hard_bounces_v1`
-- MoFo suppression List
  UNION DISTINCT
  SELECT
    LOWER(email) AS email,
    update_timestamp AS suppressed_timestamp,
    suppression_reason,
    "Campaign Monitor" AS suppression_source
  FROM
    `moz-fx-data-shared-prod.marketing_suppression_list_external.campaign_monitor_suppression_list_v1`
),
final AS (
  SELECT
    email,
    suppressed_timestamp,
    suppression_reason,
    suppression_source,
  FROM
    suppressions
  QUALIFY
    ROW_NUMBER() OVER (PARTITION BY email ORDER BY suppressed_timestamp ASC) = 1
)
SELECT
  *
FROM
  final
