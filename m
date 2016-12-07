Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35164 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932578AbcLGTlP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Dec 2016 14:41:15 -0500
Received: by mail-qk0-f182.google.com with SMTP id n204so425583277qke.2
        for <util-linux@vger.kernel.org>; Wed, 07 Dec 2016 11:41:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161207190356.lfxyogrc6gelhryl@ws.net.home>
References: <CAKSbvH9mE7YjyERuFusVJi0rbN1zdXCk9+=D7o0k5f3gTE+w-Q@mail.gmail.com>
 <CAKSbvH8mtBu--3jRe41Hiq=ubwEMU4riRG9q4QxoFtY-o1a-Pw@mail.gmail.com> <20161207190356.lfxyogrc6gelhryl@ws.net.home>
From: Whilom Chime <whilom.chime@gmail.com>
Date: Wed, 7 Dec 2016 14:41:14 -0500
Message-ID: <CAKSbvH_9JyNNL-K+8oU1=+45aM+cgcG4fvAEKcAcXOawrNDBEw@mail.gmail.com>
Subject: Re: Fwd: In the "stupid" questions department...
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks for your useful comments Karel! (inline)

On Wed, Dec 7, 2016 at 2:03 PM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Dec 07, 2016 at 10:40:36AM -0500, Whilom Chime wrote:
>> I've worked up a simple patch to libuuid to allow for generation of
>> MD5/SHA-1 UUIDs (DEC V3, V5 conformant) since I can't seem to find any
>> other C-level APIs to that effect and libuuid seems to be the C-level
>> "go-to" for such.  Does that seem reasonable?
>
>  What about http://www.ossp.org/pkg/lib/uuid?  I see this library in
>  Fedora and it supports all the UUID variants. The util-linux
>  (originally e2fsprogs) libuuid is about time based UUID only.
>
>  I'm have real doubts we need to support another UUID variants in
>  our libuuid.
>

Haha!  Wow, libossp-uuid.a would have satisfied me if I had of found
it...  A bit like a sledgehammer to tap a tack, but I agree, given
that there *is* a C API out there it's prolly best to leave
util-linux'd libuuid alone.  Though I really wish md4 and sha-1 UUID's
had gotten in there in the first place, it's literally forty lines of
code :P

I will either use libossp-uuid.a or just slip the SHA-1 version into
my code myself, I won't pursue a patch to util-linux.  But one more
process question below, just so I understand for future...

>> Obviously this requires openssl, not a dependency that currently seems
>> to exist in util-linux.  Is adding that depency reasonable?  I've
>> added it as a default-yes ./configure --with-openssl option.
>
>  Hmmm... for the hash? We have MD5 in the tree (it would be probably
>  possible to have there SHA-1 too), although for some certifications
>  (FIPS) and consolidation is probably better to use external
>  verified library.
>
>> "Stupid" question: to expose the two new APIs it looks like I need to
>> add something like:
>>
>> UUID_2.29 {
>> global:
>>         uuid_generate_md5;
>>         uuid_generate_sha1;
>> } UUID_2.20;
>>
>> to libuuid.sym  but I'm completely unclear as to what version I should
>> use, the current 2.29, some imagined 2.30, 2.29_rc3...?
>
> We do not use _rcN there, it's X.Y release number, during -rc time
> it's unstable and modifiable.
>

Could you just help me understand how lib??.sym works?  If I have 2.29
source and I add UUID_2.30 {...}... does that mean that the symbol
would be added in my local 2.29 build for testing, but once my
hypothetical patch was accepted the "world" would not see my new APIs
in any version less than 2.30?  Or does the package maintainer have to
manually maintain all kinds of lib??.sym files as revisions happen...

Thanks!


>> And there may be other things I need to do to add APIs?
>
> Maybe docs.
>
>> CRYPTO_LIBS=
>> AC_ARG_WITH([openssl],
>>   AS_HELP_STRING([--with-openssl], [compile with OpenSSL support]),
>>   [], [with_openssl=yes]
>> )
>> if test $with_openssl != no
>> then
>>     a=0
>>     AC_CHECK_HEADERS(openssl/md5.h, [], [a=1])
>>     AC_SEARCH_LIBS([MD5_Init], [crypto],
>>         [if test x"$ac_cv_search_MD5_Init" != x"none required"; then
>>             CRYPTO_LIBS="-lcrypto";
>>         fi], [a=1])
>>
>>     if test $a == 0
>>     then
>>         AC_DEFINE(HAVE_MD5, [1], [Define to 1 if you have MD5 functions])
>>     fi
>>
>>     a=0
>>     AC_CHECK_HEADERS(openssl/sha.h, [], [a=1])
>>     AC_SEARCH_LIBS([SHA1_Init], [crypto],
>>         [if test x"$ac_cv_search_MD5_Init" != x"none required"; then
>>             CRYPTO_LIBS="-lcrypto";
>>         fi], [a=1])
>>
>>     if test $a == 0
>>     then
>>         AC_DEFINE(HAVE_SHA1, [1], [Define to 1 if you have SHA1 functions])
>>     fi
>> fi
>> AC_SUBST([CRYPTO_LIBS])
>
> The best is to use pkg-config, see how we use PKG_CHECK_MODULES in the
> configure.
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
