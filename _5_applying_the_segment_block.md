## Applying the Marketing Attribution Block

**Customization**

When applying the Segment template, it will need to be tailored to the underlying data, not a simple copy/paste. A few notes on that below:

* Turn on Project Import in Admin > Labs in order to manage schema names using [constants](https://docs.looker.com/reference/manifest-params/constant).
  * The manifest file (manifest.lkml) in this block containts all constants that need to be updated / managed.
  * These constants allow organizations to make schema name reference management easy by having to hard-code values once in one place, rather than each `sql_table_name` parameter in all view files.
  * This is where organizations can select and manage their event of choice for funnel analysis.
* Schema names will be distinct to the Segment implementation, so the names in the template will need to be replaced.
* Each customer will have their own conversion events they'd like to track, so the default `ORDER_COMPLETED` table will have to be replaced. We'll go through this in this doc
* Because not all Segment implementations include all of the stock tables, the view files will need to be customized accordingly, which we’ll go through in this doc
* You’ll also want to consider how you’d like to define your sessions, which could include:
1. Whether they come from only Tracks or both Pages and Tracks
1. Session timeout/Requirements for a new session
1. Custom info from `<schema>.event` tables that is of importance

[:point_right:](_6_user_id_consolidation.md) Continue to [User ID Consolidation](_6_user_id_consolidation.md)

[:point_left:](_4_initial_validation.md) Back to [Initial Validation](_4_initial_validation.md)

[:house:](README.md) README [Table of Contents](README.md)
