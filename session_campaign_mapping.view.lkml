view: session_campaign_mapping {
  derived_table: {
    sql_trigger_value: select count(*) from ${mapped_events.SQL_TABLE_NAME} ;;
    sql:
      SELECT
        event_facts.looker_visitor_id  AS looker_visitor_id,
        event_facts.session_id  AS "session_id",
        max(sessions_pg_trk.session_start_at) AS "start_time",
        max(pages.context_campaign_name) "context_campaign_name",
        max(pages.context_campaign_source) AS "context_campaign_source",
        SUM(order_completed.revenue) AS session_revenue,
        ROW_NUMBER() OVER (PARTITION BY event_facts.looker_visitor_id ORDER BY event_facts.session_id ASC) AS session_sequence_number
      FROM ${event_facts.SQL_TABLE_NAME} AS event_facts
      LEFT JOIN @{SEGMENT_SCHEMA_NAME}.PAGES  AS pages ON event_facts.timestamp = pages.timestamp
            and event_facts.anonymous_id = pages.anonymous_id

      LEFT JOIN ${sessions_pg_trk.SQL_TABLE_NAME} AS sessions_pg_trk ON event_facts.session_id = sessions_pg_trk.session_id
        AND event_facts.timestamp = sessions_pg_trk.session_start_at

      LEFT JOIN @{SEGMENT_SCHEMA_NAME}.ORDER_COMPLETED as order_completed
        ON event_facts.anonymous_id = order_completed.anonymous_id
        AND event_facts.timestamp = order_completed.timestamp

      GROUP BY 1,2 ;;
  }

  parameter: conversion_metric_selector {
    allowed_value: {value:"Revenue" label: "Revenue"}
    allowed_value: {value:"Count" label: "Conversion Count"}
    default_value: "Count"
  }

  measure: conversion_metrics {
    type: number
    drill_fields: [detail*]
    sql:
      CASE
        WHEN {% parameter conversion_metric_selector %} = 'Revenue' THEN ${total_session_revenue}
        WHEN {% parameter conversion_metric_selector %} = 'Count' THEN ${session_pg_trk_facts.purchase_session_count}
        ELSE NULL
      END ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: session_sequence_number {
    type: number
    sql: ${TABLE}.session_sequence_number ;;
  }

  dimension_group: session_start {
    type: time
    sql: ${TABLE}."start_time" ;;
  }

  dimension: campaign_name {
    group_label: "Session Campaign"
    type: string
    sql: COALESCE(INITCAP(${TABLE}."context_campaign_name"),'Organic') ;;
  }

  dimension: campaign_source {
    group_label: "Campaign"
    label: "Session Campaign Channel"
    type: string
    sql: COALESCE(INITCAP(${TABLE}."context_campaign_source"),'Organic') ;;
    drill_fields: [campaign_name]
  }

  dimension: session_id {
    primary_key: yes
    type: string
    sql: ${TABLE}."session_id" ;;
  }

  dimension: looker_visitor_id {
    type: string
    sql: ${TABLE}.looker_visitor_id ;;
  }

  dimension: session_revenue {
    type: number
    sql: ${TABLE}.session_revenue ;;
  }

  dimension: is_purchase_session {
    type: yesno
    sql: ${session_revenue} > 0 ;;
  }

  measure: total_session_revenue {
    group_label: "Revenue"
    type: sum
    sql: ${session_revenue} ;;
    drill_fields: [detail*]
    value_format_name: usd_0
  }

  measure: visitor_count {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
    drill_fields: [detail*]
  }

  measure: revenue_attributed_to_facebook {
    group_label: "Revenue"
    type: sum
    sql: ${session_revenue} ;;
    filters: {
      field: user_campaign_facts.attribution_channel
      value: "Facebook"
    }
    filters: {
      field: session_pg_trk_facts.is_purchase_event
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: revenue_attributed_to_google {
    group_label: "Revenue"
    type: sum
    sql: ${session_revenue} ;;
    filters: {
      field: user_campaign_facts.attribution_channel
      value: "Google"
    }
    filters: {
      field: session_pg_trk_facts.is_purchase_event
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: purchases_attributed_to_facebook {
    group_label: "Purchases"
    type: count_distinct
    sql: ${session_pg_trk_facts.session_id} ;;
    filters: {
      field: user_campaign_facts.previous_campaign_source
      value: "Facebook"
    }
    filters: {
      field: session_pg_trk_facts.is_purchase_event
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: purchases_attributed_to_google {
    group_label: "Purchases"
    type: count_distinct
    sql: ${session_pg_trk_facts.session_id} ;;
    filters: {
      field: user_campaign_facts.previous_campaign_source
      value: "Google"
    }
    filters: {
      field: session_pg_trk_facts.is_purchase_event
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: purchases_attributed_to_email {
    group_label: "Purchases"
    type: count_distinct
    sql: ${session_pg_trk_facts.session_id} ;;
    filters: {
      field: user_campaign_facts.previous_campaign_source
      value: "email"
    }
    filters: {
      field: session_pg_trk_facts.is_purchase_event
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: facebook_revenue_per_purchase {
    group_label: "Revenue"
    type: number
    sql: ${revenue_attributed_to_facebook} / NULLIF(${purchases_attributed_to_facebook},0) ;;
    drill_fields: [detail*]
    value_format_name: usd
  }

  measure: google_revenue_per_purchase {
    group_label: "Revenue"
    type: number
    sql: ${revenue_attributed_to_google} / NULLIF(${purchases_attributed_to_google},0) ;;
    drill_fields: [detail*]
    value_format_name: usd
  }

  measure: revenue_per_puchase {
    group_label: "Revenue"
    type: number
    sql: ${total_session_revenue} / NULLIF(${session_pg_trk_facts.purchase_session_count},0) ;;
    drill_fields: [detail*]
  }

  measure: session_count {
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      campaign_source,
      session_start_date,
      total_session_revenue
    ]
  }
}
