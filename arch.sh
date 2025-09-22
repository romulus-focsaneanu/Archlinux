#!/bin/bash

# Cleaning the TTY
clear

# Cosmetics (colours for text).
BOLD='\e[1m'
RED='\e[91m'
BLUE='\e[34m'  
GREEN='\e[92m'
YELLOW='\e[93m'
LYELLOW='\e[33m'
CYAN='\e[36m'
RESET='\e[0m'

echo -ne "${CYAN} $(cat << 'EOF'








                                                                                                                        x+                                       
                                                                                                                        xx                                       
                                                                                                                       xxx+                                      
                                                                                                                      xx+x++                                     
                                                                                                                     xxxxxx++                                    
                                                                                                                     +++xxx+++                                   
                                                                                                                    ++++++xx++                                   
                                                                                                                   x+++++++++++                                  
                                                                                                                  x+++++++++++++                                 
                                                                                                                  +++++++++++++++                                
                                                                                                                 +++++++++++++++++                               
                                                                                                                ++++++++++++++++++                               
                                                                                                               ++++++++++++++++++++                              
                                                                                                                 +++++++++++++++++++                             
                                                                                                             +++  +++++++++++++++++++                            
                                                                                                            +++++++ ++++++++++++++++++                           
                                                                                                            ++++++++++ ++++++++++++++++                          
                                                                                                           +++++++++++++++++++++++++++++                         
                                                                                                          +++++++++++++++++++++++++++++;+                        
                                                                                                         +++++++++++++++++++++++++++++++;+                       
                                                                                                        +++++++++++++++++++++++++++++++++;+                      
                                                                                                       ++++++++++++++xxxxxxxxxxxxxxxx+++++;+                     
                                                                                                      +;;;+;;+++xxxxxxxxxxxxxxxxxxxxxxxxxxx+                     
                                                                                                     +;;+;++xxxxx+xxx+xx+xx+xx+xx+xx+xxxxxxx+                    
                                                                                                    +;;+xxxxx+xxxxx+xxxxxxxxxxxxxxxxxx+xx+xxx+                   
                                                                                                   ++xxx+xxxxxx+xxxxxx+xx+xx+xx+xx+xxxxxxxx+xx+                  
                                                                                                  xx+xxxxx+xxxxxx+xxx+       xxxxxxx+xx+xxxxxxxx                 
                                                                                                 xxxxx+xxxxx+xxxxxxx           xx+xxxxxxx+xx+xxxx                
                                                                                                xx+xxxxx+xxxxx+xxxx             xxx+xx+xxxxxxx+xxx               
                                                                                               xxxxx+xxxxx+xxxxx+x               xxxxxxx+xx+xxxx+xx              
                                                                                              xx+xxxxx+xxxxx+xxxx                xxx+xxxxxxxx+xxxxxx             
                                                                                             xxxxx+xxxxx+xxxxx+xx                 xxxx+xx+xxxxx+xx+xx            
                                                                                            xx+xxxxx+xxxxx+xxxxx                  xxxxxxxxx+xxxxxxxxxx           
                                                                                           xxxxx+xxxxx+xxxxx+xxx                  xx+xx+xxxxx+xxxx  xxx          
                                                                                          xx+xxxxx+xxxxx+xxxxx+x                  xxxxxxx+xxxxxx+xxxx            
                                                                                         xxxxx+xxxxx+xxxxx+xxxxxx                 xxx+xxxxx+xx+xxxxxxxx          
                                                                                        xxx+xxxx+xxxxx+xxxxx+xx+x                 xxxxx+xxxxxxxxx+xx+xxxx        
                                                                                       xxxxxx+xxxx+xxxxx+xx                            xx+xx+xx+xxxxxx+xxxx      
                                                                                      xx+xxxxxx+xxxxxx                                      xxxxxx+xxxxx+xxx     
                                                                                     xxxxx+xxxxxx                                                xxx+xxxxx+xx    
                                                                                    xx+xxxxxx                                                        xx+xxxxxx   
                                                                                   xxxxx+x                                                              +xx+xxx  
                                                                                  xxxx                                                                      xxxx 
                                                                                 xx                                                                            xx
     
     
     
     
     
     
     
                                                                                  A simple script made in order to simplify the process of installing Arch Linux
                                                                                                                                                                





Author: Romulus Focsaneanu
Website: https://github.com/romulus-focsaneanu/Archlinux
  


EOF
)
${RESET}"

sleep 25

# Cleaning the TTY
clear

# Define regions, countries, corresponding timezones, and languages
echo "Setting timezone and language"
declare -A regions
declare -A timezones
declare -A locales

# Populate regions and countries
regions["America"]="United States Canada Mexico Brazil Argentina Chile Colombia Cuba Dominican Republic Ecuador El Salvador Guatemala Honduras Nicaragua Panama Paraguay Peru Uruguay Venezuela"
regions["Europe"]="Albania Andorra Austria Belarus Belgium Bosnia and Herzegovina Bulgaria Croatia Cyprus Czech Republic Denmark Estonia Finland France Germany Greece Hungary Iceland Ireland Italy Latvia Lithuania Luxembourg Malta Netherlands Norway Poland Portugal Romania Slovakia Slovenia Spain Sweden Switzerland United Kingdom Ukraine"
regions["South America"]="Argentina Bolivia Brazil Chile Colombia Ecuador Guyana Paraguay Peru Suriname Uruguay Venezuela"
regions["Africa"]="Algeria Angola Benin Botswana Burkina Faso Burundi Cabo Verde Cameroon Central African Republic Chad Comoros Congo (Congo-Brazzaville) Democratic Republic of the Congo Djibouti Egypt Equatorial Guinea Eritrea Eswatini Ethiopia Gabon Gambia Ghana Guinea Guinea-Bissau Ivory Coast Kenya Lesotho Liberia Libya Madagascar Malawi Mali Mauritania Mauritius Morocco Mozambique Namibia Niger Nigeria Rwanda São Tomé and Príncipe Senegal Seychelles Sierra Leone Somalia South Africa South Sudan Sudan Tanzania Togo Tunisia Uganda Zambia Zimbabwe"
regions["Asia"]="Afghanistan Armenia Azerbaijan Bahrain Bangladesh Bhutan Brunei Cambodia China Cyprus Georgia India Indonesia Iran Iraq Israel Japan Jordan Kazakhstan Kuwait Kyrgyzstan Laos Lebanon Malaysia Maldives Mongolia Myanmar Nepal North Korea Oman Pakistan Palestine Philippines Qatar Saudi Arabia Singapore South Korea Sri Lanka Syria Taiwan Tajikistan Thailand Timor-Leste Turkmenistan United Arab Emirates Uzbekistan Vietnam Yemen"

