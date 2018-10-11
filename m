Return-Path: <SRS0=Y62r=MX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB3BC46466
	for <util-linux@archiver.kernel.org>; Thu, 11 Oct 2018 12:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEE42077C
	for <util-linux@archiver.kernel.org>; Thu, 11 Oct 2018 12:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEE42077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJKTuj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbeJKTui (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 11 Oct 2018 15:50:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FCB530820C1;
        Thu, 11 Oct 2018 12:23:40 +0000 (UTC)
Received: from ws.net.home (ovpn-117-176.ams2.redhat.com [10.36.117.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D4005F1E7;
        Thu, 11 Oct 2018 12:23:39 +0000 (UTC)
Date:   Thu, 11 Oct 2018 14:23:37 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] agetty: Reload only if it is really needed
Message-ID: <20181011122337.gecalp2lyf725ah3@ws.net.home>
References: <6970a2cd-b392-ae40-8f10-65188594e88b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6970a2cd-b392-ae40-8f10-65188594e88b@suse.cz>
User-Agent: NeoMutt/20180716-423-e60b71
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 11 Oct 2018 12:23:40 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Oct 10, 2018 at 07:26:34PM +0200, Stanislav Brabec wrote:
> If netlink event arrives and related escapes are part of issue, agetty
> reloads and re-display the prompt. Reload is triggered not only by IP
> address change, but also by IPv6 RAs. In some environments it causes
> reload several times in a minute, and even complicates the login.
> 
> To prevent this, reload only if a real change appears.

Applied, thanks.

I have applied another changes too:

 - move all issue stuff to 'struct issue'
 - rename a few things
 - make code more robust

> This consists of:
> split print_issue_file() to several functions:
> 
> eval_issue_file() prints issue to memory. It does not affect terminal in
> any way.
> 
> print_issue_file() prints issue file from memory.
> 
> cmp_issue_file() compares the issue file and returns true, if reload is
> needed.

Let's hope people do not use \4 and \6 together with 't' because it
means time string in the output :-)

> Test suite:

Can you retest the current master branch with my changes? I do not
expect any issue, but for sure...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
