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
      LEFT JOIN WEBSITE.PAGES  AS pages ON event_facts.timestamp = pages.timestamp
            and event_facts.anonymous_id = pages.anonymous_id

      LEFT JOIN ${sessions_pg_trk.SQL_TABLE_NAME} AS sessions_pg_trk ON event_facts.session_id = sessions_pg_trk.session_id
        AND event_facts.timestamp = sessions_pg_trk.session_start_at

      LEFT JOIN WEBSITE.ORDER_COMPLETED as order_completed
        ON event_facts.anonymous_id = order_completed.anonymous_id
        AND event_facts.timestamp = order_completed.timestamp

      GROUP BY 1,2 ;;
  }

  parameter: conversion_metric_selector {
    allowed_value: {value:"Revenue"}
    allowed_value: {value:"Count"}
    default_value: "Count"
  }

  measure: conversion_metrics {
    type: number
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

  dimension: event_source {
    type: string
    hidden: yes
    sql: ${TABLE}."event_source" ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}."context_campaign_name" ;;
  }

  dimension: campaign_source {
    type: string
    sql: ${TABLE}."context_campaign_source" ;;
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

  measure: total_session_revenue {
    type: sum
    sql: ${session_revenue} ;;
  }

  measure: visitor_count {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
  }

  measure: purchases_attributed_to_facebook {
    type: count_distinct
    sql: ${session_pg_trk_facts.session_id} ;;
    filters: {
      field: user_campaign_facts.previous_campaign_source
      value: "facebook"
    }
    filters: {
      field: session_pg_trk_facts.is_purchase_event
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: purchases_attributed_to_google {
    type: count_distinct
    sql: ${session_pg_trk_facts.session_id} ;;
    filters: {
      field: user_campaign_facts.previous_campaign_source
      value: "google"
    }
    filters: {
      field: session_pg_trk_facts.is_purchase_event
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: purchases_attributed_to_email {
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

  measure: session_count {
    type: count_distinct
    sql: ${session_id} ;;
  }

  set: detail {
    fields: [
      session_start_time,
      event_source,
      campaign_name,
      campaign_source,
      session_id
    ]
  }
}
