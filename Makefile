# where the repos are
RAISE=~/work/dygma/raise-v3/firmwares/Raise-Firmware-ARM
CORE=~/Arduino/hardware/dygma/samd
SIDES=~/work/dygma/raise-v3/firmwares/at88-matrix-test
SIDE_BOOTLOADER=~/work/dygma/raise-v3/firmwares/attiny_i2c_bootloader/

# $@ The file name of the target of the rule.rule
# $< first pre requisite
# $^ names of all preerquisites

# get commit names
RAISE_COMMIT= $(shell git -C ${RAISE} log --pretty=format:'%h' -n1)
CORE_COMMIT= $(shell git -C ${CORE} log --pretty=format:'%h' -n1)
SIDES_COMMIT= $(shell git -C ${SIDES} log --pretty=format:'%h' -n1)
SIDE_BOOTLOADER_COMMIT= $(shell git -C ${SIDE_BOOTLOADER} log --pretty=format:'%h' -n1)

DATE := $(shell date +'%Y-%m-%d')

# dir name
DIR=${DATE}-Raise-${RAISE_COMMIT}-Core-${CORE_COMMIT}-Side-${SIDES_COMMIT}-SideBootloader-${SIDE_BOOTLOADER_COMMIT}

all: ${DIR}/side.hex ${DIR}/side-with-bootloader.hex ${DIR}/Raise-firmware.bin ${DIR}/Raise-bootloader.bin latest

${DIR}:
	mkdir ${DIR}

latest:
	rm -f latest
	ln -s ${DIR} latest

${DIR}/side.hex: ${DIR}
	git -C ${SIDES} diff-index --quiet HEAD || exit 1
	cp ${SIDES}/out/attiny88_keyscanner.hex $@

${DIR}/side-with-bootloader.hex: ${DIR}
	git -C ${SIDES} diff-index --quiet HEAD || exit 1
	cp ${SIDES}/out/factory.hex $@

${DIR}/Raise-firmware.bin: ${DIR}
	git -C ${RAISE} diff-index --quiet HEAD || exit 1
	cp ${RAISE}/output/Raise-Firmware.ino.bin $@

${DIR}/Raise-bootloader.bin: ${DIR}
	git -C ${CORE} diff-index --quiet HEAD || exit 1
	cp ${CORE}/bootloaders/zero/samd21_sam_ba.bin $@
    
