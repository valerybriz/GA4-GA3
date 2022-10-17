-- With this query we can get the actual type of the value per parameter, it can be used also for user_properties or other objects with the same structure
SELECT
  event_name,
  params.key AS event_parameter_key,
  CASE
    WHEN params.value.string_value IS NOT NULL THEN 'string'
    WHEN params.value.int_value IS NOT NULL THEN 'int'
    WHEN params.value.double_value IS NOT NULL THEN 'double'
    WHEN params.value.float_value IS NOT NULL THEN 'float'
END
  AS event_parameter_value
FROM
  -- Change this to your Google Analytics 4 export location in BigQuery
  `ga4.analytics_<YOUR_ID>.events_*`,
  UNNEST(event_params) AS params
WHERE
  -- Define static and/or dynamic start and end date
  _table_suffix BETWEEN '20221001'
  AND FORMAT_DATE('%Y%m%d',DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))
GROUP BY
  1,
  2,
  3
ORDER BY
  1,
  2
