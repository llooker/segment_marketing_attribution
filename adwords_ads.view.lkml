view: adwords_ads {
  sql_table_name: @{GOOGLE_SCHEMA_NAME}.ads ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    link: {
      label: "Ad Performance Dashboard"
      icon_url: "https://looker.com/favicon.ico"
      url: "https://boomerang.looker.com/dashboards/8"
    }
    link: {
      label: "Campaign Lookup Dashboard"
      icon_url: "https://looker.com/favicon.ico"
      url: "https://boomerang.looker.com/dashboards/6?Campaign%20Name={{ campaigns.name._value }}"
    }
  }

  dimension: ad_group_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ad_group_id ;;
    hidden: yes
  }

  dimension: adwords_customer_id {
    type: string
    sql: ${TABLE}.adwords_customer_id ;;
    hidden: yes
  }

  dimension: original_id {
    type: string
    sql: ${TABLE}.original_id ;;
    hidden: yes
  }

  dimension_group: received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.received_at ;;
    hidden: yes
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    hidden: yes
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
    hidden: yes
  }

  dimension: uuid {
    type: number
    value_format_name: id
    sql: ${TABLE}.uuid ;;
    hidden: yes
  }

  dimension_group: uuid_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.uuid_ts ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id, ad_groups.id, ad_groups.name, ad_performance_reports.count]
  }
}
