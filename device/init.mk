### DEVICE INIT
PRODUCT_PACKAGES += \
    init.recovery.maple \
    init.maple \
    ueventd.maple

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/ramdisk/fstab.maple:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.maple
