view: user_campaign_facts {
  derived_table: {
    sql:
      SELECT
        session_campaign_mapping.looker_visitor_id  AS looker_visitor_id,
        session_campaign_mapping."session_id"  AS session_id,
        "start_time" as session_start_time,
        lag("session_id") OVER (partition by looker_visitor_id order by session_campaign_mapping."session_id" asc) as previous_session_id,
        first_value("start_time") OVER (partition by looker_visitor_id order by session_campaign_mapping."session_id" desc) as acquisition_time,
        first_value("context_campaign_name") OVER (partition by looker_visitor_id order by session_campaign_mapping."session_id" desc) as first_campaign,
        COALESCE("context_campaign_name", lag("context_campaign_name") IGNORE NULLS OVER (partition by looker_visitor_id order by session_campaign_mapping."session_id" desc), "context_campaign_name") as previous_campaign,
        first_value("context_campaign_source") OVER (partition by looker_visitor_id order by session_campaign_mapping."session_id" desc) as first_campaign_source,
        COALESCE("context_campaign_source", lag("context_campaign_source") IGNORE NULLS OVER (partition by looker_visitor_id order by session_campaign_mapping."session_id" desc), "context_campaign_source") as previous_campaign_source
      FROM ${session_campaign_mapping.SQL_TABLE_NAME} AS session_campaign_mapping

      ORDER BY 1,2,3,4
       ;;
  }

  parameter: attribution_method {
    allowed_value: {value: "First Touch"}
    allowed_value: {value: "Last Touch"}
    default_value: "Last Touch"
  }

  dimension: attribution {
    type: string
    sql:
      CASE
        WHEN {% parameter attribution_method %} = 'First Touch' THEN ${first_campaign}
        WHEN {% parameter attribution_method %} = 'Last Touch' THEN ${previous_campaign}
        ELSE NULL
      END ;;
  }

  dimension: attribution_channel {
    type: string
    sql:
      CASE
        WHEN {% parameter attribution_method %} = 'First Touch' THEN ${first_campaign_source}
        WHEN {% parameter attribution_method %} = 'Last Touch' THEN ${previous_campaign_source}
        ELSE NULL
      END ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: looker_visitor_id {
    type: string
    sql: ${TABLE}."LOOKER_VISITOR_ID" ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}."SESSION_ID" ;;
  }

  dimension_group: acquisition {
    type: time
    sql: ${TABLE}.acquisition_time ;;
  }

  dimension: days_since_acquisition {
    type: number
    sql: timestampdiff(day,${session_campaign_mapping.session_start_raw},${acquisition_raw}) ;;
  }

  dimension: first_campaign {
    type: string
    sql: COALESCE(INITCAP(${TABLE}."FIRST_CAMPAIGN"),'Organic') ;;
  }

  dimension: previous_campaign {
    type: string
    sql: COALESCE(INITCAP(${TABLE}."PREVIOUS_CAMPAIGN"),'Organic') ;;
  }

  dimension: first_campaign_source {
    type: string
    sql: COALESCE(INITCAP(${TABLE}."FIRST_CAMPAIGN_SOURCE"), 'Organic') ;;
  }

  dimension: previous_campaign_source {
    type: string
    sql: COALESCE(INITCAP(${TABLE}."PREVIOUS_CAMPAIGN_SOURCE"),'Organic') ;;
  }

  dimension: previous_session_id {
    type: string
    sql: ${TABLE}."PREVIOUS_SESSION_ID" ;;
  }

  set: detail {
    fields: [looker_visitor_id, session_id, first_campaign, previous_campaign]
  }
}
