Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20160714100143.gc4ozcmah5i5stgz@ws.net.home>
References: <20160710200242.2706-1-kerolasa@iki.fi> <201607121623.04891.sweet_f_a@gmx.de>
 <CAG27Bk3po26Bsb=E0A1UXDrTrkwPH1pEvqEKXFZ_n4PVOcxt8A@mail.gmail.com>
 <201607122338.40458.sweet_f_a@gmx.de> <alpine.LNX.2.20.1607122241300.11890@imuri>
 <20160714100143.gc4ozcmah5i5stgz@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 14 Jul 2016 23:37:19 +0100
Message-ID: <CAG27Bk1LxV=9T9CTh4kBH_EZuP2g7o0PaSSTgKXpncN6WEWFKg@mail.gmail.com>
Subject: Re: [PATCH] hwclock: remove UTC-0 localization hack
To: Karel Zak <kzak@redhat.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, J William Piggott <elseifthen@gmx.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 14 July 2016 at 11:01, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Jul 12, 2016 at 10:42:33PM +0100, Sami Kerola wrote:
>>  lib/portability.c      | 28 ++++++++++++++++++++++++++++
>
> We already care about portability and we have many fallbacks, so why
> we need lib/portability.c now? It would better to use timeutils.c (or
> inline function in c.h).

Hi Karel.

I didn't do my homework carefully enough. After assuming the timeutils.c
should be kept close to simiar with systemd version I thought some other
file should be used. But now when I look systemd version of the time-utils.c
and compare it with the util-linux copy it's pretty clear these are two very
different pieces of code. Change below moved the replacement function to
the timeutils.c with necessary commit message update.

https://github.com/kerolasa/lelux-utiliteetit/commit/0f916063a4f887f198e005a7a0f7878aa0bfbe05

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
