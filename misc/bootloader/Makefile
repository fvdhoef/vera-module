
all:
	xa -v -W -B -o out/8kb.bin data6502.a65
	cat out/8kb.bin out/8kb.bin > out/16kb.bin
	cat out/16kb.bin out/16kb.bin > out/32kb.bin
	cat out/32kb.bin out/32kb.bin > out/64kb.bin
