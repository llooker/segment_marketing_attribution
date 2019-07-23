view: users {
  sql_table_name: PERSONAS_DEFAULT.USERS ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."ID" ;;
  }

  dimension: added_then_completed {
    type: yesno
    sql: ${TABLE}."ADDED_THEN_COMPLETED" ;;
  }

  dimension: context_integrations_personas {
    type: yesno
    sql: ${TABLE}."CONTEXT_INTEGRATIONS_PERSONAS" ;;
  }

  dimension: context_library_name {
    type: string
    sql: ${TABLE}."CONTEXT_LIBRARY_NAME" ;;
  }

  dimension: context_library_version {
    type: string
    sql: ${TABLE}."CONTEXT_LIBRARY_VERSION" ;;
  }

  dimension: context_personas_namespace {
    type: string
    sql: ${TABLE}."CONTEXT_PERSONAS_NAMESPACE" ;;
  }

  dimension: context_warehouses_all {
    type: yesno
    sql: ${TABLE}."CONTEXT_WAREHOUSES_ALL" ;;
  }

  dimension: context_warehouses_warehouse_ids {
    type: string
    sql: ${TABLE}."CONTEXT_WAREHOUSES_WAREHOUSE_IDS" ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}."ORDERS_COUNT" ;;
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
    sql: ${TABLE}."RECEIVED_AT" ;;
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
    sql: ${TABLE}."UUID_TS" ;;
  }

  dimension: viewed_then_added {
    type: yesno
    sql: ${TABLE}."VIEWED_THEN_ADDED" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, context_library_name, identifies.count]
  }
}
