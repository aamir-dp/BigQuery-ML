#standardSQL
SELECT
  traffic_source.name AS CampaignName,
  traffic_source.source AS TrafficSource,
  traffic_source.medium AS TrafficMedium,
  COUNT(1) AS EventCount
FROM
  `your_project.your_dataset.events_*`
WHERE
  _TABLE_SUFFIX BETWEEN '20250101' AND '20250131'
  AND traffic_source.source = 'google'
  AND traffic_source.name IS NOT NULL
GROUP BY
  CampaignName, TrafficSource, TrafficMedium
ORDER BY
  EventCount DESC;
