#!/bin/bash

# Get the opencode process that invoked this script
# We need to walk up the process tree to find the actual opencode process
CURRENT_PID=$(ps -o ppid= -p $$ | tr -d ' ')

# Verify this is actually an opencode process, if not walk up further
while [ -n "$CURRENT_PID" ]; do
  PROC_CMD=$(ps -o cmd= -p "$CURRENT_PID" 2>/dev/null)
  if echo "$PROC_CMD" | grep -q opencode; then
    break
  fi
  CURRENT_PID=$(ps -o ppid= -p "$CURRENT_PID" 2>/dev/null | tr -d ' ')
done

if [ -z "$CURRENT_PID" ]; then
  echo "⚠ Could not identify current opencode process"
  exit 1
fi

echo "Current opencode PID: $CURRENT_PID"

# Get this script's PID to exclude it too
SCRIPT_PID=$$

# Find all opencode processes except the current one and this script
OTHER_PIDS=$(pgrep -f opencode | grep -v "^${CURRENT_PID}$" | grep -v "^${SCRIPT_PID}$")

if [ -z "$OTHER_PIDS" ]; then
  echo "No other opencode instances found"
  exit 0
fi

echo "Found opencode instances to kill:"
echo "$OTHER_PIDS" | while read pid; do
  ps -p "$pid" -o pid,cmd --no-headers 2>/dev/null || echo "$pid (process info unavailable)"
done

echo ""
echo "Killing processes..."
echo "$OTHER_PIDS" | xargs -r kill -9

# Verify they're killed
sleep 0.5
REMAINING=$(echo "$OTHER_PIDS" | xargs -r ps -p 2>/dev/null | grep -c opencode || echo "0")

if [ "$REMAINING" -eq 0 ]; then
  echo "✓ All other opencode instances terminated"
else
  echo "⚠ Some processes may still be running"
fi
