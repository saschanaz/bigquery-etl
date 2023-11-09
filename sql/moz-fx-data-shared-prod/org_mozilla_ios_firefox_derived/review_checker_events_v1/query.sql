SELECT
  DATE(submission_timestamp) AS submission_date,
  client_info.client_id AS client_id,
  client_info.os AS os,
  client_info.os_version AS os_version,
  MAX(
    CASE
      WHEN name = 'address_bar_feature_callout_displayed'
        THEN 1
      ELSE 0
    END
  ) is_address_bar_feature_callout_displayed,
  MAX(CASE WHEN name = 'address_bar_icon_clicked' THEN 1 ELSE 0 END) is_address_bar_icon_clicked,
  MAX(
    CASE
      WHEN name = 'address_bar_icon_displayed'
        THEN 1
      ELSE 0
    END
  ) is_address_bar_icon_displayed,
  MAX(
    CASE
      WHEN name = 'surface_analyze_reviews_none_available_clicked'
        THEN 1
      ELSE 0
    END
  ) is_surface_analyze_reviews_none_available_clicked,
  MAX(CASE WHEN name = 'surface_closed' THEN 1 ELSE 0 END) is_surface_closed,
  MAX(CASE WHEN name = 'surface_displayed' THEN 1 ELSE 0 END) is_surface_displayed,
  MAX(
    CASE
      WHEN name = 'surface_settings_expand_clicked'
        THEN 1
      ELSE 0
    END
  ) is_surface_settings_expand_clicked,
  MAX(
    CASE
      WHEN name = 'surface_learn_more_clicked'
        THEN 1
      ELSE 0
    END
  ) is_surface_learn_more_clicked,
  MAX(
    CASE
      WHEN name = 'surface_no_review_reliability_available'
        THEN 1
      ELSE 0
    END
  ) is_surface_no_review_reliability_available,
  MAX(
    CASE
      WHEN name = 'surface_onboarding_displayed'
        THEN 1
      ELSE 0
    END
  ) is_surface_onboarding_displayed,
  MAX(CASE WHEN name = 'surface_opt_in_accepted' THEN 1 ELSE 0 END) is_surface_opt_in_accepted,
  MAX(
    CASE
      WHEN name = 'surface_reactivated_button_clicked'
        THEN 1
      ELSE 0
    END
  ) is_surface_reactivated_button_clicked,
  MAX(CASE WHEN name = 'surface_reanalyze_clicked' THEN 1 ELSE 0 END) is_surface_reanalyze_clicked,
  MAX(
    CASE
      WHEN name = 'surface_powered_by_fakespot_link_clicked'
        THEN 1
      ELSE 0
    END
  ) is_surface_powered_by_fakespot_link_clicked,
  MAX(
    CASE
      WHEN name = 'surface_show_more_recent_reviews_clicked'
        THEN 1
      ELSE 0
    END
  ) is_surface_show_more_reviews_button_clicked,
  MAX(
    CASE
      WHEN name = 'surface_show_privacy_policy_clicked'
        THEN 1
      ELSE 0
    END
  ) is_surface_show_privacy_policy_clicked,
  MAX(
    CASE
      WHEN name = 'surface_show_quality_explainer_clicked'
        THEN 1
      ELSE 0
    END
  ) is_surface_show_quality_explainer_url_clicked,
  MAX(
    CASE
      WHEN name = 'surface_show_terms_clicked'
        THEN 1
      ELSE 0
    END
  ) is_surface_show_terms_clicked,
  MAX(
    CASE
      WHEN name = 'surface_stale_analysis_shown'
        THEN 1
      ELSE 0
    END
  ) is_surface_stale_analysis_shown,
  MAX(
    CASE
      WHEN name IN (
          'surface_analyze_reviews_none_available_clicked',
          'surface_learn_more_clicked',
          'surface_no_review_reliability_available',
          'surface_reactivated_button_clicked',
          'surface_reanalyze_clicked',
          'surface_settings_expand_clicked',
          'surface_show_more_recent_reviews_clicked',
          'surface_show_privacy_policy_clicked',
          'surface_show_quality_explainer_clicked',
          'surface_show_terms_clicked'
        )
        THEN 1
      ELSE 0
    END
  ) is_engaged_with_sidebar,
  ANY_VALUE(ping_info.experiments) AS experiments,
  normalized_channel,
  normalized_country_code,
  sample_id,
  mozfun.norm.truncate_version(client_info.app_display_version, "major") AS app_version,
FROM
  `moz-fx-data-shared-prod.org_mozilla_ios_firefox_stable.events_v1` AS e,
  UNNEST(events)
WHERE
  DATE(submission_timestamp) = @submission_date
  AND category = 'shopping'
GROUP BY
  DATE(submission_timestamp),
  client_info.client_id,
  normalized_channel,
  normalized_country_code,
  sample_id,
  os,
  os_version,
  app_version
