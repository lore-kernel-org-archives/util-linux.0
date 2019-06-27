Return-Path: <SRS0=KqhM=U2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34ABC48BD6
	for <util-linux@archiver.kernel.org>; Thu, 27 Jun 2019 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1E42084B
	for <util-linux@archiver.kernel.org>; Thu, 27 Jun 2019 13:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W65xxHCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfF0N7e (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:59:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54308 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0N7e (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 27 Jun 2019 09:59:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so5841634wme.4
        for <util-linux@vger.kernel.org>; Thu, 27 Jun 2019 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8gudWxLxmhq814OrURwj2YjqVWjRPS70Bt7kz+bbPUA=;
        b=W65xxHCSVz9NO/d8YM6GUXm4Y4Z6lHJ30PW5nLvfrE3Pd5i3Ari3sY4pzGc7BnCVaL
         tSSeUOacM84+2M7hzShk6lwCotTFhtrTD47sRzMYGZuhXxvzp29/5v5MuFrgK3ZWOZcE
         tvRpr9VY+7hknPEL1qbIsoSCt9YcZ9V1365Mj+Gcffw2TKJvg5nzTi4a6ySOcKolKTJG
         msOibGAMmonRdZVzwvNvlQIyK+ERAbpnBHRzhk40nDaCmpkaoYR4x7oXstW4f6B7duqh
         leIOP3mn1L2r9RLTELKyztPLom1I/hQ3k3QZPrP7xkT53XX7olFNnjhsp2qv0A7ZrivS
         Sswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8gudWxLxmhq814OrURwj2YjqVWjRPS70Bt7kz+bbPUA=;
        b=sqRcyAtP9Zbx8FtFhnjUPeq12NdAUNmaldGRQklkO8hzZl2qRttf8Tyy2SVLVwju5X
         fEV5b/voPyp0ZWPRo4BOlvlsPG16jsq3Wa2BJBgiy1ecsax+fvBNTv9swDIjyBzHP8M1
         5roNx283S2AAXVzrz2pErCbeqzGig0Mnwz2VFPTGWa/rZrixo1W5KeaHnf+FAGW8mr/+
         V404gXpBUfMPG9DZYjJUo7gHlItxVfKBgLhU/yOAqAbQ30e/RsJ094dF/Lj9M3TbJBsG
         DuH43QqHaBGcRHNzzP1XzE17YpFPtowJhAUmcwOaVS0kQcnj7kDTfMv723Zvfee/9L61
         TZFw==
X-Gm-Message-State: APjAAAVyqRv1PFb6fWpBys5eHzo9WaVzhJ2m3EfXQSk9oY5mjEmo1KKl
        XqX/VgzQQpeNNvMzmpyxyZ7Hum0tVEanM+WKYQs=
X-Google-Smtp-Source: APXvYqxtP1T6AbL0mByX2OZEM0iyqRDF64zc6GlL8wH1ME5Eb+kG8TbRkzR1asFf4dzTvONz3YkGEJOZdeDDoLG46tg=
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr3243903wmh.115.1561643971929;
 Thu, 27 Jun 2019 06:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190623223052.3345-1-unixmania@gmail.com> <20190624074114.oqz6s64pxgep562a@ws.net.home>
In-Reply-To: <20190624074114.oqz6s64pxgep562a@ws.net.home>
From:   Carlos Santos <unixmania@gmail.com>
Date:   Thu, 27 Jun 2019 10:59:21 -0300
Message-ID: <CAJ4jsacRnKrmB2e9D-KP8A4wcb4FsrRZDeABXwsR6hRtnGjThA@mail.gmail.com>
Subject: Re: [PATCH v2] hwclock: define cmos_interface only if necessary
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 24, 2019 at 4:41 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Sun, Jun 23, 2019 at 07:30:52PM -0300, unixmania@gmail.com wrote:
> > Make the static declaration of the cmos_interface struct and related
> > functions conditional to i386/x86_64, preventing several "defined but
> > not used" compiler warnings.
>
> I think we have to be more aggressive :-) It would be better to:
>
> ./configure.ac:
>  * add --disable-hwclock-cmos
>  * add USE_HWCLOCK_CMOS (enabled by default for i386/x86_64)
>  * add define(USE_HWCLOCK_CMOS)
>
> sys-utils/Makemodule.am:
>  * compile hwclock-cmos.c only "if USE_HWCLOCK_CMOS"
>
> hwclock:
>  * remove all unnecessary #ifdefs from hwclock-cmos.c
>  * add #ifdef USE_HWCLOCK_CMOS to hwclock.c:determine_clock_access_method()
>
>
> Note that we already use the same for RTC (which is linux only).
>
> The result will be more readable hwclock-cmos.c and only optional cmos
> code compilation.
>
>     Karel

OK, I will give it a try over the weekend.

-- 
Carlos Santos <unixmania@gmail.com>
