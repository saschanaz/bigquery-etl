-- Query for telemetry_derived.mobile_engagement_v1
            -- For more information on writing queries see:
            -- https://docs.telemetry.mozilla.org/cookbooks/bigquery/querying.html
SELECT
  *
FROM
  table
WHERE
  submission_date = @submission_date
