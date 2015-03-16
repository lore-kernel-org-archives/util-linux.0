Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59242 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbbCPKWg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 06:22:36 -0400
Date: Mon, 16 Mar 2015 11:22:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Isaac Dunham <ibid.ag@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Trying to avoid incompatability on a mount enhancement
Message-ID: <20150316102233.GA28925@ws.net.home>
References: <20150314220249.GC1808@Sparta>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150314220249.GC1808@Sparta>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 14, 2015 at 10:02:50PM +0000, Isaac Dunham wrote:
> Hello,
> I've been thinking about adding a feature to Busybox mount, but I'd
> like to check on options that are already claimed in util-linux so I
> don't cause a major incompatability.
> 
> The feature I'm thinking about is roughly analogous to "mkdir -p" or
> "cpio -d":
> it creates the mountpoints if needed.

 man mount:

 x-mount.mkdir[=mode]

        Allow  to  make  a target directory (mountpoint).  The
        optional argument mode specifies the filesystem access mode
        used for mkdir(2) in octal notation.   The default  mode  is
        0755.  This functionality is supported only for root users.


 ... so:

        mount /dev/sda1 /mnt/foo -o x-mount.mkdir

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
