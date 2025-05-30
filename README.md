# Bypass-403
Bash script for bypassing 401/403 responses primarily for bugbounty and testing purposes

![POC](poc.jpg)

## Usage
```bash
./bypass-403.sh <target_url> <path> [parallel_processes]
```
Arguments:
  `<target_url>`      : The base URL of the target (e.g., https://hackerone.com)
  `<path>`            : The path to fuzz (e.g., admin, without the leading slash if it's relative to the target_url)
  `[parallel_processes]`: Optional. The number of parallel CPU processes to use with xargs. Defaults to 4.

Example:
```bash
./bypass-403.sh https://example.com /admin 8
```

## Features
- Parallel execution using `xargs` with configurable CPU processes.
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
