view: session_pg_trk_facts {
  derived_table: {
    # Rebuilds after track_facts rebuilds
  sql_trigger_value: select COUNT(*) from ${event_facts.SQL_TABLE_NAME} ;;
    sql: select s.session_id
        --, first_referrer
        , max(t2s.timestamp) as end_at
        , count(case when t2s.event_source = 'tracks' then 1 else null end) as tracks_count
        , sum(case when t2s.event = 'product_viewed' then 1 else null end) as cnt_product_viewed
        , sum(case when t2s.event = 'product_added' then 1 else null end) as cnt_product_added
        , sum(case when t2s.event = 'order_completed' then 1 else null end) as cnt_order_completed
      from ${sessions_pg_trk.SQL_TABLE_NAME} as s
        inner join ${event_facts.SQL_TABLE_NAME} as t2s
          on s.session_id = t2s.session_id
          --using(session_id)
      group by 1
       ;;
  }

  # ----- Dimensions -----

  dimension: session_id {
    primary_key: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension: first_referrer {
    sql: ${TABLE}.first_referrer ;;
  }

  dimension: first_referrer_domain {
    sql: split_part(${first_referrer},'/',3) ;;
  }

  dimension: first_referrer_domain_mapped {
    sql: CASE WHEN ${first_referrer_domain} like '%facebook%' THEN 'facebook' WHEN ${first_referrer_domain} like '%google%' THEN 'google' ELSE ${first_referrer_domain} END ;;
  }

  dimension_group: end {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.end_at ;;
  }

  dimension: tracks_count {
    type: number
    sql: ${TABLE}.tracks_count ;;
  }

#   dimension: referrer {
#     type: number
#     sql: ${TABLE}.referrer ;;
#   }

  dimension: tracks_count_tier {
    type: tier
    sql: ${tracks_count} ;;
    tiers: [
      1,
      5,
      10,
      20,
      30,
      60
    ]
  }

  dimension: is_bounced_session {
    sql: CASE WHEN ${tracks_count} = 1 THEN 'Bounced Session'
      ELSE 'Not Bounced Session' END
       ;;
  }

  dimension: session_duration_minutes {
    type: number
    sql: datediff(minutes, ${sessions_pg_trk.start_raw}, ${end_raw}) ;;
  }

  dimension: session_duration_minutes_tiered {
    type: tier
    sql: ${session_duration_minutes} ;;
    tiers: [
      1,
      5,
      10,
      20,
      30,
      60
    ]
  }

  dimension: cnt_order_completed {
    type: number
    hidden: yes
    sql: ${TABLE}.cnt_order_completed ;;
  }

  dimension: cnt_product_viewed {
    type: number
    hidden: yes
    sql: ${TABLE}.cnt_product_viewed ;;
  }

  dimension: cnt_product_added {
    type: number
    hidden: yes
    sql: ${TABLE}.cnt_product_added ;;
  }

  dimension: is_purchase_event {
    type: yesno
    sql: ${cnt_order_completed} > 0 ;;
  }

  # ----- Measures -----

  measure: avg_session_duration_minutes {
    type: average
    value_format_name: decimal_1
    sql: ${session_duration_minutes}::float ;;

    filters: {
      field: session_duration_minutes
      value: "> 0"
    }
  }

  measure: avg_tracks_per_session {
    type: average
    value_format_name: decimal_1
    sql: ${tracks_count}::float ;;
  }

  measure: purchase_session_count {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: is_purchase_event
      value: "Yes"
    }
  }

  measure: test {
    type: number
    sql: ${product_add_session_count} - ${purchase_session_count} ;;
  }

  measure: product_view_session_count {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: cnt_product_viewed
      value: ">0"
    }
  }

  measure: product_add_session_count {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: cnt_product_added
      value: ">0"
    }
  }


}
