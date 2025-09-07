# create basic linear regression model

CREATE OR REPLACE MODEL `crypto_dataset.CryptoModel`
OPTIONS
  (model_type='linear_reg',
  input_label_cols=['high']) AS
SELECT
  high, low
FROM 
   `osu-demo-project-2025.crypto_dataset.crypto_history`  
WHERE
  high IS NOT NULL



#evaluate model

SELECT
  *
FROM
  ML.EVALUATE(MODEL `crypto_dataset.CryptoModel`)

# predict results

SELECT
  *
FROM
  ML.PREDICT(MODEL `crypto_dataset.CryptoModel`,
    (
    SELECT
      timestamp, high, low
    FROM
      `osu-demo-project-2025.crypto_dataset.crypto_history`
    WHERE
      high IS NOT NULL
      AND timestamp = '2025-01-02'))  


# explain features

SELECT
  *
FROM
  ML.EXPLAIN_PREDICT(MODEL `crypto_dataset.CryptoModel`,
    (
    SELECT
      high, low
    FROM
      `osu-demo-project-2025.crypto_dataset.crypto_history`
    WHERE
      high IS NOT NULL
      AND timestamp = '2025-01-02'),
    STRUCT(3 as top_k_features))


# include global explain

CREATE OR REPLACE MODEL `crypto_dataset.CryptoModel`
OPTIONS
  (model_type='linear_reg',
  input_label_cols=['high'],
  enable_global_explain=TRUE) AS
SELECT
  high, low, open, close
FROM
  `osu-demo-project-2025.crypto_dataset.crypto_history`
WHERE
  high IS NOT NULL

# run explainer
SELECT
  *
FROM
  ML.GLOBAL_EXPLAIN(MODEL `crypto_dataset.CryptoModel`)


# create time series model

CREATE OR REPLACE MODEL crypto_dataset.CryptoModelTimeSeries
OPTIONS
  (model_type = 'ARIMA_PLUS',
   time_series_timestamp_col = 'timestamp',
   time_series_data_col = 'high',
   auto_arima = TRUE,
   data_frequency = 'AUTO_FREQUENCY',
   decompose_time_series = TRUE
  ) AS
SELECT
  timestamp,
  high
FROM
  `osu-demo-project-2025.crypto_dataset.crypto_history`

# inspect coefficients

SELECT
 *
FROM
 ML.ARIMA_COEFFICIENTS(MODEL crypto_dataset.CryptoModelTimeSeries)

# run the forecast
SELECT
 *
FROM
 ML.FORECAST(MODEL crypto_dataset.CryptoModelTimeSeries,
             STRUCT(30 AS horizon, 0.8 AS confidence_level))

# explain and visualize forecast results
SELECT
 *
FROM
 ML.EXPLAIN_FORECAST(MODEL crypto_dataset.CryptoModelTimeSeries,
                     STRUCT(30 AS horizon, 0.8 AS confidence_level))