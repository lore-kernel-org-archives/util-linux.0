Return-Path: <SRS0=WmqB=6L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8352C54FD0
	for <util-linux@archiver.kernel.org>; Mon, 27 Apr 2020 10:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1E9206A4
	for <util-linux@archiver.kernel.org>; Mon, 27 Apr 2020 10:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFOvc65I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0KuQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726507AbgD0KuP (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 27 Apr 2020 06:50:15 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B3C0610D5
        for <util-linux@vger.kernel.org>; Mon, 27 Apr 2020 03:50:15 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so13080956edv.8
        for <util-linux@vger.kernel.org>; Mon, 27 Apr 2020 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=cSG1+DKuqC9ydDHrvMZNdmFEqAYnuM2+0QhCDqUlKc0=;
        b=bFOvc65IF38SBWEBelUOCVn/OWNgCEIGVpXkkz7HzADB6kMNdhK9YCyIE64pYY30/4
         CYcujDS3papahohiXhL5hM8p9J14t9pzGqTcalQ44wqSwdLX+cOybLkbzA+5iSqf6D06
         WJ6aheXhDbS6cN5o4PTjrwpS3Cp6+W+rreV3jYnH8PrmH3OfzuXFECJKhVsWlS4NMM2u
         KsFcEPPzu/Zy/YSoRj42rKOmGF3Q1FjucYNaS0XIfVxQYcX3zhvD4urc9UDidWBEvocy
         EHxGuMOFrVw8l84CG5TdYNPm1r2sVOyNMdxIal1r9NrJPGOm90u0Wmi0r8beWUu7mXNV
         4JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=cSG1+DKuqC9ydDHrvMZNdmFEqAYnuM2+0QhCDqUlKc0=;
        b=I3C9tZyawVf0ULp8/5+AahCOOVzZzUC657F7EazBz/g5xJgsyDPMXEybzwKvncnc2c
         Bl4E8A5eP+Hk/8D684qHCML/xyRU+fKsXLpOuUDfHZlP6IuHbE8aN6dPJ6xUPLTDj5HO
         8QmAQFcyzgPOZztanCU4zXlI6eUCdKuXlnnvAK438if40lg6U9e7n+aasGhRNrDmJ7MR
         /5CbHcUiunIce0WaF0nP8NOMKtnDAqBzeG5QaeEJflk7OOvQnsr31xdfUgsXVLwkW0nS
         LiZXWe0+VSGBvVThedC8rQcPly3lX8MRVTB0fvcj5e5p3zf9cU1zrl7aySqoVWhEB2Zf
         /w6w==
X-Gm-Message-State: AGi0PuaiHdrBFexvcVtjRfpcnegSaV6U+UlsV06ZjEw7Zn0LF+v4gUhR
        whoF39YNfeGIAPrUzU8n2Y8636IYq/jWi+YETgA=
X-Google-Smtp-Source: APiQypJXFxNedim1+3EUdoRvl4e4T+RI0wkct5qr47aj6XRobo4RoEKI1Ayg7cIVDOzhmpn6IdGFxvvdQvknyIg/Ye8=
X-Received: by 2002:a05:6402:1b08:: with SMTP id by8mr17764966edb.286.1587984614180;
 Mon, 27 Apr 2020 03:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200415211653.5455-1-michael-dev@fami-braun.de>
 <87o8rrdulx.fsf@x220.int.ebiederm.org> <9379f1f3b13b33e3a80b7cb4a58de8b8@fami-braun.de>
 <CAHO5Pa0OkdnTYRkzEsCV0=kAJZXDaSnVriEUAq3Zt-6csP3wFQ@mail.gmail.com> <20200427093346.tcoujcasylusejfq@ws.net.home>
In-Reply-To: <20200427093346.tcoujcasylusejfq@ws.net.home>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 27 Apr 2020 12:50:02 +0200
Message-ID: <CAKgNAkhDso=A9zf4DsGw7JCsEigPhtMcpOm+sxCA=PqAuNwdbA@mail.gmail.com>
Subject: Re: [PATCH] Fix PID namespace persistence
To:     Karel Zak <kzak@redhat.com>
Cc:     michael-dev <michael-dev@fami-braun.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        util-linux@vger.kernel.org, Adrian Reber <areber@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

[I should have CCed Adrian, so that he is aware of the issue also,
having added Time Namespaces; Adrian, for context, see
https://lore.kernel.org/util-linux/20200427093346.tcoujcasylusejfq@ws.net.home/T/#t
]

On Mon, 27 Apr 2020 at 11:33, Karel Zak <kzak@redhat.com> wrote:
>
> On Fri, Apr 24, 2020 at 11:21:15AM +0200, Michael Kerrisk wrote:
> > On Sun, Apr 19, 2020 at 1:06 AM michael-dev <michael-dev@fami-braun.de> wrote:
> > >
> > > Am 16.04.2020 22:49, schrieb ebiederm@xmission.com:
> > > > Why all of the extra code motion and change?
> > > >
> > > > Your description sounds like only the first hunk is necessary.  Did
> > > > something else get mixed into this change?  Or are all of the hunks
> > > > necessary?
> > >
> > > Because after unsharing, pid_for_children is a dangling symlink.
> > > So if (forkit) needs to be before /* wait for bind_ns_files_from_child()
> > > */.
> > > Moving this results in an overlapping use of the pid variable, so that
> > > gets renamed.
> > > Additionally, we cannot wait for the forkit child (bash) to exit before
> > > triggering and waiting for the bind-mounting child to bind-mount the
> > > persistent namespace. So forking and waiting for the forkit child (bash)
> > > needs to become splitted.
> >
> > @Michael: I confim theproblem, and thanks for this fix.
> >
> > @Zak: an analogous fix is required for time namespaces.
>
> OK, I'll play with it later this week. Sorry for the delay, I'm busy
> with other things.

Thanks, Karel!

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
