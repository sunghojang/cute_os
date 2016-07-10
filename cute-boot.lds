OUTPUT_FORMAT("elf32-littlearm","elf32-bigarm","elf32-littlearm")
OUTPUT_ARCH(arm)

ENTRY(except_vec_start)

SECTIONS
{
	. =0x40010000;
	. =ALIGN(4);
	.text : {start.o(.text) *(.text)}
	
	. =ALIGN(4);
	.rodata : {*(.rodata)}

	. =ALIGN(4);
	.data : {*(EXCLUDE_FILE(cuteOS.bin.o).data)}

	. =ALIGN(4);
	_os_start = .;
	.cuteOS : {cuteOS.bin.o}
	
	. =ALIGN(4);
	_os_end = .;

	. =ALIGN(4);
	__bss_start = .;
	.bss : {*(.bss)}
	__bss_end = .;
}