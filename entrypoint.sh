#!/bin/sh

echo "Starting knxmonitor service."

ARGS=$@
echo "ARGS: $ARGS"

CONFIG_PATH=/etc/knxd

if [ ! -e "$CONFIG_PATH/knxd.ini" ]; then
    echo "No config file found, using example file"
    #cp /root/knxd.ini $CONFIG_PATH/;
fi

#chown knxd:knxd /etc/knxd/knxd.ini
cd /knxlogs

echo "Press <ctrl>-c to abort"
su -s /bin/sh -c "knxmonitor $ARGS" knxmon

# Workaround because knxd always forks to background
while [ true ] ; do
    sleep 5
done
