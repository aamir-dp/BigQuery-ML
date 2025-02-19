# Google BigQuery Analytics Query

## Overview
This document provides SQL queries for analyzing Google Ads campaign performance in Google BigQuery using GA4 export schema. It includes queries to extract user acquisition details, lifetime value (LTV), and ad revenue, filtered by campaign, traffic source, and app version.

## Queries

### 1. Extracting Campaign Performance with LTV and Ad Revenue
This query retrieves campaign data for Google Ads traffic, filtering by app version **5.7.4**. It aggregates:
- **User Count** (distinct users per campaign)
- **Lifetime Value (LTV)** from `user_ltv.revenue`
- **Estimated Ad Revenue** from `publisher.ad_revenue_in_usd`

#### SQL Query
```sql
WITH campaign_data AS (
  SELECT
    user_pseudo_id,
    traffic_source.name AS CampaignName,
    traffic_source.source AS TrafficSource,
    traffic_source.medium AS TrafficMedium,
    IFNULL(user_ltv.revenue, 0) AS LTV,
    IFNULL(publisher.ad_revenue_in_usd, 0) AS AdRevenue
  FROM
    `your_project.your_dataset.events_*`
  WHERE
    _TABLE_SUFFIX BETWEEN '20230101' AND '20230131'
    AND traffic_source.name IS NOT NULL
    AND traffic_source.source = 'google'
    AND traffic_source.medium = 'cpc'
    AND app_info.version = '5.7.4'
)

SELECT
  CampaignName,
  TrafficSource,
  TrafficMedium,
  COUNT(DISTINCT user_pseudo_id) AS UserCount,
  SUM(LTV) AS TotalLTV,
  SUM(AdRevenue) AS TotalAdRevenue
FROM campaign_data
GROUP BY
  CampaignName, TrafficSource, TrafficMedium
ORDER BY
  UserCount DESC;
```

## Parameters
- **`your_project.your_dataset.events_*`** → Replace with your actual BigQuery project and dataset.
- **Date Range** → Adjust `_TABLE_SUFFIX BETWEEN 'YYYYMMDD' AND 'YYYYMMDD'` to your required timeframe.
- **Filters**
  - Only includes Google Ads traffic (`source = 'google' AND medium = 'cpc'`).
  - Limits data to app version **5.7.4**.

## Output Fields
- **CampaignName** → Name of the Google Ads campaign.
- **TrafficSource** → Source of the traffic (Google Ads).
- **TrafficMedium** → Medium (e.g., `cpc` for paid search).
- **UserCount** → Number of unique users acquired through the campaign.
- **TotalLTV** → Sum of user lifetime value (revenue).
- **TotalAdRevenue** → Sum of estimated ad revenue generated from impressions.

## Notes
- Ensure that your BigQuery dataset contains GA4 event exports before running the query.
- `publisher.ad_revenue_in_usd` is populated only for ad impression events, so some campaigns may show `0` ad revenue if no impressions were recorded.

## License
This script is provided under the MIT License. You are free to use and modify it for your analytics needs.

---
For any issues or further optimizations, feel free to contribute or reach out.

