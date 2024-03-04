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
### bqetl_mozilla_org_derived

Built from bigquery-etl repo, [`dags/bqetl_mozilla_org_derived.py`](https://github.com/mozilla/bigquery-etl/blob/generated-sql/dags/bqetl_mozilla_org_derived.py)

#### Owner

frank@mozilla.com

#### Tags

* impact/tier_1
* repo/bigquery-etl
"""


default_args = {
    "owner": "frank@mozilla.com",
    "start_date": datetime.datetime(2023, 11, 13, 0, 0),
    "end_date": None,
    "email": ["frank@mozilla.com", "telemetry-alerts@mozilla.com"],
    "depends_on_past": False,
    "retry_delay": datetime.timedelta(seconds=1800),
    "email_on_failure": True,
    "email_on_retry": True,
    "retries": 2,
}

tags = ["impact/tier_1", "repo/bigquery-etl"]

with DAG(
    "bqetl_mozilla_org_derived",
    default_args=default_args,
    schedule_interval="0 2 * * *",
    doc_md=docs,
    tags=tags,
) as dag:

    wait_for_mozilla_org_derived__ga_sessions__v1__backfill__1 = ExternalTaskSensor(
        task_id="wait_for_mozilla_org_derived__ga_sessions__v1__backfill_-1",
        external_dag_id="ga_sessions_backfill",
        external_task_id="mozilla_org_derived__ga_sessions__v1__backfill_-1",
        execution_delta=datetime.timedelta(seconds=3600),
        check_existence=True,
        mode="reschedule",
        allowed_states=ALLOWED_STATES,
        failed_states=FAILED_STATES,
        pool="DATA_ENG_EXTERNALTASKSENSOR",
    )

    wait_for_mozilla_org_derived__ga_sessions__v1__backfill__2 = ExternalTaskSensor(
        task_id="wait_for_mozilla_org_derived__ga_sessions__v1__backfill_-2",
        external_dag_id="ga_sessions_backfill",
        external_task_id="mozilla_org_derived__ga_sessions__v1__backfill_-2",
        execution_delta=datetime.timedelta(seconds=3600),
        check_existence=True,
        mode="reschedule",
        allowed_states=ALLOWED_STATES,
        failed_states=FAILED_STATES,
        pool="DATA_ENG_EXTERNALTASKSENSOR",
    )

    wait_for_mozilla_org_derived__ga_sessions__v1__backfill__3 = ExternalTaskSensor(
        task_id="wait_for_mozilla_org_derived__ga_sessions__v1__backfill_-3",
        external_dag_id="ga_sessions_backfill",
        external_task_id="mozilla_org_derived__ga_sessions__v1__backfill_-3",
        execution_delta=datetime.timedelta(seconds=3600),
        check_existence=True,
        mode="reschedule",
        allowed_states=ALLOWED_STATES,
        failed_states=FAILED_STATES,
        pool="DATA_ENG_EXTERNALTASKSENSOR",
    )

    wait_for_checks__fail_telemetry_derived__clients_first_seen__v2 = (
        ExternalTaskSensor(
            task_id="wait_for_checks__fail_telemetry_derived__clients_first_seen__v2",
            external_dag_id="bqetl_analytics_tables",
            external_task_id="checks__fail_telemetry_derived__clients_first_seen__v2",
            check_existence=True,
            mode="reschedule",
            allowed_states=ALLOWED_STATES,
            failed_states=FAILED_STATES,
            pool="DATA_ENG_EXTERNALTASKSENSOR",
        )
    )

    wait_for_telemetry_derived__clients_daily__v6 = ExternalTaskSensor(
        task_id="wait_for_telemetry_derived__clients_daily__v6",
        external_dag_id="bqetl_main_summary",
        external_task_id="telemetry_derived__clients_daily__v6",
        check_existence=True,
        mode="reschedule",
        allowed_states=ALLOWED_STATES,
        failed_states=FAILED_STATES,
        pool="DATA_ENG_EXTERNALTASKSENSOR",
    )

    checks__fail_mozilla_org_derived__ga_clients__v1 = bigquery_dq_check(
        task_id="checks__fail_mozilla_org_derived__ga_clients__v1",
        source_table="ga_clients_v1",
        dataset_id="mozilla_org_derived",
        project_id="moz-fx-data-shared-prod",
        is_dq_check_fail=True,
        owner="frank@mozilla.com",
        email=["frank@mozilla.com", "telemetry-alerts@mozilla.com"],
        depends_on_past=False,
        task_concurrency=1,
        parameters=["session_date:DATE:{{ds}}"],
        retries=0,
    )

    checks__fail_mozilla_org_derived__ga_sessions__v1 = bigquery_dq_check(
        task_id="checks__fail_mozilla_org_derived__ga_sessions__v1",
        source_table="ga_sessions_v1",
        dataset_id="mozilla_org_derived",
        project_id="moz-fx-data-shared-prod",
        is_dq_check_fail=True,
        owner="frank@mozilla.com",
        email=["frank@mozilla.com", "telemetry-alerts@mozilla.com"],
        depends_on_past=False,
        parameters=["session_date:DATE:{{ds}}"],
        retries=0,
    )

    checks__fail_mozilla_org_derived__gclid_conversions__v1 = bigquery_dq_check(
        task_id="checks__fail_mozilla_org_derived__gclid_conversions__v1",
        source_table="gclid_conversions_v1",
        dataset_id="mozilla_org_derived",
        project_id="moz-fx-data-shared-prod",
        is_dq_check_fail=True,
        owner="frank@mozilla.com",
        email=["frank@mozilla.com", "telemetry-alerts@mozilla.com"],
        depends_on_past=False,
        parameters=["conversion_window:INT64:30"] + ["activity_date:DATE:{{ds}}"],
        retries=0,
    )

    checks__fail_stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1 = bigquery_dq_check(
        task_id="checks__fail_stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1",
        source_table="dl_token_ga_attribution_lookup_v1",
        dataset_id="stub_attribution_service_derived",
        project_id="moz-fx-data-shared-prod",
        is_dq_check_fail=True,
        owner="frank@mozilla.com",
        email=["frank@mozilla.com", "telemetry-alerts@mozilla.com"],
        depends_on_past=False,
        task_concurrency=1,
        parameters=["download_date:DATE:{{ds}}"],
        retries=0,
    )

    with TaskGroup(
        "checks__fail_stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1_external",
    ) as checks__fail_stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1_external:
        ExternalTaskMarker(
            task_id="bqetl_google_analytics_derived_ga4__wait_for_checks__fail_stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1",
            external_dag_id="bqetl_google_analytics_derived_ga4",
            external_task_id="wait_for_checks__fail_stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1",
            execution_date="{{ (execution_date - macros.timedelta(days=-1, seconds=50400)).isoformat() }}",
        )

        checks__fail_stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1_external.set_upstream(
            checks__fail_stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1
        )

    mozilla_org_derived__ga_clients__v1 = bigquery_etl_query(
        task_id="mozilla_org_derived__ga_clients__v1",
        destination_table="ga_clients_v1",
        dataset_id="mozilla_org_derived",
        project_id="moz-fx-data-shared-prod",
        owner="frank@mozilla.com",
        email=["frank@mozilla.com", "telemetry-alerts@mozilla.com"],
        date_partition_parameter=None,
        depends_on_past=True,
        parameters=["session_date:DATE:{{ds}}"],
    )

    mozilla_org_derived__ga_sessions__v1 = bigquery_etl_query(
        task_id="mozilla_org_derived__ga_sessions__v1",
        destination_table="ga_sessions_v1",
        dataset_id="mozilla_org_derived",
        project_id="moz-fx-data-shared-prod",
        owner="frank@mozilla.com",
        email=["frank@mozilla.com", "telemetry-alerts@mozilla.com"],
        date_partition_parameter="session_date",
        depends_on_past=False,
    )

    mozilla_org_derived__gclid_conversions__v1 = bigquery_etl_query(
        task_id="mozilla_org_derived__gclid_conversions__v1",
        destination_table="gclid_conversions_v1",
        dataset_id="mozilla_org_derived",
        project_id="moz-fx-data-shared-prod",
        owner="frank@mozilla.com",
        email=["frank@mozilla.com", "telemetry-alerts@mozilla.com"],
        date_partition_parameter="activity_date",
        depends_on_past=False,
        parameters=["conversion_window:INT64:30"],
    )

    stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1 = bigquery_etl_query(
        task_id="stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1",
        destination_table="dl_token_ga_attribution_lookup_v1",
        dataset_id="stub_attribution_service_derived",
        project_id="moz-fx-data-shared-prod",
        owner="frank@mozilla.com",
        email=["frank@mozilla.com", "telemetry-alerts@mozilla.com"],
        date_partition_parameter=None,
        depends_on_past=False,
        task_concurrency=1,
        parameters=["download_date:DATE:{{ds}}"],
    )

    checks__fail_mozilla_org_derived__ga_clients__v1.set_upstream(
        mozilla_org_derived__ga_clients__v1
    )

    checks__fail_mozilla_org_derived__ga_sessions__v1.set_upstream(
        mozilla_org_derived__ga_sessions__v1
    )

    checks__fail_mozilla_org_derived__gclid_conversions__v1.set_upstream(
        mozilla_org_derived__gclid_conversions__v1
    )

    checks__fail_stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1.set_upstream(
        stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1
    )

    mozilla_org_derived__ga_clients__v1.set_upstream(
        checks__fail_mozilla_org_derived__ga_sessions__v1
    )

    mozilla_org_derived__ga_sessions__v1.set_upstream(
        wait_for_mozilla_org_derived__ga_sessions__v1__backfill__1
    )

    mozilla_org_derived__ga_sessions__v1.set_upstream(
        wait_for_mozilla_org_derived__ga_sessions__v1__backfill__2
    )

    mozilla_org_derived__ga_sessions__v1.set_upstream(
        wait_for_mozilla_org_derived__ga_sessions__v1__backfill__3
    )

    mozilla_org_derived__gclid_conversions__v1.set_upstream(
        checks__fail_mozilla_org_derived__ga_sessions__v1
    )

    mozilla_org_derived__gclid_conversions__v1.set_upstream(
        checks__fail_stub_attribution_service_derived__dl_token_ga_attribution_lookup__v1
    )

    mozilla_org_derived__gclid_conversions__v1.set_upstream(
        wait_for_checks__fail_telemetry_derived__clients_first_seen__v2
    )

    mozilla_org_derived__gclid_conversions__v1.set_upstream(
        wait_for_telemetry_derived__clients_daily__v6
    )
