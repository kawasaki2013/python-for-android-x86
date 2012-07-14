LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CFLAGS += -DOPENSSL_BN_ASM_MONT -DAES_ASM -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DOPENSSL_NO_STATIC_ENGINE

#LOCAL_SRC_FILES:= 0.9.9-dev/bn/armv4-mont.s \
                  0.9.9-dev/aes/aes-armv4.s \
                  0.9.9-dev/sha/sha1-armv4-large.s \
                  0.9.9-dev/sha/sha256-armv4.s \
                  0.9.9-dev/sha/sha512-armv4.s

LOCAL_SRC_FILES+= \
	cryptlib.c \
	mem.c \
	mem_clr.c \
	cversion.c \
	tmdiff.c \
	ebcdic.c \
	uid.c \
	o_time.c \
	o_str.c \
	o_dir.c \

LOCAL_CFLAGS += -DNO_WINDOWS_BRAINDEATH

LOCAL_C_INCLUDES += \
	$(NDK_MODULE_PATH)/openssl \
	$(NDK_MODULE_PATH)/openssl/include \
	$(NDK_MODULE_PATH)/zlib

LOCAL_SHARED_LIBRARIES += libz

LOCAL_SHARED_LIBRARIES += libdl

LOCAL_LDLIBS += -ldl

LOCAL_MODULE:= libcrypto

include $(BUILD_SHARED_LIBRARY)
