Return-Path: <SRS0=Ofmp=5L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB21C2D0E8
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 10:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6D320787
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 10:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPXrGPEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCZKf3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:35:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41061 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727721AbgCZKf2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 26 Mar 2020 06:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585218928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SlsV3xH6oDiFRLCR2S4lDrX/c0mF4ELLGN8dv63Kl6U=;
        b=OPXrGPEXTcZhsV5Uyt3BgclI8r9OC4J35dRUDp/hpoEZhIRehK//UlleAbuDG8gYPMPrFM
        VwSDeXtlL4/axZWkZiUgI9FaO+WXp8ZnNO/P/7tI9LYJgDm5KVa1ERuntt4VWiGdq1L2J0
        PNfMdq6aZinmUhkyRu/vtPXeMbH0pus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-iriIhn6zNmuOy9bOc1B2lA-1; Thu, 26 Mar 2020 06:35:23 -0400
X-MC-Unique: iriIhn6zNmuOy9bOc1B2lA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 665BC107ACC4;
        Thu, 26 Mar 2020 10:35:22 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D805419925;
        Thu, 26 Mar 2020 10:35:20 +0000 (UTC)
Date:   Thu, 26 Mar 2020 11:35:18 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     util-linux@vger.kernel.org,
        Benno Schulenberg <bensberg@justemail.net>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Hans Holmnerg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH v3] blkzone: add open/close/finish commands
Message-ID: <20200326103518.w2wi3f5uetlk5amx@ws.net.home>
References: <20200325150952.326707-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325150952.326707-1-damien.lemoal@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Mar 26, 2020 at 12:09:52AM +0900, Damien Le Moal wrote:
>  sys-utils/blkzone.8 | 27 +++++++++++++++++---
>  sys-utils/blkzone.c | 61 +++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 77 insertions(+), 11 deletions(-)

Applied as a diff, thanks.
https://github.com/karelzak/util-linux/commit/46cf662532ef4e924a3478f2e474b619caf141df

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

