Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39A3C28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 21:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931BA2075E
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 21:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgEFVOL convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 17:14:11 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:56064 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgEFVOL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 17:14:11 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E5D2A561210
        for <util-linux@vger.kernel.org>; Wed,  6 May 2020 23:14:07 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id r4so1746444pgg.4
        for <util-linux@vger.kernel.org>; Wed, 06 May 2020 14:14:07 -0700 (PDT)
X-Gm-Message-State: AGi0PuaH4Ojhkonw7fqZb/4xQL1hYTTxwvqdV91zzg2rQq6akFED2TIo
        8OgR05zhbYLjP3LzijSrJQgTyMff9KThASkOMXg=
X-Google-Smtp-Source: APiQypLSYNI4PKsO6+0Gd77RbwkgZrUnywyAwNpQc98QDbquo07kbkseGtLkwgIKHflGuBmnaHoSQRfepxKf8c0oORQ=
X-Received: by 2002:a62:7656:: with SMTP id r83mr10071128pfc.71.1588799646322;
 Wed, 06 May 2020 14:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAA0A08U=eWWB5eyxg4vrD_yBdVohqVT0NQfm+DG+wjbZ8HmiZg@mail.gmail.com>
 <20200414113827.xp2etrdev2oom4qc@ws.net.home> <CAA0A08W8JjTYx-ymnsBvbRHBW+WxucobBWVfyt4XdXh7Of8wMA@mail.gmail.com>
 <20200506133555.wbrul6yy24ycpfk3@ws.net.home> <CAA0A08UeXO5m8-Q0PS=kQH=MmG6q4EnjJw84JN=ckTuj4Qrnhg@mail.gmail.com>
In-Reply-To: <CAA0A08UeXO5m8-Q0PS=kQH=MmG6q4EnjJw84JN=ckTuj4Qrnhg@mail.gmail.com>
From:   =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Date:   Wed, 6 May 2020 23:13:54 +0200
X-Gmail-Original-Message-ID: <CAA0A08XGTFdhv-oAWy07QwL7YDC+gV34y70TM5Ae0jLR-MfAcA@mail.gmail.com>
Message-ID: <CAA0A08XGTFdhv-oAWy07QwL7YDC+gV34y70TM5Ae0jLR-MfAcA@mail.gmail.com>
Subject: Re: cal: column mode
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed May  6 23:14:08 2020 +0200 (CEST))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 6, 2020 at 9:06 PM Aurélien Lajoie <orel@melix.net> wrote:
>
> >
> > > > On Mon, Apr 13, 2020 at 10:41:34PM +0200, Aurélien Lajoie wrote:
> > > > > As I have announced few days ago, I have started to work on ncal like for cal.
> > > > > I have push a first working version on my github:
> > > > > https://github.com/utix/util-linux/commits/cal_column
> >
> > Aurélien, what is the current status of this your patch? I'd like to
> > make v2.36 release at the of the May :-)

The pull request is done
https://github.com/karelzak/util-linux/pull/1032

Try to be close to ncal
Major differences:
- On Julian calendar cal is using 3 letters day, keep this in vertical mode
- ncal puts 4 months per line, keep 3 for cal as in classic mode
- ncal uses only 1 space between month, cal 2 as in classic mode
- ncal and cal are putting trailing spaces, but not the same

What do you think about removing the trailing spaces for cal output ?
This is not relative to the vertical mode

Aurelien

> >
> >   Karel
> >
> > --
> >  Karel Zak  <kzak@redhat.com>
> >  http://karelzak.blogspot.com
> >

