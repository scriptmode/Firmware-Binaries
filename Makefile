RAISE=~/work/shortcut/raise-v3/firmwares/Raise-Firmware-ARM
CORE=~/Arduino/hardware/dygma/samd
SIDES=~/work/shortcut/raise-v3/firmwares/at88-matrix-test

RAISE_COMMIT= $(shell git -C ${RAISE} log --pretty=format:'%h' -n1)
CORE_COMMIT= $(shell git -C ${CORE} log --pretty=format:'%h' -n1)
SIDES_COMMIT= $(shell git -C ${SIDES} log --pretty=format:'%h' -n1)

DATE := $(shell date +'%Y-%m-%d')

DIR=${DATE}-Raise-${RAISE_COMMIT}-Core-${CORE_COMMIT}-Side-${SIDES_COMMIT}

all: ${DIR}/Left.hex ${DIR}/Right.hex ${DIR}/Raise.hex
${DIR}:
	mkdir ${DIR}

${DIR}/Left.hex:
	cp ${SIDES}/out/attiny88_keyscanner_left.hex ${DIR}/Left.hex

${DIR}/Right.hex:
	cp ${SIDES}/out/attiny88_keyscanner_right.hex ${DIR}/Right.hex

${DIR}/Raise.hex:
	cp ${RAISE}/output/Raise-Firmware.ino.hex ${DIR}/Raise.hex
