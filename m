Return-Path: dave@gnu.org
Subject: Re: [PATCH] whereis: search in path variable
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20110721165141.GG22568@nb.net.home>
References: <1311137185.3077.1.camel@offbook>
	 <20110721165141.GG22568@nb.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Jul 2011 19:01:39 -0400
Message-ID: <1311548499.3367.13.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Thu, 2011-07-21 at 18:51 +0200, Karel Zak wrote:
> On Wed, Jul 20, 2011 at 12:46:25AM -0400, Davidlohr Bueso wrote:
> > From: Davidlohr Bueso <dave@gnu.org>
> > Date: Wed, 20 Jul 2011 00:39:10 -0400
> > 
> > Currently this tool only uses the hardcoded paths for looking up
> > strings for binaries, man pages and source code, adding those
> > directories found in $PATH makes a nice little enhancement.
> 
>  Finally someone who is not lazy to implement it correctly :-)
...
>  man getenv, you should not modify the result from getenv().

ouch, sorry!

> 
> > +		if (!tok)
> > +			break;
> > +		if (inpath(tok)) /* make sure we don't repeat the search path */
> > +			continue;
> > +
> > +		pathdir = xrealloc(pathdir, (i + 1) * sizeof(char *));
> > +		pathdir[i++] = tok;
> > +	}
> 
>  here is bug, see below to gdb backtrace...
> 
> > +
> >  void
> >  getlist(int *argcp, char ***argvp, char ***flagp, int *cntp)
> >  {
> > @@ -356,6 +407,8 @@ find(char **dirs, char *cp)
> >  {
> >  	while (*dirs)
> >  		findin(*dirs++, cp);
> > +	while(*dirp)
>           ^^^^^^
> > +		findin(*dirp++, cp);
> 
>  ... this code expects that the array is terminated by zero.
> 
> Note that find() is called always for all dir lists.
> 
> Maybe it would be better to add lookpathenv() and call it from
> print_again(). You can also add -p options to control this behavior.
> See how {s,b,m}flags work.

That was my initial design, however since src, bin and man are _types_
of files, it seems that adding a similar behavior for search _paths_ is
like mixing apples and pears.

Something I am thinking of, but won't do it quite yet, is to simply
rewrite whereis and, instead of hardcoding paths, recursively search
from / and use stat + heuristics to differentiate the different files.

> 
> BTW, the whole whereis code is horrible, 

Like most BSD '80s code is. I was hoping you weren't going to ask for
cleanups :)

> for example find() is completely
> unnecessary if there is also findv() and all lists of the directories are
> static. It should be possible to use
> 
>   findv(ary, ARRAY_SIZE(ary), str);
> 
> everywhere instead of find(ary, str);
> 
>     Karel
> 
> Starting program: /home/projects/util-linux/util-linux/misc-utils/whereis lsblk
> 
> Program received signal SIGSEGV, Segmentation fault.

That'll teach me not to code half asleep. I'm sending you some cleanup
patches and then I'll add these fixes to the program.

> 0x0000003cbae7edfa in __strchr_sse2 () from /lib64/libc.so.6
> Missing separate debuginfos, use: debuginfo-install glibc-2.14-4.x86_64
> (gdb) bt
> #0  0x0000003cbae7edfa in __strchr_sse2 () from /lib64/libc.so.6
> #1  0x00000000004013c8 in findin (dir=0x1ff41 <Address 0x1ff41 out of bounds>, 
>     cp=0x7fffffffe477 "lsblk") at whereis.c:434
> #2  0x0000000000401623 in find (dirs=<optimized out>, 
>     cp=0x7fffffffe477 "lsblk") at whereis.c:421
> #3  0x00000000004017a8 in print_again (cp=0x7fffffffe477 "lsblk")
>     at whereis.c:327
> #4  0x0000000000401870 in lookup (cp=0x7fffffffe477 "lsblk") at whereis.c:374
> #5  0x0000000000400c9b in main (argc=1, argv=0x7fffffffe148) at whereis.c:242

- Davidlohr
