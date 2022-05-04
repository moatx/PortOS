/*	$BASE style.c,v 0.0 2021/07/01 12:57:50 moatx Exp $		*/

/*
 * Copyright 2021 BASE. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE AUTHORS AND CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/* Includes appear before anything else, after the license. */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/* Directly after the include statements comes a comment explaining what the file does in general terms. */

/*
 * This file shows an example usage of the coding style by making a small cat utility.
 */

/* Macros, variable declarations, and function prototypes goes here, in that order. */
#define BUFSIZE 32768


void cat(char*);

/* There must be a comment on top of all functions explaining what it does. */

/*
 * Receives the file as input and passes it to cat function.
 */

/* Return types for functions need to be on the line preceeding the line containing the function name. */
int
main(int argc, char **argv)
{
  char* file = NULL;

  if(argc == 2)
    file = argv[1];

  cat(file);
  return 0;
}

/*
 * Prints the text found in the file to standard output.
 */

void 
cat(char* f)
{
	/* Notice how variables are declared first and defined later. */
        int c;
        FILE *fs; 

	/* Statements that only occur on a single line do not need closing braces. */
	if(f == NULL)
	   fs = stdin;
	else
	   fs = fopen(f,"r");

	/* On the other hand, statments that require more than one line needs opening and closing braces. */
        while((c = fgetc(fs)) != EOF ){
            if(putchar(c) < EOF ){
                exit(1);
        }
        }
}
