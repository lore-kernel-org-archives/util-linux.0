Return-Path: bigeasy@linutronix.de
Date: Wed, 29 Feb 2012 22:31:28 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] conifigure: add a crosscompile path for
 scanf_cv_alloc_modifier
Message-ID: <20120229213128.GA11628@linutronix.de>
References: <1330103768-32139-1-git-send-email-bigeasy@linutronix.de>
 <20120228141226.GC22034@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20120228141226.GC22034@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

* Karel Zak | 2012-02-28 15:12:26 [+0100]:

>> @@ -387,6 +387,8 @@ AC_CACHE_VAL([scanf_cv_alloc_modifier],
>>        [scanf_cv_alloc_modifier=as],
>>        [scanf_cv_alloc_modifier=no]
>>      )
>> +    ,
>> +    [scanf_cv_alloc_modifier=no]
>>    )
>>  )
>
> Applied, thanks.
>
> ...but it means that you will compile the package without libmount.
> Is it expected? In the next release fsck will depend on the library,
> we have new mount and umount, ....
>
> Is it really true that your glibc is without %as / %ms ?

So I've been greping for have_scanf_alloc_modifier and did not find a
user. Well now that you mentioned, I see a user in configure.... So now
we need something like a proper fix hmm.... What about this:
- you don't want %as as it is non-standard evil
- %m is good enough an available since glibc 2.7. Why should someone
  take old glibc (2.7 was released Thu Oct 18 00:09:32 2007 +0000) and
  new util-linux?
- uClibc seems not to support it. The code seems to be behind an ifdef
  and the define itseld is hidden in a comment

If this is okay then what about:

>From 921475f1b5f11699bc311c0f1c94d5da830edfd6 Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 29 Feb 2012 22:26:19 +0100
Subject: [PATCH] build-sys: make the crosscompile path for
 scanf_cv_alloc_modifier clever

My earlier assumption was that scanf_cv_alloc_modifier is unused. This
is not true as pointed out by Karel since it used befoe checking for
libmount. Argh. So instead saying no I add a test to check for glibc
>= 2.7 which provides %m. As of uClibc v0.9.32-rc3 the situation looks
the following:
| git grep _M_SPEC__
|libc/stdio/_vfprintf.c:/* #define __UCLIBC_HAS_PRINTF_M_SPEC__ */
|libc/stdio/_vfprintf.c:#ifdef __UCLIBC_HAS_PRINTF_M_SPEC__
|libc/stdio/_vfprintf.c:# ifdef __UCLIBC_HAS_PRINTF_M_SPEC__
|libc/stdio/_vfprintf.c:# endif /* __UCLIBC_HAS_PRINTF_M_SPEC__ */
|libc/stdio/_vfprintf.c:#ifdef __UCLIBC_HAS_PRINTF_M_SPEC__
|libc/stdio/_vfprintf.c:#ifdef __UCLIBC_HAS_PRINTF_M_SPEC__
|libc/stdio/_vfprintf.c:#ifdef __UCLIBC_HAS_PRINTF_M_SPEC__
|libc/stdio/_vfprintf.c:#ifdef __UCLIBC_HAS_PRINTF_M_SPEC__
|libc/stdio/old_vfprintf.c:#ifdef __UCLIBC_HAS_PRINTF_M_SPEC__
|libc/stdio/perror.c:#ifdef __UCLIBC_HAS_PRINTF_M_SPEC__

And other libc user have to bring their own stuff.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 configure.ac |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index b40a636..0a3016b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -384,7 +384,23 @@ AC_CACHE_VAL([scanf_cv_alloc_modifier],
       [scanf_cv_alloc_modifier=no]
     )
     ,
-    [scanf_cv_alloc_modifier=no]
+
+    [AC_COMPILE_IFELSE([AC_LANG_SOURCE([
+     #include <stdio.h>
+
+     #ifdef __GLIBC__
+
+     #if !(__GLIBC_PREREQ(2, 7))
+     #error %m is not available
+     #endif
+
+     #else
+
+     #error Your C-library is not supported.
+     #endif
+     ])],
+    [scanf_cv_alloc_modifier=ms],
+    [scanf_cv_alloc_modifier=no])]
   )
 )
 
-- 
1.7.9

Which results in:
| grep -E "%m|mount" log
|checking scanf string alloc modifiers... (%ms) yes
|config.status: creating libmount/Makefile
|config.status: creating libmount/docs/Makefile
|config.status: creating libmount/docs/version.xml
|config.status: creating libmount/mount.pc
|config.status: creating libmount/src/Makefile
|config.status: creating libmount/src/libmount.h
|config.status: creating mount/Makefile


>
>    Karel
>

Sebastian
