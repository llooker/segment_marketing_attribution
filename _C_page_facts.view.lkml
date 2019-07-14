view: page_facts {
  derived_table: {
   sql_trigger_value: select count(*) from ${mapped_events.SQL_TABLE_NAME} ;;
    sql: SELECT
       e.event_id AS event_id
      ,e.looker_visitor_id
      ,e.timestamp
      ,e.campaign_source
      ,e.campaign_name
      ,CASE
          WHEN timestampdiff(second, e.timestamp, LEAD(e.timestamp) OVER(PARTITION BY e.looker_visitor_id ORDER BY e.timestamp)) > 30*60 THEN NULL
          ELSE timestampdiff(second, e.timestamp, LEAD(e.timestamp) OVER(PARTITION BY e.looker_visitor_id ORDER BY e.timestamp)) END AS lead_idle_time_condition
FROM ${mapped_events.SQL_TABLE_NAME} AS e
 ;;
  }

  dimension: event_id {
    #     hidden: true
    primary_key: yes
    sql: ${TABLE}.event_id ;;
  }

  dimension: duration_page_view_seconds {
    type: number
    sql: ${TABLE}.lead_idle_time_condition ;;
  }

  dimension: is_last_page {
    type: yesno
    sql: ${duration_page_view_seconds} is NULL ;;
  }

  dimension: looker_visitor_id {
    hidden: yes
    type: string
    sql: ${TABLE}.looker_visitor_id ;;
  }

  dimension_group: timestamp {
    hidden: yes
    type: time
    datatype: timestamp
    timeframes: [
      raw,
      time,
      date,
      month,
      day_of_week,
      year
    ]
    sql: ${TABLE}.timestamp ;;
  }

  set: detail {
    fields: [event_id]
  }
}
