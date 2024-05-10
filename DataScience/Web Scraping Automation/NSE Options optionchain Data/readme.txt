https://www.youtube.com/watch?v=a3we7QAHSfQ&list=PLqJd-cgHAQeKnuerBjfpMhRWKiNYOkwcr
https://www.nseindia.com/option-chain
https://www.nseindia.com/api/option-chain-indices?symbol=NIFTY



let cookies=()=>

in 
    cookies


let
    Source = Json.Document(Web.Contents("https://www.nseindia.com/api/option-chain-indices?symbol=NIFTY", [Headers=[#"Accept-Encoding"="gzip, deflate", #"Accept-Language"="en-US,en", #"User-Agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36 OPR/68.0.3618.206", Cookie="8A87B46ABA4CAFF3B69F913708597828~xM8YKIspOw4k2OTekhqVI8Ft8AHi/RYKbvLqfKirkbafd1XOqJELenPBKr4Y+FAgbqei34v6NKmWyp1RWvhDhh2jrLXAela7ZdmyrHShEPCaVopVDul8R91B2SbFshwrUsS7yKn5+cmpmaF25zGeiAjHTfTMnii7F2E1slCnkEo="]])),
    records = Source[records],
    data = records[data],
    #"Converted to Table" = Table.FromList(data, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to Table", "Column1", {"strikePrice", "expiryDate", "CE", "PE"}, {"strikePrice", "expiryDate", "CE", "PE"})
in
    #"Expanded Column1"





