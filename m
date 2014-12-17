Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:42287 "EHLO
	resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750949AbaLQXCd (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Dec 2014 18:02:33 -0500
From: worley@alum.mit.edu (Dale R. Worley)
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Remount failure without fstab or mtab
In-Reply-To: <5491A048.3070103@ubuntu.com> (psusi@ubuntu.com)
Date: Wed, 17 Dec 2014 18:02:30 -0500
Message-ID: <87ppbhop6h.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Phillip Susi <psusi@ubuntu.com> writes:
> I have a bug report in debian about "mount -o remount,rw /" failing
> because /etc/fstab does not contain an entry for the root fs, and
> /proc is not mounted ( booting with init=/bin/bash for recovery ).
> I'm not sure whether this is really a bug or not so I thought I'd ask.

I'm not an expert on the Debian version of mount, but my understanding
is that if there isn't a line in fstab/mtab, then the mount command must
contain both the mount point and the block device because the underlying
kernel call must be given both.  Check the documentation of "remount" in
your "mount" manual page.

Dale
