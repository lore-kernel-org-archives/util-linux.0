Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5058FC4338F
	for <util-linux@archiver.kernel.org>; Fri, 20 Aug 2021 10:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5C660FE8
	for <util-linux@archiver.kernel.org>; Fri, 20 Aug 2021 10:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhHTK6N (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhHTK6N (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 20 Aug 2021 06:58:13 -0400
Received: from mail.namespace.at (mail.namespace.at [IPv6:2a01:190:1801:100::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BA7C061575
        for <util-linux@vger.kernel.org>; Fri, 20 Aug 2021 03:57:35 -0700 (PDT)
Date:   Fri, 20 Aug 2021 12:57:32 +0200
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Skip lsns/ioctl_ns test if unshare fails
Message-ID: <20210820105732.7sjjbwazxkal2zvv@zeha.at>
References: <20210820103050.1636810-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820103050.1636810-1-zeha@debian.org>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Sorry, I missed to add my own signoff.

* Chris Hofstaedtler <zeha@debian.org> [210820 12:42]:
> Some parts of the Debian build infrastructure uses unshare to run the
> package build, and that appears to cause a "nested" unshare in the
> lsns/ioctl_ns test to fail. Unfortunately the tests then hang at this
> point.
> 
> Try running unshare before the actual test, and skip the test if unshare
> already fails.
> 
Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
> ---
>  tests/ts/lsns/ioctl_ns | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/ts/lsns/ioctl_ns b/tests/ts/lsns/ioctl_ns
> index ef6360607..15dd1af74 100755
> --- a/tests/ts/lsns/ioctl_ns
> +++ b/tests/ts/lsns/ioctl_ns
> @@ -34,6 +34,8 @@ ts_check_prog "mkfifo"
>  ts_check_prog "touch"
>  ts_check_prog "uniq"
>  
> +$TS_CMD_UNSHARE --user --pid --mount-proc true || ts_skip "Namespace support failure"
> +
>  ts_cd "$TS_OUTDIR"
>  
>  # The parent process receives namespaces ids via FIFO_DATA from bash
> -- 
> 2.33.0
> 
