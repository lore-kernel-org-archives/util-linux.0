Return-Path: <SRS0=jsgS=UK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F006CC4321A
	for <util-linux@archiver.kernel.org>; Tue, 11 Jun 2019 08:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CCD20652
	for <util-linux@archiver.kernel.org>; Tue, 11 Jun 2019 08:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404620AbfFKIPR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:15:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403996AbfFKIPQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 11 Jun 2019 04:15:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BECD23082B15;
        Tue, 11 Jun 2019 08:15:16 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F23B65C22E;
        Tue, 11 Jun 2019 08:15:15 +0000 (UTC)
Date:   Tue, 11 Jun 2019 10:15:13 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] fstrim -a/-A: Skip read-only volumes
Message-ID: <20190611081513.gvwpgg74qup2yg6w@ws.net.home>
References: <a46df663-bdfd-6f53-45e9-c4547e4ee108@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a46df663-bdfd-6f53-45e9-c4547e4ee108@suse.cz>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 11 Jun 2019 08:15:16 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 10, 2019 at 09:59:45PM +0200, Stanislav Brabec wrote:
> Calling TRIM on some read-only volumes can fail with:
> fstrim: /win: FITRIM ioctl failed: Bad file descriptor

Did you try it with the current version from git? ... because we
interpret EBADF as "the discard operation is not supported" warning
rather than an error.

> Skipping all read-only mounts seems to be safe and logical strategy.
> 
> Fixes opensuse#1106214.
> 
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> ---
>  sys-utils/fstrim.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
> index 0491e2b54..e0e9e57a9 100644
> --- a/sys-utils/fstrim.c
> +++ b/sys-utils/fstrim.c
> @@ -328,6 +328,14 @@ static int fstrim_all(struct fstrim_control *ctl)
>  		if (rc)
>  			continue;	/* overlaying mount */
>  
> +		/* FSTRIM on read-only filesystem can fail, and it can fail */
> +		if (access(path, W_OK) != 0) {
> +			if (errno == EROFS)
> +				continue;
> +			if (errno == EACCES)
> +				continue;
> +		}
> +

Anyway, for fstrim_all() it's probably good idea to call access().

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
