Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24948C433EF
	for <util-linux@archiver.kernel.org>; Tue, 14 Dec 2021 11:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhLNLqn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:46:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59130 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhLNLqn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Dec 2021 06:46:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3C29721124;
        Tue, 14 Dec 2021 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639482402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/coxntgxc92qd3kfm5eo8c+DIH8SV/iT8G9DuLNWzeo=;
        b=PB4A+pn+n3pbqsocjk85KQcSfYb4xxgK2W86r4+FvnYO2KS5N7tCZ2Zmr6Wtxrp8cl4kY9
        aGK2gJnJlWZEM+rO6IYSAgM0ouXYM5wFsOvy8T4xODW+eTJcegJa62buJybE7MCzW8M3vm
        pWPqT1YIvJ7Xjr1VuBYKIV1g37JwFFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639482402;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/coxntgxc92qd3kfm5eo8c+DIH8SV/iT8G9DuLNWzeo=;
        b=aVAvz1vSC3tVh9g3FtFVWBW22KgT30SfJplkXlA1u/GANe09YH3hIDsNUTAvcvsLDyjYd+
        htEzLC9uAQ0xQsAg==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 277E8A3B81;
        Tue, 14 Dec 2021 11:46:42 +0000 (UTC)
Date:   Tue, 14 Dec 2021 12:46:41 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kzak@redhat.com,
        kurt@garloff.de, den@openvz.org, efremov@linux.com
Subject: Re: [PATCH 0/2] libblkid: don't use O_NONBLOCK for floppy
Message-ID: <20211214114641.GX117207@kunlun.suse.cz>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Dec 09, 2021 at 03:12:31PM +0100, Vladimir Sementsov-Ogievskiy wrote:
> Good day everyone!
> 
> The commit "floppy: reintroduce O_NDELAY fix" was removed from kernel,
> so we faced the bug described and discussed here:
> https://bugzilla.suse.com/show_bug.cgi?id=1181018
> 
> Discussion in kernel list on reverting the commit:
> https://www.spinics.net/lists/stable/msg493061.html
> 
> In short, I can quote Jiri Kosina's comment:
> 
>    opening floppy device node with O_NONBLOCK is asking for all kinds
>    of trouble
> 
> So opening floppy with O_NONBLOCK in blkid leads to failure of blkid,
> probable failure of mount and unpleasant error messages in dmesg (see
> also patch 02 for details).
> 
> Vladimir Sementsov-Ogievskiy (2):
>   libblkid: introduce blkid_safe_open
>   libblkid: reopen floppy without O_NONBLOCK

Reviewed-by: Michal Suchánek <msuchanek@suse.de>

See nit in patch 2.

Thanks

Michal
> 
>  libblkid/src/blkid.h.in   |  2 ++
>  libblkid/src/evaluate.c   |  2 +-
>  libblkid/src/libblkid.sym |  4 ++++
>  libblkid/src/probe.c      | 44 ++++++++++++++++++++++++++++++++++++++-
>  libblkid/src/verify.c     |  2 +-
>  misc-utils/blkid.c        |  2 +-
>  misc-utils/wipefs.c       |  2 +-
>  7 files changed, 53 insertions(+), 5 deletions(-)
> 
> -- 
> 2.31.1
> 