# Populate timezones corresponding to countries
timezones["United States"]="America/New_York"
timezones["Canada"]="America/Toronto"
timezones["Mexico"]="America/Mexico_City"
timezones["Brazil"]="America/Sao_Paulo"
timezones["Argentina"]="America/Argentina/Buenos_Aires"
timezones["Chile"]="America/Santiago"
timezones["Colombia"]="America/Bogota"
timezones["Cuba"]="America/Havana"
timezones["Dominican Republic"]="America/Santo_Domingo"
timezones["Ecuador"]="America/Guayaquil"
timezones["El Salvador"]="America/El_Salvador"
timezones["Guatemala"]="America/Guatemala"
timezones["Honduras"]="America/Tegucigalpa"
timezones["Nicaragua"]="America/Managua"
timezones["Panama"]="America/Panama"
timezones["Paraguay"]="America/Asuncion"
timezones["Peru"]="America/Lima"
timezones["Uruguay"]="America/Montevideo"
timezones["Venezuela"]="America/Caracas"

timezones["Albania"]="Europe/Tirane"
timezones["Andorra"]="Europe/Andorra"
timezones["Austria"]="Europe/Vienna"
timezones["Belarus"]="Europe/Minsk"
timezones["Belgium"]="Europe/Brussels"
timezones["Bosnia and Herzegovina"]="Europe/Sarajevo"
timezones["Bulgaria"]="Europe/Sofia"
timezones["Croatia"]="Europe/Zagreb"
timezones["Cyprus"]="Asia/Nicosia"
timezones["Czech Republic"]="Europe/Prague"
timezones["Denmark"]="Europe/Copenhagen"
timezones["Estonia"]="Europe/Tallinn"
timezones["Finland"]="Europe/Helsinki"
timezones["France"]="Europe/Paris"
timezones["Germany"]="Europe/Berlin"
timezones["Greece"]="Europe/Athens"
timezones["Hungary"]="Europe/Budapest"
timezones["Iceland"]="Atlantic/Reykjavik"
timezones["Ireland"]="Europe/Dublin"
timezones["Italy"]="Europe/Rome"
timezones["Latvia"]="Europe/Riga"
timezones["Lithuania"]="Europe/Vilnius"
timezones["Luxembourg"]="Europe/Luxembourg"
timezones["Malta"]="Europe/Valletta"
timezones["Netherlands"]="Europe/Amsterdam"
timezones["Norway"]="Europe/Oslo"
timezones["Poland"]="Europe/Warsaw"
timezones["Portugal"]="Europe/Lisbon"
timezones["Romania"]="Europe/Bucharest"
timezones["Slovakia"]="Europe/Bratislava"
timezones["Slovenia"]="Europe/Ljubljana"
timezones["Spain"]="Europe/Madrid"
timezones["Sweden"]="Europe/Stockholm"
timezones["Switzerland"]="Europe/Zurich"
timezones["United Kingdom"]="Europe/London"
timezones["Ukraine"]="Europe/Kiev"

timezones["Algeria"]="Africa/Algiers"
timezones["Angola"]="Africa/Luanda"
timezones["Benin"]="Africa/Porto-Novo"
timezones["Botswana"]="Africa/Gaborone"
timezones["Burkina Faso"]="Africa/Ouagadougou"
timezones["Burundi"]="Africa/Gitega"
timezones["Cabo Verde"]="Atlantic/Cape_Verde"
timezones["Cameroon"]="Africa/Douala"
timezones["Central African Republic"]="Africa/Bangui"
timezones["Chad"]="Africa/Ndjamena"
timezones["Comoros"]="Indian/Comoro"
timezones["Congo (Congo-Brazzaville)"]="Africa/Brazzaville"
timezones["Democratic Republic of the Congo"]="Africa/Kinshasa"
timezones["Djibouti"]="Africa/Djibouti"
timezones["Egypt"]="Africa/Cairo"
timezones["Equatorial Guinea"]="Africa/Malabo"
timezones["Eritrea"]="Africa/Asmara"
timezones["Eswatini"]="Africa/Mbabane"
timezones["Ethiopia"]="Africa/Addis_Ababa"
timezones["Gabon"]="Africa/Libreville"
timezones["Gambia"]="Africa/Banjul"
timezones["Ghana"]="Africa/Accra"
timezones["Guinea"]="Africa/Conakry"
timezones["Guinea-Bissau"]="Africa/Bissau"
timezones["Ivory Coast"]="Africa/Abidjan"
timezones["Kenya"]="Africa/Nairobi"
timezones["Lesotho"]="Africa/Maseru"
timezones["Liberia"]="Africa/Monrovia"
timezones["Libya"]="Africa/Tripoli"
timezones["Madagascar"]="Indian/Antananarivo"
timezones["Malawi"]="Africa/Blantyre"
timezones["Mali"]="Africa/Bamako"
timezones["Mauritania"]="Africa/Nouakchott"
timezones["Mauritius"]="Indian/Mauritius"
timezones["Morocco"]="Africa/Casablanca"
timezones["Mozambique"]="Africa/Maputo"
timezones["Namibia"]="Africa/Windhoek"
timezones["Niger"]="Africa/Niamey"
timezones["Nigeria"]="Africa/Lagos"
timezones["Rwanda"]="Africa/Kigali"
timezones["São Tomé and Príncipe"]="Africa/Sao_Tome"
timezones["Senegal"]="Africa/Dakar"
timezones["Seychelles"]="Indian/Mahe"
timezones["Sierra Leone"]="Africa/Freetown"
timezones["Somalia"]="Africa/Mogadishu"
timezones["South Africa"]="Africa/Johannesburg"
timezones["South Sudan"]="Africa/Juba"
timezones["Sudan"]="Africa/Khartoum"
timezones["Tanzania"]="Africa/Dar_es_Salaam"
timezones["Togo"]="Africa/Lome"
timezones["Tunisia"]="Africa/Tunis"
timezones["Uganda"]="Africa/Kampala"
timezones["Zambia"]="Africa/Lusaka"
timezones["Zimbabwe"]="Africa/Harare"

