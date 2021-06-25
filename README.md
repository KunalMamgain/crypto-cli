<h1 align="center">
Crypto-cli
</h1>
<p align="center">
Quickly fetch top 15 cryptocurrencies by market cap right in your terminal.
<br>
Works on <b>macOS</b> and  <b>Linux</b>
<br>
<img src="./images/demo.gif">
</p>

## Prerequisites
[jq](https://stedolan.github.io/jq/) which is a command line json parser.

## Installation 
### Using `git`
```
 git clone https://github.com/KunalMamgain/crypto-cli
 cd crypto-cli
 chmod +x cryptodetails.sh
 ./cryptodetails.sh
```
## Run it with `curl`
This will only show top 15 cryptocurrencies by default.
```
curl -sS -X GET "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=15&page=1&sparkline=false" -H "accept: application/json"  | jq -r '(["S.No.","Name","Current Price ($)","ATH ($)","Change (24H)","Market Cap ($)"] | (., map(length*"-"))), (.[] | [  ( .market_cap_rank|tostring),.symbol,"$ "+(.current_price|tostring),"$ "+(.ath|tostring),(.price_change_percentage_24h|tostring)+"%","$ "+(.market_cap|tostring)]) | @tsv'| sed 's/	/,|,/g' | column -s ',' -t | sed "s/\( -[0-9]*\.[0-9]*%\)/`tput setaf 9`\1`tput sgr 0`/g" | sed " s/\( [0-9]*\.[0-9]*%\)/`tput setaf 10`\1`tput sgr 0`/g" | sed "1s/\(.*\)/`tput setaf 11`\1`tput sgr0`/g"
```
## Usage
The top 10 cryptocurrencies are shown by default by entering.
```
./cryptodetails.sh
```

For more coins, simply pass a number in n flag as an argument.
```
./cryptodetails.sh -n25 
```

To get a specific price, simply use grep.
```
./cryptodetails.sh -n150 | grep -w ada
```
<small>__note__ use "-i" flag on grep for case insensitive search.<small>

## Future integrations
Done?| Name
:---:| ---
✅| Get user input for number of cryptocurrency to be displayed.
## Reference
- [crypto-cli](https://github.com/dillionverma/crypto-cli) created by [@dillionverma](https://github.com/dillionverma/crypto-cli) was frequently used as reference throughout the development of this project.
## Special Thanks
- Really appreciate all the fantastic works by [coingecko-api](https://github.com/miscavage/CoinGecko-API), which provide super useful utilities supporting this project.

