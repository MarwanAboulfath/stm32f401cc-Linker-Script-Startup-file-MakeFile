ENTRY(Reset_Handler)/*Entry point of application to be run*/

MEMORY
{
	FLASH(rx) : 	ORIGIN = 0x08000000 ,LENGTH = 256K
	SRAM(rwx) : 	ORIGIN = 0x20000000 ,LENGTH = 20K
}

SECTIONS
{
	.text : 
	{
	s_text = . ;
	*(.isr_section)
	*(.text)
	*(.rodata)
	e_text = . ;
	}>FLASH AT >FLASH				/*>VMA>LMA*/  /* >FLASH */
	.data :
	{
	s_data = . ;
	*(.data)
	. = ALIGN(8);
	e_data = . ;
	}>SRAM AT >FLASH
	.bss :
	{
	s_bss = . ;
	*(.bss)
	e_bss = . ;
	}>SRAM


}