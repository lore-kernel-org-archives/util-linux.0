Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F562C46467
	for <util-linux@archiver.kernel.org>; Tue, 10 Jan 2023 17:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjAJR0W (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Jan 2023 12:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjAJR0V (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 10 Jan 2023 12:26:21 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB07568B2
        for <util-linux@vger.kernel.org>; Tue, 10 Jan 2023 09:26:20 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id AC837240490
        for <util-linux@vger.kernel.org>; Tue, 10 Jan 2023 18:26:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1673371578; bh=C23ZQnqQFCQtcq2QSe1Ryq3dO3f79Aac5Xnj3Boq+Vc=;
        h=Date:Cc:Subject:From:To:From;
        b=Q29P4rKt2OkJ4ZqKdoyOw2AEKhjGbOPpi/OE1VnVf2dDNAKG8wxodSKhaXkaSa/MJ
         dKgM/FRFY+19kqY8W0z3JVZT1TVAtDQdVhK+hDrSrwgR9OVf+ZI+mkLKch2/jU2k3i
         9hj5EZSaKO51viNnFn3iVyv9HIzQsWghNQMN7abeNxzK4x59fuJPcdmg6dz67//mKG
         PcOGv0WqBWpxonCT2trN/KI3Ym6fG77QseeO1olyA9z6V2ndst8bLcOGDRWqbbmNYH
         3evSyzsbOuH/7PTli1I+NuyJYPvQPuW9rAAJbLx2bREGN2ddRDbODUyETYN1SovtY/
         d92XEMB42KBxw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NryQd4tGjz9rxK;
        Tue, 10 Jan 2023 18:26:17 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 Jan 2023 17:25:07 +0000
Message-Id: <CPOOOY8R5JSS.1Y7ZTQL4S42BO@morphine>
Cc:     <kzak@redhat.com>, <achaiken@aurora.tech>
Subject: Re: [PATCH 1/3] schedutils: clarify confusing mask example in
 taskset man page
From:   "Tom Schwindl" <schwindl@posteo.de>
To:     <alison@she-devel.com>, <util-linux@vger.kernel.org>
References: <20230107194708.6878-1-alison@she-devel.com>
 <20230107194708.6878-2-alison@she-devel.com>
In-Reply-To: <20230107194708.6878-2-alison@she-devel.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

On Sat Jan 7, 2023 at 8:47 PM CET,  wrote:
> From: Alison Chaiken <alison@she-devel.com>
>
> Omit "0x" from a mask example which is clearly hexadecimal rather than om=
itting
> it from "32", which could be a decimal representation.
> ---
>  schedutils/taskset.1.adoc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/schedutils/taskset.1.adoc b/schedutils/taskset.1.adoc
> index c10cc62a2..efbab08dc 100644
> --- a/schedutils/taskset.1.adoc
> +++ b/schedutils/taskset.1.adoc
> @@ -52,10 +52,10 @@ is processor #0,
>  *0x00000003*::
>  is processors #0 and #1,
> =20
> -*0xFFFFFFFF*::
> +*FFFFFFFF*::
>  is processors #0 through #31,
> =20
> -*32*::
> +*0x32*::
>  is processors #1, #4, and #5,
> =20
>  *--cpu-list 0-2,6*::
> --=20
> 2.32.0

I'd keep the `0x` prefix simply for consistency reasons.
It's easy for the eye to recognize the character sequence as a number
and looks cleaner in general.

The second change, however, I think is right for the very same reason.

--
Best Regards,
Tom Schwindl
