Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34107 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467AbcBVKxU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Feb 2016 05:53:20 -0500
Date: Mon, 22 Feb 2016 11:53:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: add test for loop option in fstab
Message-ID: <20160222105318.neop6yksmxl6a5ye@ws.net.home>
References: <56BCE4F4.6020409@suse.cz>
 <56C75E7B.60407@suse.cz>
 <20160222101233.imyhujomel6ydin3@ws.net.home>
 <201602221129.22259.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201602221129.22259.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 22, 2016 at 11:29:21AM +0100, Ruediger Meier wrote:
> On Monday 22 February 2016, Karel Zak wrote:
> > Do you mean when /etc/mtab is a regular file? For btrfs we need fs
> > root and this information is nowhere in mtab (and maybe another
> > information related to subvolumes which we have in mountinfo).
> >
> > Not sure if we really need to support this complicated use-case with
> > deprecated mtab.
> 
> I wonder what could be the reason why some admins manually setup mtab 
> files eventhough their distro's default is to use a link to /proc.
> 
> For example on OBS (openSUSE build farm) they have always mtab files for 
> any build host. Also travis is using files for Ubuntu 12.04 and 14.04.
> 
> Is there any good reason for this? Maybe it's better for docker 

No reason, in the hell is special hot room where is "mtab users" 
written by blood on the dark heavy doors...

> containers or if you run things in a chroot?

I can't imagine usable chroot/container without /proc. The docker
don't use systemd so maybe they have not been forced to leave mtab.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
