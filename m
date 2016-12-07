Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36762 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752871AbcLGPkh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Dec 2016 10:40:37 -0500
Received: by mail-yw0-f170.google.com with SMTP id a10so302812938ywa.3
        for <util-linux@vger.kernel.org>; Wed, 07 Dec 2016 07:40:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKSbvH9mE7YjyERuFusVJi0rbN1zdXCk9+=D7o0k5f3gTE+w-Q@mail.gmail.com>
References: <CAKSbvH9mE7YjyERuFusVJi0rbN1zdXCk9+=D7o0k5f3gTE+w-Q@mail.gmail.com>
From: Whilom Chime <whilom.chime@gmail.com>
Date: Wed, 7 Dec 2016 10:40:36 -0500
Message-ID: <CAKSbvH8mtBu--3jRe41Hiq=ubwEMU4riRG9q4QxoFtY-o1a-Pw@mail.gmail.com>
Subject: Fwd: In the "stupid" questions department...
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks for your supportiveness Karel :)

"And this is not LKML, this is mailing list where we keep things in
friendly atmosphere, so don't be afraid to make a bad choice,
contribute non-perfect solution or ask "stupid" questions..."

(I was once a systems programmer working on kernel-level code back in
the late nineties but I have very little experience with the whole
"auto*" build/release paradigm, especially as evinced in this rather
substantial project.)

I've worked up a simple patch to libuuid to allow for generation of
MD5/SHA-1 UUIDs (DEC V3, V5 conformant) since I can't seem to find any
other C-level APIs to that effect and libuuid seems to be the C-level
"go-to" for such.  Does that seem reasonable?

Obviously this requires openssl, not a dependency that currently seems
to exist in util-linux.  Is adding that depency reasonable?  I've
added it as a default-yes ./configure --with-openssl option.

"Stupid" question: to expose the two new APIs it looks like I need to
add something like:

UUID_2.29 {
global:
        uuid_generate_md5;
        uuid_generate_sha1;
} UUID_2.20;

to libuuid.sym  but I'm completely unclear as to what version I should
use, the current 2.29, some imagined 2.30, 2.29_rc3...?

And there may be other things I need to do to add APIs?

As a comment, the configure.ac section pertaining to libuuid's
requirements seems a little kludgy, and I've only expanded on that.
Pointers as to more correctly accomplishing the same would of course
be welcome, I prefer to leave things better than I found them. Below
for reference if anyone's interested.

Thanks for your attentions,

Whilom

~~~~~~~~~~ configure.ac excerpt ~~~~~~~~~~

SOCKET_LIBS=
AC_SEARCH_LIBS([socket], [socket],
        [AS_IF([test x"$ac_cv_search_socket" != x"none required"],
                [SOCKET_LIBS="$SOCKET_LIBS -lsocket"])
])
AC_SUBST([SOCKET_LIBS])

CRYPTO_LIBS=
AC_ARG_WITH([openssl],
  AS_HELP_STRING([--with-openssl], [compile with OpenSSL support]),
  [], [with_openssl=yes]
)
if test $with_openssl != no
then
    a=0
    AC_CHECK_HEADERS(openssl/md5.h, [], [a=1])
    AC_SEARCH_LIBS([MD5_Init], [crypto],
        [if test x"$ac_cv_search_MD5_Init" != x"none required"; then
            CRYPTO_LIBS="-lcrypto";
        fi], [a=1])

    if test $a == 0
    then
        AC_DEFINE(HAVE_MD5, [1], [Define to 1 if you have MD5 functions])
    fi

    a=0
    AC_CHECK_HEADERS(openssl/sha.h, [], [a=1])
    AC_SEARCH_LIBS([SHA1_Init], [crypto],
        [if test x"$ac_cv_search_MD5_Init" != x"none required"; then
            CRYPTO_LIBS="-lcrypto";
        fi], [a=1])

    if test $a == 0
    then
        AC_DEFINE(HAVE_SHA1, [1], [Define to 1 if you have SHA1 functions])
    fi
fi
AC_SUBST([CRYPTO_LIBS])
