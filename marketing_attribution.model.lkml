connection: "looker_blocks"

# include all views in this project
include: "*.view"

explore: session_campaign_mapping {
  fields: [ALL_FIELDS*, -session_pg_trk_facts.session_duration_minutes, -session_pg_trk_facts.avg_session_duration_minutes]
  join: session_pg_trk_facts {
    sql_on: ${session_campaign_mapping.session_id} = ${session_pg_trk_facts.session_id} ;;
    relationship: one_to_one
  }

  join: user_campaign_facts {
    sql_on: ${session_campaign_mapping.session_id} = ${user_campaign_facts.session_id} ;;
    relationship: one_to_one
  }
}

explore: event_facts {
  view_label: "Events"
  label: "Events"

  join: pages {
    view_label: "Events"
    type: left_outer
    sql_on: event_facts.timestamp = pages.timestamp
      and event_facts.anonymous_id = pages.anonymous_id
       ;;
    relationship: one_to_one
  }

  join: tracks {
    view_label: "Events"
    type: left_outer
    sql_on: event_facts.event_id = concat(tracks.event_id, '-t')
      and event_facts.timestamp = tracks.timestamp
      and event_facts.anonymous_id = tracks.anonymous_id
       ;;
    relationship: one_to_one
    fields: []
  }

  join: page_facts {
    view_label: "Events"
    type: left_outer
    sql_on: event_facts.event_id = page_facts.event_id and
      event_facts.timestamp = page_facts.timestamp and
      event_facts.looker_visitor_id = page_facts.looker_visitor_id
       ;;
    relationship: one_to_one
  }

  join: sessions_pg_trk {
    view_label: "Sessions"
    type: left_outer
    sql_on: ${event_facts.session_id} = ${sessions_pg_trk.session_id} ;;
    relationship: many_to_one
  }

  join: session_pg_trk_facts {
    view_label: "Sessions"
    type: left_outer
    sql_on: ${event_facts.session_id} = ${session_pg_trk_facts.session_id} ;;
    relationship: many_to_one
  }

  join: mapped_campaigns {
    sql_on: ${pages.context_campaign_source} = ${mapped_campaigns.source} ;;
    relationship: many_to_one
  }

}
