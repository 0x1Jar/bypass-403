# Bypass-403
Bash script for bypassing 401/403 responses primarily for bugbounty and testing purposes

![POC](poc.jpg)

## Usage
```bash
./bypass-403.sh https://hackerone.com admin
```

## Features
- Use 34 known Bypasses mechanism for 401/403 status codes using `curl`
- GET POST PUT CONNECT PATCH OPTIONS HEAD TRACE TRACK methods

## Install
```bash
git clone https://github.com/iamj0ker/bypass-403
cd bypass-403
chmod +x bypass-403.sh
./bypass-403.sh https://hostname.com directory2bypass
```

## Contributers
Project forked from [iamj0ker](https://github.com/iamj0ker/bypass-403) for personal use.

## Notable posts
- https://blog.vidocsecurity.com/blog/401-and-403-bypass-how-to-do-it-right/
