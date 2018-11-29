Return-Path: <SRS0=CT6f=OI=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1424C43441
	for <util-linux@archiver.kernel.org>; Thu, 29 Nov 2018 10:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FE320863
	for <util-linux@archiver.kernel.org>; Thu, 29 Nov 2018 10:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FE320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeK2VIm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:08:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbeK2VIm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Nov 2018 16:08:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EEA47308219D;
        Thu, 29 Nov 2018 10:03:54 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BA6F5DA9B;
        Thu, 29 Nov 2018 10:03:54 +0000 (UTC)
Date:   Thu, 29 Nov 2018 11:03:51 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Roland Kammerer <roland.kammerer@linbit.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] tests: add test images for drbd v08/v09
Message-ID: <20181129100351.6rbci7dlakn6j2rc@ws.net.home>
References: <20181122134248.8907-1-roland.kammerer@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122134248.8907-1-roland.kammerer@linbit.com>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 29 Nov 2018 10:03:55 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Nov 22, 2018 at 02:42:48PM +0100, Roland Kammerer wrote:
>  tests/expected/blkid/low-probe-drbd-v08  |   5 +++++
>  tests/expected/blkid/low-probe-drbd-v09  |   5 +++++
>  tests/ts/blkid/images-fs/drbd-v08.img.xz | Bin 0 -> 448 bytes
>  tests/ts/blkid/images-fs/drbd-v09.img.xz | Bin 0 -> 460 bytes
>  4 files changed, 10 insertions(+)
>  create mode 100644 tests/expected/blkid/low-probe-drbd-v08
>  create mode 100644 tests/expected/blkid/low-probe-drbd-v09
>  create mode 100644 tests/ts/blkid/images-fs/drbd-v08.img.xz
>  create mode 100644 tests/ts/blkid/images-fs/drbd-v09.img.xz

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
