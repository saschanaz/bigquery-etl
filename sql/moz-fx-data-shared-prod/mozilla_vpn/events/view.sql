-- Override the default glean_usage generated view to union data from all VPN clients.
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.events`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.mozillavpn.events`
UNION ALL
SELECT
  *
FROM
  `moz-fx-data-shared-prod.org_mozilla_firefox_vpn.events`
