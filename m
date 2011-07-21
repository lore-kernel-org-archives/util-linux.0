Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60068 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab1GURaM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jul 2011 13:30:12 -0400
Date: Thu, 21 Jul 2011 18:51:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] whereis: search in path variable
Message-ID: <20110721165141.GG22568@nb.net.home>
References: <1311137185.3077.1.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311137185.3077.1.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 20, 2011 at 12:46:25AM -0400, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
> Date: Wed, 20 Jul 2011 00:39:10 -0400
> 
> Currently this tool only uses the hardcoded paths for looking up
> strings for binaries, man pages and source code, adding those
> directories found in $PATH makes a nice little enhancement.

 Finally someone who is not lazy to implement it correctly :-)

> +char    **dirp, **pathdir = NULL;

 It's unnecessary to initialize global variables to 0 or NULL.

>  main(int argc, char **argv)
>  {
> +	int i;

 variable not used

>  	setlocale(LC_ALL, "");
>  	bindtextdomain(PACKAGE, LOCALEDIR);
>  	textdomain(PACKAGE);
> @@ -179,6 +185,9 @@ main(int argc, char **argv)
>  	argc--, argv++;
>  	if (argc == 0)
>  		usage(stderr);
> +	
> +	fillpath();
> +	dirp = pathdir;

 it would be better to hide 'dirp = pathdir' to fillpath().

>  	do
>  		if (argv[0][0] == '-') {
> @@ -232,9 +241,51 @@ main(int argc, char **argv)
>  		} else
>  			lookup(*argv++);
>  	while (--argc > 0);
> +
> +	free(pathdir);

 add freepath()
>  
> +int inpath(const char *str)
> +{
> +	int i;
> +
> +	for (i = 0; i < sizeof(bindirs)/sizeof(char *) - 1 ; i++)
                    ^^^^^^^^^^^^^^^^^^^
 We have ARRAY_SIZE() in c.h, or you can use the fact that arrays are
 terminated by zero.

> +		if (!strcmp(bindirs[i], str))
> +			return 1;
> +	
> +	for (i = 0; i < sizeof(mandirs)/sizeof(char *) - 1; i++)
> +		if (!strcmp(mandirs[i], str))
> +			return 1;
> +		
> +	for (i = 0; i < sizeof(srcdirs)/sizeof(char *) - 1; i++)
> +		if (!strcmp(srcdirs[i], str))
> +			return 1;
> +	
> +	return 0;
> +}
> +
> +void fillpath(void)
> +{
> +	char *key=NULL, *tmp=NULL, *tok=NULL, *path = getenv("PATH");
> +	int i = 0;
> +
> +	if (!path)
> +		return;
> +
> +	for (tmp = path; ;tmp = NULL) {
> +		tok = strtok_r(tmp, ":", &key);

 man getenv, you should not modify the result from getenv().

> +		if (!tok)
> +			break;
> +		if (inpath(tok)) /* make sure we don't repeat the search path */
> +			continue;
> +
> +		pathdir = xrealloc(pathdir, (i + 1) * sizeof(char *));
> +		pathdir[i++] = tok;
> +	}

 here is bug, see below to gdb backtrace...

> +
>  void
>  getlist(int *argcp, char ***argvp, char ***flagp, int *cntp)
>  {
> @@ -356,6 +407,8 @@ find(char **dirs, char *cp)
>  {
>  	while (*dirs)
>  		findin(*dirs++, cp);
> +	while(*dirp)
          ^^^^^^
> +		findin(*dirp++, cp);

 ... this code expects that the array is terminated by zero.

Note that find() is called always for all dir lists.

Maybe it would be better to add lookpathenv() and call it from
print_again(). You can also add -p options to control this behavior.
See how {s,b,m}flags work.

BTW, the whole whereis code is horrible, for example find() is completely
unnecessary if there is also findv() and all lists of the directories are
static. It should be possible to use

  findv(ary, ARRAY_SIZE(ary), str);

everywhere instead of find(ary, str);

    Karel

Starting program: /home/projects/util-linux/util-linux/misc-utils/whereis lsblk

Program received signal SIGSEGV, Segmentation fault.
0x0000003cbae7edfa in __strchr_sse2 () from /lib64/libc.so.6
Missing separate debuginfos, use: debuginfo-install glibc-2.14-4.x86_64
(gdb) bt
#0  0x0000003cbae7edfa in __strchr_sse2 () from /lib64/libc.so.6
#1  0x00000000004013c8 in findin (dir=0x1ff41 <Address 0x1ff41 out of bounds>, 
    cp=0x7fffffffe477 "lsblk") at whereis.c:434
#2  0x0000000000401623 in find (dirs=<optimized out>, 
    cp=0x7fffffffe477 "lsblk") at whereis.c:421
#3  0x00000000004017a8 in print_again (cp=0x7fffffffe477 "lsblk")
    at whereis.c:327
#4  0x0000000000401870 in lookup (cp=0x7fffffffe477 "lsblk") at whereis.c:374
#5  0x0000000000400c9b in main (argc=1, argv=0x7fffffffe148) at whereis.c:242

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
