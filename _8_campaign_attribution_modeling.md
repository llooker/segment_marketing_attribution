## Campaign Attribution Method

This Marketing Attribution block comes with first- and last-touch attribution based on campaigns associated with each session. In order to accomplish this, we've created two PDTs, each with a distinct purpose.

* **Session Campaign Mapping**:
This PDT ties each session with revenue and a campaign that brought the visitor into the session. Session revenue is calculated as the sum of all completed order amount pulled from the `ORDER_COMPLETED` table. The first campaign the visitor sees in the session is assigned as the session source campaign. This session source campaign will be the basis for last-touch attribution in this block. Note that you might not use `ORDER_COMPLETED` as your desired conversion event to track. If this is the case, you need to change table and field references to `ORDER_COMPLETED` in `session_campaign_mapping` to align with your conversion event table of choice.

* **User Campaign Facts**:
This PDT ties each session with a visitor ID, and provides information on each visitor's first ever campaign that brought them into the site, every session the visitor triggered along with the sequence number of sessions, and all campaigns associated with the previous session per user. The first ever campaign each user encountered is the basis for our first-touch attribution logic. This PDT also contains logic to switch back and forth between first touch and last touch by toggling the Attribution Method parameter in Explores and Dashboards.


[:point_right:](_9_dashboards.md) Continue to [Dashboards](_9_dashboards.md)

[:point_left:](_7_session_creation_overview.md) Back to [Session Creation Overview](_7_session_creation_overview.md)

[:house:](README.md) README [Table of Contents](README.md)
