#!/bin/bash
set -euxo pipefail

target_dir="rawData"
tar -pcvf ${target_dir}_backup.tar ${target_dir}
gzip ${target_dir}_backup.tar -9


