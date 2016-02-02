Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53042 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932535AbcBBSn4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Feb 2016 13:43:56 -0500
Date: Tue, 2 Feb 2016 19:43:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org,
        David =?utf-8?B?xaB0xJtyYmE=?= <dsterba@suse.cz>
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
Message-ID: <20160202184354.goms7zouusq6pmun@ws.net.home>
References: <569FEF38.9010102@suse.cz>
 <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz>
 <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A15487.8020500@suse.cz>
 <56AA240F.5010900@suse.cz>
 <20160201121811.tk3eqsr5x3w44p34@ws.net.home>
 <56AF7BE9.4000302@suse.cz>
 <20160202101139.hayiqqbzvseiocdw@ws.net.home>
 <56B0C570.30804@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B0C570.30804@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 02, 2016 at 04:04:16PM +0100, Stanislav Brabec wrote:
> Karel Zak wrote:
> >On Mon, Feb 01, 2016 at 04:38:17PM +0100, Stanislav Brabec wrote:
> 
> >>By the way, I am just fixing next btrfs issue. Now it is in blkid. And it
> >>seems, that I will need some changes in the code: move the btrfs default
> >>subvol function into the public API, and change it to return the subvolid
> >>string.
> >
> >Why we need the function in public API?
> 
> Because lsblk does not have access to libmount private functions.

You have talked about blkid, I thought you want to add SUBVOL= to
libblkid.

For what purpose do you need it in lsblk? When the same device is
mounded on more places?

Anyway, in libmount we can extend mnt_fs_* API and add some additional
functions -- for example add mnt_fs_get_default_root().

I definitely don't want btrfs specific functions. The API should be
generic.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
