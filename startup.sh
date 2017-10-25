#!/bin/bash

# Start the first process
/usr/local/bin/serf agent -iface=eth0 &
status=$?
serf_pid=$!
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi

# Start the second process
/usr/bin/ruby /usr/app/lib/server.rb &
status=$?
ruby_pid=$!
if [ $status -ne 0 ]; then
  echo "Failed to start my_second_process: $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container will exit with an error
# if it detects that either of the processes has exited.
# Otherwise it will loop forever, waking up every 10 seconds

cleanup ()
{
  puts "Cleanup initiated"
  kill -s SIGTERM $serf_pid
  kill -s SIGTERM $ruby_pid
  exit 0
}

trap cleanup SIGINT SIGTERM

while /bin/true; do
  ps aux |grep serf |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep lib/server.rb |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they will exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit -1
  fi
  sleep 10
done
