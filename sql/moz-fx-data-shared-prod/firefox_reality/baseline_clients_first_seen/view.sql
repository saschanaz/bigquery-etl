-- Generated via ./bqetl generate glean_usage
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_reality.baseline_clients_first_seen`
AS
SELECT
  "org_mozilla_vrbrowser" AS normalized_app_id,
  * REPLACE ("release" AS normalized_channel)
FROM
  `moz-fx-data-shared-prod.org_mozilla_vrbrowser.baseline_clients_first_seen`
