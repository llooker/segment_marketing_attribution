view: campaign_compare {
  derived_table: {
    sql: with
      fb_perf as (
          select
                c.name as campaign_name,
                sum(i.spend) as spend,
                sum(i.impressions) as impresssions,
                sum(i.clicks) as clicks,
                'Facebook Ads'::text as source
          from  @{FACEBOOK_SCHEMA_NAME}.ads a
          join  @{FACEBOOK_SCHEMA_NAME}.insights i
            on  a.id = i.ad_id
          join  @{FACEBOOK_SCHEMA_NAME}.campaigns c
            on  a.campaign_id = c.id
          join  @{FACEBOOK_SCHEMA_NAME}.ad_sets ad
            on  a.adset_id = ad.id
      group by  1
      ),
      google_perf as (
        select
          c.name as campaign_name,
          sum(apr.cost/1000000) as spend,
          sum(apr.impressions) as impresssions,
          sum(apr.clicks) as clicks,
          'Google Ad Words'::text as source
            from  @{GOOGLE_SCHEMA_NAME}.ads a
            join  @{GOOGLE_SCHEMA_NAME}.ad_performance_reports apr
              on  a.id = apr.ad_id
            join  @{GOOGLE_SCHEMA_NAME}.ad_groups g
              on  a.ad_group_id = g.id
            join  @{GOOGLE_SCHEMA_NAME}.campaigns c
              on  g.campaign_id = c.id
        group by  1
      )
        select
              campaign_name,
                spend,
                impresssions,
                clicks,
                source from google_perf
      union all
        select
               campaign_name,
                spend,
                impresssions,
                clicks,
                source
        from fb_perf
       ;;
  }

  measure: count {
    type: count_distinct
    sql: ${campaign_name} ;;
    drill_fields: [detail*]
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  measure: spend {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.spend ;;
  }

  measure: impresssions {
    type: sum
    sql: ${TABLE}.impresssions ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  measure: cost_per_click {
    type: number
    sql: ${spend}::float/NULLIF(${clicks},0) ;;
    value_format_name: usd
  }

  measure: count_campaigns {
    type: count_distinct
    sql: ${campaign_name} ;;
    drill_fields: [campaign_name,count]
  }


  set: detail {
    fields: [
      campaign_name,
      spend,
      impresssions,
      clicks,
      source
    ]
  }
}
