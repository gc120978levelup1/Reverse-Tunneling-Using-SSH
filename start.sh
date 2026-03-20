#!/bin/bash
# Start SSH service
service ssh start
# Start Apache in the foreground (this keeps the container running)
apache2ctl -D FOREGROUND