timezones["Afghanistan"]="Asia/Kabul"
timezones["Armenia"]="Asia/Yerevan"
timezones["Azerbaijan"]="Asia/Baku"
timezones["Bahrain"]="Asia/Bahrain"
timezones["Bangladesh"]="Asia/Dhaka"
timezones["Bhutan"]="Asia/Thimphu"
timezones["Brunei"]="Asia/Brunei"
timezones["Cambodia"]="Asia/Phnom_Penh"
timezones["China"]="Asia/Shanghai"
timezones["Cyprus"]="Asia/Nicosia"
timezones["Georgia"]="Asia/Tbilisi"
timezones["India"]="Asia/Kolkata"
timezones["Indonesia"]="Asia/Jakarta"
timezones["Iran"]="Asia/Tehran"
timezones["Iraq"]="Asia/Baghdad"
timezones["Israel"]="Asia/Jerusalem"
timezones["Japan"]="Asia/Tokyo"
timezones["Jordan"]="Asia/Amman"
timezones["Kazakhstan"]="Asia/Almaty"
timezones["Kuwait"]="Asia/Kuwait"
timezones["Kyrgyzstan"]="Asia/Bishkek"
timezones["Laos"]="Asia/Vientiane"
timezones["Lebanon"]="Asia/Beirut"
timezones["Malaysia"]="Asia/Kuala_Lumpur"
timezones["Maldives"]="Asia/Male"
timezones["Mongolia"]="Asia/Ulaanbaatar"
timezones["Myanmar"]="Asia/Yangon"
timezones["Nepal"]="Asia/Kathmandu"
timezones["North Korea"]="Asia/Pyongyang"
timezones["Oman"]="Asia/Muscat"
timezones["Pakistan"]="Asia/Karachi"
timezones["Palestine"]="Asia/Gaza"
timezones["Philippines"]="Asia/Manila"
timezones["Qatar"]="Asia/Qatar"
timezones["Saudi Arabia"]="Asia/Riyadh"
timezones["Singapore"]="Asia/Singapore"
timezones["South Korea"]="Asia/Seoul"
timezones["Sri Lanka"]="Asia/Colombo"
timezones["Syria"]="Asia/Damascus"
timezones["Taiwan"]="Asia/Taipei"
timezones["Tajikistan"]="Asia/Dushanbe"
timezones["Thailand"]="Asia/Bangkok"
timezones["Timor-Leste"]="Asia/Dili"
timezones["Turkmenistan"]="Asia/Ashgabat"
timezones["United Arab Emirates"]="Asia/Dubai"
timezones["Uzbekistan"]="Asia/Tashkent"
timezones["Vietnam"]="Asia/Ho_Chi_Minh"
timezones["Yemen"]="Asia/Aden"

# Populate locales corresponding to countries
locales["United States"]="en_US.UTF-8"
locales["Canada"]="en_CA.UTF-8"
locales["Mexico"]="es_MX.UTF-8"
locales["Brazil"]="pt_BR.UTF-8"
locales["Argentina"]="es_AR.UTF-8"
locales["Chile"]="es_CL.UTF-8"
locales["Colombia"]="es_CO.UTF-8"
locales["Cuba"]="es_CU.UTF-8"
locales["Dominican Republic"]="es_DO.UTF-8"
locales["Ecuador"]="es_EC.UTF-8"
locales["El Salvador"]="es_SV.UTF-8"
locales["Guatemala"]="es_GT.UTF-8"
locales["Honduras"]="es_HN.UTF-8"
locales["Nicaragua"]="es_NI.UTF-8"
locales["Panama"]="es_PA.UTF-8"
locales["Paraguay"]="es_PY.UTF-8"
locales["Peru"]="es_PE.UTF-8"
locales["Uruguay"]="es_UY.UTF-8"
locales["Venezuela"]="es_VE.UTF-8"

locales["Albania"]="sq_AL.UTF-8"
locales["Andorra"]="ca_AD.UTF-8"
locales["Austria"]="de_AT.UTF-8"
locales["Belarus"]="be_BY.UTF-8"
locales["Belgium"]="nl_BE.UTF-8"
locales["Bosnia and Herzegovina"]="bs_BA.UTF-8"
locales["Bulgaria"]="bg_BG.UTF-8"
locales["Croatia"]="hr_HR.UTF-8"
locales["Cyprus"]="el_CY.UTF-8"
locales["Czech Republic"]="cs_CZ.UTF-8"
locales["Denmark"]="da_DK.UTF-8"
locales["Estonia"]="et_EE.UTF-8"
locales["Finland"]="fi_FI.UTF-8"
locales["France"]="fr_FR.UTF-8"
locales["Germany"]="de_DE.UTF-8"
locales["Greece"]="el_GR.UTF-8"
locales["Hungary"]="hu_HU.UTF-8"
locales["Iceland"]="is_IS.UTF-8"
locales["Ireland"]="en_IE.UTF-8"
locales["Italy"]="it_IT.UTF-8"
locales["Latvia"]="lv_LV.UTF-8"
locales["Lithuania"]="lt_LT.UTF-8"
locales["Luxembourg"]="lb_LU.UTF-8"
locales["Malta"]="mt_MT.UTF-8"
locales["Netherlands"]="nl_NL.UTF-8"
locales["Norway"]="nb_NO.UTF-8"
locales["Poland"]="pl_PL.UTF-8"
locales["Portugal"]="pt_PT.UTF-8"
locales["Romania"]="ro_RO.UTF-8"
locales["Slovakia"]="sk_SK.UTF-8"
locales["Slovenia"]="sl_SI.UTF-8"
locales["Spain"]="es_ES.UTF-8"
locales["Sweden"]="sv_SE.UTF-8"
locales["Switzerland"]="de_CH.UTF-8"
locales["United Kingdom"]="en_GB.UTF-8"
locales["Ukraine"]="uk_UA.UTF-8"

