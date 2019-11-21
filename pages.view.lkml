view: pages {
  sql_table_name: @{SEGMENT_SCHEMA_NAME}.PAGES ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}.anonymous_id ;;
  }

  dimension: context_campaign_name {
    type: string
    sql: ${TABLE}.context_campaign_name ;;
  }

  dimension: context_campaign_source {
    type: string
    sql: ${TABLE}.context_campaign_source ;;
  }

  dimension: context_library_name {
    type: string
    sql: ${TABLE}.context_library_name ;;
  }

  dimension: context_library_version {
    type: string
    sql: ${TABLE}.context_library_version ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: path {
    type: string
    sql: ${TABLE}.path ;;
  }

  dimension_group: received {
    type: time
    hidden: yes
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.received_at ;;
  }

  dimension_group: timestamp {
    type: time
#     hidden: yes
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.timestamp ;;
  }

  dimension: received {
    type: date
    #     timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.received_at ;;
  }

  dimension: referrer {
    type: string
    sql: ${TABLE}.referrer ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: user_id {
    type: string
    # hidden: true
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, timestamp_time, context_campaign_name, context_library_name, name, users.id]
  }

  measure: count_visitors {
    type: count_distinct
    sql: ${page_facts.looker_visitor_id} ;;
  }

  measure: count_pageviews {
    type: count
    drill_fields: [context_library_name]
  }

  measure: avg_page_view_duration_minutes {
    type: average
    value_format_name: decimal_1
    sql: ${page_facts.duration_page_view_seconds}/60.0 ;;
  }

  measure: count_distinct_pageviews {
    type: number
    sql: COUNT(DISTINCT CONCAT(${page_facts.looker_visitor_id}, ${url})) ;;
  }
}
