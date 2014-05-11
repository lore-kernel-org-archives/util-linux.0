Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f171.google.com ([209.85.128.171]:40476 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbaEKXWr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 19:22:47 -0400
Received: by mail-ve0-f171.google.com with SMTP id oz11so7796450veb.2
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 16:22:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201405120038.12221.sweet_f_a@gmx.de>
References: <201405120038.12221.sweet_f_a@gmx.de>
Date: Mon, 12 May 2014 00:22:46 +0100
Message-ID: <CAG27Bk0dj=SOiGY5Hb6VttoTZG7o4P2X=XPRV6vc82g0yheybw@mail.gmail.com>
Subject: Re: question about test suite regarding stderr/stdout
From: Sami Kerola <kerolasa@iki.fi>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11 May 2014 23:38, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> if you do this grep in util-linux
>   git grep '2>&1 >> $TS_OUTPUT' tests/ts
>
> then you find 45 lines like this
> $TS_CMD_MKCRAMFS -n $LABEL $IMAGE_SRC $IMAGE_PATH 2>&1 >> $TS_OUTPUT
>
> which means that these warnings go to make's output but not to
> $TS_OUTPUT.
>
> I'm not sure whether this is really always wanted. For me it often looks
> like a typo which should be ">> $TS_OUTPUT 2>&1" instead. Of course
> could also be that it's really wanted as is to ignore stderr of too
> verbose commands.
>
> Could somebody please check this too?
> I'v had some cases where I would have liked to see that stderr in test
> diff instead of build log. Moreover because of parallel tests it can be
> difficult to find out which warning belongs to which particular test.

Hi Rudi,

Before parallel tests sending messages to stdout was OK, but now
things has changed and I think directing all messages to $TS_OUTPUT is
better option.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
