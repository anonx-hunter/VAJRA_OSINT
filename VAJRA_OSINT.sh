#!/bin/bash

# VAJRA THE ONLY OSINT SOLUTION
# Author: Anonx-Hunter (Vineet) & DigitalValkyrie (Monika)
# Usage: ./VAJRA_OSINT.sh [organization_name]

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check if organization name is provided
if [ -z "$1" ]; then
    echo -e "${RED}Usage: ./VAJRA_OSINT.sh [organization_name]${NC}"
    exit 1
fi

TARGET=$1
TARGET_DOMAIN=$(echo $TARGET | awk -F/ '{print $3}')
OUTPUT_DIR="$TARGET-osint-report"
mkdir -p $OUTPUT_DIR

# Function for banner display
banner() {
    echo -e "${CYAN}"
    echo "=========================================="
    echo "       VAJRA THE ONLY OSINT SOLUTION      "
    echo "=========================================="
    echo -e "${NC}"
}

# 1. Domain Information
domain_info() {
    echo -e "${YELLOW}[+] Gathering Domain Information for $TARGET${NC}"
    whois -d $TARGET > $OUTPUT_DIR/domain_info.txt
    echo -e "${GREEN}[+] Domain information saved to domain_info.txt${NC}"
}

# 2. Subdomain Enumeration
subdomain_enum() {
    echo -e "${YELLOW}[+] Enumerating Subdomains using Sublist3r${NC}"
    subfinder -d $TARGET -o $OUTPUT_DIR/subdomains.txt
    echo -e "${GREEN}[+] Subdomains saved to subdomains.txt${NC}"
}

# 3. Advanced Subdomain Enumeration with Amass
#amass_enum() {
#    echo -e "${YELLOW}[+] Running Amass for comprehensive subdomain enumeration${NC}"
#    amass enum -d $TARGET -o $OUTPUT_DIR/amass_subdomains.txt
#    echo -e "${GREEN}[+] Amass results saved to amass_subdomains.txt${NC}"
#}

# 4. Web Server Analysis with WhatWeb
web_analysis() {
    echo -e "${YELLOW}[+] Analyzing Web Server with WhatWeb${NC}"
    whatweb $TARGET -v > $OUTPUT_DIR/whatweb_analysis.txt
    echo -e "${GREEN}[+] Web analysis saved to whatweb_analysis.txt${NC}"
}

# 5. Email Harvesting with theHarvester
email_harvest() {
    echo -e "${YELLOW}[+] Harvesting Emails with theHarvester${NC}"
    theHarvester -d $TARGET -l 500 -f $OUTPUT_DIR/theharvester.html
    echo -e "${GREEN}[+] Emails and metadata saved to theharvester.html${NC}"
}

# 6. Metadata Extraction with Metagoofil
metadata_extract() {
    echo -e "${YELLOW}[+] Extracting Metadata from Public Documents using Metagoofil${NC}"
    metagoofil -d $TARGET -t pdf,docx,xlsx,pptx -o $OUTPUT_DIR/metagoofil/
    echo -e "${GREEN}[+] Metadata extraction completed. Check metagoofil directory${NC}"
}

# 7. Social Media Search with Sherlock
social_media_search() {
    echo -e "${YELLOW}[+] Searching for Social Media Accounts using Sherlock${NC}"
    sherlock $TARGET > $OUTPUT_DIR/sherlock_social_media.txt
    echo -e "${GREEN}[+] Social media results saved to sherlock_social_media.txt${NC}"
}

# 8. Web Crawler with Photon
web_crawler() {
    echo -e "${YELLOW}[+] Crawling website with Photon for OSINT data${NC}"
    photon -u $TARGET -o $OUTPUT_DIR/photon_data
    echo -e "${GREEN}[+] Photon data saved in photon_data directory${NC}"
}

# 9. Recon-ng Automated Recon
recon() {
    echo -e "${YELLOW}[+] Running Bazz Framework for automated reconnaissance${NC}"
    /home/kali/mytools/Bazz.sh -t medium $TARGET > $OUTPUT_DIR/recon_output.txt
    echo -e "${GREEN}[+] Recon-ng output saved to recon-ng_output.txt${NC}"
}

# 10. Network Scanning with Nmap
nmap_scan() {
    echo -e "${YELLOW}[+] Performing Network Scan with Nmap${NC}"
    nmap -sC -sV -oN $OUTPUT_DIR/nmap_scan.txt $TARGET
    echo -e "${GREEN}[+] Nmap scan results saved to nmap_scan.txt${NC}"
}

# 11. Shodan Search for Network Devices
shodan_search() {
    echo -e "${YELLOW}[+] Searching Shodan for exposed devices${NC}"
    shodan search $TARGET > $OUTPUT_DIR/shodan_results.txt
    echo -e "${GREEN}[+] Shodan search results saved to shodan_results.txt${NC}"
}

# 12. Summary Report
generate_summary() {
    echo -e "${YELLOW}[+] Generating Summary Report${NC}"
    cat $OUTPUT_DIR/*.txt > $OUTPUT_DIR/summary_report.txt
    echo -e "${GREEN}[+] Summary report saved to summary_report.txt${NC}"
}

# Display the banner
banner

# Execute functions ------------ Testing Phase
domain_info
subdomain_enum
amass_enum
web_analysis
email_harvest
metadata_extract
social_media_search
web_crawler
recon_ng
nmap_scan
shodan_search
generate_summary

echo -e "${GREEN}[+] OSINT Information Gathering Completed. Check $OUTPUT_DIR for reports.${NC}"
