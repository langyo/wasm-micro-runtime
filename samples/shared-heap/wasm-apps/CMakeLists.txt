# Copyright (C) 2019 Intel Corporation.  All rights reserved.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

cmake_minimum_required(VERSION 3.14)
project(wasm-apps)

set(WAMR_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../..)

if (APPLE)
  set (HAVE_FLAG_SEARCH_PATHS_FIRST 0)
  set (CMAKE_C_LINK_FLAGS "")
  set (CMAKE_CXX_LINK_FLAGS "")
endif ()

set (CMAKE_SYSTEM_PROCESSOR wasm32)
set (CMAKE_SYSROOT ${WAMR_ROOT_DIR}/wamr-sdk/app/libc-builtin-sysroot)

if (NOT DEFINED WASI_SDK_DIR)
  set (WASI_SDK_DIR "/opt/wasi-sdk")
endif ()

set (CMAKE_C_FLAGS "-nostdlib -Qunused-arguments -z stack-size=32768")
set (CMAKE_C_COMPILER_TARGET "wasm32")
set (CMAKE_C_COMPILER "${WASI_SDK_DIR}/bin/clang")

set (DEFINED_SYMBOLS "${WAMR_ROOT_DIR}/wamr-sdk/app/libc-builtin-sysroot/share/defined-symbols.txt")

set (CMAKE_EXE_LINKER_FLAGS
     "-O0 -Wl,--initial-memory=65536,              \
      -Wl,--no-entry,--strip-all,                  \
      -Wl,--export=__heap_base,--export=__data_end \
      -Wl,--export=__wasm_call_ctors               \
      -Wl,--export-all                             \
      -Wl,--allow-undefined"
)

add_executable(test1.wasm test1.c)
target_link_libraries(test1.wasm)

add_executable(test2.wasm test2.c)
target_link_libraries(test2.wasm)
