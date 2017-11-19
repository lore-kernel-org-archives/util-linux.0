Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-it0-f65.google.com ([209.85.214.65]:37292 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdKSJvb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 19 Nov 2017 04:51:31 -0500
Received: by mail-it0-f65.google.com with SMTP id m191so8708711itg.2
        for <util-linux@vger.kernel.org>; Sun, 19 Nov 2017 01:51:31 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <975e1e00-fab6-e539-8b92-5388e33d7f16@gmx.com>
References: <d91b971a-29f1-3403-342b-2b837c2abcb7@gmx.com> <975e1e00-fab6-e539-8b92-5388e33d7f16@gmx.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 19 Nov 2017 09:51:30 +0000
Message-ID: <CAG27Bk2rXPKTyz=qEzns5zmJVUoWZUOa0KSHSTzD-1JWz9t70A@mail.gmail.com>
Subject: Re: [PATCH 2/2] hwclock: fix debug regression
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 18 November 2017 at 21:21, J William Piggott <elseifthen@gmx.com> wrote:
>
> commit f0a0ce7 makes debug mode implicit for the --test option.
>
> Using the previous command syntax of --test and --debug
> together invokes the undocumented Level 2 debugging when
> setting the RTC. This can cause many thousands of lines of
> output like:
> 1510967983.499968 < 1510967983.500000 (-0.000032)
>
> Fix: bump Level 2 debugging to Level 9, just before the
> other undocumented Level 10. This makes it improbable for
> the development debug levels to be accessed unintentionally.
>
> Signed-off-by: J William Piggott <elseifthen@gmx.com>
> ---
>  sys-utils/hwclock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 8ff33474e..e5f90a44e 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -494,7 +494,7 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
>                         /* The retarget is handled at the end of the loop. */
>                 } else if (deltavstarget < 0) {
>                         /* deltavstarget < 0 if current time < target time */
> -                       if (ctl->debug >= 2)
> +                       if (ctl->debug >= 9)
>                                 printf(_("%ld.%06ld < %ld.%06ld (%.6f)\n"),
>                                        nowsystime.tv_sec,
>                                        nowsystime.tv_usec,

That is probably fine as intermediate issue fix. It would be nice to
see in longer term move to use debug.h. Then ctl->debug could
be made single bit switch that turns on messaging it does, and
all internal developer debugging stuff would be done with
HWCLOCK_DEBUG_ bits. Assuming done this way adding more
debuging levels is appropriate.

FYI login-utils/su-common.c is pretty good DBG example.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