locales["Algeria"]="ar_DZ.UTF-8"
locales["Angola"]="pt_AO.UTF-8"
locales["Benin"]="fr_BJ.UTF-8"
locales["Botswana"]="en_BW.UTF-8"
locales["Burkina Faso"]="fr_BF.UTF-8"
locales["Burundi"]="fr_BI.UTF-8"
locales["Cabo Verde"]="pt_CV.UTF-8"
locales["Cameroon"]="fr_CM.UTF-8"
locales["Central African Republic"]="fr_CF.UTF-8"
locales["Chad"]="fr_TD.UTF-8"
locales["Comoros"]="ar_KM.UTF-8"
locales["Congo (Congo-Brazzaville)"]="fr_CG.UTF-8"
locales["Democratic Republic of the Congo"]="fr_CD.UTF-8"
locales["Djibouti"]="fr_DJ.UTF-8"
locales["Egypt"]="ar_EG.UTF-8"
locales["Equatorial Guinea"]="es_GQ.UTF-8"
locales["Eritrea"]="ti_ER.UTF-8"
locales["Eswatini"]="en_SZ.UTF-8"
locales["Ethiopia"]="am_ET.UTF-8"
locales["Gabon"]="fr_GA.UTF-8"
locales["Gambia"]="en_GM.UTF-8"
locales["Ghana"]="en_GH.UTF-8"
locales["Guinea"]="fr_GN.UTF-8"
locales["Guinea-Bissau"]="pt_GW.UTF-8"
locales["Ivory Coast"]="fr_CI.UTF-8"
locales["Kenya"]="sw_KE.UTF-8"
locales["Lesotho"]="en_LS.UTF-8"
locales["Liberia"]="en_LR.UTF-8"
locales["Libya"]="ar_LY.UTF-8"
locales["Madagascar"]="mg_MG.UTF-8"
locales["Malawi"]="en_MW.UTF-8"
locales["Mali"]="fr_ML.UTF-8"
locales["Mauritania"]="ar_MA.UTF-8"
locales["Mauritius"]="en_MU.UTF-8"
locales["Morocco"]="ar_MA.UTF-8"
locales["Mozambique"]="pt_MZ.UTF-8"
locales["Namibia"]="en_NA.UTF-8"
locales["Niger"]="fr_NE.UTF-8"
locales["Nigeria"]="en_NG.UTF-8"
locales["Rwanda"]="rw_RW.UTF-8"
locales["São Tomé and Príncipe"]="pt_ST.UTF-8"
locales["Senegal"]="fr_SN.UTF-8"
locales["Seychelles"]="fr_SC.UTF-8"
locales["Sierra Leone"]="en_SL.UTF-8"
locales["Somalia"]="so_SO.UTF-8"
locales["South Africa"]="en_ZA.UTF-8"
locales["South Sudan"]="en_SS.UTF-8"
locales["Sudan"]="ar_SD.UTF-8"
locales["Tanzania"]="sw_TZ.UTF-8"
locales["Togo"]="fr_TG.UTF-8"
locales["Tunisia"]="ar_TN.UTF-8"
locales["Uganda"]="en_UG.UTF-8"
locales["Zambia"]="en_ZM.UTF-8"
locales["Zimbabwe"]="en_ZW.UTF-8"

locales["Afghanistan"]="ps_AF.UTF-8"
locales["Armenia"]="hy_AM.UTF-8"
locales["Azerbaijan"]="az_AZ.UTF-8"
locales["Bahrain"]="ar_BH.UTF-8"
locales["Bangladesh"]="bn_BD.UTF-8"
locales["Bhutan"]="dz_BT.UTF-8"
locales["Brunei"]="ms_BN.UTF-8"
locales["Cambodia"]="km_KH.UTF-8"
locales["China"]="zh_CN.UTF-8"
locales["Cyprus"]="el_CY.UTF-8"
locales["Georgia"]="ka_GE.UTF-8"
locales["India"]="en_IN.UTF-8"
locales["Indonesia"]="id_ID.UTF-8"
locales["Iran"]="fa_IR.UTF-8"
locales["Iraq"]="ar_IQ.UTF-8"
locales["Israel"]="he_IL.UTF-8"
locales["Japan"]="ja_JP.UTF-8"
locales["Jordan"]="ar_JO.UTF-8"
locales["Kazakhstan"]="kk_KZ.UTF-8"
locales["Kuwait"]="ar_KW.UTF-8"
locales["Kyrgyzstan"]="ky_KG.UTF-8"
locales["Laos"]="lo_LA.UTF-8"
locales["Lebanon"]="ar_LB.UTF-8"
locales["Malaysia"]="ms_MY.UTF-8"
locales["Maldives"]="dv_MV.UTF-8"
locales["Mongolia"]="mn_MN.UTF-8"
locales["Myanmar"]="my_MM.UTF-8"
locales["Nepal"]="ne_NP.UTF-8"
locales["North Korea"]="ko_KP.UTF-8"
locales["Oman"]="ar_OM.UTF-8"
locales["Pakistan"]="ur_PK.UTF-8"
locales["Palestine"]="ar_PS.UTF-8"
locales["Philippines"]="en_PH.UTF-8"
locales["Qatar"]="ar_QA.UTF-8"
locales["Saudi Arabia"]="ar_SA.UTF-8"
locales["Singapore"]="en_SG.UTF-8"
locales["South Korea"]="ko_KR.UTF-8"
locales["Sri Lanka"]="si_LK.UTF-8"
locales["Syria"]="ar_SY.UTF-8"
locales["Taiwan"]="zh_TW.UTF-8"
locales["Tajikistan"]="tg_TJ.UTF-8"
locales["Thailand"]="th_TH.UTF-8"
locales["Timor-Leste"]="pt_TL.UTF-8"
locales["Turkmenistan"]="tk_TM.UTF-8"
locales["United Arab Emirates"]="ar_AE.UTF-8"
locales["Uzbekistan"]="uz_UZ.UTF-8"
locales["Vietnam"]="vi_VN.UTF-8"
locales["Yemen"]="ar_YE.UTF-8"

# Show region options
echo "Please choose a region:"
select region in "${!regions[@]}"; do
    if [[ -n $region ]]; then
        echo "You selected the region: $region"
        break
    else
        echo "Please select a valid option."
    fi
done

# Show country options based on the selected region
echo "Please choose a country from the region $region:"
select selected_country in ${regions[$region]}; do
    if [[ -n $selected_country ]]; then
        echo "You selected the country: $selected_country"
        break
    else
        echo "Please select a valid option."
    fi
