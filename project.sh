#!/bin/bash

# --- Color Configuration (ANSI) ---
NC='\033[0m' # No Color
PRIMARY='\033[1;34m' # Blue
SUCCESS='\033[1;32m' # Green
WARNING='\033[1;33m' # Yellow
ERROR='\033[1;31m'   # Red
TEXT_MUTED='\033[0;37m' # Light Gray

# --- Variables ---
CLIENT_NAME=""
TICKET_COUNT=0

# --- Helper Functions ---
clear_screen() {
    clear
}

print_header() {
    echo -e "${PRIMARY}=============================================${NC}"
    echo -e "${PRIMARY}          RemoteCode Client Service          ${NC}"
    echo -e "${PRIMARY}=============================================${NC}"
    if [ ! -z "$CLIENT_NAME" ]; then
        echo -e "${TEXT_MUTED}Active Session: $CLIENT_NAME | Tickets Logged: $TICKET_COUNT${NC}"
        echo -e "${PRIMARY}--------------------------------------------=${NC}"
    fi
    echo ""
}

press_any_key() {
    echo ""
    read -p "Press [Enter] to return to the main menu..."
}

# --- Menu Actions ---
onboard_client() {
    clear_screen
    print_header
    echo -e "${PRIMARY}[1] Client Onboarding${NC}\n"
    
    read -p "Enter Client/Company Name: " CLIENT_NAME
    if [ -z "$CLIENT_NAME" ]; then
        echo -e "\n${ERROR}Error: Client name cannot be empty.${NC}"
        CLIENT_NAME=""
        press_any_key
        return
    fi
    
    read -p "Enter Client Contact Email: " client_email
    read -p "Enter Primary Project Scope (e.g., Web App, API): " project_scope
    
    # Simulate saving to a database/file
    echo "Client: $CLIENT_NAME | Email: $client_email | Scope: $project_scope" >> clients_db.txt
    
    echo -e "\n${SUCCESS}✓ Client '$CLIENT_NAME' successfully onboarded into RemoteCode system.${NC}"
    press_any_key
}

log_ticket() {
    clear_screen
    print_header
    echo -e "${PRIMARY}[2] Log a Support Ticket${NC}\n"
    
    if [ -z "$CLIENT_NAME" ]; then
        echo -e "${WARNING}⚠ No active client session found. Please onboard or select a client first.${NC}"
        press_any_key
        return
    fi
    
    read -p "Enter issue description: " issue_desc
    read -p "Priority Level (Low/Medium/High): " priority
    
    # Generate random 4-digit ticket ID
    ticket_id=$((1000 + RANDOM % 9000))
    
    # Simulate saving ticket
    echo "Ticket: #$ticket_id | Client: $CLIENT_NAME | Issue: $issue_desc | Priority: $priority" >> tickets_log.txt
    
    ((TICKET_COUNT++))
    
    echo -e "\n${SUCCESS}✓ Ticket #$ticket_id successfully opened for $CLIENT_NAME.${NC}"
    echo -e "${TEXT_MUTED}A remote engineer will review this asynchronously.${NC}"
    press_any_key
}

view_system_status() {
    clear_screen
    print_header
    echo -e "${PRIMARY}[3] RemoteCode Infrastructure Status${NC}\n"
    
    # Simulating a system health check
    echo -e "Checking global network nodes..."
    sleep 0.5
    echo -e "  • US-East Edge Node:      [ ${SUCCESS}ONLINE${NC} ]"
    echo -e "  • EU-Central Edge Node:   [ ${SUCCESS}ONLINE${NC} ]"
    echo -e "  • APAC-South Edge Node:   [ ${SUCCESS}ONLINE${NC} ]"
    echo -e "  • Async Code Repository:  [ ${SUCCESS}OPERATIONAL${NC} ]"
    
    echo -e "\n${SUCCESS}All global systems are operational. Work from anywhere protocols active.${NC}"
    press_any_key
}

# --- Main Program Loop ---
while true; do
    clear_screen
    print_header
    
    echo -e "Please select an option:"
    echo -e "  1) Onboard New Client"
    echo -e "  2) Log Support Ticket"
    echo -e "  3) Check Global Infrastructure Status"
    echo -e "  4) Exit Application"
    echo ""
    read -p "Selection [1-4]: " menu_option
    
    case $menu_option in
        1)
            onboard_client
            ;;
        2)
            log_ticket
            ;;
        3)
            view_system_status
            ;;
        4)
            clear_screen
            echo -e "\n${PRIMARY}Thank you for using RemoteCode Client Service. Ending session.${NC}\n"
            exit 0
            ;;
        *)
            echo -e "\n${ERROR}Invalid option. Please choose between 1 and 4.${NC}"
            sleep 1.5
            ;;
    esac
done
