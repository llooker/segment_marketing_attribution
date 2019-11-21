view: daily_campaign_spend {
  derived_table: {
    sql: -- raw sql results do not include filled-in values for 'adwords_campaign_performance_reports.start_date'


      SELECT
        'Google' AS source,
        adwords_campaign_performance_reports.date_start AS date,
        COALESCE(SUM((adwords_campaign_performance_reports.cost/1000000) ), 0) AS cost
      FROM @{GOOGLE_SCHEMA_NAME}.campaign_performance_reports  AS adwords_campaign_performance_reports

      GROUP BY 1,2

      UNION

      SELECT
        'Facebook',
        facebook_insights.date_start,
        COALESCE(SUM(facebook_insights.spend ), 0)
      FROM @{FACEBOOK_SCHEMA_NAME}.insights  AS facebook_insights

      GROUP BY 1,2
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: source {
    type: string
    sql: ${TABLE}."SOURCE" ;;
  }

  dimension_group: date {
    group_label: "Date"
    type: time
    sql: ${TABLE}."DATE" ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${source} || '-' || ${date_date} ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  measure: total_cost {
    type: sum
    sql: ${cost} ;;
  }

  measure: total_facebook_spend {
    type: sum
    sql: ${cost} ;;
    filters: {
      field: source
      value: "Facebook"
    }
  }

  measure: total_google_spend {
    type: sum
    sql: ${cost} ;;
    filters: {
      field: source
      value: "Google"
    }
  }

  measure: customer_acquisition_cost {
    type: number
    sql: ${total_cost} / NULLIF(${session_pg_trk_facts.purchase_session_count},0) ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [source, date_time, cost]
  }
}
