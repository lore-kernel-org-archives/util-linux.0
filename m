Return-Path: <SRS0=fv9v=3Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBFEC2D0DB
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 16:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C26206D4
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 16:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiYsR0/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgA0Qiu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:38:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43988 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0Qiu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Jan 2020 11:38:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so12141215wre.10
        for <util-linux@vger.kernel.org>; Mon, 27 Jan 2020 08:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g1eXdFMgipMro+PEkfxnePuP5aY6vqrml733NuA2HE8=;
        b=iiYsR0/QLRqhukzb+JVzrb+tk1Tg6xMo8qDWuZUBe+ivpLvrPugsK3kauWb+jK4Ww6
         XC3XpkEm8byQIoROt+x9e4qmKscp6sFG75w+Mk+1cT6tFifUz4FKQtVKoErPzu0NKl4L
         xTYFJnu/hntRwtfPpGLd0c38rDVpVq41aWBXZfM1LdgAAqPwnzGXxILL3ZDYQRiYZ9yY
         /8/L0WJaTRgS2HXfmU37jBj8SLJ8khnrcVABtrSNpkaVo1CFjgG2jq1u1fcdySrfM94U
         Ef9ul3xXCf0c/kVKgnux8BzwUiyH43xO/Lqv+oSyZWwKZ7uW5vtX2alClHBuxpRtEaxm
         3sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g1eXdFMgipMro+PEkfxnePuP5aY6vqrml733NuA2HE8=;
        b=e3zOCHjR9OT06aUmx4+JxF+esQV5PS5m2NPbZ9EhYEXhOMidxv4cGMqCEB5BWwCwVD
         AIt5/Cm2gSk75d6YIIuX6f4wC2WHq/uG5JnE5XlCwH+yUKNMLIs3JZvwzQaVA27RDRXl
         QDIw5VJrsCEPmgNpAQvhO1DHlZTqU5L92XRP6eMTOLabHUGCoEZQjs0e5rvAV+ZMFkvI
         TSOc3xUndUm7MjERlZhjaxUnDOTWDHbafTu7woNYzsZy4mBRe8LEiFob3klOSOgNYuNy
         vDnTyV1bSxPLpo1KkS0mMGuEtMZtkqsIlp0EueXrvpv4Zht2OsS6syoC3IbGmZXJmOn/
         BKRA==
X-Gm-Message-State: APjAAAXQOr/fNjwYCz7i70ZLgWM+e4Rds+HqsW9hbrC/Ky5sN1zpw8nB
        vgM8kULjeEhRjAGs9FDATFCv0zW7/Z3gUKg6EiZxsa9b
X-Google-Smtp-Source: APXvYqxkG5AgJC5U+J0A/xnI7bH3u4sAuUIq0OGn+xqZDYQCbW0ndPcXwM7Rl1Bd1ZMYCWugsNMZkyzQ5CTyW1r8N3o=
X-Received: by 2002:adf:fe07:: with SMTP id n7mr21713635wrr.286.1580143128163;
 Mon, 27 Jan 2020 08:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20200121105711.zzeeolydlivqnik7@ws.net.home> <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
 <20200125105126.xaopgydc7dlrpztt@x2.net.home> <nycvar.YAK.7.76.2001261131130.3053@zhn.tzk.pbz>
 <20200127161317.wwyupvqbighx3rqx@ws.net.home>
In-Reply-To: <20200127161317.wwyupvqbighx3rqx@ws.net.home>
From:   Carlos Santos <unixmania@gmail.com>
Date:   Mon, 27 Jan 2020 13:38:37 -0300
Message-ID: <CAJ4jsaf+s71UB9YOS_jeAn79t=2vSsY+7b-UvGPUEne87+ohPQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.35
To:     Karel Zak <kzak@redhat.com>
Cc:     J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 27, 2020 at 1:13 PM Karel Zak <kzak@redhat.com> wrote:
>
> On Sun, Jan 26, 2020 at 11:59:59AM -0500, J William Piggott wrote:
> > You do realize that I had to heavily modify that file to remove its
> > gnulib dependencies (because you said no to gnulib). If I recall
>
> I know, this is why we keep it in the tree (and thanks for all the
> work!).
>
> > correctly I had newer and older versions to chose from and picked that
> > one due to it having the most bugs fixed while still being practical to
> > strip its gnulib dependence.
> >
> > The reasons for making the change were:
> >  * remove hwclock's dependence on date(1)
> >  * remove an insecure call to date(1)
> >  * I thought there would be to many complaints if the accepted input
> >    date formats were changed
> >
> > As to the last bullet point; personally I think having the --date optio=
n
> > accept every date syntax know to history is nonsense.
>
> Yes, I agree it's probably overkill.
>
> > Or you could just use the existing utillinux date parser.
>
> This is what I have implemented for --disable-hwclock-gplv3 to have
> anything ASAP for the next 2.35.1 update... Maybe we can make it the
> default for the next release v2.36 and later remove the gnulib code at
> all.
>
> > The question is, do you want to deal with any pushback for
> > changing the long established accepted --date formats?
>
> IMHO the existing utillinux date parser is good enough, but I have no
> clue how people use --date.

This is a bit disturbing. People should know in advance what date/time
formats hwclock supports. They should be described in the man page, at
least in a simple statement like =E2=80=9Cthe suported date formats are the
same as foo(3)=E2=80=9D. Leaving it to be guessed by users, either reading =
the
source code or testing at run-time does not make sense. The man page
does not even mention Documentation/parse-date.txt.

--
Carlos Santos <unixmania@gmail.com>
