Return-Path: <SRS0=QJpf=XF=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A9BC3A5A2
	for <util-linux@archiver.kernel.org>; Tue, 10 Sep 2019 13:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F4220863
	for <util-linux@archiver.kernel.org>; Tue, 10 Sep 2019 13:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbfIJNoU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:44:20 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:43666 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfIJNoU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 10 Sep 2019 09:44:20 -0400
Received: by mail-io1-f48.google.com with SMTP id r8so12615966iol.10
        for <util-linux@vger.kernel.org>; Tue, 10 Sep 2019 06:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=hhGoI/rZ7yKDxTu1St6dzOKQ9XIBB9GIPZ2/BztSahA=;
        b=PjStu4BJedoqSlU6CHfvU+kFndGWrr6vzrRI088tO7tcqw75MuHTea65lx32Rc4++F
         k/PKc3oxmNJcEShWi4SO45DbxxNX+878Ujdvv6ZLlK7rgGEL1wMNXzn2J/uXAov/vIAI
         XdUIKoklFOp7PUyRprvWtJN947gdRwKag0LAKWDOEs7MCfdGAtD8ynEQQL16qyoD5M+b
         irnSr9XMcPM83+TsqPEUy/Xm77egTsiSpRZhZ46KgHkVt6+CFNG1UVrh8PBrM/M0j+cY
         V8fUE3qXS/4onB5aYP6oT+nSq2jiANpVwJY2vTbNqS3xMoH01MmBiAOZvW+deh1IuPpo
         Bbzw==
X-Gm-Message-State: APjAAAUa5IsKCth3guW1pWqL9amPLluEJW7RkWbE1tYFso+3lf6dmBSL
        Xfsh1yztrqnhxiWFbOc52VlNR5lop+hIFG64UW49syA8
X-Google-Smtp-Source: APXvYqyrPQSkmQvHt7p6rg0VG7SMEBaXI9oFNqCTeNYgFzl+jRcSNXfGQgSc4wQbY6EuqztY4eAqBQPoLnTHdoIQ1o0=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr31348250ior.173.1568123059725;
 Tue, 10 Sep 2019 06:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAD56B7foOQ8UYuMYPBqaYUa4DQw_qc4QUJRRkgdeV1g1x0NfoA@mail.gmail.com>
In-Reply-To: <CAD56B7foOQ8UYuMYPBqaYUa4DQw_qc4QUJRRkgdeV1g1x0NfoA@mail.gmail.com>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Tue, 10 Sep 2019 14:44:08 +0100
Message-ID: <CAG27Bk2efpSwz97CHom4Mr0N+LSmFh1qT4rDeb9jF=2VVqfc0g@mail.gmail.com>
Subject: Re: last reboot
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, 10 Sep 2019 at 10:20, Paul Thomas <pthomas8589@gmail.com> wrote:
>
> Hello, 'last' is a handy tool, and using it for
> 'last reboot' provides a nice log.
>
> I was wondering if there are currently any platforms where more
> information about the reboot type is supported? For instance on the
> Zynq UltraScale+ devices there are a variety of reboot reasons:
> https://www.xilinx.com/html_docs/registers/ug1087/crl_apb___reset_reason.html#
>
> So on each startup the reason could be read and logged before
> resting the register[1].
>
> I guess one tricky issue would be the kernel interface,
> for a test I was just using memtool like this:
> # memtool md 0xFF5E0220+1
> ff5e0220: 00000001
>
> Where 00000001 indicates an 'External POR', but this probably
> isn't how we'd want to do it.
>
> I'm not subscribed to the mailing-list so please cc me any response.
>
> thanks,
> Paul
>
> [1] If the register is not reset then multiple bits can accumulate
> so you wouldn't now which is correct for the current boot

Hi Paul

The last(1) is pretty simple tool.  It can and will display information
tracked in utmp(5) data.

http://man7.org/linux/man-pages/man5/utmp.5.html

The utmp data is stored over many many reboots, that might stay around for
years.  Notice that changing utmp(5) is probably not the easiest thing to
achieve.  That format is part of POSIX.  Assuming standards are changed then
update to various libc implementations is needed as well.

Alternatively some sort of extented-utmp format could be created to avoid
standardization work, but getting that to adopted might be hard.  While utmp
has it's flaws it is not exactly broken.  In short while I'm not strictly
against better reboot reason tracking I am a somewhat doubtful how feasible
this work is.

That said what is that memtool?  I have never noticed it before.  By glance
it looks a little like abandonware.  Maybe it could be get a home in
util-linux if a tool like that is found to be useful, and old maintainer
does not mind.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
