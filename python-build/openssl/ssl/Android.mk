LOCAL_PATH:= $(call my-dir)

local_c_includes := \
	$(NDK_MODULE_PATH)/openssl \
	$(NDK_MODULE_PATH)/openssl/include \
	$(NDK_MODULE_PATH)/openssl/crypto

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	kssl.c

include $(LOCAL_PATH)/../android-config.mk

LOCAL_C_INCLUDES += $(local_c_includes)

LOCAL_SHARED_LIBRARIES += libcrypto

LOCAL_MODULE:= libssl

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

# ssltest

LOCAL_SRC_FILES:=ssltest.c

LOCAL_C_INCLUDES += $(local_c_includes)

LOCAL_SHARED_LIBRARIES := libssl

include $(LOCAL_PATH)/../android-config.mk

LOCAL_MODULE:=ssltest

LOCAL_MODULE_TAGS := optional

include $(BUILD_EXECUTABLE)
