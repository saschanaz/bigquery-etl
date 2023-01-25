-- Generated via ./bqetl generate stable_views
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_desktop.crash`
AS
SELECT
  * REPLACE (
    mozfun.norm.metadata(metadata) AS metadata,
    mozfun.norm.glean_ping_info(ping_info) AS ping_info,
    (
      SELECT AS STRUCT
        metrics.* REPLACE (
          STRUCT(
            mozfun.glean.parse_datetime(metrics.datetime.crash_time) AS crash_time,
            metrics.datetime.crash_time AS raw_crash_time
          ) AS datetime
        )
    ) AS metrics,
    'Firefox' AS normalized_app_name
  )
FROM
  `moz-fx-data-shared-prod.firefox_desktop_stable.crash_v1`
