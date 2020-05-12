Return-Path: <SRS0=qlqL=62=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A420DC54E4A
	for <util-linux@archiver.kernel.org>; Tue, 12 May 2020 13:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3BA206CC
	for <util-linux@archiver.kernel.org>; Tue, 12 May 2020 13:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgELNpu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 May 2020 09:45:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38449 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbgELNpu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 May 2020 09:45:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id e25so13713131ljg.5
        for <util-linux@vger.kernel.org>; Tue, 12 May 2020 06:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5523WR9VzuwMa8S6reS9q2hP+cpSc3osAdKYh+m54Fo=;
        b=OMvRz98pPjs7rhaPjvJVbPMRMr19Vbf6V5yD68pRj+1zi/fqtwyKlLOvuz3UzX+ceF
         Ew082ZN5H19zsiv+TcCN/ixfCO8qlQO2ZsPW67jO/Sz/TeL+WGRvyamyf8O+jea3KArA
         TMXcwNreYtXWct6nsr3PnSfA3lN2TaXDwUXxKaY+nWDahc+0nkUDhiHDo0Y8T7eYl0X3
         RUT8w6uWnR2g5Fa9eENPmavRYyv7G9u5Ykidws3UGk11hvzNL+mEhTbChEC+v7T894FL
         bpafD2p+Yob3Ev6Usb7pV2EIyuxGHR6O2sxWjev1tITzfMeuthCXV7k6NsHXLFZP8Y6A
         Yn2w==
X-Gm-Message-State: AOAM533iXo3zqJvoWE2I0288XXPDizA5nAWi0bgaue3WZsVmpgCLMJNk
        +2QeZ7SdNlk3LHy5AaZRV+vHlG9u021EHPCUQaJZSA==
X-Google-Smtp-Source: ABdhPJwwOvbBBRPNyoss6WClEsanEyCkHitTLmeA8LeoSDXbDthzJuRD2mrSAqxOE0Uv/4c/ZTF26nOV+xkOh+uVUso=
X-Received: by 2002:a05:651c:119a:: with SMTP id w26mr13665977ljo.53.1589291148072;
 Tue, 12 May 2020 06:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200506191923.5272-1-kerolasa@iki.fi> <20200512085358.yjfl7ryg4bq3tpx4@ws.net.home>
In-Reply-To: <20200512085358.yjfl7ryg4bq3tpx4@ws.net.home>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Tue, 12 May 2020 14:45:36 +0100
Message-ID: <CAG27Bk0_upB1-tVotyFM-fs2vt_JEYpXV6-H714YV5z-aB1DDA@mail.gmail.com>
Subject: Re: [PATCH 0/2] more(1) use libmagic and make page up/down and arrow
 keys work
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, 12 May 2020 at 09:54, Karel Zak <kzak@redhat.com> wrote:
> On Wed, May 06, 2020 at 08:19:21PM +0100, Sami Kerola wrote:
> > Here are two changes to more(1) that where requested in earlier github
> > pull[1] request to get review in maillist, so here we go.
>
> Applied, thanks.
>
> > First one of the changes will link more(1) with libmagic so that various
> > binary formats can be detected with effect the pager will not mess up
> > termial.
>
> It seems we do not have devel package for libmagic in Fedora.

Oh, that's a little disappointing. Archlinux has libmagic in core
repository and that lead me thinking it is quite likely part of even
most minimal installation, but apparently I was wrong.

> > Second change is perhaps a little bit more exciting.  It will add page-up,
> > page-down, arrow-up, and arrow-down movements to more(1).  This pager has
> > known now to scroll back and forth since long time ago, but most of the
> > people do not seem to know key bindings so lets help users by assigning the
> > most obvious buttons the way one might expect them to work.
>
> This is nice feature, maybe also add arrow keys to move one line
> up/down.

Funny you said that. The more(1) movements are still quite disappointing
when trying to read the code. Sometime before Christmas I will try to
address that along with adding posix required more(1) key-bindings.
But there is no hope these would be ready before next util-linux release
so now we have a little unexpected movements for a bit. I hope that
is still an improvement to earlier situation when going backwards
seemed to be impossible for most of the users.

Thank you for review and merge Karel.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
