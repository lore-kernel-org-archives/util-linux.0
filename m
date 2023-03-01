Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBB0C7EE2F
	for <util-linux@archiver.kernel.org>; Wed,  1 Mar 2023 14:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCAOSD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCAOSC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Mar 2023 09:18:02 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957196A73
        for <util-linux@vger.kernel.org>; Wed,  1 Mar 2023 06:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rQytVRF5f81ZcRhH1JZxZsjWldH1VZBpWZUB6edIsJg=; b=GNKKoFh0VSLDWg6znM9YFz0x1k
        ocPAIuGavaJGGzZBQ4RAbi/IE+x2IwhwoCb2G3kOF5e/iS3drlq19zO3RyPoajrxP8VOZzLKX0ZKd
        AGifYJnx25TG17hoHqdr8XaDlVo5Jw8MSmHiQNofRF30Fb6eqtyCbqHLBqpmqMgQJF5bZtFmyHN9Y
        BtN1spWG5h7Z2tNhjUaeADnOmflAHDkgSlXpcvcGbA9a51NcXSlhOF6NyJ2uB87D+XqQ/QnyF65Cb
        J6wSNj8izb/1oqQrn4RylvzMvV0QIA3L1kPNgTKzRgzWqccWUcys7VM+qYMYNx4QhfUJQTdsfseCV
        /In4Adpg==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <zeha@debian.org>)
        id 1pXNHG-00F16N-D8; Wed, 01 Mar 2023 14:17:54 +0000
Date:   Wed, 1 Mar 2023 15:17:47 +0100
From:   Chris Hofstaedtler <zeha@debian.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: Move clock.txt to /run
Message-ID: <20230301141747.jpbvk4aieq3pdehh@zeha.at>
References: <20230301140957.21604-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230301140957.21604-1-msuchanek@suse.de>
X-Debian-User: zeha
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

* Michal Suchanek <msuchanek@suse.de> [230301 15:10]:
> Moving the clock.txt to /run which is in tmpfs should resolve the
> problem even for users not running uuidd.
[..]
>  
> -#define LIBUUID_CLOCK_FILE	"/var/lib/libuuid/clock.txt"
> +#define LIBUUID_CLOCK_FILE	"/run/libuuid/clock.txt"

Last time I asked about this file on this mailing list, I was
informed that clock.txt is supposed to survive reboots.
Moving it to /run (or any other tmpfs) would break this.

Chris

