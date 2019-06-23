Return-Path: <SRS0=Vkmh=UX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A4C43613
	for <util-linux@archiver.kernel.org>; Mon, 24 Jun 2019 02:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3511208CA
	for <util-linux@archiver.kernel.org>; Mon, 24 Jun 2019 02:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLozL0SP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfFXCeD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:34:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50298 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFXCeD (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Jun 2019 22:34:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so11232377wmf.0
        for <util-linux@vger.kernel.org>; Sun, 23 Jun 2019 19:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FBi6k8oAFP+kggXSH+iVuisRFqNsL9BpGjTkgNbYtRM=;
        b=vLozL0SPhO65QjrTXQ07GNfwcnnJus5TTvQIRXSTmNGIf1eQJuRmXQx2+hjO5pQG8K
         GcRU0OMYA+XBfPt2eFax7Ss6B/ecHgUJnGE0ekt0M0yF3Px/ok5ucDEGhboHcQ1BVRvY
         nq6NWfdE8gS7BA8boRSl1qVWrx66ttHb5+xFqBuKd2c8eL8bXXketH6hKIut4hwC84BM
         mfeXzd4y4TmkPGaMOEBqN5g4b5ZFHeIMsYnsiSVmKjRtIcrR6Zlk9jpokk5hiupLNPha
         fe5G8i0uwi1gowALjToom3wIz2y7zqCXLYLc7Ai85+3UnTqW26D1+nqy961BgyHPrY+/
         kCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FBi6k8oAFP+kggXSH+iVuisRFqNsL9BpGjTkgNbYtRM=;
        b=TstOC3IJoa5WNQV25JB46gMNCDkZnsW8I8MxXdYPRBfxZKCkOn/QOzIHUc4mhTZRrq
         g3XfxK5PhoGTbznhXb8ZhzIHu8y4RCU7elpGDbJe9QVabut/nYsJRKQFgT+odtnZL4nl
         5fyHcJJaZ0SMjIMt45qf6G4h1dV25aCsaTAeXNAHglW+pYFv0IIBirXdV5/RbdpVjsbf
         uu/a8I0GL9Ry8YYjk3CrB+/l2x2bxOM3bwjMtCnsgudFzClGmnSnb7+aW4KTzxGlwiUg
         g5CG8iMsbDGOR6NXK6KBl+U+6qcRZ8WA3g8nhvUNGLeNHD8JFERsWY0BLTQ4x02vCrIH
         XBOA==
X-Gm-Message-State: APjAAAUMwLo4+g5kEnKWPm4WB1ySVDtFztdOl1U2XRMDDGg8ZFh+9lb4
        yj06eK7mXL2DbJAxlcrKQ7BW01Uu8cHugLHABWYGUvTG
X-Google-Smtp-Source: APXvYqyvDKIyXu+uzLILEEAUZeitNhDM9Qi2siLIDDLwXeXLwlFBI5lL+a4AyCT0lYuAD74Kcjdr9L/egqiC0DnlGsM=
X-Received: by 2002:a1c:238e:: with SMTP id j136mr11870664wmj.4.1561329151823;
 Sun, 23 Jun 2019 15:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190623172800.23445-1-unixmania@gmail.com>
In-Reply-To: <20190623172800.23445-1-unixmania@gmail.com>
From:   Carlos Santos <unixmania@gmail.com>
Date:   Sun, 23 Jun 2019 19:32:20 -0300
Message-ID: <CAJ4jsacE=p_4+v_L4XEF1KRma-tmnRCUP+e8wqF=8FmBPwFf1A@mail.gmail.com>
Subject: Re: [PATCH] hwclock: define cmos_interface only if necessary
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Jun 23, 2019 at 2:28 PM <unixmania@gmail.com> wrote:
>
> From: Carlos Santos <unixmania@gmail.com>
>
> Move the static declaration to the probe_for_cmos_clock() function and
> make it conditional to i386/x86_64, preventing a "defined but not used"
> compiler warning.
>
> Signed-off-by: Carlos Santos <unixmania@gmail.com>
> ---
>  sys-utils/hwclock-cmos.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
> index a11f676b8..ada4a9c43 100644
> --- a/sys-utils/hwclock-cmos.c
> +++ b/sys-utils/hwclock-cmos.c
> @@ -398,21 +398,21 @@ static const char *get_device_path(void)
>         return NULL;
>  }
>
> -static struct clock_ops cmos_interface = {
> -       N_("Using direct ISA access to the clock"),
> -       get_permissions_cmos,
> -       read_hardware_clock_cmos,
> -       set_hardware_clock_cmos,
> -       synchronize_to_clock_tick_cmos,
> -       get_device_path,
> -};
> -
>  /*
>   * return &cmos if cmos clock present, NULL otherwise.
>   */
>  struct clock_ops *probe_for_cmos_clock(void)
>  {
>  #if defined(__i386__) || defined(__x86_64__)
> +       static struct clock_ops cmos_interface = {
> +               N_("Using direct ISA access to the clock"),
> +               get_permissions_cmos,
> +               read_hardware_clock_cmos,
> +               set_hardware_clock_cmos,
> +               synchronize_to_clock_tick_cmos,
> +               get_device_path,
> +       };
> +
>         return &cmos_interface;
>  #else
>         return NULL;
> --
> 2.18.1
>

Please ignore this patch. I just sent an updated one.

-- 
Carlos Santos <unixmania@gmail.com>
