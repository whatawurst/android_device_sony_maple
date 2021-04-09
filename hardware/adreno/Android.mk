VULKAN_LIB_PATH := hw/vulkan.msm8998.so

VULKAN_SYMLINK := $(TARGET_OUT_VENDOR)/lib/vulkan.msm8998.so
$(VULKAN_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating lib/vulkan.msm8998.so symlink: $@"
	@mkdir -p $(dir $@)
	$(hide) ln -sf $(VULKAN_LIB_PATH) $@

VULKAN64_SYMLINK := $(TARGET_OUT_VENDOR)/lib64/vulkan.msm8998.so
$(VULKAN64_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating lib64/vulkan.msm8998.so symlink: $@"
	@mkdir -p $(dir $@)
	$(hide) ln -sf $(VULKAN_LIB_PATH) $@

ALL_DEFAULT_INSTALLED_MODULES += \
	$(VULKAN_SYMLINK) \
	$(VULKAN64_SYMLINK)
