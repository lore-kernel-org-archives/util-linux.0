Return-Path: <SRS0=sRCm=5N=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74F7C43331
	for <util-linux@archiver.kernel.org>; Sat, 28 Mar 2020 22:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AC220732
	for <util-linux@archiver.kernel.org>; Sat, 28 Mar 2020 22:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgC1Wkf convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:40:35 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:51674 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgC1Wke (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 28 Mar 2020 18:40:34 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8DB1D5605EE
        for <util-linux@vger.kernel.org>; Sat, 28 Mar 2020 23:40:32 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id s23so5034784plq.13
        for <util-linux@vger.kernel.org>; Sat, 28 Mar 2020 15:40:32 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2Bj31m8Wo2jmndOgt0LPk8wlXKKiy0O3fs4wNrdajTCtf1ZZYD
        cDl1rws8S8Qdx6Wwdpc+jF+WOm/QoR0jCfOP9x0=
X-Google-Smtp-Source: ADFU+vuEoNRf2y7H+vMRsFfo1LrciqmnkLj/l+ee9x0GWXFwFHqsXqYh9muve2i53UdDMlK8dhqy51ZLPCFxmDp3970=
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr5870806pls.36.1585435230908;
 Sat, 28 Mar 2020 15:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200328223341.11463-1-orel@melix.net>
In-Reply-To: <20200328223341.11463-1-orel@melix.net>
From:   =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Date:   Sat, 28 Mar 2020 23:40:20 +0100
X-Gmail-Original-Message-ID: <CAA0A08WSHwGSNqD00YJgmfCVM=-iLHJgV-T1JThRasxcgKjkfA@mail.gmail.com>
Message-ID: <CAA0A08WSHwGSNqD00YJgmfCVM=-iLHJgV-T1JThRasxcgKjkfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] cal: use a const char*
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Mar 28 23:40:32 2020 +0100 (CET))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

I am starting to work on cal to add the vertical layout
https://github.com/karelzak/util-linux/issues/604

I am starting to share some cleaning before submitting the feature.

What do you prefer for the feature itself ?
A Pull-request on github or patch using the mailing list?
I have no idea about how many commits I will create.
I can squash them once it is ready and submit on the mailing list.


Best Regars,
Ôrel

On Sat, Mar 28, 2020 at 11:33 PM Aurelien LAJOIE <orel@melix.net> wrote:
>
> A put string function should not modify the char*
>
> Signed-off-by: Aurelien LAJOIE <orel@melix.net>
> ---
>  misc-utils/cal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/misc-utils/cal.c b/misc-utils/cal.c
> index 6f192ccea..728600377 100644
> --- a/misc-utils/cal.c
> +++ b/misc-utils/cal.c
> @@ -108,7 +108,7 @@ static int setup_terminal(char *term
>         return 0;
>  }
>
> -static void my_putstring(char *s)
> +static void my_putstring(const char *s)
>  {
>  #if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW)
>         if (has_term)
> --
> 2.20.1
>

