# Bypass-403
Bash script for bypassing 401/403 responses primarily for bugbounty and testing purposes

![POC](poc.jpg)

## Usage
```bash
./bypass-403.sh https://hackerone.com admin
```

## Features
- 34 known mechanisms to bypass 401/403 status codes
- GET POST PUT CONNECT PATCH OPTIONS HEAD TRACE TRACK methods using `curl`

## Install
```bash
git clone https://github.com/iamj0ker/bypass-403
cd bypass-403
chmod +x bypass-403.sh
./bypass-403.sh https://hostname.com directory2bypass
```

## Responsibility
For personal use only. There are no liabilities for any damages.

## Notable posts
- https://blog.vidocsecurity.com/blog/401-and-403-bypass-how-to-do-it-right/
