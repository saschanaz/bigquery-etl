-- Generated via ./bqetl generate glean_usage
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.focus_android.metrics`
AS
SELECT
  "org_mozilla_focus" AS normalized_app_id,
  "release" AS normalized_channel,
  additional_properties,
  client_info,
  document_id,
  events,
  metadata,
  metrics,
  normalized_app_name,
  normalized_country_code,
  normalized_os,
  normalized_os_version,
  ping_info,
  sample_id,
  submission_timestamp
FROM
  `moz-fx-data-shared-prod.org_mozilla_focus.metrics`
UNION ALL
SELECT
  "org_mozilla_focus_beta" AS normalized_app_id,
  "beta" AS normalized_channel,
  additional_properties,
  client_info,
  document_id,
  events,
  metadata,
  STRUCT(
    STRUCT(
      metrics.boolean.browser_is_default,
      metrics.boolean.glean_core_migration_successful,
      metrics.boolean.glean_error_preinit_tasks_timeout,
      metrics.boolean.tracking_protection_has_advertising_blocked,
      metrics.boolean.tracking_protection_has_analytics_blocked,
      metrics.boolean.tracking_protection_has_content_blocked,
      metrics.boolean.tracking_protection_has_ever_changed_etp,
      metrics.boolean.tracking_protection_has_social_blocked,
      metrics.boolean.mozilla_products_has_fenix_installed,
      metrics.boolean.mozilla_products_is_fenix_default_browser,
      metrics.boolean.browser_ui_proton_enabled,
      metrics.boolean.fog_failed_idle_registration,
      metrics.boolean.gifft_validation_main_ping_assembling,
      metrics.boolean.metrics_start_reason_activity_error,
      metrics.boolean.metrics_start_reason_process_error,
      metrics.boolean.metrics_search_widget_installed,
      metrics.boolean.notifications_permission_granted,
      metrics.boolean.cookie_banners_service_detect_only,
      metrics.boolean.extensions_use_remote_policy,
      metrics.boolean.extensions_use_remote_pref
    ) AS `boolean`,
    STRUCT(
      metrics.counter.glean_error_io,
      metrics.counter.glean_error_preinit_tasks_overflow,
      metrics.counter.glean_time_invalid_timezone_offset,
      metrics.counter.glean_upload_deleted_pings_after_quota_hit,
      metrics.counter.glean_upload_pending_pings,
      metrics.counter.glean_validation_app_forceclosed_count,
      metrics.counter.glean_validation_baseline_ping_count,
      metrics.counter.glean_validation_foreground_count,
      metrics.counter.settings_screen_whats_new_tapped,
      metrics.counter.settings_screen_autocomplete_domain_added,
      metrics.counter.shortcuts_shortcut_added_counter,
      metrics.counter.shortcuts_shortcut_opened_counter,
      metrics.counter.tracking_protection_toolbar_shield_clicked,
      metrics.counter.browser_total_uri_count,
      metrics.counter.autocomplete_domain_added,
      metrics.counter.autocomplete_domain_removed,
      metrics.counter.autocomplete_list_order_changed,
      metrics.counter.browser_report_site_issue_counter,
      metrics.counter.fog_ipc_flush_failures,
      metrics.counter.fog_ipc_replay_failures,
      metrics.counter.fog_ipc_shutdown_registration_failures,
      metrics.counter.power_cpu_time_bogus_values,
      metrics.counter.power_gpu_time_bogus_values,
      metrics.counter.power_total_cpu_time_ms,
      metrics.counter.power_total_gpu_time_ms,
      metrics.counter.power_total_thread_wakeups,
      metrics.counter.rtcrtpsender_count,
      metrics.counter.rtcrtpsender_count_setparameters_compat,
      metrics.counter.pdfjs_used,
      metrics.counter.glean_upload_in_flight_pings_dropped,
      metrics.counter.glean_upload_missing_send_ids,
      metrics.counter.dotprint_requested,
      metrics.counter.dotprint_android_dialog_requested,
      metrics.counter.translations_requests_count,
      metrics.counter.fog_inits_during_shutdown,
      metrics.counter.bloburl_resolve_stopped,
      metrics.counter.networking_residual_cache_folder_count,
      metrics.counter.cookie_banners_cookie_injection_fail,
      metrics.counter.networking_set_cookie
    ) AS `counter`,
    metrics.datetime,
    STRUCT(
      metrics.labeled_counter.crash_metrics_crash_count,
      metrics.labeled_counter.glean_error_invalid_label,
      metrics.labeled_counter.glean_error_invalid_overflow,
      metrics.labeled_counter.glean_error_invalid_state,
      metrics.labeled_counter.glean_error_invalid_value,
      metrics.labeled_counter.glean_upload_ping_upload_failure,
      metrics.labeled_counter.glean_validation_pings_submitted,
      metrics.labeled_counter.browser_search_ad_clicks,
      metrics.labeled_counter.browser_search_in_content,
      metrics.labeled_counter.browser_search_with_ads,
      metrics.labeled_counter.shortcuts_shortcut_removed_counter,
      metrics.labeled_counter.browser_search_search_count,
      metrics.labeled_counter.gmp_update_xml_fetch_result,
      metrics.labeled_counter.power_cpu_ms_per_thread_content_background,
      metrics.labeled_counter.power_cpu_ms_per_thread_content_foreground,
      metrics.labeled_counter.power_cpu_ms_per_thread_gpu_process,
      metrics.labeled_counter.power_cpu_ms_per_thread_parent_active,
      metrics.labeled_counter.power_cpu_ms_per_thread_parent_inactive,
      metrics.labeled_counter.power_cpu_time_per_process_type_ms,
      metrics.labeled_counter.power_gpu_time_per_process_type_ms,
      metrics.labeled_counter.power_wakeups_per_process_type,
      metrics.labeled_counter.power_wakeups_per_thread_content_background,
      metrics.labeled_counter.power_wakeups_per_thread_content_foreground,
      metrics.labeled_counter.power_wakeups_per_thread_gpu_process,
      metrics.labeled_counter.power_wakeups_per_thread_parent_active,
      metrics.labeled_counter.power_wakeups_per_thread_parent_inactive,
      metrics.labeled_counter.perf_startup_startup_type,
      metrics.labeled_counter.netwerk_early_hints,
      metrics.labeled_counter.netwerk_eh_link_type,
      metrics.labeled_counter.cookie_banners_click_result,
      metrics.labeled_counter.power_cpu_time_per_tracker_type_ms,
      metrics.labeled_counter.ipc_received_messages_content_background,
      metrics.labeled_counter.ipc_received_messages_content_foreground,
      metrics.labeled_counter.ipc_received_messages_gpu_process,
      metrics.labeled_counter.ipc_received_messages_parent_active,
      metrics.labeled_counter.ipc_received_messages_parent_inactive,
      metrics.labeled_counter.ipc_sent_messages_content_background,
      metrics.labeled_counter.ipc_sent_messages_content_foreground,
      metrics.labeled_counter.ipc_sent_messages_gpu_process,
      metrics.labeled_counter.ipc_sent_messages_parent_active,
      metrics.labeled_counter.ipc_sent_messages_parent_inactive,
      metrics.labeled_counter.cookie_banners_rule_lookup_by_domain,
      metrics.labeled_counter.cookie_banners_rule_lookup_by_load,
      metrics.labeled_counter.pdfjs_buttons,
      metrics.labeled_counter.pdfjs_editing,
      metrics.labeled_counter.network_data_size_pb_per_type,
      metrics.labeled_counter.network_data_size_per_type,
      metrics.labeled_counter.networking_speculative_connection_outcome,
      metrics.labeled_counter.networking_speculative_connect_outcome,
      metrics.labeled_counter.networking_cookie_timestamp_fixed_count,
      metrics.labeled_counter.rtcrtpsender_setparameters_blame_length_changed,
      metrics.labeled_counter.rtcrtpsender_setparameters_blame_no_getparameters,
      metrics.labeled_counter.rtcrtpsender_setparameters_blame_no_transactionid,
      metrics.labeled_counter.rtcrtpsender_setparameters_blame_stale_transactionid,
      metrics.labeled_counter.dotprint_failure,
      metrics.labeled_counter.pdfjs_geckoview,
      metrics.labeled_counter.network_cors_authorization_header,
      metrics.labeled_counter.extensions_apis_dnr_startup_cache_entries,
      metrics.labeled_counter.pwmgr_form_autofill_result,
      metrics.labeled_counter.extensions_process_event,
      metrics.labeled_counter.data_storage_entries,
      metrics.labeled_counter.pdfjs_stamp,
      metrics.labeled_counter.fog_validation_gvsv_audio_stream_init,
      metrics.labeled_counter.fog_validation_gvsv_audio_stream_init_gecko,
      metrics.labeled_counter.extensions_counters_browser_action_preload_result,
      metrics.labeled_counter.extensions_counters_event_page_idle_result,
      metrics.labeled_counter.networking_residual_cache_folder_removal,
      metrics.labeled_counter.cookie_banners_cmp_detected_cmp,
      metrics.labeled_counter.cookie_banners_cmp_result,
      metrics.labeled_counter.extensions_startup_cache_read_errors,
      metrics.labeled_counter.networking_trr_request_count,
      metrics.labeled_counter.codec_stats_audio_preferred_codec,
      metrics.labeled_counter.codec_stats_other_fec_signaled,
      metrics.labeled_counter.codec_stats_ulpfec_negotiated,
      metrics.labeled_counter.codec_stats_video_preferred_codec,
      metrics.labeled_counter.gpu_process_crash_fallbacks,
      metrics.labeled_counter.formautofill_form_submission_heuristic,
      metrics.labeled_counter.networking_http_channel_onstart_success_https_rr,
      metrics.labeled_counter.networking_https_rr_presented,
      metrics.labeled_counter.networking_https_upgrade_with_https_rr
    ) AS `labeled_counter`,
    metrics.memory_distribution,
    STRUCT(
      metrics.string.browser_default_search_engine,
      metrics.string.browser_locale_override,
      metrics.string.ping_reason,
      metrics.string.preferences_user_theme,
      metrics.string.browser_install_source,
      metrics.string.geckoview_validation_build_id,
      metrics.string.geckoview_validation_version,
      metrics.string.blocklist_mlbf_source,
      metrics.string.extensions_quarantined_domains_listhash,
      metrics.string.extensions_quarantined_domains_remotehash,
      metrics.string.glean_client_annotation_experimentation_id,
      metrics.string.glean_database_rkv_load_error,
      metrics.string.gpu_process_feature_status
    ) AS `string`,
    metrics.quantity,
    metrics.custom_distribution,
    metrics.timespan,
    metrics.timing_distribution,
    metrics.labeled_boolean,
    metrics.rate,
    metrics.uuid
  ) AS `metrics`,
  normalized_app_name,
  normalized_country_code,
  normalized_os,
  normalized_os_version,
  ping_info,
  sample_id,
  submission_timestamp
FROM
  `moz-fx-data-shared-prod.org_mozilla_focus_beta.metrics`
UNION ALL
SELECT
  "org_mozilla_focus_nightly" AS normalized_app_id,
  "nightly" AS normalized_channel,
  additional_properties,
  client_info,
  document_id,
  events,
  metadata,
  STRUCT(
    STRUCT(
      metrics.boolean.browser_is_default,
      metrics.boolean.glean_core_migration_successful,
      metrics.boolean.glean_error_preinit_tasks_timeout,
      metrics.boolean.tracking_protection_has_advertising_blocked,
      metrics.boolean.tracking_protection_has_analytics_blocked,
      metrics.boolean.tracking_protection_has_content_blocked,
      metrics.boolean.tracking_protection_has_ever_changed_etp,
      metrics.boolean.tracking_protection_has_social_blocked,
      metrics.boolean.mozilla_products_has_fenix_installed,
      metrics.boolean.mozilla_products_is_fenix_default_browser,
      metrics.boolean.browser_ui_proton_enabled,
      metrics.boolean.fog_failed_idle_registration,
      metrics.boolean.gifft_validation_main_ping_assembling,
      metrics.boolean.metrics_start_reason_activity_error,
      metrics.boolean.metrics_start_reason_process_error,
      metrics.boolean.metrics_search_widget_installed,
      metrics.boolean.notifications_permission_granted,
      metrics.boolean.cookie_banners_service_detect_only,
      metrics.boolean.extensions_use_remote_policy,
      metrics.boolean.extensions_use_remote_pref
    ) AS `boolean`,
    STRUCT(
      metrics.counter.glean_error_io,
      metrics.counter.glean_error_preinit_tasks_overflow,
      metrics.counter.glean_time_invalid_timezone_offset,
      metrics.counter.glean_upload_deleted_pings_after_quota_hit,
      metrics.counter.glean_upload_pending_pings,
      metrics.counter.glean_validation_app_forceclosed_count,
      metrics.counter.glean_validation_baseline_ping_count,
      metrics.counter.glean_validation_foreground_count,
      metrics.counter.settings_screen_whats_new_tapped,
      metrics.counter.settings_screen_autocomplete_domain_added,
      metrics.counter.shortcuts_shortcut_added_counter,
      metrics.counter.shortcuts_shortcut_opened_counter,
      metrics.counter.tracking_protection_toolbar_shield_clicked,
      metrics.counter.browser_total_uri_count,
      metrics.counter.autocomplete_domain_added,
      metrics.counter.autocomplete_domain_removed,
      metrics.counter.autocomplete_list_order_changed,
      metrics.counter.browser_report_site_issue_counter,
      metrics.counter.fog_ipc_flush_failures,
      metrics.counter.fog_ipc_replay_failures,
      metrics.counter.fog_ipc_shutdown_registration_failures,
      metrics.counter.power_cpu_time_bogus_values,
      metrics.counter.power_gpu_time_bogus_values,
      metrics.counter.power_total_cpu_time_ms,
      metrics.counter.power_total_gpu_time_ms,
      metrics.counter.power_total_thread_wakeups,
      metrics.counter.rtcrtpsender_count,
      metrics.counter.rtcrtpsender_count_setparameters_compat,
      metrics.counter.pdfjs_used,
      metrics.counter.glean_upload_in_flight_pings_dropped,
      metrics.counter.glean_upload_missing_send_ids,
      metrics.counter.dotprint_requested,
      metrics.counter.dotprint_android_dialog_requested,
      metrics.counter.translations_requests_count,
      metrics.counter.fog_inits_during_shutdown,
      metrics.counter.bloburl_resolve_stopped,
      metrics.counter.networking_residual_cache_folder_count,
      metrics.counter.cookie_banners_cookie_injection_fail,
      metrics.counter.networking_set_cookie
    ) AS `counter`,
    metrics.datetime,
    STRUCT(
      metrics.labeled_counter.crash_metrics_crash_count,
      metrics.labeled_counter.glean_error_invalid_label,
      metrics.labeled_counter.glean_error_invalid_overflow,
      metrics.labeled_counter.glean_error_invalid_state,
      metrics.labeled_counter.glean_error_invalid_value,
      metrics.labeled_counter.glean_upload_ping_upload_failure,
      metrics.labeled_counter.glean_validation_pings_submitted,
      metrics.labeled_counter.browser_search_ad_clicks,
      metrics.labeled_counter.browser_search_in_content,
      metrics.labeled_counter.browser_search_with_ads,
      metrics.labeled_counter.shortcuts_shortcut_removed_counter,
      metrics.labeled_counter.browser_search_search_count,
      metrics.labeled_counter.gmp_update_xml_fetch_result,
      metrics.labeled_counter.power_cpu_ms_per_thread_content_background,
      metrics.labeled_counter.power_cpu_ms_per_thread_content_foreground,
      metrics.labeled_counter.power_cpu_ms_per_thread_gpu_process,
      metrics.labeled_counter.power_cpu_ms_per_thread_parent_active,
      metrics.labeled_counter.power_cpu_ms_per_thread_parent_inactive,
      metrics.labeled_counter.power_cpu_time_per_process_type_ms,
      metrics.labeled_counter.power_gpu_time_per_process_type_ms,
      metrics.labeled_counter.power_wakeups_per_process_type,
      metrics.labeled_counter.power_wakeups_per_thread_content_background,
      metrics.labeled_counter.power_wakeups_per_thread_content_foreground,
      metrics.labeled_counter.power_wakeups_per_thread_gpu_process,
      metrics.labeled_counter.power_wakeups_per_thread_parent_active,
      metrics.labeled_counter.power_wakeups_per_thread_parent_inactive,
      metrics.labeled_counter.perf_startup_startup_type,
      metrics.labeled_counter.netwerk_early_hints,
      metrics.labeled_counter.netwerk_eh_link_type,
      metrics.labeled_counter.cookie_banners_click_result,
      metrics.labeled_counter.power_cpu_time_per_tracker_type_ms,
      metrics.labeled_counter.ipc_received_messages_content_background,
      metrics.labeled_counter.ipc_received_messages_content_foreground,
      metrics.labeled_counter.ipc_received_messages_gpu_process,
      metrics.labeled_counter.ipc_received_messages_parent_active,
      metrics.labeled_counter.ipc_received_messages_parent_inactive,
      metrics.labeled_counter.ipc_sent_messages_content_background,
      metrics.labeled_counter.ipc_sent_messages_content_foreground,
      metrics.labeled_counter.ipc_sent_messages_gpu_process,
      metrics.labeled_counter.ipc_sent_messages_parent_active,
      metrics.labeled_counter.ipc_sent_messages_parent_inactive,
      metrics.labeled_counter.cookie_banners_rule_lookup_by_domain,
      metrics.labeled_counter.cookie_banners_rule_lookup_by_load,
      metrics.labeled_counter.pdfjs_buttons,
      metrics.labeled_counter.pdfjs_editing,
      metrics.labeled_counter.network_data_size_pb_per_type,
      metrics.labeled_counter.network_data_size_per_type,
      metrics.labeled_counter.networking_speculative_connection_outcome,
      metrics.labeled_counter.networking_speculative_connect_outcome,
      metrics.labeled_counter.networking_cookie_timestamp_fixed_count,
      metrics.labeled_counter.rtcrtpsender_setparameters_blame_length_changed,
      metrics.labeled_counter.rtcrtpsender_setparameters_blame_no_getparameters,
      metrics.labeled_counter.rtcrtpsender_setparameters_blame_no_transactionid,
      metrics.labeled_counter.rtcrtpsender_setparameters_blame_stale_transactionid,
      metrics.labeled_counter.dotprint_failure,
      metrics.labeled_counter.pdfjs_geckoview,
      metrics.labeled_counter.network_cors_authorization_header,
      metrics.labeled_counter.extensions_apis_dnr_startup_cache_entries,
      metrics.labeled_counter.pwmgr_form_autofill_result,
      metrics.labeled_counter.extensions_process_event,
      metrics.labeled_counter.data_storage_entries,
      metrics.labeled_counter.pdfjs_stamp,
      metrics.labeled_counter.fog_validation_gvsv_audio_stream_init,
      metrics.labeled_counter.fog_validation_gvsv_audio_stream_init_gecko,
      metrics.labeled_counter.extensions_counters_browser_action_preload_result,
      metrics.labeled_counter.extensions_counters_event_page_idle_result,
      metrics.labeled_counter.networking_residual_cache_folder_removal,
      metrics.labeled_counter.cookie_banners_cmp_detected_cmp,
      metrics.labeled_counter.cookie_banners_cmp_result,
      metrics.labeled_counter.extensions_startup_cache_read_errors,
      metrics.labeled_counter.networking_trr_request_count,
      metrics.labeled_counter.codec_stats_audio_preferred_codec,
      metrics.labeled_counter.codec_stats_other_fec_signaled,
      metrics.labeled_counter.codec_stats_ulpfec_negotiated,
      metrics.labeled_counter.codec_stats_video_preferred_codec,
      metrics.labeled_counter.gpu_process_crash_fallbacks,
      metrics.labeled_counter.formautofill_form_submission_heuristic,
      metrics.labeled_counter.networking_http_channel_onstart_success_https_rr,
      metrics.labeled_counter.networking_https_rr_presented,
      metrics.labeled_counter.networking_https_upgrade_with_https_rr
    ) AS `labeled_counter`,
    metrics.memory_distribution,
    STRUCT(
      metrics.string.browser_default_search_engine,
      metrics.string.browser_locale_override,
      metrics.string.ping_reason,
      metrics.string.preferences_user_theme,
      metrics.string.browser_install_source,
      metrics.string.geckoview_validation_build_id,
      metrics.string.geckoview_validation_version,
      metrics.string.blocklist_mlbf_source,
      metrics.string.extensions_quarantined_domains_listhash,
      metrics.string.extensions_quarantined_domains_remotehash,
      metrics.string.glean_client_annotation_experimentation_id,
      metrics.string.glean_database_rkv_load_error,
      metrics.string.gpu_process_feature_status
    ) AS `string`,
    metrics.quantity,
    metrics.custom_distribution,
    metrics.timespan,
    metrics.timing_distribution,
    metrics.labeled_boolean,
    metrics.rate,
    metrics.uuid
  ) AS `metrics`,
  normalized_app_name,
  normalized_country_code,
  normalized_os,
  normalized_os_version,
  ping_info,
  sample_id,
  submission_timestamp
FROM
  `moz-fx-data-shared-prod.org_mozilla_focus_nightly.metrics`
