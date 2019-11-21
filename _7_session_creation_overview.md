## Session Creation Overview: Page and Track Analysis


For this block, we will include both pages and tracks events to define sessions. For this, we create intermediate persistent derived tables (PDTs) to process tracks and page views into enriched events and sessions. Including pages allows users to define referrer campaigns, enabling first touch and last touch attribution.

![page track analysis](http://gdurl.com/46Cz)

A. [**Alias Mapping**] (_A_alias_mapping.view.lookml) - User ID Consolidation from Tracks and Pages Table

B. [**Mapped Events**](_B_mapped_events.view.lookml) - Serves to map all events (Tracks and Pages) to universal user id as first step in sessionization. Ranks events by User and get the time difference between one event to the next.

C. [**Session Track Pages**](_C_session_pg_tracks.view.lookml) - Creates sessions from Mapped Events by identifying a period of inactivity greater than 30 minutes, ending the current session and creating a new one.

D. [**Event Facts**](_D_event_facts.view.lookml) - Maps events to session ids. This table will the starting point for exploration as it contains all the necessary keys (Session ID, Universal User ID) for all relevant joins. Session or User fact tables can be created from Event facts to speed up query results.

Looker Model - These individual files can be integrated in the [Pages Model File](pages.model.lookml). Event_id is NOT the primary key for Events, so joins must use multiple identifiers on required fields, like anonymous_id, received_at, and event_id. Also event_id may be called id, just swap the name.

[:point_right:](_8_campaign_attribution_modeling.md) Continue to [Campaign Attribution Method](_8_campaign_attribution_modeling.md)

[:point_left:](_6_user_id_consolidation.md) Back to [User ID Consolidation](_6_user_id_consolidation.md)

[:house:](README.md) README [Table of Contents](README.md)
