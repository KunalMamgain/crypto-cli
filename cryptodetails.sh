function main(){
  check $@ 
}
list=15
currency="usd"
function check(){
  while getopts ":c:n:h" opt; do
    case $opt in
      n) n="$OPTARG";;
      c) c="$OPTARG";;
      h) help; exit 1;;
      \?)printf "\n"; echo "Command not found";help;exit 1 ;; # Handle error: unknown option or missing required argument.
    esac
  done
#  shift $((OPTIND -1))

echo $OPTARG 
  if [ "$n" = "" ]
  then 
    #echo "crypto curl output"
    display
    exit 1
  else
      list=$n
      display
  fi
}
help(){
printf "\n"
  cat << EOF
  Quickly fetch top 15 cryptocurrencies by market cap right in your terminal.
  
  Usage: $0 -n <number of coins you want>
  Example: $0 -n 20

  -n <number> To display more number of coins [max:250]
  -h          Show this help message and exit
EOF
}
display(){
    #echo $currency
    curl -sS -X GET "https://api.coingecko.com/api/v3/coins/markets?vs_currency=$currency&order=market_cap_desc&per_page=$list&page=1&sparkline=false" -H "accept: application/json"  | jq -r '(["S.No.","Name","Current Price ($)","Change (24H)","ATH ($)","Market Cap ($)"] | (., map(length*"-"))), (.[] | [  ( .market_cap_rank|tostring),.symbol,"$ "+(.current_price|tostring),(.price_change_percentage_24h|tostring)+"%","$ "+(.ath|tostring),"$ "+(.market_cap|tostring)]) | @tsv'| sed 's/	/,|,/g' | column -s ',' -t | sed "s/\( -[0-9]*\.[0-9]*%\)/`tput setaf 9`\1`tput sgr 0`/g" | sed " s/\( [0-9]*\.[0-9]*%\)/`tput setaf 10`\1`tput sgr 0`/g" | sed "1s/\(.*\)/`tput setaf 11`\1`tput sgr0`/g"
}
main $@
