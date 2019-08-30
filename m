Return-Path: <SRS0=drYi=W2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5277C3A59B
	for <util-linux@archiver.kernel.org>; Fri, 30 Aug 2019 19:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1EB20659
	for <util-linux@archiver.kernel.org>; Fri, 30 Aug 2019 19:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfH3TIM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:08:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbfH3TIM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 30 Aug 2019 15:08:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D165CD4CD;
        Fri, 30 Aug 2019 19:08:11 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-73.brq.redhat.com [10.40.204.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAD7F19D7A;
        Fri, 30 Aug 2019 19:08:10 +0000 (UTC)
Date:   Fri, 30 Aug 2019 21:08:07 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: use env and support both unbuffer/stdbuf
Message-ID: <20190830190807.f67rpglfbrkt3n7p@10.255.255.10>
References: <20190827111748.g4o375ya2shfrivs@10.255.255.10>
 <219cbcaeb173a07e97dbac8e1b653904369d91e0.1566907983.git.ps@pks.im>
 <20190828105107.tkhwqh3limxjo5yc@10.255.255.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828105107.tkhwqh3limxjo5yc@10.255.255.10>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 30 Aug 2019 19:08:11 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Aug 28, 2019 at 12:51:11PM +0200, Karel Zak wrote:
> Maybe the best and most robust solution would be split stdout and
> stderr into two files for each test. Now we have $TS_OUTPUT, what about
> to replace it with $TS_STDOUT and $TS_STDERR? Something like:
> 
>  - $TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
>  + $TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT >> $TS_STDOUT 2>> $TS_STDERR
> 
> And also create tests/expected/<foo>/<bar>{.err} for tests where any
> output on stderr is expected, otherwise assume $TS_STDERR is empty.
> 
> This change will be pretty invasive, but than we can easily compare 
> outputs and keep track about what is where printed. 

Implemented. So, the voodoo with (un)buffered output is no more
necessary.

The last remaining problem is colctl, see:

    https://travis-ci.org/karelzak/util-linux/jobs/578940843

diff-{{{
--- /home/travis/build/karelzak/util-linux/tests/expected/colcrt/regressions-hang1	2019-08-30 18:48:16.236479052 +0000
+++ /home/travis/build/karelzak/util-linux/tests/output/colcrt/regressions-hang1	2019-08-30 18:51:50.046236386 +0000
@@ -1,3 +1 @@
-789:;<=>=>?IABUVNXYZ[ `abcdefgg !"#$%&'()*+,-./01234)*:,-./0123456789:;[=>?1234)*:,-./0123456789:;[=>?4456789:;<=>?IABUVN`abcdefg !"
-                     -
-return value: 0
+return value: 124
}}}-diff

 ... for some reason it returns nothing, but $? is 124. The problem is
 elapsed timeout, but why?

        timeout 2 env LC_ALL=C.UTF-8 $TS_CMD_COLCRT < $1 >> $TS_OUTPUT 2>> $TS_ERRLOG
        echo "return value: $?" >> $TS_OUTPUT

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
