Return-Path: <SRS0=58Rc=QS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2332CC169C4
	for <util-linux@archiver.kernel.org>; Mon, 11 Feb 2019 09:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C282146F
	for <util-linux@archiver.kernel.org>; Mon, 11 Feb 2019 09:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfBKJlt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:41:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKJlt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 11 Feb 2019 04:41:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21C2DC01DDF2;
        Mon, 11 Feb 2019 09:41:49 +0000 (UTC)
Received: from ws.net.home (ovpn-204-77.brq.redhat.com [10.40.204.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D4945B682;
        Mon, 11 Feb 2019 09:41:47 +0000 (UTC)
Date:   Mon, 11 Feb 2019 10:41:43 +0100
From:   Karel Zak <kzak@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Johannes Unglert <unglert@b1-systems.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: Improvement suggestion for mkfs.8 manpage
Message-ID: <20190211094143.5n77lillrqeyoy66@ws.net.home>
References: <8cac72fd-8116-53e9-1a7f-5c22377dce04@b1-systems.de>
 <20190207161304.GC7387@mit.edu>
 <3ee93fe9-e024-ef49-92d0-0167318bba36@b1-systems.de>
 <20190208152002.GA23000@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208152002.GA23000@mit.edu>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 11 Feb 2019 09:41:49 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Feb 08, 2019 at 10:20:02AM -0500, Theodore Y. Ts'o wrote:
> In general, I generally recommend that people use /sbin/mkfs.ext4 or
> /sbin/mke2fs -t ext4, because the mkfs wrapper doesn't add much value,
> and it gets confusing which options are parameters are grabbed by
> mkfs, and which will get passed to the back-end mkfs program.

Yes, the first sentence in the DESCRIPTION section:

  This mkfs frontend is deprecated in favour of filesystem specific mkfs.<type> utils.


Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
