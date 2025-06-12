MEMORY {
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 64K  /* C8T6 Flash 大小 */
    RAM (xrw)  : ORIGIN = 0x20000000, LENGTH = 20K  /* C8T6 RAM 大小 */
}

SECTIONS {
    .text : {
        *(.isr_vector)
        *(.text*)
    } > FLASH
    /* 其他段（如.data、.bss）... */
}