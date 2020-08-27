Return-Path: <SRS0=LL90=CF=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA4CC433E3
	for <util-linux@archiver.kernel.org>; Thu, 27 Aug 2020 15:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9912080C
	for <util-linux@archiver.kernel.org>; Thu, 27 Aug 2020 15:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7t98d5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgH0PQ7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgH0PQu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 27 Aug 2020 11:16:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABA5C061264
        for <util-linux@vger.kernel.org>; Thu, 27 Aug 2020 08:16:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s19so2845729eju.6
        for <util-linux@vger.kernel.org>; Thu, 27 Aug 2020 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUdHpDKke+KriCmUWpL9cZ+xrqLYgX5ga8ArTSWViok=;
        b=b7t98d5ncP1V7N8YliRoKC8KIImCI7ICIK3K7Wq56QRp8HArptGC4HH/kIvS8q6Qoy
         F42V1Ueei6p7cUVc2mp33E+AgJqGHMTGlcVCrZSryWJzobPMsRxXbYMPGBRx+j/gAay6
         4VU8rvmroWhtN5n9gC2IVShD+f8uAXCWgyoZvcb033eonu5+e2wafH4fellR6jKOu6Ml
         ab45D6pHw9iVlz2UpAM35k05mVNV8A/IcQP6lT9gKhB0X8vGRCQlNDKx1qeL5CqveQx4
         YAUbVkCmJQ58vCdYTkvas4iZbSFBKMC4cZIp95jsOT09TZUwSzqmSjBnZ1X6T9MEZVg4
         TD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUdHpDKke+KriCmUWpL9cZ+xrqLYgX5ga8ArTSWViok=;
        b=P7D8PSyUh3YZDllmpsZrfCeSWNILf9WKfZUrmGfU7E55b7ji63hDr+68Ibep+hLJTe
         TsOuCdB5cefGjvfC6FX8BMWYYCwjbPCHN0POlkCEkjD7vqQ5E/hUvVM3UqOfNr4pzNoz
         DmgyWLCPgSIVgQHg+4FQ0i3cs/lOSDWdjxjsWQSag5WV4Xl/BUy/nXvWoYiKrWtgn497
         UxvwpmoK5d8fUD96xV1kTACUXt5lb+1A1F+CRMajDxmwmAmi6yBxVpkWKF0Kime1uCvV
         nUKSX/jfdqz3HT31Nx1p05rKwDbXOuc+kgG8Wn0PRu3+vPA7oapkntjca4VP6hKzJfZF
         kEOA==
X-Gm-Message-State: AOAM530UH1G+rsqqoBGoOw5QAddy7i3AB4RI/pgCO8rh+1GfdeJR72BA
        TCRlFChpBzUDqRech5ngblI5GRmygyya5GoyjrGo8rEi
X-Google-Smtp-Source: ABdhPJzs84MsVUQ62GSMZpmdeCqLF4iBZOI4OhjyF0wPfp7yNOMJpGzvxq0rtEj+7uXbE0zz0NCMdWMKBu/2aCipuWw=
X-Received: by 2002:a17:906:af41:: with SMTP id ly1mr20819726ejb.418.1598541406896;
 Thu, 27 Aug 2020 08:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200724100618.584918-1-mtk.manpages@gmail.com>
 <20200724100618.584918-4-mtk.manpages@gmail.com> <rff2f1$77s$2@ciao.gmane.io>
In-Reply-To: <rff2f1$77s$2@ciao.gmane.io>
From:   Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Thu, 27 Aug 2020 17:16:35 +0200
Message-ID: <CALxWeYpTakVkzRtzMPdGvtr0T7=0u+WKQZ8AxQAZkWA7qJvWJQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] Manual pages: sfdisk.8: Minor wording and
 formatting fixes
To:     Nuno Silva <nunojsilva@ist.utl.pt>
Cc:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Nuno,

On Fri, Jul 24, 2020 at 6:33 PM Nuno Silva <nunojsilva@ist.utl.pt> wrote:
>
> On 2020-07-24, Michael Kerrisk (man-pages) wrote:
>
> > Signed-off-by: Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com>
> > ---
> >  disk-utils/sfdisk.8 | 38 +++++++++++++++++++++++++++-----------
> >  1 file changed, 27 insertions(+), 11 deletions(-)
> >
> > diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
> > index 6c3f62edd..6c54a1699 100644
> > --- a/disk-utils/sfdisk.8
> > +++ b/disk-utils/sfdisk.8
> [...]
> > @@ -601,7 +615,9 @@ The welcome message.
> >
> >  .SH ENVIRONMENT
> >  .IP SFDISK_DEBUG=all
> > -enables sfdisk debug output.
> > +enablescw
>
> And here "enables", not "enablescw"?

Yes; thanks. I've sent a patch to fix the two typos that you noticed.

Just a note though: when you strip the CC from a message, it's very
likely (because of things like individual mail filtering rules) that
relevant people will *not* notice your mail. It's best to always
preserve the CC list, unless there's some good reason not to.

Cheers,

Michael
