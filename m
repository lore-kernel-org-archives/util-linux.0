Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:62320 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab2F3U7N convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 30 Jun 2012 16:59:13 -0400
Received: by wgbds11 with SMTP id ds11so1768833wgb.1
        for <util-linux@vger.kernel.org>; Sat, 30 Jun 2012 13:59:11 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201206282338.41501.vapier@gentoo.org>
References: <CAG27Bk3xh7nAhvktOR45drKcKBgaCTtFqduOyvWz5arTGegCBA@mail.gmail.com>
	<201206282338.41501.vapier@gentoo.org>
Date: Sat, 30 Jun 2012 22:59:11 +0200
Message-ID: <CAG27Bk1ejSJ+N0XWO1u09M1Xojd6Q+NTvHkb6-bTV-yG22H_XA@mail.gmail.com>
Subject: Re: [pull] /run directory and swapon
From: Sami Kerola <kerolasa@iki.fi>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 29, 2012 at 5:38 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 27 June 2012 17:33:25 Sami Kerola wrote:
>> --- a/configure.ac
>> +++ b/configure.ac
>>
>> +case $prefix:$localstatedir in
>> +  NONE:'${prefix}/var')
>> +    localstatedir=/run
>> +    AC_MSG_NOTICE([  --localstatedir defaults to /run])
>
> i'd trim the leading whitespace in the message

Why? It looks correct to me.

$ ./configure
[...]
configure: Default --exec-prefix detected.
configure:   --bindir defaults to /bin
configure:   --sbindir defaults to /sbin
configure:   --libdir defaults to /lib
configure:   --localstatedir defaults to /run
[...]

>> +    ;;
>> +  *:'${prefix}/var')
>> +    localstatedir=${prefix}/run
>> +    ;;
>> +  NONE:*)
>> +    ;;
>> +  *:*)
>> +    localstatedir=${prefix}/${localstatedir}
>> +    ;;
>> +esac
>
> is this last case just so you can AC_DEFINE the value below ?  in general,
> this is fragile.  defines should be expanded at make time rather than configure.
>
> CPPFLAGS="$CPPFLAGS -D_PATH_LOCALSTATEDIR=\"\${localstatedir}\""

The comment was a bit mysterious to me, so I tried to find what you
meant by fragility. The

http://www.opensource.apple.com/source/xar/xar-28/xar/configure.ac

has following

dnl Define cpp macros in CPPFLAGS, rather than doing AC_DEFINE(macro), since the
dnl definitions need to be seen before and headers are included, which is a pain
dnl to make happen otherwise.

which seem to match what you meant. I changed the line to be C
preprocessor definition, and added you as patch CC. Benno, I added you
to swapon patches CC as well. The changes are in my git.

git://github.com/kerolasa/lelux-utiliteetit.git varrun-swapon

AFAIK the last thing to sort out before merge is the lsblk & swapon
device size difference. Either I did something silly, or there is some
sort of issue somewhere.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
