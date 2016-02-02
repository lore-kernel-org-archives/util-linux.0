Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41640 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754255AbcBBKLl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Feb 2016 05:11:41 -0500
Date: Tue, 2 Feb 2016 11:11:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org,
        David =?utf-8?B?xaB0xJtyYmE=?= <dsterba@suse.cz>
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
Message-ID: <20160202101139.hayiqqbzvseiocdw@ws.net.home>
References: <569FEF38.9010102@suse.cz>
 <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz>
 <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A15487.8020500@suse.cz>
 <56AA240F.5010900@suse.cz>
 <20160201121811.tk3eqsr5x3w44p34@ws.net.home>
 <56AF7BE9.4000302@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56AF7BE9.4000302@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 01, 2016 at 04:38:17PM +0100, Stanislav Brabec wrote:
> Karel Zak wrote:
> 
> >I did some changes to the code:
> >
> >  * use mnt_resolve_target() rather than mnt_resolve_spec() for target
> >  * move all to get_btrfs_fs_root()
> >  * make the basic if/else more readable
> 
> By the way, I am just fixing next btrfs issue. Now it is in blkid. And it
> seems, that I will need some changes in the code: move the btrfs default
> subvol function into the public API, and change it to return the subvolid
> string.

Why we need the function in public API?

Add subvolume ID to the probing result is no problem. It's just 
another NAME=value.

> >It would be nice to have tests/ts/mount/btrfs with all the "mount -a"
> >variants you have in commit messages.
> 
> Are there any rules/framework for such tests that need root and editing of
> /etc/fstab?

See for example tests/ts/mount/fstab-devname, 

    ts_skip_nonroot  -- ignore the test for non-root user
    ts_fstab_add     -- add line to the fstab

the functions are implemented in tests/functions.sh

> I think that use of losetup and /dev/loopX can be used for most testcases. I
> am not sure about kernel partition table support inside loop devices.

We use:
    ts_device_init     -- for loop devies (uses truncate command)
    ts_scsi_debug_init -- for devices by scsi_debug kernel module

scsi_debug is better solution, because it's absolutely without any
side effects, but it's based on RAM, so create 10GiB disk is bad idea :)

For more details see tests/ts/* with many many examples.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
