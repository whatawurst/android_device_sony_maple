#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=maple
VENDOR=sony

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi


# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
extract "${MY_DIR}/proprietary-files-vendor.txt" "${SRC}" "${KANG}" --section "${SECTION}"

DEVICE_ROOT="${ANDROID_ROOT}"/vendor/"${VENDOR}"/"${DEVICE}"/proprietary/

# Use v28 libprotobuf
# Using patchelf on them doesn't work for some reason
sed -i "s|libprotobuf-cpp-lite.so|libpootobuf-cpp-lite.so|g" "${DEVICE_ROOT}"/vendor/lib/libwvhidl.so
sed -i "s|libprotobuf-cpp-lite.so|libpootobuf-cpp-lite.so|g" "${DEVICE_ROOT}"/vendor/lib64/libwvhidl.so 
sed -i "s|libprotobuf-cpp-full.so|libpootobuf-cpp-full.so|g" "${DEVICE_ROOT}"/vendor/lib/libsettings.so 
sed -i "s|libprotobuf-cpp-full.so|libpootobuf-cpp-full.so|g" "${DEVICE_ROOT}"/vendor/lib64/libsettings.so 
sed -i "s|libprotobuf-cpp-lite.so|libpootobuf-cpp-lite.so|g" "${DEVICE_ROOT}"/vendor/lib/mediadrm/libwvdrmengine.so 
sed -i "s|libprotobuf-cpp-lite.so|libpootobuf-cpp-lite.so|g" "${DEVICE_ROOT}"/vendor/lib64/mediadrm/libwvdrmengine.so 

# Move fpc firmware to vendor
sed -i "s|/system/etc/firmware|/vendor/firmware\x0\x0\x0\x0|g" "${DEVICE_ROOT}"/vendor/lib/lib_fpc_tac_shared.so
sed -i "s|/system/etc/firmware|/vendor/firmware\x0\x0\x0\x0|g" "${DEVICE_ROOT}"/vendor/lib64/lib_fpc_tac_shared.so

#
# Fix product path
#

function fix_product_path () {
    sed -i \
        's/\/system\/framework\//\/system\/product\/framework\//g' \
        "${DEVICE_ROOT}"/"$1"
}

fix_product_path product/etc/permissions/com.qualcomm.qti.imscmservice-V2.0-java.xml
fix_product_path product/etc/permissions/com.qualcomm.qti.imscmservice-V2.1-java.xml
fix_product_path product/etc/permissions/com.qualcomm.qti.imscmservice.xml
fix_product_path product/etc/permissions/embms.xml
fix_product_path product/etc/permissions/lpa.xml
fix_product_path product/etc/permissions/qcrilhook.xml
fix_product_path product/etc/permissions/telephonyservice.xml

"${MY_DIR}"/setup-makefiles.sh
