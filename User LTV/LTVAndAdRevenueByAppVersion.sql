#standardSQL
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
    _TABLE_SUFFIX BETWEEN '20240101' AND '20250131'
    AND traffic_source.name IS NOT NULL
    AND traffic_source.source = 'google'
    AND traffic_source.medium = 'cpc'
    AND app_info.version = '1.0.0'
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
