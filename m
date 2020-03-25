Return-Path: <SRS0=LCHA=5K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F8C43331
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 14:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB7E20658
	for <util-linux@archiver.kernel.org>; Wed, 25 Mar 2020 14:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgCYOQb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:16:31 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42794 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgCYOQa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 25 Mar 2020 10:16:30 -0400
Received: by mail-vs1-f67.google.com with SMTP id s10so1553271vsi.9
        for <util-linux@vger.kernel.org>; Wed, 25 Mar 2020 07:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqL62Vg34M/wJhQ+moYSJyXz+QuoucL+WkddzNlRD3M=;
        b=UnGtTBPb2/TelxO9xkdGd06hW4wx73RZjqZJYzJJJUoOU1j4o1i1F6nUp4sQGUBtkj
         NnXCd10ZbEmOG6wb8VNAtoNwZ9ssgcYKZZUBPrZzSs7KqlJdwnSBw5SSofSIJiNHugx6
         ZTDvA6kF6zXrlz5jSkaj6yfZ8BpZUcofB57GEbmuvWF2KeHQuK+hWn/aRrs2TnTS6GJm
         h0GtbUiE7G7FEl/80djO1KuskNd55LwgjPocmaHq5pW9xL2GvHykawUFJ+M8Yo5EFMKT
         37nj7JeydB0DUcmecHBz3o1AiNB1Ab2iCBJCJ12Qu8KeTaViLbVZB3W/kwEUcauyCQui
         MPMA==
X-Gm-Message-State: ANhLgQ1JDdAEhECvoFHoEswOcGfO5ZdOTPjeAdU+W8yoHVzcnxuQDmWi
        +teGeHxAMQzJTBksZmhEIf6IL9RutbX/mMp8v7k=
X-Google-Smtp-Source: ADFU+vuYm0e5N0nbrlMSRLbfj/tYbQh/0bvIEhUW/TP1KTmK0vhUytuqWrYhJ3ngCYZ6JM5B4Ybx2l1v1i52DHubjEk=
X-Received: by 2002:a67:a20f:: with SMTP id l15mr2742228vse.40.1585145789073;
 Wed, 25 Mar 2020 07:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200324212625.6934-1-orel@melix.net>
In-Reply-To: <20200324212625.6934-1-orel@melix.net>
From:   Peter Cordes <peter@cordes.ca>
Date:   Wed, 25 Mar 2020 11:16:18 -0300
Message-ID: <CA+bjHUQtPfk5vDNbxSbxPzashLNG+MdLzy8HtZLbsOJ0C_fnzQ@mail.gmail.com>
Subject: Re: [PATCH] libuuid: improve uuid_unparse() performance
To:     Aurelien LAJOIE <orel@melix.net>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Nice optimization, and yes converting to hex is something CPUs can do
really efficiently.  Not surprising that scanf and other overhead was
a huge part of the total time.  I have some suggestions to make it
even more efficient:

* Use static const for your lookup tables (avoiding GOT overhead vs.
globals), and make them only 16 bytes not 36
* Make the helper function take its first 2 args in the same order as
the external API so it doesn't need to shuffle registers around before
tailcalling, just put that 3rd arg in a register and jmp.  (The
function is big enough that GCC chooses not to inline it into all both
different callers at -O2, but will at -O3.)
* The variant with the fixed default could be defined as an alias for
the existing one, I think, so it can have the same address as the
lower or upper function.  This saves code size by not having another
lea / jmp, or worse a 3rd copy of the whole function if it inlines.
* Avoid extra loads of the source data by reading into a tmp var,
instead of re-accessing the same uuid[i] twice, the 2nd time after a
store to *p which might overlap; the compiler can't prove otherwise.

