Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57046 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444Ab3ANIfW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jan 2013 03:35:22 -0500
Date: Mon, 14 Jan 2013 09:35:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: Phillip Susi <psusi@ubuntu.com>, Thomas Orgis <thomas-forum@orgis.org>,
        util-linux@vger.kernel.org
Subject: Re: losetup -d --force for zombie loop devices?
Message-ID: <20130114083513.GB16421@x2.net.home>
References: <20120417100346.2a0b8301@orgis.org>
 <201301112352.55112.vapier@gentoo.org>
 <50F0F0E8.2020909@ubuntu.com>
 <201301120029.29896.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201301120029.29896.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 12, 2013 at 12:29:28AM -0500, Mike Frysinger wrote:
> On Saturday 12 January 2013 00:13:12 Phillip Susi wrote:
> > On 01/11/2013 11:52 PM, Mike Frysinger wrote:
> > >> but my point was that what you are looking for is umount -f, not
> > >> umount -l.
> > > 
> > > and my point is that `umount -f` doesn't always work which means
> > > `umount -l` is sometimes the only way to remove a mount point.  an
> > > unresponsive remote or something is holding open a reference (which
> > > doesn't show up in `lsof -n`).
> > 
> > Right.  Forced unmounts aren't really implemented.  They need to be.
> > It isn't losetup that needs to be forcibly detached, but the filesystem.
> 
> would be nice if userland had visibility into all these handles that the 
> kernel has opened.  for example, with losetup, i think the only way is to 
> query the loop devices directly or sysfs ?  might be handy to at least teach 
> lsof to peek in there, but still sucks we have to do it subsystem by 
> subsystem.

 That's my wish to have in lsblk output a column with handlers counter
 that kernel has open for the device. Unfortunately this info is not
 exported by sysfs.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
