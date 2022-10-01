#
# Copyright (C) 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit AOSP configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Qcom standard decryption
PRODUCT_PACKAGES += \
	qcom_decrypt \
	qcom_decrypt_fbe

## Device identifier. This must come after all inclusions
PRODUCT_NAME := twrp_maple
PRODUCT_DEVICE := maple
PRODUCT_BRAND := Sony
PRODUCT_MODEL := G8141
PRODUCT_MANUFACTURER := Sony

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=maple \
    PRIVATE_BUILD_DESC="G8141-user 9 47.2.A.10.107 172320177 release-keys"

BUILD_FINGERPRINT := Sony/G8141/G8141:9/47.2.A.10.107/172320177:user/release-keys

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.usb.pid_suffix=1F1 \
    vendor.usb.rndis.func.name=gsi
