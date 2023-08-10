--- User-facing view. Generated via sql_generators.active_users.
--- This view returns Glean data for the full history: https://mozilla-hub.atlassian.net/browse/DENG-970
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.focus_android.active_users_aggregates`
AS
SELECT
  * EXCEPT (app_version, app_name),
  IF(app_name IN ('Focus Android Glean', 'Focus Android'), 'Focus Android', app_name) AS app_name,
  app_version,
  `mozfun.norm.browser_version_info`(app_version).major_version AS app_version_major,
  `mozfun.norm.browser_version_info`(app_version).minor_version AS app_version_minor,
  `mozfun.norm.browser_version_info`(app_version).patch_revision AS app_version_patch_revision,
  `mozfun.norm.browser_version_info`(app_version).is_major_release AS app_version_is_major_release,
  `mozfun.norm.os`(os) AS os_grouped
FROM
  `moz-fx-data-shared-prod.focus_android_derived.active_users_aggregates_v2`
WHERE
  app_name IN ('Focus Android Glean', 'Focus Android Glean BrowserStack')