If you really are bottlenecking on UUID throughput, see my SIMD answer
on https://stackoverflow.com/questions/53823756/how-to-convert-a-binary-integer-number-to-a-hex-string
with x86 SSE2 (baseline for x86-64), SSSE3, AVX2 variable-shift, and
AVX512VBMI integer -> hex manual vectorization that can do 8 input
bytes -> 16 hex digits at once.  Or with YMM vectors, 32 hex digits.
The asm should be straightforward to translate to intrinsics.  (Remove
the part that reverses the byte-order from x86 little-endian to
printing order, since uuid bytes are apparently already in the right
order).  You'd need some shuffling to store to the right places around
the '-' formatting but that's doable.  Using an 8-byte store that
overlaps where you want a '-', *then* storing the '-', then a 4-byte
store of the bottom of the register, could work well to avoid one
shuffle with SSE2.  Or with SSSE3 or higher, use pshufb to shuffle in
the '-' bytes

On Tue, Mar 24, 2020 at 6:35 PM Aurelien LAJOIE <orel@melix.net> wrote:

>
>  libuuid/src/unparse.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/libuuid/src/unparse.c b/libuuid/src/unparse.c
> index a95bbb042..62bb3ef26 100644
> --- a/libuuid/src/unparse.c
> +++ b/libuuid/src/unparse.c
> @@ -36,41 +36,40 @@
>
>  #include "uuidP.h"
>
> -static const char *fmt_lower =
> -       "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x";
> -
> -static const char *fmt_upper =
> -       "%08X-%04X-%04X-%02X%02X-%02X%02X%02X%02X%02X%02X";
> +char const __str_digits_lower[36] = "0123456789abcdefghijklmnopqrstuvwxyz";
> +char const __str_digits_upper[36] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";


Shouldn't these be static, not global, like the old format strings
were?  Unless/until we want them somewhere else as well, these should
probably be private, and only 16 bytes each because the only current
use is for mapping a nibble -> hex ASCII.

Also, leading double underscore identifiers are reserved for use by
the C implementation.  If we want to use a global name, it should
probably be uuid__str_digits_lower or something like that.  And if
not, the name can be hexdigits_lower / upper.

>
> -static void uuid_unparse_x(const uuid_t uu, char *out, const char *fmt)
> +static void uuid_fmt(char *buf, const uuid_t uuid, char const fmt[36])
>  {
> +       char *p = buf;
> +       for (int i = 0; i < 16; i++) {
> +               if (i == 4 || i == 6 || i == 8 || i == 10) {
> +                       *p++ = '-';
> +               }
> +               *p++ = fmt[uuid[i] >> 4];
> +               *p++ = fmt[uuid[i] & 15];


It's slightly more efficient to load into unsigned tmp; the compiler
can't prove that buf and uuid don't overlap so it actually reloads for
the 2nd statement.  This is bad because we're pretty much going to
bottleneck or close to it on throughput of load/store instructions, on
a typical modern x86 for example.

char *restrict out would solve the same problem, and presumably no
caller would ever pass overlapping buffers.  And if they did, would
rather have this function read the original bytes instead of reloading
hex-digit bytes as binary UUID bytes.  Although at that point we're
into UB territory.

>
> +       }
> +       *p = '\0';
>  }
>
>  void uuid_unparse_lower(const uuid_t uu, char *out)
>  {
> -       uuid_unparse_x(uu, out, fmt_lower);
> +       uuid_fmt(out, uu, __str_digits_lower);
>  }
>

Best to have uuid_fmt take args in the same order as these wrappers,
so if a compiler decides not to inline it, the wrapper functions can
just put the digit-table pointer into another register and tailcall.
For example, your version compiles like this for x86-64: (on the
Godbolt compiler explorer, clang -O2 -fPIC)

uuid_unparse_lower_orig:
    mov rax, rdi
    lea rdx, [rip + hexdigits_lower]    # add a 3rd arg
    mov rdi, rsi
    mov rsi, rax             # swap the first 2 args
    jmp uuid_fmt_orig # TAILCALL

vs.

uuid_unparse_lower:
    lea rdx, hexdigits_lower[rip]          # add a 3rd arg
    jmp uuid_fmt                          # and tailcall

uuid_t is a typedef for an array of unsigned char[16] so as a function
arg it's just a pointer.

https://godbolt.org/z/fcZFhi is what I've been playing around with, in
case I don't get back to this and actually make a patch myself.
