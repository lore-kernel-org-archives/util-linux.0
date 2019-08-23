Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D899C3A5A2
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 12:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0937521897
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 12:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393173AbfHWMPl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:15:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391421AbfHWMPl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 08:15:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13268307D868;
        Fri, 23 Aug 2019 12:15:41 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 502083769;
        Fri, 23 Aug 2019 12:15:40 +0000 (UTC)
Date:   Fri, 23 Aug 2019 14:15:37 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 6/6] tests: libfdisk: remove reliance on buffer behaviour
 of standard streams
Message-ID: <20190823121537.lcyj46ur7biaaick@10.255.255.10>
References: <cover.1566555078.git.ps@pks.im>
 <be4da4d3eee59f06f3c99e813f79d61e2636da38.1566555078.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be4da4d3eee59f06f3c99e813f79d61e2636da38.1566555078.git.ps@pks.im>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 23 Aug 2019 12:15:41 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Aug 23, 2019 at 12:17:03PM +0200, Patrick Steinhardt wrote:
> The tests in libfdisk/mkpart-full all rely on the buffering behaviour of
> standard output and standard error streams, most importantly that stderr
> is non-buffering and stdout is buffering. This doesn't hold on all libc
> implementations when redirecting to a file, breaking the test suite on
> such platforms.
> 
> Use the ts_unbuffered function to stop buffering of the standard output
> stream to fix this.

We have function ts_run. For now it's used only for some library tests
where we want to detect leaks, etc. It seems that growing number of
situations when we need some extra setting before the exec.

May be we can make this function more generic, add buffering control 
and use in all tests.

Something like

 ts_run leak unbuf -- $TESTPROG       # ASAN & unbuffered exec
 ts_run unbuf -- $TESTPROG            # unbuffered exec
 ts_run -- $TESTPROG                  # just exec

... or so ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
