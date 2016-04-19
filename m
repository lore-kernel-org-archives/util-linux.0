Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40842 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbcDSJSx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Apr 2016 05:18:53 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1B0D201E8
	for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 09:18:52 +0000 (UTC)
Received: from ws (ovpn-204-89.brq.redhat.com [10.40.204.89])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3J9IpjU015269
	for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 05:18:52 -0400
Date: Tue, 19 Apr 2016 11:18:51 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libblkid: make blkid_do_wipe() work with probes with
 offset
Message-ID: <20160419091851.nzetsxvea7klztbm@ws.net.home>
References: <1460989325-28748-1-git-send-email-petr.uzel@suse.cz>
 <20160418180018.wgjfgaule76mcfyb@ws.net.home>
 <20160419090502.GA20078@skipper.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160419090502.GA20078@skipper.site>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 19, 2016 at 11:05:02AM +0200, Petr Uzel wrote:
> On Mon, Apr 18, 2016 at 08:00:18PM +0200, Karel Zak wrote:
> > On Mon, Apr 18, 2016 at 04:22:05PM +0200, Petr Uzel wrote:
> > > When a probe is created with an offset, e.g. via
> > > blkid_probe_set_device(), this offset is correctly used when looking for
> > > the signatures, but is not respected by blkid_do_wipe() function.
> > > Therefore the signature is removed from an invalid location.
> > 
> > Wow, excellent catch. 
> 
> Thanks, feels good to again contribute a fix after such a long time :)
> 
> > How did you found it? Do you use libblkid in some partitioning tool or
> > installer?
> 
> Yes, I'm trying to implement a --wipesignatures for parted - this
> would wipe the signatures from a new partition, _before_ the kernel
> is informed. This is to avoid mess like RAID autoassembly...
> 
> [If only there was some sane mechanism lock a device to temporarily
> prevent udev from touching it :/]

since v2.28 fdisk wipes disks (--wipe=auto,always,never), but it does
not care about partitions. 

Maybe we can improve it and add --wipe-partitions too. IMHO it should
not be enabled by default, because change disk layout and keep
filesystems seems like a valid use-case.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
