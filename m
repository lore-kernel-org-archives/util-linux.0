Return-Path: elseifthen@gmx.com
Subject: Re: [v2 PATCH 0/2] Pull Request
To: Karel Zak <kzak@redhat.com>
References: <e2d14b08-f310-cf33-feb4-6e07b8b0f59b@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ffb425a2-4be0-e72a-5b1e-35daa72edacb@gmx.com>
Date: Sun, 24 Dec 2017 10:06:39 -0500
MIME-Version: 1.0
In-Reply-To: <e2d14b08-f310-cf33-feb4-6e07b8b0f59b@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Karel,

If you'd like --gregorian and --julian to mean exclusively using their
respective calendar system, then we could:

* change --iso to --gregorian and let the man page explain that it is proleptic.

* depreciate --julian in favor of --ordinal (--doy or --day-of-year). IMO, this
   should be done regardless.

* create a private --roma that is the complement to --gregorian; then after an
   appropriate mourning period change it to --julian and make it public.

RFC:
Can/should the new cal(1) options have short versions?

>From Documentation/howto-contribute.txt:
"... it is not recommended to add short command line options [to POSIX utils]
before they are part of the standard."

But most of cal(1)'s options already have short versions and the standard says
there are no options for cal(1).

If we use my above idea then --julian will have -j, so IMO --gregorian should
have -g. It would also be nice for --ordinal to have -o.
