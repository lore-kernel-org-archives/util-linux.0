Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48710 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbaCXJOw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Mar 2014 05:14:52 -0400
Date: Mon, 24 Mar 2014 10:14:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Werner Baumann <werner.baumann@onlinehome.de>
Cc: util-linux@vger.kernel.org
Subject: Re: libmount, documentation
Message-ID: <20140324091446.GA20416@x2.net.home>
References: <20140323100633.711b61f9@ginster.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140323100633.711b61f9@ginster.fritz.box>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 23, 2014 at 10:06:33AM +0100, Werner Baumann wrote:
> I would like to use libmount in my mounthelper program (davfs2) to
> solve issues that arise when /etc/mtab is a symbolic link
> to /proc/mounts.

The best way is to probably to see mount.nfs from nfs-utils

http://git.linux-nfs.org/?p=steved/nfs-utils.git;a=blob;f=utils/mount/mount_libmount.c

the code completely based on libmount, but core mount functionality is
NFS specific.

Note that NFS requires special set of userspace options (libmount
calls it "attributes"). It's anything you don't have to care about in
standard mount helpers.

> But I can't find any documentation of libmount that would allow me to
> use it. Is there any documentation?

https://www.kernel.org/pub/linux/utils/util-linux/v2.24/libmount-docs/index.html

If you will have any questions then ask me, I can also help you to
review your helper program code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
