view: user_campaign_facts {
  derived_table: {
    sql: -- use existing session_campaign_mapping in LOOKER_SCRATCH.LR$9YITOYWRVFE8TH6UEPEPF_session_campaign_mapping
      SELECT
        session_campaign_mapping.looker_visitor_id  AS looker_visitor_id,
        session_campaign_mapping."session_id"  AS session_id,
        first_value("context_campaign_name") OVER (partition by looker_visitor_id order by session_campaign_mapping."session_id" asc) as first_campaign,
        COALESCE("context_campaign_name", lag("context_campaign_name") IGNORE NULLS OVER (partition by looker_visitor_id order by session_campaign_mapping."session_id" asc), "context_campaign_name") as previous_campaign,
        first_value("context_campaign_source") OVER (partition by looker_visitor_id order by session_campaign_mapping."session_id" asc) as first_campaign_source,
        COALESCE("context_campaign_source", lag("context_campaign_source") IGNORE NULLS OVER (partition by looker_visitor_id order by session_campaign_mapping."session_id" asc), "context_campaign_source") as previous_campaign_source
      FROM ${session_campaign_mapping.SQL_TABLE_NAME} AS session_campaign_mapping

      ORDER BY 1,2
       ;;
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

  dimension: first_campaign {
    type: string
    sql: ${TABLE}."FIRST_CAMPAIGN" ;;
  }

  dimension: previous_campaign {
    type: string
    sql: ${TABLE}."PREVIOUS_CAMPAIGN" ;;
  }

  dimension: first_campaign_source {
    type: string
    sql: ${TABLE}."FIRST_CAMPAIGN_SOURCE" ;;
  }

  dimension: previous_campaign_source {
    type: string
    sql: ${TABLE}."PREVIOUS_CAMPAIGN_SOURCE" ;;
  }

  set: detail {
    fields: [looker_visitor_id, session_id, first_campaign, previous_campaign]
  }
}
