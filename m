Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F35C433F5
	for <util-linux@archiver.kernel.org>; Thu, 20 Jan 2022 15:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbiATPge (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:36:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56840 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346547AbiATPgd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 20 Jan 2022 10:36:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C92ED1F388;
        Thu, 20 Jan 2022 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642692992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGqJBkiPksipMOrPgHFJbNpjlUHjeZB45nZa7+utJC8=;
        b=yQ5NhCQ26RHDv8KYmkazlpDn/b6jEFZCOR7s3ey2ztQvKqpDhpDEjOIfX96n4UhUhwFz1z
        X1ietc/x30dbQega1TQssXXEAmxsBwAHju0NLL1cI+5TwJ6NX0yblf1KJBQUNTh4kbHL+i
        jqEtag+tCqKS32LjsVNghBkX1Ijp2Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642692992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGqJBkiPksipMOrPgHFJbNpjlUHjeZB45nZa7+utJC8=;
        b=iMeQQzKNnOHRu34zvliaWe2RcRuGNCzXDU5iPK9d4JHZzB0pIHMqbT6Z4zTzYnt8Dqc3hV
        sqKRptPCQOLdUgDQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B9F8DA3B87;
        Thu, 20 Jan 2022 15:36:32 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ACBA7A05D3; Thu, 20 Jan 2022 16:36:31 +0100 (CET)
Date:   Thu, 20 Jan 2022 16:36:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] mount: Fix race in loop device reuse code
Message-ID: <20220120153631.bnzgg37egvcg2soi@quack3.lan>
References: <20220120114705.25342-1-jack@suse.cz>
 <a0ec54b9-869f-15e3-4b0c-4c922d120b40@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ec54b9-869f-15e3-4b0c-4c922d120b40@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu 20-01-22 22:46:57, Tetsuo Handa wrote:
> On 2022/01/20 20:47, Jan Kara wrote:
> > Fix the problem by rechecking that loop device is still attached after
> > opening the device. This makes sure the kernel will not autoclear the
> > device anymore.
> 
> Since this block is marked as /* overlap -- full size and offset match
> (reuse) */ , can just checking that neither loopcxt_get_fd() nor
> loopcxt_get_info() failed guarantee that full size and offset still
> match? Isn't there possibility that autoclear of file1 completes and
> another thread again assigns file2 (with different size or offset) right
> before /* Open loop device to block device autoclear... */ line? Don't we
> need to compare with more robust identifier like device:inode pair?

I was considering that as well (even had it coded in an early version) but
then decided agaist it. The underlying file, offset, size can change even
while you have the loop device open (through LOOP_CHANGE_FD,
LOOP_SET_STATUS, ...). So checking after having the loop device open is no
better than checking before and I could not come up with realistic scenario
where checking later would significantly help.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
