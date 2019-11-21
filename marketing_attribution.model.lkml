connection: "looker_blocks"

# include all views in this project
include: "*.view"
include: "*.dashboard"

explore: session_campaign_mapping {
  label: "Campaign Attribution"
  fields: [ALL_FIELDS*, -session_pg_trk_facts.session_duration_minutes, -session_pg_trk_facts.avg_session_duration_minutes]
  join: session_pg_trk_facts {
    view_label: "Session Events"
    sql_on: ${session_campaign_mapping.session_id} = ${session_pg_trk_facts.session_id} ;;
    relationship: one_to_one
  }

  join: user_campaign_facts {
    view_label: "Users"
    sql_on: ${session_campaign_mapping.session_id} = ${user_campaign_facts.session_id} ;;
    relationship: one_to_one
  }

  join: daily_campaign_spend {
    sql_on: ${session_campaign_mapping.session_start_raw} >= ${daily_campaign_spend.date_raw}
      AND ${session_campaign_mapping.campaign_source} = ${daily_campaign_spend.source};;
    relationship: many_to_one
  }
}
