Return-Path: <SRS0=bVSf=TO=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5043C04AB4
	for <util-linux@archiver.kernel.org>; Tue, 14 May 2019 11:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9BC20818
	for <util-linux@archiver.kernel.org>; Tue, 14 May 2019 11:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfENLjz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 May 2019 07:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfENLjz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 May 2019 07:39:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EED693001809;
        Tue, 14 May 2019 11:39:54 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34CEF2B9C8;
        Tue, 14 May 2019 11:39:54 +0000 (UTC)
Date:   Tue, 14 May 2019 13:39:51 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH V2 2/2] libblkid: Set BLKID_BID_FL_VERIFIED in case
 revalidation is not needed
Message-ID: <20190514113951.q64zh2gngtj4oudb@ws.net.home>
References: <20190513124418.24157-1-nborisov@suse.com>
 <20190513124418.24157-2-nborisov@suse.com>
 <7901c2a7-f8c8-9e39-efb1-62ecd7fe74e2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7901c2a7-f8c8-9e39-efb1-62ecd7fe74e2@suse.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 14 May 2019 11:39:55 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 13, 2019 at 05:21:33PM +0300, Nikolay Borisov wrote:
> >  	    (diff < BLKID_PROBE_MIN ||
> > -		dev->bid_flags & BLKID_BID_FL_VERIFIED))
> > +		dev->bid_flags & BLKID_BID_FL_VERIFIED)) {
> > +		dev->bid_flags |= BLKID_BID_FL_VERIFIED;
> 
> Actually I think this patch is wrong because the check for
> dev->bid_flags & BLKID_BID_FL_VERIFIED should also be removed. E.g.

Merged (both patches) and BLKID_BID_FL_VERIFIED removed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
