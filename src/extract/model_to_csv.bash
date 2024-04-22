#!/bin/bash

tr ' ' '\n' $@ | grep -F "slot_area" | sed -E "s/slot_area\(//" | sed -E "s/\)$//" | sed "s/(//" | sed "s/)//"
