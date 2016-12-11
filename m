Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20161209131501.5vmmx6jbg7qnz6f3@ws.net.home>
References: <20161204091259.12651-1-kerolasa@iki.fi> <20161209131501.5vmmx6jbg7qnz6f3@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 11 Dec 2016 12:05:06 +0000
Message-ID: <CAG27Bk2ciWO7e1Bfb6z7HUeBz_L63jqnxifO7=H9Dz0KmFFJLw@mail.gmail.com>
Subject: Re: [PATCH] lib/randutils: use getrandom(2) when it is available
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 9 December 2016 at 13:15, Karel Zak <kzak@redhat.com> wrote:

Thank you Karel for good and easy to action review.

> On Sun, Dec 04, 2016 at 09:12:59AM +0000, Sami Kerola wrote:
>> +AC_CHECK_FUNCS([getrandom], [], [
>> +     AS_IF([UL_CHECK_SYSCALL([getrandom])
>> +       test "$ul_cv_syscall_getrandom" = SYS_getrandom],
>> +             [AC_DEFINE([SYSTEM_GETRANDOM], [1],
>> +                     [Define if getrandom syscall is missing from libc])
>> +     ])
>> +])
>
> I have doubts we need SYSTEM_GETRANDOM macro:

Removed, and getrandom() check added to long AC_CHECK_FUNCS list.

> Why not like in another utils (see sched utils for example):
>
> #ifndef HAVE_FALLOCATE
> # include <sys/syscall.h>
> #else
> # include <linux/random.h>
> #endif
>
> /* usable kernel-headers, but old glibc-headers */
> #if defined (__linux__) && !defined(SYS_getrandom) && defined(__NR_getrandom)
> # define SYS_getrandom __NR_getrandom
> #endif
>
> /* libc without function, but we have syscal */
> #if !defined(HAVE_GETRANDOM) && defined(SYS_getrandom)
> static int getrandom(void *buf, size_t buflen, unsigned int flags)
> {
>     return (syscall(SYS_getrandom, buf, buflen, flags));
> }
> #define HAVE_GETRANDOM
> #endif

Done very similar way as above, with exception sys/syscall.h is
included only when __linux__ is defined.  I am not entirely sure,
but osx compilation for example is less prone to break this way.

CC: Rudi
https://github.com/kerolasa/lelux-utiliteetit/blob/cc01c2dca4f62e36505570d5cb15f868aa44bf54/lib/randutils.c#L30

>>  /*
>>   * Generate a stream of random nbytes into buf.
>>   * Use /dev/urandom if possible, and if not,
>> @@ -72,10 +87,19 @@ int random_get_fd(void)
>>   */
>>  void random_get_bytes(void *buf, size_t nbytes)
>>  {
>> -     size_t i, n = nbytes;
>> +     size_t i;
>> +     unsigned char *cp = (unsigned char *)buf;
>> +
>> +#if defined(SYSTEM_GETRANDOM) || defined(HAVE_GETRANDOM)
>
> #ifdef HAVE_GETRANDOM
>
>>  const char *random_tell_source(void)
>>  {
>> +#if defined(SYSTEM_GETRANDOM)
>> +     return _("syscall(SYS_getrandom) function");
>> +#elif defined(HAVE_GETRANDOM)
>> +     return _("libc getrandom() function");
>> +#else
>
> seems like overkill :-)
>
> #ifdef HAVE_GETRANDOM
>     return _("getrandom function");
> #else
>     ...

Unecessary fine grained detail from printiout is removed.

Updated changes are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git getrandom

for you to fetch changes up to cc01c2dca4f62e36505570d5cb15f868aa44bf54:

  lib/randutils: use getrandom(2) when it is available (2016-12-11
11:46:54 +0000)

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
