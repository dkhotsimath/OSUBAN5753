# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

# get data from crypto API under DK's account. Use your own API key param.

import requests

def get_data():
    crypto_api_url = "https://min-api.cryptocompare.com/data/price"
    payload = {'fsym': 'BTC', 'tsyms': 'USD', 'api_key': '31e1ecf5b68d157a68720a13dff010390f3295cffd89f93645e56059aed71d24'}
    request_data = requests.get(crypto_api_url,params=payload)
    return request_data.json()

CryptoAPIDataResponse = get_data()

# convert it into JSON
import json

CryptoAPIDataResponseJSON = json.dumps(CryptoAPIDataResponse)

print(CryptoAPIDataResponseJSON)

# load into Event Hub in imathco (use your own for the exercise)

import nest_asyncio
nest_asyncio.apply()

import asyncio
from azure.eventhub.aio import EventHubProducerClient
from azure.eventhub import EventData

async def run():
    # Create a producer client to send messages to the event hub.
    # Specify a connection string to your event hubs namespace and
 	    # the event hub name.
    producer = EventHubProducerClient.from_connection_string(conn_str="Endpoint=sb://osueventhubns.servicebus.windows.net/;SharedAccessKeyName=OSU-crypto-eventhub-ap;SharedAccessKey=Yfwp3uW/T/AP7gVtivV1wIhXu/3gYvcnbEhESknou8c=;EntityPath=cryptohub", eventhub_name="cryptohub")
    async with producer:
        # Create a batch.
        event_data_batch = await producer.create_batch()

        # Add events to the batch.
        event_data_batch.add(EventData(CryptoAPIDataResponseJSON))

        # Send the batch of events to the event hub.
        await producer.send_batch(event_data_batch)

loop = asyncio.get_event_loop()
loop.run_until_complete(run())


