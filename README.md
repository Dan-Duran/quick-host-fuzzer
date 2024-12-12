# Quick Host Fuzzer

`Quick Host Fuzzer` is a lightweight, yet powerful, bash script designed for ethical hacking and penetration testing. It allows users to dynamically fuzz subdomains and check their HTTP response status. Whether you're looking for valid subdomains or trying to identify potential vulnerabilities, this script offers an efficient and user-friendly solution.

**This is perfect for Hack The Box and TryHackMe Challenges!!**

## Subscribe to my Channels!
- **👉 Checkout some more awesome tools at [GetCyber](https://getcyber.me/tools)**
- **👉 Subscribe to my YouTube Channel [GetCyber - YouTube](https://youtube.com/getCyber)**
- **👉 Discord Server [GetCyber - Discord](https://discord.gg/YUf3VpDeNH)**

## Features
- **Dynamic Subdomain Fuzzing**: Test subdomains against a given base domain.
- **HTTP Response Filtering**: Include only specific HTTP status codes (e.g., `200`, `403`) for precise results.
- **Progress Tracking**: Real-time updates on the scan progress.
- **Color-Coded Output**: Quickly identify valid and invalid subdomains.
- **Simple Usage**: No dependencies outside of bash and curl.

## How It Works
The script reads a list of subdomains from a wordlist and appends them to a given base domain. It then sends HTTP requests using `curl` with the `Host` header set to the generated subdomain. Based on the server's response, it categorizes the subdomains as valid or invalid. You can filter the results by specifying desired HTTP status codes.

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Dan-Duran/quick-host-fuzzer.git
   cd quick-host-fuzzer
   ```

2. **Make the Script Executable**:
   ```bash
   chmod +x fuzzer.sh
   ```

## Usage

```bash
./fuzzer.sh -u <base-domain> -w <wordlist> [-i <include-status>]
```

### Required Arguments
- `-u`: Base domain to fuzz (e.g., `example.com`).
- `-w`: Wordlist file containing subdomains (e.g., `wordlist.txt`).

### Optional Arguments
- `-i`: Comma-separated HTTP status codes to filter results (e.g., `200,301`).

### Examples

#### 1. Basic Subdomain Fuzzing
Test subdomains against `example.com` using a wordlist:
```bash
./fuzzer.sh -u example.com -w wordlist.txt
```
### Screenshots

![image](https://github.com/user-attachments/assets/abd6e552-7483-42df-9e00-58109bc90339)

![image](https://github.com/user-attachments/assets/7f8c15ad-a8ca-403c-b426-66798082f8cd)

#### 2. Filter by HTTP Status Codes
Only show subdomains that return HTTP status codes `200` or `403`:
```bash
./fuzzer.sh -u example.com -w wordlist.txt -i 200,403
```

#### 3. Large Wordlist Example
Use a large wordlist to fuzz subdomains and track progress:
```bash
./fuzzer.sh -u example.com -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt
```

## Output Format

### Standard Output
The script provides color-coded output for easier readability:
- **Green (Valid)**: Subdomains that return `200` or a user-defined valid status.
- **Red (Invalid)**: Subdomains that return any other HTTP status.

Example:
```plaintext
Valid: dev.example.com -> 200
Invalid: nosubdomain.example.com -> 404
```

### Progress Tracking
For large wordlists, the script updates progress in real-time:
```plaintext
Progress: 100/1000 (10%)
```

## Practical Example
Imagine you're fuzzing subdomains for `example.com`. Using a small wordlist:
```plaintext
admin
dev
staging
test
```
Running:
```bash
./fuzzer.sh -u example.com -w wordlist.txt
```
Output:
```plaintext
Valid: dev.example.com -> 200
Invalid: admin.example.com -> 404
Invalid: staging.example.com -> 404
Invalid: test.example.com -> 404
Scan complete! Processed 4 subdomains.
```

## Key Features in Action

- **Filtered Results**:
  If you specify `-i 200`, only subdomains with a `200` response are displayed.
- **Dynamic Progress**:
  Large wordlists are manageable with real-time progress updates.
- **Simple Dependencies**:
  No additional software required—just bash and curl.

## Why Use This Script?

1. **Efficiency**:
   Quickly scan and identify valid subdomains.

2. **Customizable**:
   Filter results based on HTTP status codes.

3. **User-Friendly**:
   Designed to provide clear and actionable results.

## Limitations
- **DNS Resolution**:
  Ensure proper DNS resolution or `/etc/hosts` configuration for the base domain.
- **Wordlist Quality**:
  Results depend on the quality of the provided wordlist.

## Disclaimer
This script is intended for ethical hacking and educational purposes only. Ensure you have permission to test against a target domain.
