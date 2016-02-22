Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:49918 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754259AbcBVK3d (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Feb 2016 05:29:33 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] tests: add test for loop option in fstab
Date: Mon, 22 Feb 2016 11:29:21 +0100
Cc: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
References: <56BCE4F4.6020409@suse.cz> <56C75E7B.60407@suse.cz> <20160222101233.imyhujomel6ydin3@ws.net.home>
In-Reply-To: <20160222101233.imyhujomel6ydin3@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201602221129.22259.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 22 February 2016, Karel Zak wrote:
> Do you mean when /etc/mtab is a regular file? For btrfs we need fs
> root and this information is nowhere in mtab (and maybe another
> information related to subvolumes which we have in mountinfo).
>
> Not sure if we really need to support this complicated use-case with
> deprecated mtab.

I wonder what could be the reason why some admins manually setup mtab 
files eventhough their distro's default is to use a link to /proc.

For example on OBS (openSUSE build farm) they have always mtab files for 
any build host. Also travis is using files for Ubuntu 12.04 and 14.04.

Is there any good reason for this? Maybe it's better for docker 
containers or if you run things in a chroot?

cu,
Rudi
