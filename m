Return-Path: <SRS0=n9wB=6X=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5EAC28CBC
	for <util-linux@archiver.kernel.org>; Sat,  9 May 2020 19:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15327208E4
	for <util-linux@archiver.kernel.org>; Sat,  9 May 2020 19:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icQJbKTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgEITGD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 9 May 2020 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgEITGD (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 9 May 2020 15:06:03 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F023C061A0C
        for <util-linux@vger.kernel.org>; Sat,  9 May 2020 12:06:03 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id r7so4200529edo.11
        for <util-linux@vger.kernel.org>; Sat, 09 May 2020 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPduKrc19dtmM+HV3UjupWDTHwmz1XBcgCsmEZlP9q0=;
        b=icQJbKTKSFBDTcIZR6QweVm+KSH5qZbYqc6tgdUEB5sBCqQQ5xtEO0bqSK92tOp5le
         JySmzrnI3VSUShkcPC+L0ALOfszX372mPd2K5CynSC2qiNM+g6IBAKmdqCULIM32AETy
         TbOw3VWofhC0cECNW4aRdGuPoHFy9p14Azb+awbfMmyHQXMY7NiBpePp+pUoVl5P7M+Q
         mH4d559w+W2cw4j9L0GN7YtPskQxcBx30Q3+MvhBfTxXjks+BdUwEIxkihsOBHMUENwQ
         r//SS/zYXDQWrr6but6ytK7HNO7vOBPywWgzOQPB/YksAHQWyOUBAnWVPXLQBOnPl7I/
         06aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPduKrc19dtmM+HV3UjupWDTHwmz1XBcgCsmEZlP9q0=;
        b=te1AwcOxelxYHGk+bGk78/e8zYLxCPtzqVGJ7hb+UDnuYmqK0WDDfWY6U5YYqdZzuy
         auGVhwc2upSGM6WHU8B8sjJ+o3dLaqUSK4/L4K22FDOs48sW/wx8+qvAjYE0j224Kals
         xlEdFguG0q9qIENXI3P14NX367USXfHOv4agf4O9dMAcVgRd7SoXLFM2tlJj551l0Y59
         kZnNlUwe6vVvdSAEAQdC1Vmz5XRS1wMJe5dIYvTDRgfpAoyWxfLaVpqDSL6S+nsk11qt
         olPa6s6Me7LPIdATp8JiBEit40HzfQ4+r+LiCuiSSeiimvZPy8fYxo1meWLRM/o5dy99
         Ljsg==
X-Gm-Message-State: AGi0PuZ570MzRDWmNov89v4ySnF6Pt5Vzcqca+onA0dsmi6c5UeuUhWe
        5q5kVKMsLXMbkSpqKivfIZvyJgwDP4jWfDxC5eY=
X-Google-Smtp-Source: APiQypJhm9o6vM/yOUQNeB0WcUknY4GFMJekov+NBmottiP43ijBFe+MhRq/JQslih6LaoihWRP0Pgg0Uj9qi0+1fuQ=
X-Received: by 2002:aa7:c2ce:: with SMTP id m14mr7620753edp.305.1589051162008;
 Sat, 09 May 2020 12:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200503191335.GB27970@Debian-50-lenny-64-minimal>
 <CALxWeYrDdow1y2oA1VkcCyiQH1Vm9jNN79o541FPRaHYom=pAg@mail.gmail.com> <20200509190020.GA28852@Debian-50-lenny-64-minimal>
In-Reply-To: <20200509190020.GA28852@Debian-50-lenny-64-minimal>
From:   Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Sat, 9 May 2020 21:05:50 +0200
Message-ID: <CALxWeYpxvs+fcXzbExJ0n5ebeFtBdzm53ucPndW475CKe2KR0Q@mail.gmail.com>
Subject: Re: Errors in man pages of util-linux
To:     Helge Kreutzmann <debian@helgefjell.de>
Cc:     util-linux@vger.kernel.org,
        =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>,
        Karel Zak <kzak@redhat.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, May 9, 2020 at 9:00 PM Helge Kreutzmann <debian@helgefjell.de> wrote:
>
> Hello Michael,
> On Sat, May 09, 2020 at 08:53:31PM +0200, Michael Kerrisk wrote:
> > Hello Helge ;-),
> >
> > I think no maintainer wants to deal with a 1000-line mail listing 100+
> > minor bugs. May I suggest making the maintainer's life a little easier
> > by breaking things up into pieces. For example, one mail per manual
> > page (which would be 43 mails by my count).  But maybe Karel has
> > another suggestion on how you could make his life easier.
>
> Sure, I can do this, it did not see this mentioned for reporting bugs
> in util-linux, hence I did not do so.
>
> Will do so soon, probably tomorrow.

Maybe hold off for a day or three before investing effort on this.
Karel may have a better idea than mine re his preferred method of
reporting.

Thanks,

Michael
