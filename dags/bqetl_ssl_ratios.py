# Generated via https://github.com/mozilla/bigquery-etl/blob/main/bigquery_etl/query_scheduling/generate_airflow_dags.py

from airflow import DAG
from airflow.sensors.external_task import ExternalTaskMarker
from airflow.sensors.external_task import ExternalTaskSensor
from airflow.utils.task_group import TaskGroup
import datetime
from operators.gcp_container_operator import GKEPodOperator
from utils.constants import ALLOWED_STATES, FAILED_STATES
from utils.gcp import bigquery_etl_query, bigquery_dq_check

docs = """
### bqetl_ssl_ratios

Built from bigquery-etl repo, [`dags/bqetl_ssl_ratios.py`](https://github.com/mozilla/bigquery-etl/blob/generated-sql/dags/bqetl_ssl_ratios.py)

#### Description

The DAG schedules SSL ratios queries.
#### Owner

chutten@mozilla.com

#### Tags

* impact/tier_3
* repo/bigquery-etl
"""


default_args = {
    "owner": "chutten@mozilla.com",
    "start_date": datetime.datetime(2019, 7, 20, 0, 0),
    "end_date": None,
    "email": ["telemetry-alerts@mozilla.com", "chutten@mozilla.com"],
    "depends_on_past": False,
    "retry_delay": datetime.timedelta(seconds=1800),
    "email_on_failure": True,
    "email_on_retry": True,
    "retries": 2,
}

tags = ["impact/tier_3", "repo/bigquery-etl"]

with DAG(
    "bqetl_ssl_ratios",
    default_args=default_args,
    schedule_interval="0 2 * * *",
    doc_md=docs,
    tags=tags,
) as dag:

    wait_for_copy_deduplicate_main_ping = ExternalTaskSensor(
        task_id="wait_for_copy_deduplicate_main_ping",
        external_dag_id="copy_deduplicate",
        external_task_id="copy_deduplicate_main_ping",
        execution_delta=datetime.timedelta(seconds=3600),
        check_existence=True,
        mode="reschedule",
        allowed_states=ALLOWED_STATES,
        failed_states=FAILED_STATES,
        pool="DATA_ENG_EXTERNALTASKSENSOR",
    )

    checks__fail_telemetry_derived__ssl_ratios__v1 = bigquery_dq_check(
        task_id="checks__fail_telemetry_derived__ssl_ratios__v1",
        source_table="ssl_ratios_v1",
        dataset_id="telemetry_derived",
        project_id="moz-fx-data-shared-prod",
        is_dq_check_fail=True,
        owner="chutten@mozilla.com",
        email=["chutten@mozilla.com", "telemetry-alerts@mozilla.com"],
        depends_on_past=False,
        parameters=["submission_date:DATE:{{ds}}"],
        retries=0,
    )

    telemetry_derived__ssl_ratios__v1 = bigquery_etl_query(
        task_id="telemetry_derived__ssl_ratios__v1",
        destination_table="ssl_ratios_v1",
        dataset_id="telemetry_derived",
        project_id="moz-fx-data-shared-prod",
        owner="chutten@mozilla.com",
        email=["chutten@mozilla.com", "telemetry-alerts@mozilla.com"],
        date_partition_parameter="submission_date",
        depends_on_past=False,
    )

    checks__fail_telemetry_derived__ssl_ratios__v1.set_upstream(
        telemetry_derived__ssl_ratios__v1
    )

    telemetry_derived__ssl_ratios__v1.set_upstream(wait_for_copy_deduplicate_main_ping)
