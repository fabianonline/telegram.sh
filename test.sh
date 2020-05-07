#!/bin/bash

echo "command: $@"
"$@"
RETURN_CODE=$?
echo "RETURN_CODE: $RETURN_CODE"
