# create basic linear regression model

CREATE OR REPLACE MODEL `SampleDataSetforOSU.CryptoModel`
OPTIONS
  (model_type='linear_reg',
  input_label_cols=['high']) AS
SELECT
  high, low
FROM 
   `osudemoproject-341819.SampleDataSetforOSU.CryptoHistDataFullWithTime`  
WHERE
  high IS NOT NULL



#evaluate model

SELECT
  *
FROM
  ML.EVALUATE(MODEL `SampleDataSetforOSU.CryptoModel`)

# predict results

SELECT
  *
FROM
  ML.PREDICT(MODEL `SampleDataSetforOSU.CryptoModel`,
    (
    SELECT
      high, low
    FROM
      `osudemoproject-341819.SampleDataSetforOSU.CryptoHistDataFullWithTime`
    WHERE
      high IS NOT NULL
      AND time = 1540598400))  


# explain features

SELECT
  *
FROM
  ML.EXPLAIN_PREDICT(MODEL `SampleDataSetforOSU.CryptoModel`,
    (
    SELECT
      high, low
    FROM
      `osudemoproject-341819.SampleDataSetforOSU.CryptoHistDataFullWithTime`
    WHERE
      high IS NOT NULL
      AND time = 1540598400),
    STRUCT(3 as top_k_features))


# include global explain

CREATE OR REPLACE MODEL `SampleDataSetforOSU.CryptoModel`
OPTIONS
  (model_type='linear_reg',
  input_label_cols=['high'],
  enable_global_explain=TRUE) AS
SELECT
  high, low, open, close
FROM
  `osudemoproject-341819.SampleDataSetforOSU.CryptoHistDataFullWithTime`
WHERE
  high IS NOT NULL

# run explainer
SELECT
  *
FROM
  ML.GLOBAL_EXPLAIN(MODEL `SampleDataSetforOSU.CryptoModel`)


# create time series model

CREATE OR REPLACE MODEL SampleDataSetforOSU.CryptoModelTS
OPTIONS
  (model_type = 'ARIMA_PLUS',
   time_series_timestamp_col = 'snapshotdatetime',
   time_series_data_col = 'high',
   auto_arima = TRUE,
   data_frequency = 'AUTO_FREQUENCY',
   decompose_time_series = TRUE
  ) AS
SELECT
  snapshotdatetime,
  high
FROM
  `osudemoproject-341819.SampleDataSetforOSU.CryptoHistDataFullWithTime`

# inspect coefficients

SELECT
 *
FROM
 ML.ARIMA_COEFFICIENTS(MODEL SampleDataSetforOSU.CryptoModelTS)

# run the forecast
SELECT
 *
FROM
 ML.FORECAST(MODEL SampleDataSetforOSU.CryptoModelTS,
             STRUCT(30 AS horizon, 0.8 AS confidence_level))

# explain and visualize forecast results
SELECT
 *
FROM
 ML.EXPLAIN_FORECAST(MODEL SampleDataSetforOSU.CryptoModelTS,
                     STRUCT(30 AS horizon, 0.8 AS confidence_level))