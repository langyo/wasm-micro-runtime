# Copyright (C) 2019 Intel Corporation.  All rights reserved.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#!/bin/bash
TARGET=$1
HEAP_SIZE=$2
./iwasm -g=0.0.0.0:1234 --heap-size=${HEAP_SIZE} /mnt/build/${TARGET}.wasm
