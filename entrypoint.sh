#!/bin/sh

echo "Starting knxmonitor service."

ARGS=$@
echo "ARGS: $ARGS"

cd /knxlogs

echo "Press <ctrl>-c to abort"
/bin/sh -c "knxmonitor $ARGS" knxmon

while [ true ] ; do
    sleep 5
done
