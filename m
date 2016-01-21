Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54092 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759832AbcAUPpb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jan 2016 10:45:31 -0500
Date: Thu, 21 Jan 2016 16:45:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org,
        David =?utf-8?B?xaB0xJtyYmE=?= <dsterba@suse.cz>
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
Message-ID: <20160121154529.hpv3ycl2syptemp4@ws.net.home>
References: <569FEF38.9010102@suse.cz>
 <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz>
 <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A0F847.5000000@suse.cz>
 <20160121153713.erxzeieqtnsf2wsu@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160121153713.erxzeieqtnsf2wsu@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 21, 2016 at 04:37:13PM +0100, Karel Zak wrote:
> > David also wrote btrfs_get_default_subvolume_path(), but then we found,
> > that there is probably better to use subvolid and path saved in
> > procinfo:
> 
> Do you mean /proc/self/mountinfo ?
> 
> > 
> > + The tab.c patch would be much smaller and straightforward.
> > - Kernel evaluates it when creating procinfo entries, this would
> >   duplicate it.
> > x Both subvol and subvolid in procinfo were introduced together in the
> >   mainline kernel, and btrfs_get_default_subvolume_path() needs more
> >   ioctl() calls.
> 
> No sure if I follow.

Read it and the patch again, and now it makes sense. Yes, the ioctl and 
subvolid= from mountinfo seems better than dependence on libbtrfs.

    Karel.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
