Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C2C28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3607C206DB
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgEFNVp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 09:21:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgEFNVo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 6 May 2020 09:21:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AAAD8AF6F;
        Wed,  6 May 2020 13:21:45 +0000 (UTC)
Date:   Wed, 6 May 2020 15:21:41 +0200
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: add dax capability detection in topology
 probing
Message-ID: <20200506132141.GZ1329@technoir>
References: <20200505143145.9852-2-ailiop@suse.com>
 <20200506130847.d2u66a2lsrp4pfah@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506130847.d2u66a2lsrp4pfah@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 06, 2020 at 03:08:47PM +0200, Karel Zak wrote:
> On Tue, May 05, 2020 at 04:31:45PM +0200, Anthony Iliopoulos wrote:
> > The dax (direct access) blockdev capability is exposed via sysfs, add it
> > to the list of topology values to be obtained while probing.
> > 
> > Expose blkid_topology_get_dax() symbol that programs can link against
> > for querying the capability.
> 
> Do we have any use-case for this change? 
> 
> We maintain blkid_topology_* mostly for mkfs-like programs portability 
> (years ago we had only ioctls, etc..). You can see that libblkid export
> only small subset topology stuff, so why we need DAX there? ;-)

The use-case is indeed mkfs. I am planning to submit a patch to xfsprogs
that warns if the blockdev is dax-capable but the default or specified
fs blocksize isn't matching the platform page size (in which case the fs
cannot be used/mounted with dax). This comes up with archs like ppc64
where the page size is larger than the default (usually 4K) fs blocksize.

I wanted to avoid parsing sysfs from xfsprogs, especially given that
libblkid is already leveraged there to obtain the topology, and I assume
it may be handy for e2fsprogs too, as ext4 (and any other fs that may
support dax in the future) is bound to the same restriction.
