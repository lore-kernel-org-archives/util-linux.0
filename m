Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D93C433F5
	for <util-linux@archiver.kernel.org>; Wed,  6 Apr 2022 14:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiDFOFV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiDFOFO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2022 10:05:14 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D6C33E85
        for <util-linux@vger.kernel.org>; Wed,  6 Apr 2022 02:33:41 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e1e5e8d9faso2305831fac.4
        for <util-linux@vger.kernel.org>; Wed, 06 Apr 2022 02:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o8Q43ppOD7z/jwbNbG/7rjnAldUfYVJV7RWxej8rEU8=;
        b=RnfnprNCIxxmTBj7jqDyVrQQLUm3kVwJM3y0Q6F6iHJzDrLUEsOwHjg8W5V8xluOkt
         42zbxbMFbHc7zEPvRhIFKaWod99pFfYBwJp5c4F7pe9nPqjRT1xu9N917bnbrwYvV9mN
         rJpvdfZ9q2XJVC+U+wXlgB+kKsuAljCI451uZw/cFhQTL+qto/gH/zjn/pNZ/V9eSUvV
         sKfjTerLoRlaUM7f5c3ITD3hjoZfPNZog0SL0h3DZlVc7lD6+lxlSfIfcUWEpj4/iVZ6
         rzdWWdfPDoFTfVt9qAF9jTQ3Q91i/oWQPYd4VVVyDoS5HrZTNW34VSMOfwiS7SUDuh2P
         4XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o8Q43ppOD7z/jwbNbG/7rjnAldUfYVJV7RWxej8rEU8=;
        b=VrglXLA69rGHB1t1wnXB7XoQYCzWaYwQNxsltgIebVD1BLObZrIP8bBuKy2oO1Y5+X
         lUkUQfGipOz34S7VvBVhZ+3TaENoGnOhZQkR+/fb+/rWVmV0tgWi8owB972Eh4Lohqh0
         jtqsU47lDZcKuvfid1onK+TGdiayxWzTg2UQJ0T7Y1EQuG0+FAkmRmD0z7N80XIon2Mj
         HNukTgbxj8nQERJoAljwNddO1wXuhsabaZ+9wLd6pCS/D9lPFKits/wTk+GvWK/AT00a
         85iyGysmQhVmNi8K3noVhd/jpA8Qe5/dkX2Jhi2h0s6lThQOVy+wH4Yj8L2A4jwu82GK
         LD+w==
X-Gm-Message-State: AOAM532098oErdCWXRRMecWBYHw96Ko/B4v5F02k6wSQnn0k0ko8AOcF
        6PmAHUEofVnCIUGDOGYyGMngr7gg3VgHukzeZ9rPktyA
X-Google-Smtp-Source: ABdhPJySalIlEMD+bxdFGwHVk/JzY5jramIuljvSN5+FF/HMYoIW3UPGu36s2hJkdGKlW/HgMcNbxjKIkI3XTdVH5u0=
X-Received: by 2002:a05:6870:d28d:b0:da:b3f:3234 with SMTP id
 d13-20020a056870d28d00b000da0b3f3234mr3399666oae.228.1649237621060; Wed, 06
 Apr 2022 02:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220405180459.944658-1-fontaine.fabrice@gmail.com> <20220406084310.dw3exobhzgzboaqx@ws.net.home>
In-Reply-To: <20220406084310.dw3exobhzgzboaqx@ws.net.home>
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
Date:   Wed, 6 Apr 2022 11:33:29 +0200
Message-ID: <CAPi7W80uOvMWaJpJjQ=UPOJ-mOJZ2yNYbJ_Uigos_xeJwnyr1A@mail.gmail.com>
Subject: Re: [PATCH] configure.ac: add lsns option
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Thanks for your quick feedback, I'll backport your patch to buildroot.

Best Regards,

Fabrice


Le mer. 6 avr. 2022 =C3=A0 10:43, Karel Zak <kzak@redhat.com> a =C3=A9crit =
:
>
> On Tue, Apr 05, 2022 at 08:04:59PM +0200, Fabrice Fontaine wrote:
> >  configure.ac | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Applied, thanks.
>
> It's good idea to add --disable-lsns, but for your use-case it's
> workaround. The proper solution is to compile lsns, but without
> NS_GET_ ioctls. Fixed by:
>
>     https://github.com/util-linux/util-linux/commit/fc686823b008bc95e2ebe=
904c706a117a03e2754
>
>  Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>
