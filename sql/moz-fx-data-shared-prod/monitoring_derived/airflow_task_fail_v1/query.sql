SELECT
  dag_id,
  task_id,
  duration,
  execution_date,
  start_date,
  end_date,
FROM
  `moz-fx-data-bq-fivetran.telemetry_airflow_metadata_public.task_fail`
WHERE
  NOT _fivetran_deleted
UNION ALL
-- including historical data from the pre-migration Airflow instance
SELECT
  dag_id,
  task_id,
  duration,
  execution_date,
  start_date,
  end_date,
FROM
  `moz-fx-data-bq-fivetran.airflow_metadata_airflow_db.task_fail`
WHERE
  NOT _fivetran_deleted
