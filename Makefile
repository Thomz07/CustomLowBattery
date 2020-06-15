ARCHS = armv7 arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomLowBattery

CustomLowBattery_FILES = Tweak.xm
CustomLowBattery_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
