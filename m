Return-Path: <SRS0=I2d6=MY=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7378C43441
	for <util-linux@archiver.kernel.org>; Fri, 12 Oct 2018 08:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCE32086A
	for <util-linux@archiver.kernel.org>; Fri, 12 Oct 2018 08:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCE32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeJLQHt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:07:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34737 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbeJLQHt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 12 Oct 2018 12:07:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA74930DF713;
        Fri, 12 Oct 2018 08:36:28 +0000 (UTC)
Received: from ws.net.home (ovpn-117-176.ams2.redhat.com [10.36.117.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01EE177E25;
        Fri, 12 Oct 2018 08:36:27 +0000 (UTC)
Date:   Fri, 12 Oct 2018 10:36:26 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] agetty: Reload only if it is really needed
Message-ID: <20181012083626.chz7xq7642mj24xx@ws.net.home>
References: <6970a2cd-b392-ae40-8f10-65188594e88b@suse.cz>
 <20181011122337.gecalp2lyf725ah3@ws.net.home>
 <ac83a915-5a73-c4ff-6d43-2fea33166754@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac83a915-5a73-c4ff-6d43-2fea33166754@suse.cz>
User-Agent: NeoMutt/20180716-423-e60b71
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 12 Oct 2018 08:36:28 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Oct 11, 2018 at 09:37:07PM +0200, Stanislav Brabec wrote:
> Karel Zak wrote:
> > Can you retest the current master branch with my changes? I do not
> > expect any issue, but for sure...
> Works as expected.
> 
> There is one remaining issue:
> 
> Reload happens even if user already started to type logname. It is very
> uncomfortable

I thought about it too.

> and it can even lead to problems with login. I tried to
> fix that: Once any letter is already entered, reload will be blocked
> and postponed.
> 
> To fix this, we would need to disable reloads once any character was
> entered. It would require switch to character mode and custom handling
> of backspace. I am not sure, whether we want this.

We already had implementation based on character mode for the select()
and it was pretty fragile (see commit message 2a14beb4e9c6cdf4466993741d86e45dd57ddef3).

The problem was that the code tried to switch back to line mode within
get_logname() to manage control keys (del/backspace) by terminal. The
switch between the modes is really bad idea in time you read from the
terminal.

The character mode for all get_logname() is definitely good idea for
the reload issue, the question is how tricky will be to manage login
name string on terminal. You need to refresh all the output line on
del/backspace, etc.

Send patch ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