done

# Assign the corresponding timezone and locale
user_timezone=${timezones[$selected_country]}
user_locale=${locales[$selected_country]}

# Output the timezone and locale
echo "The timezone for $selected_country is set to: $user_timezone"
echo "The locale for $selected_country is set to: $user_locale"

sleep 5

# Cleaning the TTY
clear

# keyboard layouts
# Fetch the list of keyboard layouts
echo "Setting the keyboard layout."
layouts=$(localectl list-keymaps)

# Convert the list into an array
IFS=$'\n' read -r -d '' -a layout_array <<< "$layouts"

# Display the list of keyboard layouts with numbers
echo "Please select your keyboard layout.Scroll the list with UP/DOWN arrows keys and identify the coresponding number for your keyboard layout; than press q and enter the number."
sleep 5
for i in "${!layout_array[@]}"; do
    echo "$((i + 1)). ${layout_array[i]}"
done | less

# Prompt user for selection after viewing the list
echo "Please enter the number of your choice:"
read -p "> " choice

# Validate input
if [[ "$choice" -gt 0 && "$choice" -le "${#layout_array[@]}" ]]; then
    KEYBOARD=${layout_array[$((choice - 1))]}  # Define the selected layout as $KEYBOARD
    echo "You have selected: $KEYBOARD"
    
    # Set the keyboard layout
    localectl set-keymap "$KEYBOARD"
    echo "Keyboard layout set to $KEYBOARD."
    sleep 5
else
    echo "Invalid choice. Please run the script again."
fi

# Cleaning the TTY
clear

# Prompt for a username
get_username() {
    read -p "Enter your username: " username
}

# Prompt for user password
get_user_password() {
    while true; do
        read -s -p "Enter your password: " user_password
        echo
        read -s -p "Confirm your password: " confirm_password
        echo
        
        if [ "$user_password" == "$confirm_password" ]; then
            break
        else
            echo "Passwords do not match. Please try again."
        fi
    done
}

# Prompt for root password
get_root_password() {
    while true; do
        read -s -p "Enter a password for the root account: " root_password
        echo
        read -s -p "Confirm the root password: " confirm_root_password
        echo
        
        if [ "$root_password" == "$confirm_root_password" ]; then
            break
        else
            echo "Root passwords do not match. Please try again."
        fi
    done
}

# Main execution
get_username
get_user_password

read -p "Do you want the same password for the root account? (y/n): " same_as_root

if [[ "$same_as_root" == "y" ]]; then
    root_password=$user_password
    echo "The root password has been set to the same as your user password."
else
    get_root_password
fi

# Cleaning the TTY
clear

# Prompt user for hostname
read -p "Please enter the hostname: " hostname

# Cleaning the TTY
clear

# Choose which Linux kernel u want to install
display_options() {
    echo "Please choose which Linux kernel(s) you want to install:"
    echo "1) linux"
    echo "2) linux-zen"
    echo "3) linux-lts"
    echo "4) linux and linux-lts"
    echo "5) linux-zen and linux-lts"
    echo "6) linux and linux-zen"
    echo "7) Exit"
}

# Prompt the user for their choice
prompt_choice() {
    display_options
    read -rp "Enter the number of your choice: " choice
    echo
}

# Main script execution
while true; do
    prompt_choice

    case $choice in
        1)
            linux="linux linux-headers"
            echo "You chose to install: $linux"
            break
            ;;
        2)
            linux="linux-zen linux-zen-headers"
            echo "You chose to install: $linux"
            break
            ;;
        3)
            linux="linux-lts linux-lts-headers"
            echo "You chose to install: $linux"
            break
            ;;
        4)
            linux="linux linux-headers linux-lts linux-lts-headers"
            echo "You chose to install: $linux"
            break
            ;;
        5)
            linux="linux-zen linux-zen-headers linux-lts linux-lts-headers"
            echo "You chose to install: $linux"
            break
            ;;
        6)
            linux="linux linux-headers linux-zen linux-zen-headers"
            echo "You chose to install: $linux"
            break
            ;;
        7)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done

# Cleaning the TTY
clear

# Partitions setup
#set -x
# Display available drives
echo "Available drives:"
lsblk

# Choosing the target for the installation.
echo "Available disks for the installation:"
PS3="Please select the number of the corresponding disk (e.g. 1): "
select ENTRY in $(lsblk -dpnoNAME|grep -P "/dev/sd|nvme|vd");
do
    drive="$ENTRY"
    echo "Arch Linux will be installed on the following disk: $drive"
    break
done

# Prompt for partition sizes
read -p "Enter EFI partition size in MB (e.g., 300 or 512): " efi_size
read -p "Enter the size for the Btrfs root partition in MB (e.g., 85000): " btrfsroot_size
read -p "Enter the size for the home partition in MB (e.g., 50000 or 0 to use the rest of the disk): " home_size

# Cleaning the TTY
clear

# Convert sizes to sectors (assuming 1MB = 2048 sectors)
efi_size_sec=$(( efi_size * 2048 ))
btrfs_size_sec=$(( btrfsroot_size * 2048 ))
home_size_sec=0
swap_size_sec=0

# Get the end sector using sgdisk command
ENDSECTOR=$(sgdisk -E "$drive")

# Determine sizes
if [[ -z "$home_size" ]]; then
    home_size_sec=$(( ENDSECTOR - efi_size_sec - btrfs_size_sec ))
else
    home_size_sec=$(( home_size * 2048 ))
fi

# Ask the user about creating a swap partition only if home size is not 0
if [[ "$home_size" -ne 0 ]]; then
    echo "Do you want to create a swap partition? (y/n)"
    read -r SWAP_ANSWER
fi

# Create partitions using sgdisk
sgdisk --zap-all $drive
sgdisk -og $drive
sgdisk -n 1:0:+${efi_size_sec} -c 1:"EFI" -t 1:ef00 $drive
sgdisk -n 2:0:+${btrfs_size_sec} -c 2:"BTRFSROOT" -t 2:8300 $drive
sgdisk -n 3:0:+${home_size_sec} -c 3:"HOME" -t 3:8300 $drive

