Return-Path: <SRS0=K1B8=M7=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB6AECDE43
	for <util-linux@archiver.kernel.org>; Fri, 19 Oct 2018 07:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E56020869
	for <util-linux@archiver.kernel.org>; Fri, 19 Oct 2018 07:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E56020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeJSP6C (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:58:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeJSP6C (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 Oct 2018 11:58:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC0CD308421D;
        Fri, 19 Oct 2018 07:53:06 +0000 (UTC)
Received: from ws.net.home (ovpn-116-198.ams2.redhat.com [10.36.116.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77756600C8;
        Fri, 19 Oct 2018 07:53:05 +0000 (UTC)
Date:   Fri, 19 Oct 2018 09:53:03 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, util-linux@vger.kernel.org
Subject: Re: [PATCH v2] agetty: don't put the VC into canonical mode
Message-ID: <20181019075303.d6bqf3yja6psshqu@ws.net.home>
References: <20181016064149.2698-1-lkundrak@v3.sk>
 <20181016074053.dea6ydle26y37uva@ws.net.home>
 <9313c880-265c-908a-6138-c8f24d6c434e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9313c880-265c-908a-6138-c8f24d6c434e@suse.cz>
User-Agent: NeoMutt/20180716-423-e60b71
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 19 Oct 2018 07:53:07 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Oct 18, 2018 at 09:25:33PM +0200, Stanislav Brabec wrote:
> On Oct 16, 2018 at 9:40 AM Karel Zak wrote:
> > On Tue, Oct 16, 2018 at 08:41:49AM +0200, Lubomir Rintel wrote:
> >> Seems like zero lflags do the job just fine on a Linux VT. Reset it to
> >> canonical mode before running login.
> > 
> > What about Del/Backspace keys when user is typing login name? :-)
> 
> It could be easy without Backspace support. Just read the characters.
> But we have to implement Backspace.
> 
> When you leave canonical mode, then agetty code has to handle Backspace.
> 
> Hopefully, agetty doesn't support arrows and Delete (forward delete),
> so we don't have to implement advanced parts of line editing.
> 
> My experiments show two possibilities. I am not sure, what is better,
> but 1 seems to be more straightforward.
> 
> 
> 1) c_lflag &= ~(ICANON | ECHO)
> 
> This falls back to a no echo mode. Program has to handle echo and
> buffer parsing. Program has to handle backspace.
> 
> The implementation seems to be straightforward.
> 
> Downside: Remote logins can experience delays when getting echo.

This seems like a small downside as data from remote machine is pretty
common thing for remote access :-)

> 2) c_lflag &= ~(ICANON)
> 
> Non-canonical mode with echo seems to be usable as well. The terminal
> itself does the echo, program does the input parsing. Program has to
> handle Backspace. Echo will be immediate even with slow remote logins,
> but Backspace has to be handled remotely.
> 
> The second implementation has a problem: The Linux console input and
> output are out of sync in the time of agetty. Input returns 0x7f after
> pressing backspace, but output does back step (not back space) after
> sending 0x08. I don't know the fix yet.

This seems fragile, especially on environment with obscure serial
lines (or serial over ssh, etc.) where nobody has clue about proper
setting. It seems better to be slow than fragile.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
