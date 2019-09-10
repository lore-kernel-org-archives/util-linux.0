Return-Path: <SRS0=QJpf=XF=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8C1C49ED8
	for <util-linux@archiver.kernel.org>; Tue, 10 Sep 2019 14:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077972081B
	for <util-linux@archiver.kernel.org>; Tue, 10 Sep 2019 14:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS679CuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfIJOFF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:05:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32769 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfIJOFF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 10 Sep 2019 10:05:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so20879924qtd.0
        for <util-linux@vger.kernel.org>; Tue, 10 Sep 2019 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qOgJ4rIhYi1mM57xl+4xXnW2GmON+CjHlSv4oBzfGk=;
        b=lS679CuW+KOQf6qXDvu1KYqyR+O4YB58ww0yLfAuF9E/+IDe72iCQqKpi0FzBVh46Y
         rIXe6LnV5iqUVu6dawr1G64Kstq6eCOWyt9G5J19pOTknQvODiVwMxBKBxhJZQ0FNMQz
         j4gGjUQZipnmvO7adTAYOM8BdblPhud9WKPyduQQigjArL46S62+E71Fw6615rtFySNY
         KFI3FwN66GW42ocCSDvxdB6TGx1pTV/XNS4Yas2dgTi5Maz+U1v0p1qMHSn7BjffXXfN
         o6URiY7RMMqhCctLiFj7Br8Pd0LJ4FuwywlHuRnQe8RWWlLuiE8bHaXgh4/LeGlyJmDY
         82qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qOgJ4rIhYi1mM57xl+4xXnW2GmON+CjHlSv4oBzfGk=;
        b=kzPC0GtUH3T285C+E324MGITMZyYouAt1qYHaHAzqRrIp9sGIjYnEJwCSal5RZQP5D
         AmpqRRINc5Qi0Co4ZJLRMNbe4UZkYhwE/zAINN0oe5G7AyXphrko4oZQUMSJdu8Oqr6x
         Y0BaHk/PnEp6mg2ISlzcWq7DkezmIry3QenJ2Yhk0gt8CGFqGcNQHS5zRnBlvr4hCpVG
         kN4DQgfVYPxLdezl7Fl24X8JFr6yw8wEbn+tSJl706WA2xAd5cFC/7Rt7vjzN1rOVQmM
         uGN93YzTDwTzW+3PZkGEO1tUwTJRJ8K02RIfZbddB5S64g31iyAJ7Hrob+ZOSpVYKqMt
         EWng==
X-Gm-Message-State: APjAAAUA88G174n5GMCDViyZ5jI9QMNCYIu/g2CuPYThFzouSYDN2FIE
        7GNUBTUDZh3igHj/wkN9JBHacvrjnta/axuBak8GXPPT
X-Google-Smtp-Source: APXvYqwjA6SYLT8RiZnCwNif6ljL5teKCtzZvo9a4sj8GW7DcPjpbL52qcsrmgjpQ5jiI/SdIy0uSW6oS/17PsiGbQg=
X-Received: by 2002:a0c:fec9:: with SMTP id z9mr11944374qvs.113.1568124304227;
 Tue, 10 Sep 2019 07:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAD56B7foOQ8UYuMYPBqaYUa4DQw_qc4QUJRRkgdeV1g1x0NfoA@mail.gmail.com>
 <CAG27Bk2efpSwz97CHom4Mr0N+LSmFh1qT4rDeb9jF=2VVqfc0g@mail.gmail.com>
In-Reply-To: <CAG27Bk2efpSwz97CHom4Mr0N+LSmFh1qT4rDeb9jF=2VVqfc0g@mail.gmail.com>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Tue, 10 Sep 2019 10:04:52 -0400
Message-ID: <CAD56B7c38z364xNk32cOuAaWKRiq+RwPOLUx3WwMuqT7bSsvDQ@mail.gmail.com>
Subject: Re: last reboot
To:     kerolasa@gmail.com
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Sami,

>
> The last(1) is pretty simple tool.  It can and will display information
> tracked in utmp(5) data.
>
> http://man7.org/linux/man-pages/man5/utmp.5.html
Thanks for the information.

>
> The utmp data is stored over many many reboots, that might stay around for
> years.  Notice that changing utmp(5) is probably not the easiest thing to
Yes, staying around for years with an entry for each boot would be desirable.

> achieve.  That format is part of POSIX.  Assuming standards are changed then
> update to various libc implementations is needed as well.
>
> Alternatively some sort of extented-utmp format could be created to avoid
> standardization work, but getting that to adopted might be hard.  While utmp
> has it's flaws it is not exactly broken.  In short while I'm not strictly
> against better reboot reason tracking I am a somewhat doubtful how feasible
> this work is.
OK, this makes sense. I might do something simple for our use case.

>
> That said what is that memtool?  I have never noticed it before.  By glance
> it looks a little like abandonware.  Maybe it could be get a home in
> util-linux if a tool like that is found to be useful, and old maintainer
> does not mind.
I'm not sure what the current state is, but it's included in the latest debian:
https://packages.debian.org/buster/memtool

It's a very simple (if not dangerous) tool to r/w /dev/mem. But it's very handy
for spying on memory mapped I/O registers like in this case.

I guess adding an interface isn't any worse than /dev/mem directly, but it
still might not be desirable to have it on every system?

-Paul
