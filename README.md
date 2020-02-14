### What does this block do for me?
Marketing Attribution Block by Segment takes event tracking data and ties each user session to a campaign, allowing users to see which campaigns were most influencial in bringing on new users and revenue. In addition, users have the option to toggle between first touch (i.e. customer acquisition) and last touch (i.e. conversion) attribution to track the differences in campaigns that brought new users vs those that brought in revenue.

**Note**: This Block is an extension of the [Event Analytics by Segment Block](https://looker.com/platform/blocks/source/event-analytics-by-segment). It specifically uses the ["Pages and Tracks"](https://github.com/llooker/segment_bigquery/blob/master/_5_applying_the_segment_block.md) version of the Block. Please refer to details in the [Event Analytics Block entry](https://github.com/llooker/segment_bigquery).

### What's New?
This Marketing Attribution Block adds the ability to organize and analyze conversions as they relate to specific campaigns and marketing channels. This is made possible by adding one model file, three new View files, and one dashboard file:

* marketing_attribution.model.lkml
* session_campaign_mapping.view.lkml
* user_campaign_mapping.view.lkml
* daily_campaign_spend.view.lkml
* 1_revenue_attribution.dashboard.lookml

An overview of each file is listed in the **Block Structure** section below.

### Block Structure (New Explore)
* **Campaign Attribution**: The Campaign Attribution explore takes four distinct views - sessions, events, users, and spend - to provide a holistic view on campaign performance. This explore is an extension of the Event Analytics by Segment block, and is based on both the standard Segment web tracking schema (tracks, pages, etc.), as well as Facebook Ads and Google AdWords data piped in through Segment. This is included in the **marketing_attribution.model.lkml** model file.

### Block Structure (New PDTs)
* **Session Campaign Mapping**: This PDT takes each session and assigns it a campaign and channel through which the session was entered, along with total revenue during each session. **session_campaign_mapping.view.lkml** is the relevant view file.
* **User Campaign Facts**: This PDT associates each visitor ID with a visitor's acquisition channel and campaign (i.e. first touch), and the campaign / channel that triggered any given user session's previous session (i.e. last touch). **user_campaign_mapping.view.lkml** is the relevant view file.
* **Daily Campaign Spend**: This PDT standardizes campaign cost across channels (Google AdWords and Facebook Ads by default) as total spend by date. **daily_campaign_spend.view.lkml** is the relevant view file.

### Block Structure (New Dashboard)
* **Revenue Attribution Dashboard**: This dashboard provides users with the analyses necessary to take digital marketing to the next level. Key insights include which channels bring in the most conversion, and what campaigns are most effective at nudging users to take desired actions. This is included in the **1_revenue_attribution.dashboard.lookml** file.

### Required Customization

#### In Looker
* **Implementing the Base Event Analytics Block**: This Block is an extension of the Event Analytics Block, and specifically leverages sessionization built on the tracks and pages tables in Segment. You will therefore need at least tracks and pages in your database, and make sure to change the schema name in the `sql_table_name` parameter for each view referring to underlying tables. The required files are already included in this Block, so you won't have to implement the Event Analytics Block separately. (just drag and drop files from this block). Please refer to the details in the Block Overview instructions below.
* **Implementing the Google and Facebook Ads Block**: This Block combines Event Analytics data with campaign-level data pulled from Google adnd Facebook campaigns. The required files are already included in this Block, so you won't have to implement the Google and Facebook Ads Block separately (just drag and drop files from this block).
* **Adjust Key Actions to Create a User Funnel**: How you will track a user's steps to conversion (e.g. Visit -> View Product -> Add to Cart -> Purchase) depends on what actions users are able to take. You will have to adjust the SQL query in the `_F_session_pg_track_facts` view to include `, sum(case when t2s.event = 'INSERT EVENT NAME HERE' then 1 else null end) as count_[event_name]`.
* **Using the Correct Covnersion Event**: The default Block uses `ORDER_COMPLETED` to track conversion sessions and session revenue. This might not be the same event name, or even the kind of conversions you capture (signups, logins, etc.). You'll have to update table and field references in the `session_campaign_mapping` view file to align the Block to your business.

### Data Structure, Block Structure, and Implementation Instructions ###
Documentation is found in the included markdown files and linked below:

1. [Block Overview](_1_block_overview.md)

1. [Configuring the Database Connection](_2_configuring_the_database_connection.md)

1. [Table Structure](_3_table_structure.md)

1. [Initial Validation](_4_initial_validation.md)

1. [Applying the Segment Block](_5_applying_the_segment_block.md)

1. [User ID Consolidation](_6_user_id_consolidation.md)

1. [Session Creation Overview](_7_session_creation_overview.md)

1. [Campaign Attribution Method](_8_campaign_attribution_modeling.md)

1. [Dashboards](_9_dashboards.md)

What if I find an error? Suggestions for improvements?
Great! Blocks were designed for continuous improvement through the help of the entire Looker community, and we'd love your input. To log an error or improvement recommentation, simply create a "New Issue" in the corresponding Github repo for this Block. Please be as detailed as possible in your explanation, and we'll address it as quick as we can.

[:point_right:](_1_block_overview.md) Continue to [Block Overview](_1_block_overview.md)

[:house:](README.md) README [Table of Contents](README.md)
