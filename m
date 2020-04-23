Return-Path: <SRS0=ksb4=6H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0C4C2BA19
	for <util-linux@archiver.kernel.org>; Thu, 23 Apr 2020 10:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6718B20776
	for <util-linux@archiver.kernel.org>; Thu, 23 Apr 2020 10:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0iK50QH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgDWKlc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725863AbgDWKlc (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 23 Apr 2020 06:41:32 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076E1C035493
        for <util-linux@vger.kernel.org>; Thu, 23 Apr 2020 03:41:32 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so3936207edq.7
        for <util-linux@vger.kernel.org>; Thu, 23 Apr 2020 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=KfYtuvCBUyGx3z6UMKC5BCQuwyWXN5IpUYvAl88VKjM=;
        b=r0iK50QH95j4G0kSd54YIwG5JiJaIcJ/UNFWycEhTZadZfEzDnGGz3DgFkwsRhaBub
         XR0gv7c38dzF5jQ/CZUPQ0ydL8QI4prvXEtbPP66Ngc+TZLo6oiMPQWLcZmXcXHAeldf
         hV4CofvaMFSoZq0Je3FeEkJPzoO1D9ARyLkCoPdOMP/dv3AimehZhlBU/GbITwCCHO4a
         T/af8NVC8c8adG4AvANeawZcSfZVbs7TVOFfLvqnIOaYJQeXsX/VZ3VWAeV9MUZ1YGb7
         ieN3GdTpdOEm0RdEHrKoV3EWFZDzR+P07SVIFQPuqcpMYihDB0Nv1gsGtF1d1X9fhjar
         FqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=KfYtuvCBUyGx3z6UMKC5BCQuwyWXN5IpUYvAl88VKjM=;
        b=G+28Thiw00Tr9okH2b36PM4OqYKlFMORqq++M9uEv1Bg2qsB4MpZCOim883DjcyDwR
         RduAkzql1px43tJ3WK6D40uRJnP9MZSo0+3sIoVHl1jMa/f647DUWKGVTXOzFA6RCev5
         jT+5xRvRFpcEGDk8CPnnoSrgU/gdfUlzWnzlZwTwytb2MEmshPGgEoIAe2VbG0aaWrvC
         nwrczV5QNWj38UWKZCnd7RSs8nSJCsM3GVFMof4/6bPEeE22vYEM4YNy8EkztGu65g2b
         DCDmva1GoQNIXASgtihPwtqARgx+ES7BN1LqWSUjNrXSYpiusLBP2r6JxlUOQNoEoM2o
         elfA==
X-Gm-Message-State: AGi0PuZu6uUZoS8azxT1PHud9TewaomTVl2bOR2ikW1gugQSAqJGAlkG
        Gxp6nUWSoMEnrMAl8WfQmMHwxAYFyoSGZ6PqS9dOcQ==
X-Google-Smtp-Source: APiQypIvwwkkQnV9/97pf7sXPDBvUEFNvKhMTTEg1CGvIrnBNv7JrRovv6J/P7aRq5/Fz8mxKUkAfuBBrCWECulgo4A=
X-Received: by 2002:a05:6402:16da:: with SMTP id r26mr1958636edx.375.1587638490722;
 Thu, 23 Apr 2020 03:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200423083702.14466-1-steve@sk2.org>
In-Reply-To: <20200423083702.14466-1-steve@sk2.org>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 23 Apr 2020 12:41:19 +0200
Message-ID: <CAKgNAkg8Qgjc3Jaui9fMD7Y+s=VULQ57neFAnwAyBwoUc0WeOA@mail.gmail.com>
Subject: Re: [PATCH] docs: nsenter(1): fix further details in PID namespace section
To:     Stephen Kitt <steve@sk2.org>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Looks good to me.

Reviewed-by: Michael Kerrisk <mtk.manpages@gmail.com>

On Thu, 23 Apr 2020 at 10:38, Stephen Kitt <steve@sk2.org> wrote:
>
> The "Further details" sentence in the PID namespace section got merged
> with the surrounding text; this patch moves it to the end, to match
> the other namespace sections, and adds the missing clone(2) reference.
>
> Fixes: 894efece9eb89 ("Provide better cross references for namespace concepts")
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  sys-utils/nsenter.1 | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
> index 9cce839c0..c51d9b04a 100644
> --- a/sys-utils/nsenter.1
> +++ b/sys-utils/nsenter.1
> @@ -61,17 +61,18 @@ flag in
>  .B PID namespace
>  Children will have a set of PID to process mappings separate from the
>  .B nsenter
> -process
> +process.
> +.B nsenter
> +will fork by default if changing the PID namespace, so that the new program
> +and its children share the same PID namespace and are visible to each other.
> +If \fB\-\-no\-fork\fP is used, the new program will be exec'ed without forking.
>  For further details, see
>  .BR pid_namespaces (7)
>  and
>  the discussion of the
>  .B CLONE_NEWPID
>  flag in
> -.B nsenter
> -will fork by default if changing the PID namespace, so that the new program
> -and its children share the same PID namespace and are visible to each other.
> -If \fB\-\-no\-fork\fP is used, the new program will be exec'ed without forking.
> +.BR clone (2).
>  .TP
>  .B user namespace
>  The process will have a distinct set of UIDs, GIDs and capabilities.
> --
> 2.20.1
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
