
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


from google.oauth2 import service_account

credentials = service_account.Credentials.from_service_account_info(
# enter service account credentials here
,
)

sql="SELECT * FROM `osudemoproject-341819.SampleDataset.CryptoHistwithTime` LIMIT 10"
df = pandas_gbq.read_gbq(sql, project_id="osudemoproject-341819", credentials=credentials)
df.head()