# If user wants to create swap partition
    if [[ "$SWAP_ANSWER" == "y" ]]; then
        sgdisk -n 4:0:0 -c 4:"SWAP" -t 4:8200 "${drive}"  
    echo "Swap partition created using the remaining space."
fi

# Get partition information
    if [[ "$drive" == "/dev/sda" ]]; then
        part_efi="${drive}1"
        part_btrfsroot="${drive}2"
        part_home="${drive}3"
        part_swap="${drive}4"
    fi

    # Get partition information
    if [[ "$drive" == "/dev/sdb" ]]; then
        part_efi="${drive}1"
        part_btrfsroot="${drive}2"
        part_home="${drive}3"
        part_swap="${drive}4"
    fi

    # Get partition information
    if [[ "$drive" == "/dev/sdc" ]]; then
        part_efi="${drive}1"
        part_btrfsroot="${drive}2"
        part_home="${drive}3"
        part_swap="${drive}4"
    fi

    # Get partition information
    if [[ "$drive" == "/dev/nvme0n1" ]]; then
        part_efi="${drive}p1"
        part_btrfsroot="${drive}p2"
        part_home="${drive}p3"
        part_swap="${drive}p4"
    fi

    # Get partition information
    if [[ "$drive" == "/dev/nvme1n1" ]]; then
        part_efi="${drive}p1"
        part_btrfsroot="${drive}p2"
        part_home="${drive}p3"
        part_swap="${drive}p4"
    fi

# Format the Btrfs root partitions
mkfs.btrfs -f $part_btrfsroot                     
    
# Mount the Btrfs root partition
mount $part_btrfsroot /mnt                      
cd /mnt

# Create Btrfs subvolumes
btrfs su cr @
btrfs su cr @snapshots
btrfs su cr @log
btrfs su cr @cache
btrfs su cr @tmp
btrfs su cr @srv

# Unmount Btrfs root to remount with subvolumes
cd
umount /mnt

# Remount the subvolumes with specified options
mount -o subvol=@,noatime,ssd,compress=zstd,space_cache=v2,discard=async $part_btrfsroot /mnt  
mkdir -p /mnt/{.snapshots,srv,var/log,var/cache,var/tmp,.btrfsroot}
mount -o subvol=@snapshots $part_btrfsroot /mnt/.snapshots                                                 
mount -o subvol=@log $part_btrfsroot /mnt/var/log                                                          
mount -o subvol=@cache $part_btrfsroot /mnt/var/cache                                                      
mount -o subvol=@tmp $part_btrfsroot /mnt/var/tmp                                                          
mount -o subvol=@srv $part_btrfsroot /mnt/srv                                                              
mount -o subvolid=5 $part_btrfsroot /mnt/.btrfsroot    

# Mount the home partition
mkfs.ext4 -F $part_home
mkdir -p /mnt/home
mount $part_home /mnt/home

# Mount the EFI partition
mkfs.vfat -F32 $part_efi
mkdir -p /mnt/efi
mount $part_efi /mnt/efi

# Create and enable swap if requested
if [[ "$SWAP_ANSWER" == "y" ]]; then
    mkswap $part_swap
    swapon $part_swap
fi

# Cleaning the TTY
clear

# Display available drives
echo "Available drives:"

lsblk



echo -ne "Partitions have been created, formatted, and mounted successfully! 


The installation will continue in a few seconds..."

sleep 15

# Cleaning the TTY
clear

# Edit pacman parameters
sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i '38d' /etc/pacman.conf
sed -i '38 i ParallelDownloads = 10' /etc/pacman.conf
sed -i '92s/.//' /etc/pacman.conf
sed -i '93s/.//' /etc/pacman.conf
sed -i '34 i ILoveCandy' /etc/pacman.conf

# Run the reflector command
echo "Update the mirrors list for $selected_country..."
reflector --verbose --country "$selected_country" -l 20 --sort rate --save /etc/pacman.d/mirrorlist

echo "Mirror list updated for the country: $selected_country"

# Refreshing mirrorlist
pacman -Sy

# Update system clock
timedatectl set-ntp true

# Initialize the pacman keyring
pacman-key --init

# Populate the local keyring
pacman-key --populate archlinux

# Refreshing mirrorlist
pacman -Sy

# Cleaning the TTY
clear

# Detect if Intel CPU found
if lscpu | grep -qi "intel" > /dev/null; then
         ucode="intel-ucode"
    echo "Intel CPU detected. Setting ucode to '$ucode'."
else
    echo "No Intel CPU detected."
fi   

# Detect if AMD CPU found
if lscpu | grep -qi "amd" > /dev/null; then
         ucode="amd-ucode"
    echo "AMD CPU detected. Setting ucode to '$ucode'."
else
    echo "AMD CPU not detected."
fi  

# Cleaning the TTY
clear

# Install essential packages
echo "Installing essential packages..."
pacstrap -K /mnt base base-devel $linux linux-firmware $ucode efibootmgr nano openssh git dhcpcd wget reflector rsync networkmanager network-manager-applet pacman-contrib flatpak terminus-font dialog firefox grub btrfs-progs

# Cleaning the TTY
clear

# Generate fstab 
echo "Generate fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# Cleaning the TTY
clear

# Chroot into the new system
arch-chroot /mnt /bin/bash <<EOF 

# Set timezine
echo "Setting timezone to $user_timezone..."
ln -sf /usr/share/zoneinfo/$user_timezone /etc/localtime

# Sync hardware clock
hwclock --systohc

# Inform the user
echo "Timezone has been set to $timezone."

# Cleaning the TTY
clear

# Enable the selected locale in locale.gen
echo "Enabling locale: $user_locale"
if grep -q "^#$user_locale" /etc/locale.gen; then
    sed -i "s/^#$user_locale/$user_locale/" /etc/locale.gen
elif grep -q "^$user_locale" /etc/locale.gen; then
    echo "Locale '$user_locale' is already enabled."
else
    echo "Locale '$user_locale' not found in locale.gen, please check if it is correct."
    exit 1
fi

# Cleaning the TTY
clear

# Generate the locales
echo "Generating the locales..."
locale-gen

# Set the system locale
echo "LANG=\"$user_locale\"" > /etc/locale.conf
# Confirm that /etc/locale.conf has been updated successfully
if [[ $? -ne 0 ]]; then
    echo "Error: Unable to write to /etc/locale.conf"
    exit 1
