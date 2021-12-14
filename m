Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468EFC433EF
	for <util-linux@archiver.kernel.org>; Tue, 14 Dec 2021 10:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhLNKZV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Dec 2021 05:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhLNKZU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Dec 2021 05:25:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F408C061748
        for <util-linux@vger.kernel.org>; Tue, 14 Dec 2021 02:25:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AB22B8184A
        for <util-linux@vger.kernel.org>; Tue, 14 Dec 2021 10:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BA6C34600;
        Tue, 14 Dec 2021 10:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639477518;
        bh=zNtLt9nDpbL31wYC0+OUq9zAEzZAYI95yB2NG8H4Me8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ppcdbngGyIUH29E/vn+CaaSd+L4Q4pm7hSbSD+RmyhPRANB2NDC0uLqTMvcJttN5q
         rV0Khac//OSHx23SYL2QMvm22vnYkF9fz7DQvi6l2y08hIn59IFPfVRobLl//FlBQ9
         pF1YAxjwo4u/+5IFCXt1JFS5fBKMsU6ltP2q1ZICFloVaMee/qEjMjF17fnaG13PMn
         7ewfEHHYoKPbHZBxiWdfnNYVCEZNkXh4nRluIUPsxUTzYeW2iT6ntOowaZXTsVGlGh
         F1lwh8tl79PyoJSBuw+m+spPvSIqZC3jo/uBwn8A2X19RtR4J2IdtSmnE85R1piEmP
         zocBJkVDHqRJA==
Date:   Tue, 14 Dec 2021 11:25:14 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
cc:     util-linux@vger.kernel.org, kzak@redhat.com, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
Subject: Re: [PATCH 0/2] libblkid: don't use O_NONBLOCK for floppy
In-Reply-To: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
Message-ID: <nycvar.YFH.7.76.2112141123570.16505@cbobk.fhfr.pm>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, 9 Dec 2021, Vladimir Sementsov-Ogievskiy wrote:

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

Ah, thanks, finally someone found the motivation to look into what it'd 
take to fix this properly in libblkid. FWIW,

	Acked-by: Jiri Kosina <jkosina@suse.cz>

for the changes.

Thank you!

-- 
Jiri Kosina
SUSE Labs

