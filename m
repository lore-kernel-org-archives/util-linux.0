Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-it0-f66.google.com ([209.85.214.66]:37042 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161197AbeEXT10 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 24 May 2018 15:27:26 -0400
Received: by mail-it0-f66.google.com with SMTP id 70-v6so3889527ity.2
        for <util-linux@vger.kernel.org>; Thu, 24 May 2018 12:27:26 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20180524071058.dgy5csrr6ucebwlo@ws.net.home>
References: <20180523222436.28823-1-kerolasa@iki.fi> <20180523222436.28823-2-kerolasa@iki.fi>
 <20180524071058.dgy5csrr6ucebwlo@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 24 May 2018 20:27:25 +0100
Message-ID: <CAG27Bk2S4iLOSc0bADWfQKzEVTh+-mYAxbWSO+Y2bgswZKty5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] more: remove global variables, add struct more_control
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 May 2018 at 08:10, Karel Zak <kzak@redhat.com> wrote:
> On Wed, May 23, 2018 at 11:24:36PM +0100, Sami Kerola wrote:
>> -#define Fopen(s,m)   (Currline = 0,file_pos=0,fopen(s,m))
>> -#define Ftell(f)     file_pos
>> -#define Fseek(f,off) (file_pos=off,fseek(f,off,0))
>> -#define Getc(f)              (++file_pos, getc(f))
>> -#define Ungetc(c,f)  (--file_pos, ungetc(c,f))
>> +#define Fopen(s,m)   (ctl->Currline = 0, ctl->file_pos=0, fopen(s,m))
>> +#define Ftell(f)     ctl->file_pos
>> +#define Fseek(f,off) (ctl->file_pos=off, fseek(f, off, 0))
>> +#define Getc(f)              (++ctl->file_pos, getc(f))
>> +#define Ungetc(c,f)  (--ctl->file_pos, ungetc(c,f))
>
> These macros are horrible. It would be nice to remove it by another
> patch and use standard code rather than any macros -- for example
> Fopen() is used only once.
>
> For often used stuff like Getc() it would be better to use inline functions.
>
> Anyway, modify 'ctl' (or any global variable) and don't use it as
> argument for the macro is horrible.

My intention is to get rid of these macros completely. Precarious macros
with pointer arguments will relatively soon. As it sounds you probably
want that change to be added to this series. I'll do that during weekend.

I assume you already figured these more(1) changes are related to a
change set I submitted couple years go, but what was not merged.
Basically haven't lost hope with more(1), this pager can and should
be modernised. But I did learn from previous experience that that it
is no good to send too large change set. That is why this comes in
small(ish) bits. Unfortunately first few changes will be quite sweeping.
For example most if not all variable names need renaming to make
the code understandable. When these big changes are done things
like sane signal handling (without relying on longjmp()) is in todo
list among with many other things.

>> -static char *BS = "\b";
>> -static char *BSB = "\b \b";
>> -static char *CARAT = "^";
>
> #define BS  "\b"

Ack.

>> +struct more_control {
>> +     struct termios otty;            /* output terminal */
>> +     struct termios savetty0;        /* original terminal settings */
>> +     long file_pos;                  /* file position */
>> +     long file_size;                 /* file size */
>> +     int fnum;                       /* argv[] position */
>> +     int dlines;                     /* screen size in lines */
>> +     int nscroll;                    /* number of lines scrolled by 'd' */
>> +     int promptlen;                  /* message prompt length */
>> +     int Currline;                   /* line we are currently at */
>> +     char **fnames;                  /* The list of file names */
>> +     int nfiles;                     /* Number of files left to process */
>> +     char *shell;                    /* name of the shell to use */
>> +     int shellp;                     /* does previous shell command exist */
>> +     sigjmp_buf restore;             /* siglongjmp() destination */
>> +     char *Line;                     /* line buffer */
>> +     size_t LineLen;                 /* size of Line buffer */
>> +     int Lpp;                        /* lines per page */
>> +     char *Clear;                    /* clear screen */
>> +     char *eraseln;                  /* erase line */
>> +     char *Senter;                   /* enter standout mode */
>> +     char *Sexit;                    /* exit standout mode */
>> +     char *ULenter;                  /* enter underline mode */
>> +     char *ULexit;                   /* exit underline mode */
>> +     char *chUL;                     /* underline character */
>> +     char *chBS;                     /* backspace character */
>> +     char *Home;                     /* go to home */
>> +     char *cursorm;                  /* cursor movement */
>> +     char cursorhome[40];            /* contains cursor movement to home */
>> +     char *EodClr;                   /* clear rest of screen */
>> +     int Mcol;                       /* number of columns */
>> +     char *previousre;               /* previous search() buf[] item */
>> +     struct {
>> +             long chrctr;            /* row number */
>> +             long line;              /* line number */
>> +     } context,
>> +       screen_start;
>> +     char ch;
>> +     int lastcmd;                    /* previous more key command */
>> +     int lastarg;                    /* previous key command argument */
>> +     int lastcolon;                  /* is a colon-prefixed key command */
>> +     char shell_line[SHELL_LINE];
>> +     char PC;                        /* pad character */
>> +     uint32_t
>
>  Please, 'unsigned int' as on another places.

Ack.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
