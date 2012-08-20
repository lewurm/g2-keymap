CPPFLAGS=-g
SOURCES=KeyCharacterMap.o main.o
TARGET=dumpkeychars
VERSION=0.3
DUMP=$(addsuffix .dump,$(shell ls *.kcm.bin *.kcm.bin.orig))

all: $(TARGET) $(DUMP)

$(TARGET): $(SOURCES)
	c++ $^ -o $@

%.dump: % $(TARGET)
	./$(TARGET) $< > $@

clean:
	rm -f *.o $(TARGET) $(DUMP)

release:
	zip g2-keymap-$(VERSION).zip vision-keypad.kl vision-keypad.kl.orig vision-keypad.kcm.bin vision-keypad.kcm.bin.orig 

install:
	adb shell mount -o remount,rw /dev/block/mmcblk0p25 /system
	adb push vision-keypad-ger.kl /system/usr/keylayout/
	adb push vision-keypad-ger.kcm /system/usr/keychars/vision-keypad-ger.kcm
