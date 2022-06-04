Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47302C433EF
	for <util-linux@archiver.kernel.org>; Sat,  4 Jun 2022 08:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiFDI2R (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 4 Jun 2022 04:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiFDI2Q (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 4 Jun 2022 04:28:16 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F5437A29
        for <util-linux@vger.kernel.org>; Sat,  4 Jun 2022 01:28:14 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id i66so13219942oia.11
        for <util-linux@vger.kernel.org>; Sat, 04 Jun 2022 01:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2fSEQ9NjsDKuaKdZipabOWizVFUiq2+oAelTStqmdY=;
        b=d8VYI2WCWeomwG9WafOGjbSuBappmeWjX4fVZmZbNT+/QSLCUkVbNpoHBarlJb2/OE
         G4+hyenpayKHKNDnCzfS36bbwhJfrbCRrj1JNoxMSvVMfPDyZP1fLQHwaWAAzT3IUxr7
         UmbE77oaQohMUuA6Rsx98izMV5yx7mny2Y7JrqSCvxL9ceDvxv9QUpjsSe8my7aKj94e
         gzrGjJLMdXTVWeFKDXyAs3KOn/UijYLLSo/aud5sbmsEC/lkHqR4l4Hxt5ctxnvpOJy9
         hSmVeXLj6FwGoAXENtcA11fmQnUPUlYeh6TQ+xccP/h01SC56eRw0dDhvRYaSIvAOBnx
         grJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2fSEQ9NjsDKuaKdZipabOWizVFUiq2+oAelTStqmdY=;
        b=xfsVzbL5cpumXc88ItaH1gKPoJck1sUbhjW4jHlRoWQU4Yt0U3QQE5hMgxCdjsbTVE
         KeSVLGmDk+nn4qUpcxdOiAQfStCdNuOCZYeNauYQBo3PRinjBwf+wbUjdtTyO1x2b+nB
         rgpCamEzl351VywgsUlIRblO7o9ljwiMMNLeJK2sMBpiHkYgqDr9dJhe7o+yMuW2EK2p
         EZey7lGulKgSwSZBpqN6T+eQ1ank9mVW3oBsE5/hZCZpqIxvzX7P+22uFN8r+WLgMLM1
         NEgNVyE3iAU3nScUPY38k3ZIMdT8bSkDF5NTsnakTwXD/4dypa1/e1+LzXve3ASZ/Pon
         u7VQ==
X-Gm-Message-State: AOAM531hb3cOl3blQX9TJSFxkHTI9cRKk54yBfWKPnK5rpS3gjnaYSbk
        M1Tr3uEiUsjeUX+So54TCdv0ng75kudb2zPuiFII1AxWiKA=
X-Google-Smtp-Source: ABdhPJyNJaOUoFwoQKzxVrikfg7NZGqNmUV1ymuvq5wHQaRIHZecbQWpIZNxxGv5ZFoztO/HfrghauUuDrlKxOgfSmc=
X-Received: by 2002:a05:6808:2002:b0:32b:50ab:431f with SMTP id
 q2-20020a056808200200b0032b50ab431fmr8075666oiw.120.1654331293667; Sat, 04
 Jun 2022 01:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqzipCFaFFAs-o=FDA_g=9NmrqzieXaYtWwbGCCXDeiM5g@mail.gmail.com>
 <SN6PR04MB39834AB02ACBCA91B949F821C2A09@SN6PR04MB3983.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB39834AB02ACBCA91B949F821C2A09@SN6PR04MB3983.namprd04.prod.outlook.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sat, 4 Jun 2022 11:28:08 +0300
Message-ID: <CADxRZqxFetP=SczfzZtpx_G1OgseFtpLLQwDhLhCJ_NMGRGhUg@mail.gmail.com>
Subject: Re: [PATCH] pipesz: use native PAGE_SIZE in tests
To:     Nathan Sharp <nwsharp@live.com>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jun 4, 2022 at 5:00 AM Nathan Sharp <nwsharp@live.com> wrote:
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> --- a/tests/ts/misc/pipesz
> +++ b/tests/ts/misc/pipesz
> @@ -18,6 +18,10 @@ TS_DESC="pipesz"
>  . $TS_TOPDIR/functions.sh
>  ts_init "$*"
>
> +set -o pipefail
> +
> +DEFAULT_PIPE_SIZE=$(($(getconf PAGE_SIZE) * 16))

DEFAULT_PIPE_SIZE=$(($($TS_HELPER_SYSINFO pagesize) * 16))

to be consistent with other tests
