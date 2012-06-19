Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51377 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab2FSNtt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Jun 2012 09:49:49 -0400
Received: by wgbdr13 with SMTP id dr13so6829582wgb.1
        for <util-linux@vger.kernel.org>; Tue, 19 Jun 2012 06:49:47 -0700 (PDT)
From: Marek Otahal <markotahal@gmail.com>
To: util-linux@vger.kernel.org
Subject: [cont.2] Clang analysis warnings WAS: Re: dev.c : Warning - dereference of null pointer, clang --analyze
Date: Tue, 19 Jun 2012 15:49:24 +0200
Message-ID: <103088032.Rojk1ZUChg@beruska>
In-Reply-To: <5021496.29gTT1mHgK@beruska>
References: <1468557.if6BRfJlxj@beruska> <5021496.29gTT1mHgK@beruska>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 19 of June 2012 14:46:53 you wrote:
> Clang/llvm analysis on recent git master, hope some of them are relevant (not all mistakes by clang). 
> 
> There're memleaks, null pointers passed, uninitialized params passed, execution with unknow priviledges(!), 
> null pointere dereference, buffer overflow, etc.
> 
> Sorry, the list is quite long, but please take time to skim it all, i didnt sort the warnings by importance, just as they appeared. 
> 
  CC       parse.o
parse.c:144:10: warning: Size argument is greater than the length of the destination buffer
                (void) strncpy(tfu->fmt, savep, p - savep);
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/bits/string2.h:761:33: note: expanded from macro 'strncpy'
#  define strncpy(dest, src, n) __builtin_strncpy (dest, src, n)
                                ^



  CC       ul.o
ul.c:481:22: warning: The left operand of '==' is a garbage value
        for (*cp = ' '; *cp == ' '; cp--)
                        ~~~ ^
ul.c:447:22: warning: The left operand of '==' is a garbage value
        for (*cp = ' '; *cp == ' '; cp--)
                        ~~~ ^




 CC       pg.o
pg.c:1223:7: warning: Value stored to 'sz' is never read
                                                sz = regerror(rerror, &re,
                                                ^    ~~~~~~~~~~~~~~~~~~~~~



  CC       hwclock.o
hwclock.c:1671:2: warning: Value stored to 'argv' is never read
        argv += optind;
        ^       ~~~~~~



  CC       rtc.o
rtc.c:309:4: warning: The left expression of the compound assignment is an uninitialized value. The computed
      value will also be garbage
                        FD_SET(rtc_fd, &rfds);
                        ^~~~~~~~~~~~~~~~~~~~~
/usr/include/sys/select.h:91:28: note: expanded from macro 'FD_SET'
#define FD_SET(fd, fdsetp)      __FD_SET (fd, fdsetp)
                                ^
/usr/include/bits/select.h:51:43: note: expanded from macro '__FD_SET'
  ((void) (__FDS_BITS (set)[__FD_ELT (d)] |= __FD_MASK (d)))
                                          ^



  CC       mount-mount.o
mount.c:2768:9: warning: Dereference of null pointer
                                    mc->m.mnt_opts, options, 0, 0);
                                    ^~~~~~~~~~~~~~
mount.c:2036:2: warning: Null pointer argument in call to string copy function
        strncpy (n, s, sub-s);
        ^~~~~~~~~~~~~~~~~~~~~
/usr/include/bits/string2.h:761:33: note: expanded from macro 'strncpy'
#  define strncpy(dest, src, n) __builtin_strncpy (dest, src, n)
                                ^
mount.c:2060:17: warning: Memory is never released; potential leak of memory pointed to by 'opts'
        return xstrdup(opts);
                       ^~~~
3 warnings generated.



  CC       mount-sundries.o
sundries.c:33:6: warning: Null pointer argument in call to string copy function
     strncpy(t,s,n);
     ^~~~~~~~~~~~~~
/usr/include/bits/string2.h:761:33: note: expanded from macro 'strncpy'
#  define strncpy(dest, src, n) __builtin_strncpy (dest, src, n)
                                ^



  CC       mount-fstab.o
fstab.c:832:6: warning: Dereference of null pointer (loaded from variable 'dest')
        if (*dest) {
            ^~~~~




Now, compilation finished correctly :) 
With regards, 
Mark
-- 

Marek Otahal :o)
