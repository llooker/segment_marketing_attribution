view: page_aliases_mapping {
  derived_table: {
    sql_trigger_value: select count(*) from @{SEGMENT_SCHEMA_NAME}.tracks ;;
    sql: with
      -- Establish all child-to-parent edges from tables (tracks, pages, aliases)
      all_mappings as (
        select
          anonymous_id
          ,user_id
          ,timestamp as timestamp
        from @{SEGMENT_SCHEMA_NAME}.tracks

        union distinct

        select
          user_id
          ,null
          ,timestamp
        from @{SEGMENT_SCHEMA_NAME}.tracks

        union distinct

        select
          anonymous_id
          ,user_id
          ,timestamp
        from @{SEGMENT_SCHEMA_NAME}.pages

        union distinct

        select
          user_id
          ,null
          ,timestamp
        from @{SEGMENT_SCHEMA_NAME}.pages
      )
      select * from (
      select
      -- *
        distinct anonymous_id as alias,
        coalesce(first_value(user_id)
            over(
              partition by anonymous_id
              order by COALESCE(user_id, 'ZZZZZZZZZZZZZZZZZ'), timestamp desc
              rows between unbounded preceding and unbounded following), anonymous_id) as looker_visitor_id

      from all_mappings
      where anonymous_id IS NOT NULL
      order by anonymous_id
      )
      where alias is not NULL
       ;;
  }

  # Anonymous ID
  dimension: alias {
    primary_key: yes
    sql: ${TABLE}.alias ;;
  }

  # User ID
  dimension: looker_visitor_id {
    sql: ${TABLE}.looker_visitor_id ;;
  }

  measure: count {
    type: count
  }

  measure: count_visitor {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
  }
}