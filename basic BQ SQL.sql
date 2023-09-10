
SELECT 
  *, TIMESTAMP_SECONDS(time) AS snapshotdatetime
FROM 
   `osudemoproject-341819.SampleDataset.CryptoHistDataFull`  

Order by TIMESTAMP_SECONDS(time) asc
limit 100


CREATE TABLE IF NOT EXISTS SampleDataset.CryptoHistwithTime2    
AS    
SELECT *,     
 TIMESTAMP_SECONDS(time) AS snapshotdatetime 
FROM SampleDataset.CryptoHistDataFull