fi

# Inform the user about the selected locale
echo "Your system locale has been set to: $user_locale."
echo "You can verify the locale settings with the command: locale"

# Cleaning the TTY
clear

# Set the keyboard layout
echo "Setting keyboard layout to $KEYBOARD..."
echo "KEYMAP=$KEYBOARD" > /etc/vconsole.conf

# Cleaning the TTY
clear

# Network configuration
echo "$hostname" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts

# Inform the user
echo "Network configuration have been set."

# Cleaning the TTY
clear

# Set the root password
echo "Setting the root password..."
echo "root:$root_password" | chpasswd
echo "Root password has been set successfully."

# Cleaning the TTY
clear

# Create the user
useradd -m -G wheel "$username"
echo "$username:$user_password" | chpasswd
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Inform the user
echo "User $username has been created successfully."
echo "User password $password has been set successfully."

# Cleaning the TTY
clear

# Edit pacman parameters
sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i '38d' /etc/pacman.conf
sed -i '38 i ParallelDownloads = 10' /etc/pacman.conf
sed -i '92s/.//' /etc/pacman.conf
sed -i '93s/.//' /etc/pacman.conf
sed -i '34 i ILoveCandy' /etc/pacman.conf

# Refresh pacman
pacman -Syy

# Cleaning the TTY
clear

# Check for existing swap partitions
if swapon --show | grep -q '^'; then
    echo "Swap partition exists. Skipping zram-generator installation."
else
    echo "No swap partition detected. Installing zram-generator..."
    pacman -S --noconfirm zram-generator && echo "[zram0]
    zram-size = ram / 2
    swap-priority = 100" > /etc/systemd/zram-generator.conf
    echo "zram-generator installed and configuration created."
fi

# Cleaning the TTY
clear

# Installing audio drivers
yes | pacman -S alsa-utils alsa-firmware pipewire pipewire-alsa pipewire-pulse pipewire-jack pipewire-audio pipewire-zeroconf wireplumber sof-firmware pavucontrol libpipewire lib32-libpipewire lib32-pipewire ffnvcodec-headers pipewire-x11-bell pipewire-v4l2 || true

# Cleaning the TTY
clear

# Installing common pkgs
pacman -S --needed --noconfirm xorg xorg-server xorg-xinit xorg-apps xorg-twm xorg-xclock xf86-input-libinput xf86-input-evdev  xorg-xkill xdg-user-dirs xdg-user-dirs-gtk gstreamer gvfs gvfs-mtp gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-nfs gvfs-smb smartmontools arch-install-scripts libwnck3 b43-fwcutter busybox cpio mobile-broadband-provider-info modem-manager-gui net-snmp networkmanager-openconnect networkmanager-openvpn networkmanager-pptp networkmanager-vpnc dnsutils modemmanager netctl net-tools ntfs-3g sg3_utils nss-mdns usb_modeswitch whois wireless_tools dhclient dnsmasq ethtool openconnect openvpn rp-pppoe wireless-regdb wpa_supplicant wvdial iwd iw linux-atm ndisc6 ppp pptpclient vpnc xl2tpd upower hwinfo python solid mlocate glances htop screenfetch ffmpeg fsarchiver ark bluez bluez-utils bluez-tools archiso ffmpegthumbnailer poppler-glib libgsf libopenraw freetype2 gst-libav gsound gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-ugly gst-plugins-bad gst-plugins-bad-libs sdparm libdvdcss systemd-ui dosfstools mtools os-prober bash-completion bc partimage json-glib libsoup dbus-glib polkit efitools cdrkit crda ddrescue exfat-utils gpart gparted android-tools android-udev mtpfs nfs-utils vte3 gtk3 libnotify desktop-file-utils appstream-glib archlinux-appstream-data gettext itstool vala meson ninja gobject-introspection squashfs-tools crypto++ ecryptfs-utils fuse3 pv unrar unzip asciidoc libhandy lxsession yaml-cpp bluez-qt5 inxi mkinitcpio-archiso plasma-framework5 qt5-tools qt5-webengine syslinux cmake clonezilla cups cups-filters cups-pdf ghostscript gsfonts foomatic-db-engine foomatic-db foomatic-db-ppds foomatic-db-nonfree foomatic-db-nonfree-ppds gutenprint foomatic-db-gutenprint-ppds system-config-printer hplip splix xf86-input-vmmouse expac lynis rkhunter bluez-obex gvim neovim fuseiso arch-audit links elinks zsh apparmor python-notify2 inotify-tools acpi acpi_call-dkms acpid 7zip adwaita-cursors adwaita-icon-theme adwaita-icon-theme-legacy accountsservice archlinux-contrib archlinux-keyring archlinux-wallpaper avahi curl cronie darkhttpd ddrescue duf fastfetch ffmpegthumbs font-manager fontconfig fwupd fwupd-efi gedit haveged hicolor-icon-theme hwdata iotop isoimagewriter jdk-openjdk lm_sensors man-db man-pages mdadm nethogs pacutils papirus-icon-theme plymouth power-profiles-daemon tar ufw ufw-extras gufw unrar unzip veracrypt which zip meld jq openbsd-netcat gstreamer-vaapi blueman discord gimp gimp-plugin-gmic fuse2fs thunderbird btop plymouth-kcm ncdu audacious audacious-plugins bleachbit conky inkscape qbittorrent shortwave shotwell libreoffice-fresh vlc vlc-plugins-all || true

# Cleaning the TTY
clear

# Installing fonts pkgs
pacman -S --needed --noconfirm ttf-dejavu gnu-free-fonts ttf-liberation ttf-bitstream-vera ttf-ubuntu-font-family ttf-caladea ttf-carlito ttf-croscore cantarell-fonts noto-fonts ttf-anonymous-pro ttf-cascadia-code ttf-droid ttf-fira-code ttf-fira-mono ttf-fira-sans woff2-font-awesome ttf-hack ttf-inconsolata ttf-opensans ttf-roboto ttf-roboto-mono adobe-source-code-pro-fonts inter-font noto-fonts-emoji || true

# Cleaning the TTY
clear

# Append BTRFS to mkinitcpio modules
sed -i '/^MODULES=/s/)/btrfs)/' /etc/mkinitcpio.conf

