- dashboard: facebook_ads_overview
  title: Facebook Ads Overview
  layout: newspaper
  elements:
  - name: Total Clicks
    title: Total Clicks
    model: facebook_ads
    explore: facebook_insights
    type: single_value
    fields:
    - facebook_insights.clicks
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 0
    col: 18
    width: 6
    height: 2
  - name: Total Spend
    title: Total Spend
    model: facebook_ads
    explore: facebook_insights
    type: single_value
    fields:
    - facebook_insights.spend
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 0
    col: 0
    width: 6
    height: 2
  - name: Campaign Count
    title: Campaign Count
    model: facebook_ads
    explore: facebook_insights
    type: single_value
    fields:
    - facebook_ads.campaign_count
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 0
    col: 12
    width: 6
    height: 2
  - name: Ads Count
    title: Ads Count
    model: facebook_ads
    explore: facebook_insights
    type: single_value
    fields:
    - facebook_ads.count
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 0
    col: 6
    width: 6
    height: 2
  - name: Cost per Click
    title: Cost per Click
    model: facebook_ads
    explore: facebook_insights
    type: single_value
    fields:
    - facebook_insights.cost_per_click
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 2
    col: 6
    width: 6
    height: 2
  - name: Click Through Rate
    title: Click Through Rate
    model: facebook_ads
    explore: facebook_insights
    type: single_value
    fields:
    - facebook_insights.click_through_rate
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 2
    col: 12
    width: 6
    height: 2
  - name: Total Impressions
    title: Total Impressions
    model: facebook_ads
    explore: facebook_insights
    type: single_value
    fields:
    - facebook_insights.impressions
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 2
    col: 0
    width: 6
    height: 2
  - name: Daily Performance
    title: Daily Performance
    model: facebook_ads
    explore: facebook_insights
    type: looker_line
    fields:
    - facebook_insights.impressions
    - facebook_insights.date_start_date
    - facebook_insights.cost_per_click
    - facebook_insights.spend
    sorts:
    - facebook_insights.date_start_date
    limit: 5000
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    y_axes:
    - label:
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: facebook_insights.cost_per_click
        name: Cost per Click
    - label:
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: facebook_insights.spend
        name: Spend
    - label: ''
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: facebook_insights.impressions
        name: Impressions
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 4
    col: 0
    width: 18
    height: 8
  - name: Average Frequency
    title: Average Frequency
    model: facebook_ads
    explore: facebook_insights
    type: single_value
    fields:
    - facebook_insights.average_frequency
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 2
    col: 18
    width: 6
    height: 2
  - name: Impressions by Campaign Type
    title: Impressions by Campaign Type
    model: facebook_ads
    explore: facebook_insights
    type: looker_pie
    fields:
    - facebook_campaigns.buying_type
    - facebook_insights.impressions
    sorts:
    - facebook_campaigns.buying_type
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: insights.impressions
        name: Impressions
    - label:
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: insights.clicks
        name: Clicks
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: insights.cost_per_click
        name: Cost per Click
    series_types: {}
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 4
    col: 18
    width: 6
    height: 8
  - name: Campaign Performance (Top 10 by Impression Count)
    title: Campaign Performance (Top 10 by Impression Count)
    model: facebook_ads
    explore: facebook_insights
    type: looker_column
    fields:
    - facebook_campaigns.name
    - facebook_insights.impressions
    - facebook_insights.clicks
    - facebook_insights.cost_per_click
    sorts:
    - facebook_insights.impressions desc
    limit: 10
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: facebook_insights.impressions
        name: Impressions
    - label:
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: facebook_insights.clicks
        name: Clicks
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: facebook_insights.cost_per_click
        name: Cost per Click
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 12
    col: 0
    width: 24
    height: 8
  - name: Campaign Overview
    title: Campaign Overview
    model: facebook_ads
    explore: facebook_insights
    type: table
    fields:
    - facebook_campaigns.name
    - facebook_insights.impressions
    - facebook_insights.average_frequency
    - facebook_insights.clicks
    - facebook_insights.click_through_rate
    - facebook_insights.cost_per_click
    sorts:
    - facebook_insights.impressions desc
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_ignored_fields:
    - insights.average_frequency
    - insights.impressions
    - insights.clicks
    - insights.click_through_rate
    - facebook_insights.click_through_rate
    - facebook_insights.clicks
    - facebook_insights.average_frequency
    - facebook_insights.impressions
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    conditional_formatting:
    - type: high to low
      value:
      background_color:
      font_color:
      palette:
        name: Red to White
        colors:
        - "#F36254"
        - "#FFFFFF"
      bold: false
      italic: false
      strikethrough: false
    listen:
      Campaign Name: facebook_campaigns.name
      Insights Start Date: facebook_insights.date_start_date
    row: 20
    col: 0
    width: 24
    height: 8
  filters:
  - name: Campaign Name
    title: Campaign Name
    type: field_filter
    default_value:
    model: facebook_ads
    explore: facebook_ads
    field: facebook_campaigns.name
    listens_to_filters: []
    allow_multiple_values: true
  - name: Insights Start Date
    title: Insights Start Date
    type: date_filter
    default_value: ''
    model:
    explore:
    field:
    listens_to_filters: []
    allow_multiple_values: true
