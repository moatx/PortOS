#include <console.h>
#include <cpu.h>

#define VGA_WIDTH 80
#define cons_buf (volatile char*)0xB8000
#define black 0x07
#define newline() (char_loc = char_loc + (160 - (char_loc % 160))) /* 160 is the line size (the result of 80 collums * element and each element takes 2 bytes (bytes for each elements)); line size - char location % line size (to find the length) + char location */

volatile char* txt;
unsigned int char_loc = 0; /* the reason why this is global is because if its local all the stored data will be lost when the function returns, and that means it'll print the new char in the same place the old char is not next to it */
/*
int x = 0;
int y = 0;
*/

/*
void update_cursor(int, int);
*/

void 
consinit(void)
{
    int j = 0;
    txt = cons_buf;

    /* disable the cursor for now */
    outb(0x3D4, 0x0A);
    outb(0x3D5, 0x20);

    /* there are 25 lines each of 80 columns; each element takes 2 bytes */
    while(j < 80 * 25 * 2) {
        txt[j] = ' ';
        txt[j+1] = black; 		
        j = j + 2;
}
}

/* 
 * prints a character by adding two to the buffer for next character, and by adding another one for color.
 */

void 
printc(char str, int color) 
{
    if(str == '\n'){
        char_loc = char_loc + (160 - (char_loc % 160));
	/*
        update_cursor(x,y++);
	*/
    }

    txt[char_loc++] = str;
    txt[char_loc++] = color;

}

/* 
 * prints a string by checking if the string has ended in a while loop
 */

void 
printl(const char* str, int color) 
{
    unsigned int l = 0;
    while (str[l] != '\0'){
        printc(str[l], color);
        ++l;
  }
/*
    update_cursor(x+l,y);
*/
}
/* print to the console with black as the color by calling printl */

void
printf(const char* str)
{
	printl(str,black);
}
/*
void 
update_cursor(int ix, int iy)
{
	uint16_t pos = iy * VGA_WIDTH + ix;

	outb(0x3D4, 0x0F);
	outb(0x3D5, (uint8_t) (pos & 0xFF));
	outb(0x3D4, 0x0E);
	outb(0x3D5, (uint8_t) ((pos >> 8) & 0xFF));
}
*/