# Check for Intel Integrated Graphics Controller
if lscpu | grep -i "intel" > /dev/null; then
    echo "INTEL GPU detected...Install INTEL drivers"
    sed -i '/^MODULES=/s/)/ i915)/' /etc/mkinitcpio.conf  && pacman -S --needed --noconfirm libvdpau-va-gl libva-intel-driver vulkan-intel intel-gmmlib intel-media-driver libva-utils vulkan-headers vulkan-icd-loader vulkan-tools mesa mesa-utils mesa-demos lib32-mesa intel-gpu-tools || true
fi  

# Check for the NVIDIA GPU
if lspci | grep -i nvidia > /dev/null; then
    echo "NVIDIA GPU detected...Install NVIDIA drivers"
    pacman -S --noconfirm nvidia-dkms libglvnd nvidia-utils opencl-nvidia lib32-libglvnd lib32-nvidia-utils lib32-opencl-nvidia nvidia-settings nvidia-prime nvtop
    sed -i '/^MODULES=/s/)/ nvidia)/' /etc/mkinitcpio.conf 
else
    echo "No NVIDIA GPU detected. Skipping NVIDIA driver installation."
fi

# Check for AMD GPU
if lspci | grep -i "advanced micro devices" > /dev/null; then
   echo "AMD GPU detected..."
   pacman -S --noconfirm --needed xf86-video-amdgpu mesa lib32-mesa mesa-vdpau lib32-mesa-vdpau lib32-vulkan-radeon vulkan-radeon glu lib32-glu vulkan-icd-loader lib32-vulkan-icd-loader
   sed -i '/^MODULES=/s/)/ amdgpu)/' /etc/mkinitcpio.conf
fi

# Cleaning the TTY
clear

# Installing KDE-Plasma as desktop environment
pacman -S --needed --noconfirm kf6 qt6 plasma-meta kde-applications-meta packagekit-qt6 kde-cli-tools kdeplasma-addons plasma-activities polkit-kde-agent flatpak-kcm bluedevil glib2 ibus kaccounts-integration kscreen libaccounts-qt plasma-nm plasma-pa scim extra-cmake-modules kaccounts-integration kdoctools libibus wayland-protocols plasma-applet-window-buttons plasma-workspace appmenu-gtk-module kwayland-integration plasma5-integration xdg-desktop-portal-gtk kde-pim-meta kde-system-meta kde-gtk-config kwin-x11 plasma-x11-session gnome-disk-utility || true

# Cleaning the TTY
clear

# installing snapper for btrfs filesystem
pacman -S --needed --noconfirm grub-btrfs snap-pac snapper

# Add flatpak repo
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Grub bootloader install for mount point /mnt/efi
grub-install --target=x86_64-efi --efi-directory=/efi --boot-directory=/boot --bootloader-id=GRUB $part_btrfsroot

# Update GRUB configuration for multiple kernels when btrfs file system exist
if [[ $choice -ge 4 && $choice -le 6 ]]; then
    echo "Two kernels are installed. Updating Grub configuration file..."
    if [ -f /etc/default/grub ]; then
        sed -i '3d' /etc/default/grub
        sed -i '3i GRUB_DEFAULT="1>2"' /etc/default/grub
        echo "GRUB configuration has been updated."
    else
        echo "GRUB configuration file not found. No changes made."
    fi
else
    echo "One kernel installed or grub configuration file not found or not required to be updated...."
fi

# Grub configuration settings
sed -i '4d' /etc/default/grub
sed -i '4 i GRUB_TIMEOUT="2"' /etc/default/grub
sed -i '6d' /etc/default/grub
sed -i '6 i GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet splash lsm=landlock,lockdown,yama,integrity,apparmor,bpf audit=1"' /etc/default/grub
sed -i '42d' /etc/default/grub
sed -i '42 i export GRUB_COLOR_NORMAL="white/black"' /etc/default/grub
sed -i '43d' /etc/default/grub
sed -i '43 i export GRUB_COLOR_HIGHLIGHT="light-red/black"' /etc/default/grub
sed -i '46d' /etc/default/grub
sed -i '46 i GRUB_BACKGROUND="/etc/default/splash.png"' /etc/default/grub

# Snapper configuration
umount /.snapshots
rm -rf /.snapshots
snapper --no-dbus -c root create-config /
btrfs subvolume delete /.snapshots
mkdir /.snapshots
mount -a
chmod a+rx /.snapshots
chown :$username /.snapshots
# Setting default btrfs subvol 256 root 
btrfs subvol set-default 256 /
   

# Set keymap service to run on the first boot
if [[ "$KEYBOARD" == "uk" ]]; then
    # Creating set-keymap service
    echo "
    [Unit]
    Description=Set X11 Keymap
    After=local-fs.target
    
    [Service]
    Type=oneshot
    ExecStart=/usr/bin/localectl --no-convert set-x11-keymap gb pc104
    RemainAfterExit=yes
    
    [Install]
    WantedBy=multi-user.target" > /etc/systemd/system/set-keymap.service
else
      # Creating set-keymap service
    echo "
    [Unit]
    Description=Set X11 Keymap
    After=local-fs.target
    
    [Service]
    Type=oneshot
    ExecStart=/usr/bin/localectl --no-convert set-x11-keymap $KEYBOARD
    RemainAfterExit=yes
    
    [Install]
    WantedBy=multi-user.target" > /etc/systemd/system/set-keymap.service
fi     

# Enable necessary services
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable dhcpcd.service
systemctl enable acpid
systemctl enable ufw
systemctl enable avahi-daemon
systemctl enable haveged.service
systemctl enable paccache.timer
systemctl enable set-keymap.service
systemctl enable sddm.service

# Edit system parameters
sed -i '50s/^#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=5s/' /etc/systemd/system.conf

# Refreshing grub
grub-mkconfig -o /boot/grub/grub.cfg

# Generating intramfs
mkinitcpio -P

EOF

# Copy ArchLinux into working directory after reboot
cp -r Archlinux /mnt/home/$username

# Setting boot wallpaper in directory
cp -r Archlinux/splash.png /mnt/etc/default

echo "The installation has been completed.Rebooting in ..."; for i in {10..1}; do echo -n "$i.."; sleep 1; done; echo ""; echo "Rebooting now..."

# Unmount all partitions and reboot
umount -R /mnt
reboot
















