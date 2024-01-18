SELECT
    event_date AS date,
    event.params.key = ga_session_id => events.param.values.int_value AS visitor_identifier,
    user_pseudo_id AS full_visitor_id,
    AS visit_start_time,
    AS page_path,
    AS page_path_level,
    AS hit_type,
    AS is_exit,
    (CASE WHEN event_params.key = 'entrances', TRUE, FALSE) AS is_entrance,
    event.params.key = ga_session_number => events.params.int_value AS hit_number,
    AS event_category,
    AS event_label,
    AS event_action,
    device.category AS device_category,
    device.operating_system AS operating_system,
    device.language AS language,
    COALESCE(device.browser, device.web_info.browser) AS browser, -- OR device.web_info.browser
    COALESCE(device.browser_version, device.web_info.browser_version) AS browser_version, -- OR device.web_info.browser_version
    geo.country AS country,
    AS source,
    AS medium,
    AS campaign,
    AS ad_content,
    AS visits,
    AS bounces,
    AS hit_time,
    AS first_interaction,
    AS last_interaction,
    AS entrances, -- event_params.key
    AS exits,
    AS event_id, -- event_params.int_value?
    AS page_level_1,
    AS page_level_2,
    AS page_level_3,
    AS page_level_4,
    AS page_level_5,
    AS page_name -- event_params.key = page_title or page_location? => event.params.value.string_value

    FROM `moz-fx-data-marketing-prod.analytics_313696158.events_*`,
    unnest(event_params) AS event_params