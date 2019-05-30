Return-Path: <SRS0=Em1C=T6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A16C28CC0
	for <util-linux@archiver.kernel.org>; Thu, 30 May 2019 13:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D962596C
	for <util-linux@archiver.kernel.org>; Thu, 30 May 2019 13:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfE3NTI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 30 May 2019 09:19:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfE3NTI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 30 May 2019 09:19:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E47F3006370;
        Thu, 30 May 2019 13:19:08 +0000 (UTC)
Received: from ws (unknown [10.40.205.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C8CF100203C;
        Thu, 30 May 2019 13:19:07 +0000 (UTC)
Date:   Thu, 30 May 2019 15:19:04 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org, Frederic Crozat <fcrozat@suse.com>
Subject: Re: [PATCH] raw: Add raw.service
Message-ID: <20190530131904.zvicpy2djdulxt6n@ws>
References: <f4c8feb9-2bdc-8a40-7bc1-d24fcd94d0a7@suse.cz>
 <20190530123530.q2ngscgnmgi3s327@ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530123530.q2ngscgnmgi3s327@ws>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 30 May 2019 13:19:08 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, May 30, 2019 at 02:35:35PM +0200, Karel Zak wrote:
> On Thu, May 30, 2019 at 12:30:16AM +0200, Stanislav Brabec wrote:
> > Add raw.service that allows to initialize raw devices on boot.
> 
> And why not udev?
...
> Maybe all we need is to add any info about udev configuration to
> raw(8).

And note ... do we really want to improve anything around raw devices?

All we need is to dig really deep grave and keep it there.

So, don't try to make zombies to look nice and user friendly. Zombies
are ugly, deal with it! :-)

    Karel

> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
