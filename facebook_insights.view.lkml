view: facebook_insights {
  sql_table_name: @{FACEBOOK_SCHEMA_NAME}.insights ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: ad_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ad_id ;;
  }

  measure: call_to_action_clicks {
    type: sum
    sql: ${TABLE}.call_to_action_clicks ;;
    drill_fields: [campaigns.name, ads.name, call_to_action_clicks]
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
    drill_fields: [campaigns.name, ads.name, clicks]
  }

  dimension_group: date_start {
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
    sql: ${TABLE}.date_start ;;
  }

  dimension_group: date_stop {
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
    sql: ${TABLE}.date_stop ;;
  }

  measure: deeplink_clicks {
    type: sum
    sql: ${TABLE}.deeplink_clicks ;;
    drill_fields: [campaigns.name, ads.name, deeplink_clicks]
  }

  dimension: frequency {
    type: number
    sql: ${TABLE}.frequency ;;
  }

  measure: average_frequency {
    type: average
    sql: ${frequency} ;;
    value_format_name: decimal_1
    drill_fields: [campaigns.name, ads.name, average_frequency]
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    drill_fields: [campaigns.name, ads.name, impressions]
  }

  measure: inline_post_engagements {
    type: sum
    sql: ${TABLE}.inline_post_engagements ;;
  }

  measure: link_clicks {
    type: sum
    sql: ${TABLE}.link_clicks ;;
    drill_fields: [campaigns.name, ads.name, link_clicks]
  }

  measure: newsfeed_clicks {
    type: sum
    sql: ${TABLE}.newsfeed_clicks ;;
    drill_fields: [campaigns.name, ads.name, newsfeed_clicks]
  }

  measure: newsfeed_impressions {
    type: sum
    sql: ${TABLE}.newsfeed_impressions ;;
    drill_fields: [campaigns.name, ads.name, newsfeed_impressions]
  }

  measure: reach {
    type: sum
    sql: ${TABLE}.reach ;;
    drill_fields: [campaigns.name, ads.name, reach]
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
  }

  measure: social_clicks {
    type: sum
    sql: ${TABLE}.social_clicks ;;
    drill_fields: [campaigns.name, ads.name, social_clicks]
  }

  measure: social_impressions {
    type: sum
    sql: ${TABLE}.social_impressions ;;
    drill_fields: [campaigns.name, ads.name, social_impressions]
  }

  measure: social_spend {
    type: sum
    sql: ${TABLE}.social_spend ;;
  }

  measure: spend {
    type: sum
    sql: ${TABLE}.spend ;;
    value_format_name: usd
    drill_fields: [facebook_campaigns.name, facebook_ads.name, spend]
  }

  measure: unique_clicks {
    type: sum
    sql: ${TABLE}.unique_clicks ;;
    drill_fields: [facebook_campaigns.name, facebook_ads.name, unique_clicks]
  }

  measure: unique_impressions {
    type: sum
    sql: ${TABLE}.unique_impressions ;;
    drill_fields: [facebook_campaigns.name, facebook_ads.name, unique_impressions]
  }

  measure: unique_social_clicks {
    type: sum
    sql: ${TABLE}.unique_social_clicks ;;
    drill_fields: [facebook_campaigns.name, facebook_ads.name, unique_social_clicks]
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
  }

  measure: website_clicks {
    type: sum
    sql: ${TABLE}.website_clicks ;;
    drill_fields: [facebook_campaigns.name, facebook_ads.name, website_clicks]
  }

  measure: cost_per_click {
    type: number
    sql: ${spend}/NULLIF(${clicks},0) ;;
    value_format_name: usd
    drill_fields: [facebook_campaigns.name, facebook_ads.name, cost_per_click]
  }

  measure: click_through_rate {
    type: number
    sql: ${clicks}/NULLIF(${impressions},0) ;;
    value_format_name: percent_1
    drill_fields: [facebook_campaigns.name, facebook_ads.name, click_through_rate]
  }
}
