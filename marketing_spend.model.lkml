connection: "looker_blocks"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: adwords_ad_performance_reports {
  join: adwords_ads {
    relationship: many_to_one
    sql_on: ${adwords_ad_performance_reports.ad_id} = ${adwords_ads.id} ;;
  }
  join: adwords_ad_groups {
    relationship: many_to_one
    sql_on: ${adwords_ads.ad_group_id} = ${adwords_ad_groups.id} ;;
  }
  join: adwords_campaigns {
    relationship: many_to_one
    sql_on: ${adwords_ad_groups.campaign_id} = ${adwords_campaigns.id} ;;
  }
}

explore: adwords_campaign_performance_reports {
  join: adwords_campaigns {
    relationship: many_to_one
    sql_on: ${adwords_campaign_performance_reports.campaign_id} = ${adwords_campaigns.id} ;;
  }
  join: adwords_ad_groups {
    relationship: one_to_many
    sql_on: ${adwords_ad_groups.campaign_id} = ${adwords_campaigns.id} ;;
  }

}

## Facebook Ads ##
explore: facebook_ads {
  join: facebook_campaigns {
    type: left_outer
    sql_on: ${facebook_ads.campaign_id} = ${facebook_campaigns.id} ;;
    relationship: many_to_one
  }

  join: facebook_ad_sets {
    type: left_outer
    sql_on: ${facebook_ads.adset_id} = ${facebook_ad_sets.id} ;;
    relationship: many_to_one
  }

  join: facebook_insights {
    type: left_outer
    sql_on: ${facebook_ads.id} = ${facebook_insights.ad_id} ;;
    relationship: many_to_one
  }
}

explore: facebook_insights {
  join: facebook_ads {
    type: left_outer
    sql_on: ${facebook_insights.ad_id} = ${facebook_ads.id} ;;
    relationship: many_to_one
  }

  join: facebook_ad_sets {
    type: left_outer
    sql_on: ${facebook_ads.adset_id} = ${facebook_ad_sets.id} ;;
    relationship: many_to_one
  }

  join: facebook_campaigns {
    type: left_outer
    sql_on: ${facebook_ads.campaign_id} = ${facebook_campaigns.id} ;;
    relationship: many_to_one
  }
}
