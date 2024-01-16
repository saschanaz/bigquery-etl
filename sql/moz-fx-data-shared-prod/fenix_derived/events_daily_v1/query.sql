-- Generated by ./bqetl generate events_daily
WITH sample AS (
  SELECT
    DATE(submission_timestamp) AS submission_date,
    name AS event,
    category,
    extra,
    sample_id,
    timestamp,
    metadata,
    normalized_channel,
    normalized_os,
    normalized_os_version,
    client_info.client_id AS client_id,
    client_info.android_sdk_version AS android_sdk_version,
    client_info.app_build AS app_build,
    client_info.app_channel AS app_channel,
    client_info.app_display_version AS app_display_version,
    client_info.architecture AS architecture,
    client_info.device_manufacturer AS device_manufacturer,
    client_info.device_model AS device_model,
    client_info.first_run_date AS first_run_date,
    client_info.telemetry_sdk_build AS telemetry_sdk_build,
    client_info.locale AS locale,
    (
      SELECT
        ARRAY_AGG(STRUCT(key, value.branch AS value))
      FROM
        UNNEST(ping_info.experiments)
    ) AS experiments
  FROM
    org_mozilla_firefox.events e
  CROSS JOIN
    UNNEST(e.events) AS event
  UNION ALL
  SELECT
    DATE(submission_timestamp) AS submission_date,
    name AS event,
    category,
    extra,
    sample_id,
    timestamp,
    metadata,
    normalized_channel,
    normalized_os,
    normalized_os_version,
    client_info.client_id AS client_id,
    client_info.android_sdk_version AS android_sdk_version,
    client_info.app_build AS app_build,
    client_info.app_channel AS app_channel,
    client_info.app_display_version AS app_display_version,
    client_info.architecture AS architecture,
    client_info.device_manufacturer AS device_manufacturer,
    client_info.device_model AS device_model,
    client_info.first_run_date AS first_run_date,
    client_info.telemetry_sdk_build AS telemetry_sdk_build,
    client_info.locale AS locale,
    (
      SELECT
        ARRAY_AGG(STRUCT(key, value.branch AS value))
      FROM
        UNNEST(ping_info.experiments)
    ) AS experiments
  FROM
    org_mozilla_firefox_beta.events e
  CROSS JOIN
    UNNEST(e.events) AS event
  UNION ALL
  SELECT
    DATE(submission_timestamp) AS submission_date,
    name AS event,
    category,
    extra,
    sample_id,
    timestamp,
    metadata,
    normalized_channel,
    normalized_os,
    normalized_os_version,
    client_info.client_id AS client_id,
    client_info.android_sdk_version AS android_sdk_version,
    client_info.app_build AS app_build,
    client_info.app_channel AS app_channel,
    client_info.app_display_version AS app_display_version,
    client_info.architecture AS architecture,
    client_info.device_manufacturer AS device_manufacturer,
    client_info.device_model AS device_model,
    client_info.first_run_date AS first_run_date,
    client_info.telemetry_sdk_build AS telemetry_sdk_build,
    client_info.locale AS locale,
    (
      SELECT
        ARRAY_AGG(STRUCT(key, value.branch AS value))
      FROM
        UNNEST(ping_info.experiments)
    ) AS experiments
  FROM
    org_mozilla_fenix.events e
  CROSS JOIN
    UNNEST(e.events) AS event
),
events AS (
  SELECT
    *
  FROM
    sample
  WHERE
    (
      submission_date = @submission_date
      OR (@submission_date IS NULL AND submission_date >= '2020-01-01')
    )
    AND client_id IS NOT NULL
),
joined AS (
  SELECT
    CONCAT(udf.pack_event_properties(events.extra, event_types.event_properties), index) AS index,
    events.* EXCEPT (category, event, extra)
  FROM
    events
  INNER JOIN
    fenix.event_types event_types
    USING (category, event)
)
SELECT
  submission_date,
  client_id,
  sample_id,
  CONCAT(STRING_AGG(index, ',' ORDER BY timestamp ASC), ',') AS events,
  -- client info
  mozfun.stats.mode_last(ARRAY_AGG(android_sdk_version)) AS android_sdk_version,
  mozfun.stats.mode_last(ARRAY_AGG(app_build)) AS app_build,
  mozfun.stats.mode_last(ARRAY_AGG(app_channel)) AS app_channel,
  mozfun.stats.mode_last(ARRAY_AGG(app_display_version)) AS app_display_version,
  mozfun.stats.mode_last(ARRAY_AGG(architecture)) AS architecture,
  mozfun.stats.mode_last(ARRAY_AGG(device_manufacturer)) AS device_manufacturer,
  mozfun.stats.mode_last(ARRAY_AGG(device_model)) AS device_model,
  mozfun.stats.mode_last(ARRAY_AGG(first_run_date)) AS first_run_date,
  mozfun.stats.mode_last(ARRAY_AGG(telemetry_sdk_build)) AS telemetry_sdk_build,
  mozfun.stats.mode_last(ARRAY_AGG(locale)) AS locale,
  -- metadata
  mozfun.stats.mode_last(ARRAY_AGG(metadata.geo.city)) AS city,
  mozfun.stats.mode_last(ARRAY_AGG(metadata.geo.country)) AS country,
  mozfun.stats.mode_last(ARRAY_AGG(metadata.geo.subdivision1)) AS subdivision1,
  -- normalized fields
  mozfun.stats.mode_last(ARRAY_AGG(normalized_channel)) AS channel,
  mozfun.stats.mode_last(ARRAY_AGG(normalized_os)) AS os,
  mozfun.stats.mode_last(ARRAY_AGG(normalized_os_version)) AS os_version,
  -- ping info
  mozfun.map.mode_last(ARRAY_CONCAT_AGG(experiments)) AS experiments
FROM
  joined
GROUP BY
  submission_date,
  client_id,
  sample_id
