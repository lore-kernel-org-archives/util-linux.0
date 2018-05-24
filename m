Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935637AbeEXHLC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 24 May 2018 03:11:02 -0400
Date: Thu, 24 May 2018 09:10:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] more: remove global variables, add struct
 more_control
Message-ID: <20180524071058.dgy5csrr6ucebwlo@ws.net.home>
References: <20180523222436.28823-1-kerolasa@iki.fi>
 <20180523222436.28823-2-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523222436.28823-2-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 23, 2018 at 11:24:36PM +0100, Sami Kerola wrote:
> This is rather big change, but that is the only way to do this sort job.  To
> keep this change relatively understandable only moves global variables to a
> state structure.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  text-utils/more.c | 1316 +++++++++++++++++++++++----------------------
>  1 file changed, 672 insertions(+), 644 deletions(-)
> 
> diff --git a/text-utils/more.c b/text-utils/more.c
> index 603c79003..03aae421f 100644
> --- a/text-utils/more.c
> +++ b/text-utils/more.c
> @@ -85,11 +85,11 @@
>  
>  #define VI	"vi"	/* found on the user's path */
>  
> -#define Fopen(s,m)	(Currline = 0,file_pos=0,fopen(s,m))
> -#define Ftell(f)	file_pos
> -#define Fseek(f,off)	(file_pos=off,fseek(f,off,0))
> -#define Getc(f)		(++file_pos, getc(f))
> -#define Ungetc(c,f)	(--file_pos, ungetc(c,f))
> +#define Fopen(s,m)	(ctl->Currline = 0, ctl->file_pos=0, fopen(s,m))
> +#define Ftell(f)	ctl->file_pos
> +#define Fseek(f,off)	(ctl->file_pos=off, fseek(f, off, 0))
> +#define Getc(f)		(++ctl->file_pos, getc(f))
> +#define Ungetc(c,f)	(--ctl->file_pos, ungetc(c,f))

These macros are horrible. It would be nice to remove it by another
patch and use standard code rather than any macros -- for example
Fopen() is used only once.

For often used stuff like Getc() it would be better to use inline functions.

Anyway, modify 'ctl' (or any global variable) and don't use it as
argument for the macro is horrible.

> -static char *BS = "\b";
> -static char *BSB = "\b \b";
> -static char *CARAT = "^";

#define BS  "\b"
...

> +struct more_control {
> +	struct termios otty;		/* output terminal */
> +	struct termios savetty0;	/* original terminal settings */
> +	long file_pos;			/* file position */
> +	long file_size;			/* file size */
> +	int fnum;			/* argv[] position */
> +	int dlines;			/* screen size in lines */
> +	int nscroll;			/* number of lines scrolled by 'd' */
> +	int promptlen;			/* message prompt length */
> +	int Currline;			/* line we are currently at */
> +	char **fnames;			/* The list of file names */
> +	int nfiles;			/* Number of files left to process */
> +	char *shell;			/* name of the shell to use */
> +	int shellp;			/* does previous shell command exist */
> +	sigjmp_buf restore;		/* siglongjmp() destination */
> +	char *Line;			/* line buffer */
> +	size_t LineLen;			/* size of Line buffer */
> +	int Lpp;			/* lines per page */
> +	char *Clear;			/* clear screen */
> +	char *eraseln;			/* erase line */
> +	char *Senter;			/* enter standout mode */
> +	char *Sexit;			/* exit standout mode */
> +	char *ULenter;			/* enter underline mode */
> +	char *ULexit;			/* exit underline mode */
> +	char *chUL;			/* underline character */
> +	char *chBS;			/* backspace character */
> +	char *Home;			/* go to home */
> +	char *cursorm;			/* cursor movement */
> +	char cursorhome[40];		/* contains cursor movement to home */
> +	char *EodClr;			/* clear rest of screen */
> +	int Mcol;			/* number of columns */
> +	char *previousre;		/* previous search() buf[] item */
> +	struct {
> +		long chrctr;		/* row number */
> +		long line;		/* line number */
> +	} context,
> +	  screen_start;
> +	char ch;
> +	int lastcmd;			/* previous more key command */
> +	int lastarg;			/* previous key command argument */
> +	int lastcolon;			/* is a colon-prefixed key command */
> +	char shell_line[SHELL_LINE];
> +	char PC;			/* pad character */
> +	uint32_t

 Please, 'unsigned int' as on another places.

> +		bad_so:1,		/* true if overwriting does not turn off standout */
> +		catch_susp:1,		/* we should catch the SIGTSTP signal */
> +		clreol:1,		/* do not scroll, paint each screen from the top */
> +		docrterase:1,		/* is erase previous supported */
> +		docrtkill:1,		/* is erase input supported */
> +		dumb:1,			/* is terminal type known */
> +		dum_opt:1,		/* suppress bell */
> +		eatnl:1,		/* is newline ignored after 80 cols */
> +		errors:1,		/* is an error reported */
> +		firstf:1,		/* is the input file the first in list */
> +		fold_opt:1,		/* fold long lines */
> +		hard:1,			/* is this hard copy terminal (a printer or such) */
> +		hardtabs:1,		/* print spaces instead of '\t' */
> +		inwait:1,		/* is waiting user input */
> +		lastp:1,		/* run previous key command */
> +		no_intty:1,		/* is input in interactive mode */
> +		noscroll:1,		/* do not scroll, clear the screen and then display text */
> +		notell:1,		/* suppress quit dialog */
> +		no_tty:1,		/* is output in interactive mode */
> +		Pause:1,		/* is output paused */
> +		pstate:1,		/* current UL state */
> +		soglitch:1,		/* terminal has standout mode glitch */
> +		ssp_opt:1,		/* suppress white space */
> +		startup:1,		/* is startup completed */
> +		stop_opt:1,		/* stop after form feeds */
> +		ulglitch:1,		/* terminal has underline mode glitch */
> +		ul_opt:1,		/* underline as best we can */
> +		within:1,		/* true if we are within a file, false if we are between files */
> +		Wrap:1;			/* set if automargins */
> +};
> +

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
