#!/usr/bin/with-contenv bashio
set -e

touch "/etc/genmon/kwlog.txt"

### Define config files ###
genmqttconf="/addons/genmon/genmqtt.conf"
genmonconf="/addons/genmon/genmon.conf"
mymailconf="/addons/genmon/mymail.conf"
genloaderconf="/addons/genmon/genloader.conf"

### Get config values ###
sitename=$(bashio::config 'sitename')
serial_tcp_ip_address=$(bashio::config 'serial_tcp_ip_address')
serial_tcp_port=$(bashio::config 'serial_tcp_port')
generator_size=$(bashio::config 'generator_size')
fuel_type=$(bashio::config 'fuel_type')
enable_mqtt=$(bashio::config 'enable_mqtt')
mqtt_ip_address=$(bashio::config 'mqtt_ip_address')
mqtt_username=$(bashio::config 'mqtt_username')
mqtt_password=$(bashio::config 'mqtt_password')
mqtt_port=$(bashio::config 'mqtt_port')

### Deploy configs ###
genmonconfpath="/addons/genmon"

if ! [ -d "$genmonconfpath" ];
then
    bashio::log.green "Deploying config files..."
    /opt/genmon/genmonmaint.sh -s -c $genmonconfpath
fi

if ! [ -f "$genmonconfpath/modified_configs" ];
then
    ### Start modifying config files ###
    bashio::log.green "Modifying configuration files..."

    ### Enable serial over TCP ###
    bashio::log.yellow "Enable serial over TCP..."
    sed -i "s/use_serial_tcp = False/use_serial_tcp = True/g" $genmonconf

    ### Enable power outage check ###
    bashio::log.yellow "Enable outage checks..."
    sed -i "s/disableoutagecheck = False/disableoutagecheck = true/g" $genmonconf

    ### Disable email ###
    bashio::log.yellow "Disable email..."
    sed -i "s/disableemail = false/disableemail = true/g" $mymailconf
    sed -i "s/disableimap = false/disableimap = true/g" $mymailconf
    sed -i "s/disablesmtp = false/disablesmtp = true/g" $mymailconf

    ### Turn off CPU temp guage ###
    bashio::log.yellow "Disable CPU temp guage..."
    echo "useraspberrypicputempgauge = false" >> $genmonconf

    ### Set generator size ###
    if [ "${generator_size}" ];
    then
        bashio::log.yellow "Setting generator size to ${generator_size}"
        echo "nominalkw = ${generator_size}" >> $genmonconf
    fi

    ### Set fuel type ###
    if [ "${fuel_type}" ];
    then
        bashio::log.yellow "Setting fuel type to ${fuel_type}"
        echo "fueltype = ${fuel_type}" >> $genmonconf
    fi

    ### Set sitename ###
    if [ "${sitename}" ];
    then
        bashio::log.yellow "Setting sitename to ${sitename}..."
        sed -i "s/sitename = SiteName/sitename = ${sitename}/g" $genmonconf
    fi

    ### Set Serial TCP Address ###
    if [ "${serial_tcp_ip_address}" ];
    then
        bashio::log.yellow "Setting serial TCP address to ${serial_tcp_ip_address}..."
        sed -i "s/serial_tcp_address =/serial_tcp_address = ${serial_tcp_ip_address}/g" $genmonconf
    fi

    ### Set Serial TCP Port ###
    if [ "${serial_tcp_port}" ];
    then
        bashio::log.yellow "Setting serial TCP port to ${serial_tcp_port}..."
        sed -i "s/serial_tcp_port = 8899/serial_tcp_port = ${serial_tcp_port}/g" $genmonconf
    fi

    ### Check if MQTT should be enabled ###
    if [ "${enable_mqtt}" == true ];
    then
        bashio::log.yellow "Enabling and setting up MQTT..."
        sed -i ":start;N;N;s/\[genmqtt]\nmodule = genmqtt.py\nenable = False/[genmqtt]\nmodule = genmqtt.py\nenable = True/" $genloaderconf

        ### Set MQTT ip address ###
        if [ "${mqtt_ip_address}" ]
        then
            bashio::log.yellow "Setting MQTT adress set to ${mqtt_ip_address}..."
            sed -i "s/mqtt_address = 192.168.1.20/mqtt_address = ${mqtt_ip_address}/g" $genmqttconf
        fi

        ### Set MQTT Port ###
        if [ "${mqtt_port}" ];
        then
            bashio::log.yellow "Settings MQTT port set to ${mqtt_port}..."
            sed -i "s/mqtt_port = 8899/mqtt_port = ${mqtt_port}/g" $genmqttconf
        fi

        ### Set MQTT username ###
        if [ "${mqtt_username}" ];
        then
            bashio::log.yellow "Setting MQTT username set to ${mqtt_username}..."
            sed -i "s/username =/username = ${mqtt_username}/g" $genmqttconf
        fi

        ### Set MQTT password ###
        if [ "${mqtt_password}" ];
        then
            bashio::log.yellow "Settings MQTT password..."
            sed -i "s/password =/password = ${mqtt_password}/g" $genmqttconf
        fi

        ### Set MQTT flush interval to 60 seconds for Home Assistant ###
        bashio::log.yellow "Seting flush interval to 60s..."
        sed -i "s/flush_interval = 0/flush_interval = 60/g" $genmqttconf

        ### Set numerics to json ###
        bashio::log.yellow "Seting numerics to json..."
        sed -i "s/numeric_json = False/numeric_json = true/g" $genmqttconf
    fi

    touch "$genmonconfpath/modified_configs"

    bashio::log.green "Config updates complete!"
    ### End modifying config files ###
fi

### Start genmon services ###
bashio::log.yellow "Starting GenMon services..."

/opt/genmon/startgenmon.sh start -c $genmonconfpath && tail -F /var/log/genmon.log