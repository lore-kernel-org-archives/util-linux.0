Return-Path: <SRS0=Ofmp=5L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB575C43331
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 01:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810AE20714
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 01:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCZBG4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:06:56 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:53466 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbgCZBGz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 25 Mar 2020 21:06:55 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id BD4415646EE
        for <util-linux@vger.kernel.org>; Thu, 26 Mar 2020 02:06:52 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id ng8so1778352pjb.2
        for <util-linux@vger.kernel.org>; Wed, 25 Mar 2020 18:06:52 -0700 (PDT)
X-Gm-Message-State: ANhLgQ25O8uBKXm66NWe8tHh3a1bTApn9VBMbwiB1V95+vIYz3HAbDjB
        rTwC5P8pRx/1Yv9AFXTg5CAkXtYUMZqm8Je4DR8=
X-Google-Smtp-Source: ADFU+vsb+JthwvgpUUjdvgnMsqPqJUcA6tCA5tGDG394fMTt8pzDAQ/QF4r9YpnUAzux6qN4KVOh30OzMD03TulRnzk=
X-Received: by 2002:a17:90a:8c18:: with SMTP id a24mr296111pjo.43.1585184810362;
 Wed, 25 Mar 2020 18:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200324212625.6934-1-orel@melix.net> <CA+bjHUQtPfk5vDNbxSbxPzashLNG+MdLzy8HtZLbsOJ0C_fnzQ@mail.gmail.com>
In-Reply-To: <CA+bjHUQtPfk5vDNbxSbxPzashLNG+MdLzy8HtZLbsOJ0C_fnzQ@mail.gmail.com>
From:   =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Date:   Thu, 26 Mar 2020 02:06:38 +0100
X-Gmail-Original-Message-ID: <CAA0A08WYct_BhybReWMkK_LXBS2L0DmmyNh2W8cp=kys9Q0R7g@mail.gmail.com>
Message-ID: <CAA0A08WYct_BhybReWMkK_LXBS2L0DmmyNh2W8cp=kys9Q0R7g@mail.gmail.com>
Subject: Re: [PATCH] libuuid: improve uuid_unparse() performance
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Mar 26 02:06:53 2020 +0100 (CET))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 25, 2020 at 3:16 PM Peter Cordes <peter@cordes.ca> wrote:
>
> Nice optimization, and yes converting to hex is something CPUs can do
> really efficiently.  Not surprising that scanf and other overhead was
> a huge part of the total time.  I have some suggestions to make it
> even more efficient:
Thanks, I will submit a new version.
>
> * Use static const for your lookup tables (avoiding GOT overhead vs.
> globals), and make them only 16 bytes not 36
done
> * Make the helper function take its first 2 args in the same order as
> the external API so it doesn't need to shuffle registers around before
> tailcalling, just put that 3rd arg in a register and jmp.  (The
> function is big enough that GCC chooses not to inline it into all both
> different callers at -O2, but will at -O3.)
done
> * The variant with the fixed default could be defined as an alias for
> the existing one, I think, so it can have the same address as the
> lower or upper function.  This saves code size by not having another
> lea / jmp, or worse a 3rd copy of the whole function if it inlines.

I have done it using __attribute__ alias like:

void uuid_unparse(const uuid_t uu, char *out)
        __attribute__((alias("uuid_unparse_lower")));

> * Avoid extra loads of the source data by reading into a tmp var,
> instead of re-accessing the same uuid[i] twice, the 2nd time after a
> store to *p which might overlap; the compiler can't prove otherwise.
Done

>
> If you really are bottlenecking on UUID throughput, see my SIMD answer
> on https://stackoverflow.com/questions/53823756/how-to-convert-a-binary-integer-number-to-a-hex-string
> with x86 SSE2 (baseline for x86-64), SSSE3, AVX2 variable-shift, and
> AVX512VBMI integer -> hex manual vectorization that can do 8 input
> bytes -> 16 hex digits at once.  Or with YMM vectors, 32 hex digits.
> The asm should be straightforward to translate to intrinsics.  (Remove
> the part that reverses the byte-order from x86 little-endian to
> printing order, since uuid bytes are apparently already in the right
> order).  You'd need some shuffling to store to the right places around
> the '-' formatting but that's doable.  Using an 8-byte store that
> overlaps where you want a '-', *then* storing the '-', then a 4-byte
> store of the bottom of the register, could work well to avoid one
> shuffle with SSE2.  Or with SSSE3 or higher, use pshufb to shuffle in
> the '-' bytes

