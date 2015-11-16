#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fortune -s | cowsay -f "$DIR/dynamic_duo.cow" -n > /etc/motd