view: session_campaign_mapping {
  derived_table: {
    sql_trigger_value: select count(*) from ${mapped_events.SQL_TABLE_NAME} ;;
    sql:
      SELECT
        sessions_pg_trk.session_start_at AS "sessions_pg_trk.start_time",
        pages.timestamp AS "pages.timestamp_time",
        event_facts.event_source  AS "event_facts.event_source",
        event_facts.looker_visitor_id  AS looker_visitor_id,
        pages.context_campaign_name  AS "pages.context_campaign_name",
        pages.context_campaign_source  AS "pages.context_campaign_source",
        sessions_pg_trk.session_id  AS "sessions_pg_trk.session_id",
        row_number() over(partition by event_facts.looker_visitor_id order by pages.timestamp) as session_sequence_number
      FROM ${event_facts.SQL_TABLE_NAME} AS event_facts
      LEFT JOIN WEB_PROD.PAGES  AS pages ON event_facts.timestamp = pages.timestamp
            and event_facts.anonymous_id = pages.anonymous_id

      LEFT JOIN ${sessions_pg_trk.SQL_TABLE_NAME} AS sessions_pg_trk ON event_facts.session_id = sessions_pg_trk.session_id
        AND pages.timestamp = sessions_pg_trk.session_start_at


      WHERE (event_facts.event_source = 'pages')
      GROUP BY 1,2,3,4,5,6,7
      ORDER BY 4 DESC
      --LIMIT 500
       ;;
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
#     hidden: yes
    sql: ${TABLE}."sessions_pg_trk.start_time" ;;
  }

  dimension: pageview_time {
    type: string
    hidden: yes
    sql: ${TABLE}."pages.timestamp_time" ;;
  }

  dimension: event_source {
    type: string
    hidden: yes
    sql: ${TABLE}."event_facts.event_source" ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}."pages.context_campaign_name" ;;
  }

  dimension: campaign_source {
    type: string
    sql: ${TABLE}."pages.context_campaign_source" ;;
  }

  dimension: session_id {
    primary_key: yes
    type: string
    sql: ${TABLE}."sessions_pg_trk.session_id" ;;
  }

  dimension: looker_visitor_id {
    type: string
    sql: ${TABLE}.looker_visitor_id ;;
  }

  measure: visitor_count {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
  }

  measure: purchases_attributed_to_facebook {
    type: count_distinct
    sql: ${session_pg_trk_facts.session_id} ;;
    filters: {
      field: campaign_source
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
      field: campaign_source
      value: "google"
    }
    filters: {
      field: session_pg_trk_facts.is_purchase_event
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      session_start_time,
      pageview_time,
      event_source,
      campaign_name,
      campaign_source,
      session_id
    ]
  }
}
