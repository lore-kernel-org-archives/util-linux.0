Return-Path: <SRS0=2g+Q=UD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0088DC282CE
	for <util-linux@archiver.kernel.org>; Tue,  4 Jun 2019 11:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA207247B8
	for <util-linux@archiver.kernel.org>; Tue,  4 Jun 2019 11:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfFDLFO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:05:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfFDLFO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Jun 2019 07:05:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50068C064293;
        Tue,  4 Jun 2019 11:05:14 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91A9D10027C2;
        Tue,  4 Jun 2019 11:05:13 +0000 (UTC)
Date:   Tue, 4 Jun 2019 13:05:10 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: fix detection of dm-integrity superblock
 version
Message-ID: <20190604110510.7js47tkznolmdk2k@ws.net.home>
References: <20190604101657.7268-1-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604101657.7268-1-gmazyland@gmail.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 04 Jun 2019 11:05:14 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 04, 2019 at 12:16:57PM +0200, Milan Broz wrote:
>  libblkid/src/superblocks/lvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
