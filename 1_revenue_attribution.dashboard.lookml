- dashboard: revenue_attribution
  title: Revenue Attribution
  layout: newspaper
  elements:
  - name: Adwords Performance
    title: Adwords Performance
    merged_queries:
    - model: marketing_attribution
      explore: session_campaign_mapping
      type: looker_line
      fields: [session_campaign_mapping.purchases_attributed_to_facebook, session_campaign_mapping.purchases_attributed_to_google,
        session_campaign_mapping.session_start_date, session_campaign_mapping.conversion_metrics]
      fill_fields: [session_campaign_mapping.session_start_date]
      filters:
        session_campaign_mapping.conversion_metric_selector: Count
      sorts: [session_campaign_mapping.session_start_date desc]
      limit: 500
      column_limit: 50
    - model: marketing_spend
      explore: facebook_insights
      type: table
      fields: [facebook_insights.spend, facebook_insights.date_start_date]
      fill_fields: [facebook_insights.date_start_date]
      sorts: [facebook_insights.date_start_date desc]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: facebook_insights.date_start_date
        source_field_name: session_campaign_mapping.session_start_date
    - model: marketing_spend
      explore: adwords_ad_performance_reports
      type: table
      fields: [adwords_ad_performance_reports.total_cost, adwords_ad_performance_reports.date_start_date]
      fill_fields: [adwords_ad_performance_reports.date_start_date]
      sorts: [adwords_ad_performance_reports.date_start_date desc]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: adwords_ad_performance_reports.date_start_date
        source_field_name: session_campaign_mapping.session_start_date
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: session_campaign_mapping.purchases_attributed_to_google,
            id: session_campaign_mapping.purchases_attributed_to_google, name: Purchases
              Attributed to Google}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: adwords_ad_performance_reports.total_cost, id: adwords_ad_performance_reports.total_cost,
            name: Total Cost}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_labels:
      session_campaign_mapping.purchases_attributed_to_google: Conversions from Google
      adwords_ad_performance_reports.total_cost: Adwords Spend
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    type: looker_area
    hidden_fields: [session_campaign_mapping.purchases_attributed_to_facebook, facebook_insights.spend,
      session_campaign_mapping.conversion_metrics]
    sorts: [session_campaign_mapping.session_start_date desc]
    listen:
    - Timeframe: session_campaign_mapping.session_start_date
    -
    -
    row: 48
    col: 12
    width: 12
    height: 7
  - name: Users Acquired
    title: Users Acquired
    model: marketing_attribution
    explore: session_campaign_mapping
    type: single_value
    fields: [session_campaign_mapping.visitor_count, session_campaign_mapping.session_count]
    filters:
      session_pg_trk_facts.is_purchase_event: 'Yes'
    limit: 500
    column_limit: 50
    series_types: {}
    hidden_fields: [session_pg_trk_facts.pruchase_session_count]
    listen:
      Attribution Method: user_campaign_facts.attribution_method
      Timeframe: session_campaign_mapping.session_start_date
    row: 5
    col: 0
    width: 5
    height: 3
  - name: Conversion by Acquisition Referrer
    title: Conversion by Acquisition Referrer
    model: marketing_attribution
    explore: session_campaign_mapping
    type: looker_column
    fields: [user_campaign_facts.previous_campaign_source, session_pg_trk_facts.product_view_session_count,
      session_pg_trk_facts.product_add_session_count, session_pg_trk_facts.purchase_session_count]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_labels:
      session_campaign_mapping.count: Sessions
      session_pg_trk_facts.pruchase_session_count: Purchases
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_dropoff: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Attribution Method: user_campaign_facts.attribution_method
      Timeframe: session_campaign_mapping.session_start_date
    row: 32
    col: 0
    width: 24
    height: 8
  - name: Repeat Visits
    title: Repeat Visits
    model: marketing_attribution
    explore: session_campaign_mapping
    type: looker_line
    fields: [session_campaign_mapping.campaign_source, session_campaign_mapping.count,
      session_campaign_mapping.session_sequence_number]
    pivots: [session_campaign_mapping.campaign_source]
    sorts: [session_campaign_mapping.count desc 0, session_campaign_mapping.campaign_source]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: Sessions, orientation: left, series: [{axisId: session_campaign_mapping.count,
            id: email - session_campaign_mapping.count, name: email}, {axisId: session_campaign_mapping.count,
            id: facebook - session_campaign_mapping.count, name: facebook}, {axisId: session_campaign_mapping.count,
            id: google - session_campaign_mapping.count, name: google}, {axisId: session_campaign_mapping.count,
            id: session_campaign_mapping.campaign_source___null - session_campaign_mapping.count,
            name: "∅"}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Visit Count
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: right
    series_types: {}
    point_style: none
    series_labels:
      session_campaign_mapping.count: Sessions
      session_pg_trk_facts.pruchase_session_count: Purchases
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_dropoff: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Attribution Method: user_campaign_facts.attribution_method
    row: 40
    col: 0
    width: 12
    height: 8
  - name: Facebook Performance
    title: Facebook Performance
    merged_queries:
    - model: marketing_attribution
      explore: session_campaign_mapping
      type: looker_line
      fields: [session_campaign_mapping.purchases_attributed_to_facebook, session_campaign_mapping.purchases_attributed_to_google,
        session_pg_trk_facts.purchase_session_count, session_campaign_mapping.session_start_date]
      fill_fields: [session_campaign_mapping.session_start_date]
      sorts: [session_campaign_mapping.session_start_date desc]
      limit: 500
      column_limit: 50
    - model: marketing_spend
      explore: facebook_insights
      type: table
      fields: [facebook_insights.spend, facebook_insights.date_start_date]
      fill_fields: [facebook_insights.date_start_date]
      sorts: [facebook_insights.date_start_date desc]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: facebook_insights.date_start_date
        source_field_name: session_campaign_mapping.session_start_date
    - model: marketing_spend
      explore: adwords_ad_performance_reports
      type: table
      fields: [adwords_ad_performance_reports.total_cost, adwords_ad_performance_reports.date_start_date]
      fill_fields: [adwords_ad_performance_reports.date_start_date]
      sorts: [adwords_ad_performance_reports.date_start_date desc]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: adwords_ad_performance_reports.date_start_date
        source_field_name: session_campaign_mapping.session_start_date
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: session_campaign_mapping.purchases_attributed_to_facebook,
            id: session_campaign_mapping.purchases_attributed_to_facebook, name: Purchases
              Attributed to Facebook}], showLabels: true, showValues: true, minValue: !!null '',
        unpinAxis: false, tickDensity: default, type: linear}, {label: '', orientation: right,
        series: [{axisId: facebook_insights.spend, id: facebook_insights.spend, name: Spend}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_labels:
      session_campaign_mapping.purchases_attributed_to_google: Conversions from Google
      adwords_ad_performance_reports.total_cost: Adwords Spend
      facebook_insights.spend: Facebook Spend
      session_campaign_mapping.purchases_attributed_to_facebook: Conversions from
        Facebook
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    type: looker_area
    hidden_fields: [session_pg_trk_facts.purchase_session_count, session_campaign_mapping.purchases_attributed_to_google,
      adwords_ad_performance_reports.total_cost]
    sorts: [session_campaign_mapping.session_start_date desc]
    listen:
    - Timeframe: session_campaign_mapping.session_start_date
    -
    -
    row: 48
    col: 0
    width: 12
    height: 7
  - name: Revenue by Channel
    title: Revenue by Channel
    model: marketing_attribution
    explore: session_campaign_mapping
    type: looker_bar
    fields: [session_campaign_mapping.total_session_revenue, user_campaign_facts.attribution_channel]
    pivots: [user_campaign_facts.attribution_channel]
    filters: {}
    sorts: [user_campaign_facts.attribution_channel]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: Revenue, orientation: bottom, series: [{axisId: email - session_campaign_mapping.total_session_revenue,
            id: email - session_campaign_mapping.total_session_revenue, name: email},
          {axisId: facebook - session_campaign_mapping.total_session_revenue, id: facebook
              - session_campaign_mapping.total_session_revenue, name: facebook}, {
            axisId: google - session_campaign_mapping.total_session_revenue, id: google
              - session_campaign_mapping.total_session_revenue, name: google}, {axisId: user_campaign_facts.attribution_channel___null
              - session_campaign_mapping.total_session_revenue, id: user_campaign_facts.attribution_channel___null
              - session_campaign_mapping.total_session_revenue, name: "∅"}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      Google - session_campaign_mapping.total_session_revenue: "#4285F4"
      Facebook - session_campaign_mapping.total_session_revenue: "#3b5998"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Attribution Method: user_campaign_facts.attribution_method
      Timeframe: session_campaign_mapping.session_start_date
    row: 2
    col: 10
    width: 14
    height: 6
  - name: Purchases
    title: Purchases
    model: marketing_attribution
    explore: session_campaign_mapping
    type: single_value
    fields: [session_campaign_mapping.visitor_count, session_campaign_mapping.session_count]
    filters:
      session_pg_trk_facts.is_purchase_event: 'Yes'
    limit: 500
    column_limit: 50
    series_types: {}
    hidden_fields: [session_campaign_mapping.visitor_count]
    listen:
      Attribution Method: user_campaign_facts.attribution_method
      Timeframe: session_campaign_mapping.session_start_date
    row: 5
    col: 5
    width: 5
    height: 3
  - name: Revenue
    title: Revenue
    model: marketing_attribution
    explore: session_campaign_mapping
    type: single_value
    fields: [session_campaign_mapping.total_session_revenue]
    filters: {}
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: Revenue, orientation: bottom, series: [{axisId: email - session_campaign_mapping.total_session_revenue,
            id: email - session_campaign_mapping.total_session_revenue, name: email},
          {axisId: facebook - session_campaign_mapping.total_session_revenue, id: facebook
              - session_campaign_mapping.total_session_revenue, name: facebook}, {
            axisId: google - session_campaign_mapping.total_session_revenue, id: google
              - session_campaign_mapping.total_session_revenue, name: google}, {axisId: user_campaign_facts.attribution_channel___null
              - session_campaign_mapping.total_session_revenue, id: user_campaign_facts.attribution_channel___null
              - session_campaign_mapping.total_session_revenue, name: "∅"}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Attribution Method: user_campaign_facts.attribution_method
      Timeframe: session_campaign_mapping.session_start_date
    row: 2
    col: 5
    width: 5
    height: 3
  - name: Customer Lifetime Value
    title: Customer Lifetime Value
    model: marketing_attribution
    explore: session_campaign_mapping
    type: looker_line
    fields: [session_campaign_mapping.total_session_revenue, user_campaign_facts.attribution_channel,
      user_campaign_facts.days_since_acquisition]
    pivots: [user_campaign_facts.attribution_channel]
    filters: {}
    sorts: [session_campaign_mapping.total_session_revenue desc 0, user_campaign_facts.attribution_channel]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: lifetime_value, label: Lifetime Value, expression: 'running_total(${session_campaign_mapping.total_session_revenue})',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    hidden_fields: [session_campaign_mapping.total_session_revenue]
    listen:
      Attribution Method: user_campaign_facts.attribution_method
    row: 40
    col: 12
    width: 12
    height: 8
  - name: First Touch to Last Touch Analysis
    title: First Touch to Last Touch Analysis
    model: marketing_attribution
    explore: session_campaign_mapping
    type: sankey
    fields: [session_campaign_mapping.conversion_metrics, user_campaign_facts.first_campaign,
      user_campaign_facts.previous_campaign]
    filters: {}
    sorts: [session_campaign_mapping.conversion_metrics desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: right
    series_types: {}
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: monotone
    listen:
      Metrics: session_campaign_mapping.conversion_metric_selector
      Timeframe: session_campaign_mapping.session_start_date
    row: 24
    col: 10
    width: 14
    height: 8
  - name: User Acquisition Trends
    title: User Acquisition Trends
    model: marketing_attribution
    explore: session_campaign_mapping
    type: looker_area
    fields: [session_campaign_mapping.visitor_count, user_campaign_facts.first_campaign_source,
      user_campaign_facts.acquisition_date]
    pivots: [user_campaign_facts.first_campaign_source]
    fill_fields: [user_campaign_facts.acquisition_date]
    sorts: [user_campaign_facts.first_campaign_source 0, user_campaign_facts.acquisition_date]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: converted_visitors_cumulative, label: Converted
          Visitors (Cumulative), expression: 'running_total(${session_campaign_mapping.visitor_count})',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [session_campaign_mapping.visitor_count]
    listen:
      Timeframe: session_campaign_mapping.session_start_date
    row: 16
    col: 10
    width: 14
    height: 8
  - name: First Touch - Acquisition Referrer
    title: First Touch - Acquisition Referrer
    model: marketing_attribution
    explore: session_campaign_mapping
    type: looker_pie
    fields: [session_campaign_mapping.conversion_metrics, user_campaign_facts.first_campaign_source]
    sorts: [session_campaign_mapping.conversion_metrics desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#000000"}]
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    inner_radius: 60
    hidden_fields:
    listen:
      Metrics: session_campaign_mapping.conversion_metric_selector
      Timeframe: session_campaign_mapping.session_start_date
    row: 16
    col: 0
    width: 10
    height: 8
  - name: Last Touch Conversion Referrer
    title: Last Touch Conversion Referrer
    model: marketing_attribution
    explore: session_campaign_mapping
    type: looker_pie
    fields: [session_campaign_mapping.conversion_metrics, user_campaign_facts.previous_campaign_source]
    sorts: [session_campaign_mapping.conversion_metrics desc]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    inner_radius: 60
    series_types: {}
    hidden_fields:
    listen:
      Metrics: session_campaign_mapping.conversion_metric_selector
      Timeframe: session_campaign_mapping.session_start_date
    row: 24
    col: 0
    width: 10
    height: 8
  - name: <font color="#294988" size="6" weight="bold">Customer Behavior</font>
    type: text
    title_text: <font color="#294988" size="6" weight="bold">Customer Behavior</font>
    body_text: ''
    row: 14
    col: 0
    width: 24
    height: 2
  - name: <font color="#294988" size="6" weight="bold">Revenue Attribution</font>
    type: text
    title_text: <font color="#294988" size="6" weight="bold">Revenue Attribution</font>
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Google Revenue vs Cost
    title: Google Revenue vs Cost
    merged_queries:
    - model: marketing_attribution
      explore: session_campaign_mapping
      type: table
      fields: [session_campaign_mapping.facebook_revenue_per_purchase, session_campaign_mapping.google_revenue_per_purchase,
        session_campaign_mapping.purchases_attributed_to_facebook, session_campaign_mapping.purchases_attributed_to_google]
      filters:
        user_campaign_facts.attribution_method: First Touch
        session_campaign_mapping.session_start_date: 30 days
      limit: 500
      column_limit: 50
      dynamic_fields: [{table_calculation: row, label: row, expression: row(), value_format: !!null '',
          value_format_name: !!null '', _kind_hint: dimension, _type_hint: number}]
    - model: marketing_spend
      explore: facebook_insights
      type: table
      fields: [facebook_insights.spend]
      limit: 500
      dynamic_fields: [{table_calculation: row, label: row, expression: row(), value_format: !!null '',
          value_format_name: !!null '', _kind_hint: dimension, _type_hint: number}]
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: row
        source_field_name: row
    - model: marketing_spend
      explore: adwords_campaign_performance_reports
      type: table
      fields: [adwords_campaign_performance_reports.total_cost]
      limit: 500
      dynamic_fields: [{table_calculation: row, label: row, expression: row(), value_format: !!null '',
          value_format_name: !!null '', _kind_hint: dimension, _type_hint: number}]
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: row
        source_field_name: row
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    type: looker_column
    hidden_fields: [session_campaign_mapping.conversions_attributed_to_facebook, session_campaign_mapping.conversions_attributed_to_google,
      facebook_insights.spend, adwords_campaign_performance_reports.total_cost, session_campaign_mapping.purchases_attributed_to_facebook,
      session_campaign_mapping.purchases_attributed_to_google, session_campaign_mapping.facebook_revenue_per_purchase,
      facebook_cac, row]
    dynamic_fields: [{table_calculation: facebook_cac, label: Facebook CAC, expression: "${facebook_insights.spend}\
          \ / ${session_campaign_mapping.purchases_attributed_to_facebook}", value_format: !!null '',
        value_format_name: usd, _kind_hint: measure, _type_hint: number}, {table_calculation: google_cac,
        label: Google CAC, expression: "${adwords_campaign_performance_reports.total_cost}\
          \ / ${session_campaign_mapping.purchases_attributed_to_google}", value_format: !!null '',
        value_format_name: usd, _kind_hint: measure, _type_hint: number}]
    listen:
    - Attribution Method: user_campaign_facts.attribution_method
      Timeframe: session_campaign_mapping.session_start_date
    - Timeframe: facebook_insights.date_start_date
    - Timeframe: adwords_campaign_performance_reports.start_date
    row: 8
    col: 0
    width: 12
    height: 6
  - name: Facebook Revenue vs Cost
    title: Facebook Revenue vs Cost
    merged_queries:
    - model: marketing_attribution
      explore: session_campaign_mapping
      type: table
      fields: [session_campaign_mapping.facebook_revenue_per_purchase, session_campaign_mapping.google_revenue_per_purchase,
        session_campaign_mapping.purchases_attributed_to_facebook, session_campaign_mapping.purchases_attributed_to_google]
      filters:
        user_campaign_facts.attribution_method: First Touch
        session_campaign_mapping.session_start_date: 30 days
      limit: 500
      column_limit: 50
      dynamic_fields: [{table_calculation: row, label: row, expression: row(), value_format: !!null '',
          value_format_name: !!null '', _kind_hint: dimension, _type_hint: number}]
    - model: marketing_spend
      explore: facebook_insights
      type: table
      fields: [facebook_insights.spend]
      limit: 500
      dynamic_fields: [{table_calculation: row, label: row, expression: row(), value_format: !!null '',
          value_format_name: !!null '', _kind_hint: dimension, _type_hint: number}]
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: row
        source_field_name: row
    - model: marketing_spend
      explore: adwords_campaign_performance_reports
      type: table
      fields: [adwords_campaign_performance_reports.total_cost]
      limit: 500
      dynamic_fields: [{table_calculation: row, label: row, expression: row(), value_format: !!null '',
          value_format_name: !!null '', _kind_hint: dimension, _type_hint: number}]
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: row
        source_field_name: row
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    type: looker_column
    hidden_fields: [session_campaign_mapping.conversions_attributed_to_facebook, session_campaign_mapping.conversions_attributed_to_google,
      facebook_insights.spend, adwords_campaign_performance_reports.total_cost, session_campaign_mapping.purchases_attributed_to_facebook,
      session_campaign_mapping.purchases_attributed_to_google, session_campaign_mapping.google_revenue_per_purchase,
      google_cac, row]
    dynamic_fields: [{table_calculation: facebook_cac, label: Facebook CAC, expression: "${facebook_insights.spend}\
          \ / ${session_campaign_mapping.purchases_attributed_to_facebook}", value_format: !!null '',
        value_format_name: usd, _kind_hint: measure, _type_hint: number}, {table_calculation: google_cac,
        label: Google CAC, expression: "${adwords_campaign_performance_reports.total_cost}\
          \ / ${session_campaign_mapping.purchases_attributed_to_google}", value_format: !!null '',
        value_format_name: usd, _kind_hint: measure, _type_hint: number}]
    listen:
    - Attribution Method: user_campaign_facts.attribution_method
      Timeframe: session_campaign_mapping.session_start_date
    - Timeframe: facebook_insights.date_start_date
    - Timeframe: adwords_campaign_performance_reports.start_date
    row: 8
    col: 12
    width: 12
    height: 6
  - name: Total Spend
    title: Total Spend
    merged_queries:
    - model: marketing_spend
      explore: adwords_campaign_performance_reports
      type: single_value
      fields: [adwords_campaign_performance_reports.total_cost]
      limit: 500
      dynamic_fields: [{table_calculation: row, label: row, expression: row(), value_format: !!null '',
          value_format_name: !!null '', _kind_hint: dimension, _type_hint: number}]
      query_timezone: America/Los_Angeles
      series_types: {}
    - model: marketing_spend
      explore: facebook_insights
      type: table
      fields: [facebook_insights.spend]
      limit: 500
      dynamic_fields: [{table_calculation: row, label: row, expression: row(), value_format: !!null '',
          value_format_name: !!null '', _kind_hint: dimension, _type_hint: number}]
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: row
        source_field_name: row
    series_types: {}
    type: single_value
    hidden_fields: [adwords_campaign_performance_reports.total_cost, facebook_insights.spend,
      row]
    sorts: [facebook_insights.spend desc]
    dynamic_fields: [{table_calculation: total_spend, label: Total Spend, expression: "${facebook_insights.spend}+${adwords_campaign_performance_reports.total_cost}",
        value_format: !!null '', value_format_name: usd_0, _kind_hint: measure, _type_hint: number}]
    listen:
    - Timeframe: adwords_campaign_performance_reports.start_date
    - Timeframe: facebook_insights.date_start_date
    row: 2
    col: 0
    width: 5
    height: 3
  filters:
  - name: Metrics
    title: Metrics
    type: field_filter
    default_value: Revenue
    allow_multiple_values: true
    required: false
    model: marketing_attribution
    explore: session_campaign_mapping
    listens_to_filters: []
    field: session_campaign_mapping.conversion_metric_selector
  - name: Attribution Method
    title: Attribution Method
    type: field_filter
    default_value: Last Touch
    allow_multiple_values: true
    required: false
    model: marketing_attribution
    explore: session_campaign_mapping
    listens_to_filters: []
    field: user_campaign_facts.attribution_method
  - name: Timeframe
    title: Timeframe
    type: field_filter
    default_value: 2019/06/21 to 2019/08/01
    allow_multiple_values: true
    required: false
    model: marketing_attribution
    explore: session_campaign_mapping
    listens_to_filters: []
    field: session_campaign_mapping.session_start_date
