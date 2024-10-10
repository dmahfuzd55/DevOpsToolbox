#!/bin/bash

# Find query where firstname customername match customernumber show

db.amendcustomersvalidation.find({ $expr: { $eq: ["$data.customerInfoData.data.FirstName", "$data.customerInfoData.data.CustomerName"] } }, { "customerInfoData.data.CustNumber": 1, _id: 0 })

db.amendcustomersvalidation.find({ $expr: { $eq: ["$data.customerInfoData.data.FirstName", "$data.customerInfoData.data.CustomerName"] } }).count()



filter: 
{
  "$or": [
    {
      "customerInfoData.data.firstName": { "$regex": ".*", "$options": "i" }
    },
    {
      "customerInfoData.data.CustomerName": { "$regex": ".*", "$options": "i" }
    }
  ]
}


{
  "$expr": {
    "$ne": [
      { "$toLower": "$customerInfoData.data.FirstName" },
      { "$toLower": "$customerInfoData.data.CustomerName" }
    ]
  }
}


project: {
    _id: 0,
    "customerInfoData.header.BrchNum": 1,
    "customerInfoData.data.CustNumber": 1, 
    "customerInfoData.data.FirstName": 1, 
    "customerInfoData.data.LastName": 1,
    "customerInfoData.data.AddrLine1": 1,
    "customerInfoData.data.AddrLine2": 1,
    "customerInfoData.data.FatherName": 1,
    "customerInfoData.data.MotherMaidenName": 1,
    "customerInfoData.data.CustomerName": 1,
    "customerInfoData.data.IdNum": 1,
    }


### Multiple value query

({ "Data.LogId": { $in: ["97X07052024101315", "20X07052024115710"] } })