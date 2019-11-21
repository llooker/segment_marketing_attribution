## Initial Validation

An important part of the initial data validation is making sure the event data has been configured as expected in the Segment implementation, especially user identifiers contained in the subset of Tracks, Pages, and Aliases tables available. Here is a suggested list:

1. Verify that all events in Pages and Tracks have an Anonymous Id.
1. Verify that any schemas that will be tied together have Anonymous IDs in Pages and Tracks that will map.
1. Verify the events in Tracks (`tracks.event`) are as expected.
1. Verify all entries in Pages have `context_campaign_source` and `context_campaign_name` for campaign tracking.

If you see any deviations from expected behavior, there may be some things that should be configured on the Segment end.

[:point_right:](_5_applying_the_segment_block.md) Continue to [Applying the Segment Block](_5_applying_the_segment_block.md)

[:point_left:](_3_table_structure.md) Back to [Table Structure](_3_table_structure.md)

[:house:](README.md) README [Table of Contents](README.md)