I will take a look at it, but in a second time, I get your idea.
I am not familiar with this, nice way to jumb on SIMD operations.

>
> On Tue, Mar 24, 2020 at 6:35 PM Aurelien LAJOIE <orel@melix.net> wrote:
>
> >
> >  libuuid/src/unparse.c | 35 +++++++++++++++++------------------
> >  1 file changed, 17 insertions(+), 18 deletions(-)
> >
> > diff --git a/libuuid/src/unparse.c b/libuuid/src/unparse.c
> > index a95bbb042..62bb3ef26 100644
> > --- a/libuuid/src/unparse.c
> > +++ b/libuuid/src/unparse.c
> > @@ -36,41 +36,40 @@
> >
> >  #include "uuidP.h"
> >
> > -static const char *fmt_lower =
> > -       "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x";
> > -
> > -static const char *fmt_upper =
> > -       "%08X-%04X-%04X-%02X%02X-%02X%02X%02X%02X%02X%02X";
> > +char const __str_digits_lower[36] = "0123456789abcdefghijklmnopqrstuvwxyz";
> > +char const __str_digits_upper[36] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
>
>
> Shouldn't these be static, not global, like the old format strings
> were?  Unless/until we want them somewhere else as well, these should
> probably be private, and only 16 bytes each because the only current
> use is for mapping a nibble -> hex ASCII.
>
> Also, leading double underscore identifiers are reserved for use by
> the C implementation.  If we want to use a global name, it should
> probably be uuid__str_digits_lower or something like that.  And if
> not, the name can be hexdigits_lower / upper.
>
> >
> > -static void uuid_unparse_x(const uuid_t uu, char *out, const char *fmt)
> > +static void uuid_fmt(char *buf, const uuid_t uuid, char const fmt[36])
> >  {
> > +       char *p = buf;
> > +       for (int i = 0; i < 16; i++) {
> > +               if (i == 4 || i == 6 || i == 8 || i == 10) {
> > +                       *p++ = '-';
> > +               }
> > +               *p++ = fmt[uuid[i] >> 4];
> > +               *p++ = fmt[uuid[i] & 15];
>
>
> It's slightly more efficient to load into unsigned tmp; the compiler
> can't prove that buf and uuid don't overlap so it actually reloads for
> the 2nd statement.  This is bad because we're pretty much going to
> bottleneck or close to it on throughput of load/store instructions, on
> a typical modern x86 for example.
>
> char *restrict out would solve the same problem, and presumably no
> caller would ever pass overlapping buffers.  And if they did, would
> rather have this function read the original bytes instead of reloading
> hex-digit bytes as binary UUID bytes.  Although at that point we're
> into UB territory.
>
> >
> > +       }
> > +       *p = '\0';
> >  }
> >
> >  void uuid_unparse_lower(const uuid_t uu, char *out)
> >  {
> > -       uuid_unparse_x(uu, out, fmt_lower);
> > +       uuid_fmt(out, uu, __str_digits_lower);
> >  }
> >
>
> Best to have uuid_fmt take args in the same order as these wrappers,
> so if a compiler decides not to inline it, the wrapper functions can
> just put the digit-table pointer into another register and tailcall.
> For example, your version compiles like this for x86-64: (on the
> Godbolt compiler explorer, clang -O2 -fPIC)
>
> uuid_unparse_lower_orig:
>     mov rax, rdi
>     lea rdx, [rip + hexdigits_lower]    # add a 3rd arg
>     mov rdi, rsi
>     mov rsi, rax             # swap the first 2 args
>     jmp uuid_fmt_orig # TAILCALL
>
> vs.
>
> uuid_unparse_lower:
>     lea rdx, hexdigits_lower[rip]          # add a 3rd arg
>     jmp uuid_fmt                          # and tailcall
>
> uuid_t is a typedef for an array of unsigned char[16] so as a function
> arg it's just a pointer.
>
> https://godbolt.org/z/fcZFhi is what I've been playing around with, in
> case I don't get back to this and actually make a patch myself.

