#include <gdt.h>

void init_gdt(void);
void init(void);

static void cls(void);
static void print(char *str);
static unsigned int char_loc = 0;

#define cons_buf (volatile char*)0xB8000
#define black 0x07


gdt_entry_t gdt_entries[5];
gdt_ptr_t gdt_ptr;
/*
idt_entry_t idt_entries[256];
idt_ptr_t   idt_ptr;
*/

void
init_gdt(void)
{
	gdt_ptr.limit = (sizeof(gdt_entry_t) * 5) - 1;
	gdt_ptr.base = (uint32_t) & gdt_entries;
/*
	gdt_set_gate(0, 0, 0, 0, 0);
*/
	/* NULL segment */
	/* gdt_set_gate(1, 0, 0xFFFFFFFF, 0x9A, 0xCF); */
	/* code segment */
	/* gdt_set_gate(2, 0, 0xFFFFFFFF, 0x92, 0xCF); */
	/* data segment */
	/* gdt_set_gate(3, 0, 0xFFFFFFFF, 0xFA, 0xCF); */
	/* user mode code segment */
	/* gdt_set_gate(4, 0, 0xFFFFFFFF, 0xF2, 0xCF); */
	/* user mode data segment */
	/* gdt_flush((u32int) & gdt_ptr); */
}


void
init(void)
{
	cls();
	print("initializing neccesary md gdt and idt");
	for (;;);
}

static void
cls(void)
{
	int j = 0;
	volatile char *txt = cons_buf;

	while (j < 80 * 25 * 2) {
		txt[j] = ' ';
		txt[j + 1] = black;
		j = j + 2;
	}
}
/* early debug print function */
static void
print(char *str)
{
	unsigned int l = 0;
	volatile char *txt = cons_buf;
	while (str[l] != '\0') {
		if (str[l] == '\n') {
			char_loc = char_loc + (160 - (char_loc % 160));
		} else if (str[l] >= ' ') {
			txt[char_loc++] = str[l];
			txt[char_loc++] = black;
		}
		++l;
	}
}
