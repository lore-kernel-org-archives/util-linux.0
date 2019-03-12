Return-Path: <SRS0=rvHk=RP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD84FC43381
	for <util-linux@archiver.kernel.org>; Tue, 12 Mar 2019 08:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C01B2147C
	for <util-linux@archiver.kernel.org>; Tue, 12 Mar 2019 08:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfCLIWE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:22:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfCLIWD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 12 Mar 2019 04:22:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9ED6630832D8;
        Tue, 12 Mar 2019 08:22:03 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 828D019C71;
        Tue, 12 Mar 2019 08:22:02 +0000 (UTC)
Date:   Tue, 12 Mar 2019 09:21:59 +0100
From:   Karel Zak <kzak@redhat.com>
To:     L A Walsh <lkml@tlinx.org>
Cc:     "Dr. David Alan Gilbert" <dave@treblig.org>,
        util-linux@vger.kernel.org
Subject: Re: does util-linux have a 'report sector size' util?
Message-ID: <20190312082159.jojrjq7ox3d457ke@ws.net.home>
References: <5C86CBA1.40802@tlinx.org>
 <20190311212104.edekhgctqto37tn7@gallifrey>
 <5C86D476.6060807@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C86D476.6060807@tlinx.org>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 12 Mar 2019 08:22:03 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Mar 11, 2019 at 02:34:46PM -0700, L A Walsh wrote:
> On 3/11/2019 2:21 PM, Dr. David Alan Gilbert wrote:
> > * L A Walsh (lkml@tlinx.org) wrote:
> >> Trying to track down why my 4K drives no longer display 4K
> >> in sysfs (/sys) and don't seem to show individual disk
> >> drive information.  When I first got the drives, linux displayed
> >> the correct physical disk size, but when I look now, I only
> >> see 512.
> >
> > Is this one of the PHY-SEC or LOG-SEC fields that lsblk can print?
> >
> > [dg@major ~]$ lsblk -o "NAME,PHY-SEC,LOG-SEC"
> > NAME                                            PHY-SEC LOG-SEC
> > sda                                                 512     512
> ---
>     It would be, if it was correct.  Megacli displays:
> 
>    Sector Size:  512
>    Logical Sector Size:  512
>    Physical Sector Size:  4096
> 
> But lsblk displays 512 for everything.  The disk says it uses a 512e format
> with the 'e' meaning it emulates 512 even if not 512.

lsblk, fdisk, blockdev, ... but all of the utils read the information
from kernel. So, it depends how the device reports topology to the
kernel.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
