view: mapped_campaigns {
  derived_table: {
    sql: SELECT
        id,
        name,
        'google' AS source
      FROM GOOGLE.CAMPAIGNS
      UNION
      SELECT
        id,
        name,
        'facebook' AS source
      FROM FACEBOOK_SANDBOX.CAMPAIGNS
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source;;
  }

  set: detail {
    fields: [id, name]
  }
}
