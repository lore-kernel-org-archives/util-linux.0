Return-Path: <SRS0=3CY+=3R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4425CC2D0DB
	for <util-linux@archiver.kernel.org>; Tue, 28 Jan 2020 19:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1780B2467E
	for <util-linux@archiver.kernel.org>; Tue, 28 Jan 2020 19:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgA1TYZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:24:25 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:44342 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgA1TYZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 28 Jan 2020 14:24:25 -0500
Received: by mail-io1-f49.google.com with SMTP id e7so15696658iof.11
        for <util-linux@vger.kernel.org>; Tue, 28 Jan 2020 11:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DReQeW0eJzLwaqM29ca/6l93ySa8A7RdT417cAmEXn4=;
        b=r+h6a0VuYtLbSo3HtEjaapsZlIBYPbnucl6F+p0qjro6K5QqudRAjHjICjiSxH57Rd
         lv8cg0+PzYVdAW+SbPK3g10NDyMwn5UGCdUT+hrZCdQyS1PjO3DKfk3/tyJG0L7nfY7q
         ttqAAq3fyGmmBDz8VEhqJBvgzyAyHWaD8ZTHMMZHy2xbDDiTjfauZguQo/MWo90LLnKr
         FvA8sQFrA1UWDmPQs8q1c8usT4gwG4G+0EBuzd6JVRDElqYJVjJecBVcnx2ifyogMOrl
         lZdocQVKMoY4ZdGBgJIpoMmrT+rORHCO15ilU/agZH5jqwwoy4ubcuullO3CyQNAfuas
         zsrw==
X-Gm-Message-State: APjAAAX5z4doxp0XI61IssgbwzkeEwmVjOQHdP1+KMO411KR2aS31T17
        Et4HBuy8eSfD/CVo1ccsJzKJTz5EXVa67Pfcu/Q=
X-Google-Smtp-Source: APXvYqwzU6JFKd5DwclVvqHgjLoasGUcsZR/YrfZvgXO/JAWXfJyND3Jfnqblj78+MKxHgdZjl5zEZxR6LBltn4D5Eo=
X-Received: by 2002:a05:6638:1a3:: with SMTP id b3mr19421144jaq.84.1580239464770;
 Tue, 28 Jan 2020 11:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20200121105711.zzeeolydlivqnik7@ws.net.home> <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
 <20200127133435.tcnhf23yhi3laphp@ws.net.home> <20200127134005.qymawlxsf34p4oma@ws.net.home>
 <CAJ4jsafKGLntP-uKj-+kVY=xGk9FTPuw98ntsAEEpMFR8Ub6zQ@mail.gmail.com> <20200127202152.4jh2w4chch37wgee@ws.net.home>
In-Reply-To: <20200127202152.4jh2w4chch37wgee@ws.net.home>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Tue, 28 Jan 2020 19:24:13 +0000
Message-ID: <CAG27Bk0K-p+9eqUp8H+=-qrUuaEeiSHHsj7t9BA+fyRAwfVY3Q@mail.gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.35
To:     Karel Zak <kzak@redhat.com>
Cc:     Carlos Santos <unixmania@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, 27 Jan 2020 at 20:22, Karel Zak <kzak@redhat.com> wrote:
> No, it's really simple digits based date-time like "2012-09-22 16:34:22".
>
> getdate(3) is maybe another choice for future versions, for 2.35.1 is
> parse_timestamp() good enough to avoid GPLv3.

This will most likely end up causing an ABI breakage so I think the best
option is the least complicated time format, that is what parse_timestamp()
provides.

In case arbitrary format really must be supported then I think the best
option is to parse_timestamp() and if that fails call getdate() as well.
That said I have no idea how to write instructions to manual page about
DATEMSK environment variable and strptime() formats without causing
new-to-linux users to wonder why simple things must be so hard.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
