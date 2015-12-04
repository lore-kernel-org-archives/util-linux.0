Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47742 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756054AbbLDKVc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 05:21:32 -0500
Date: Fri, 4 Dec 2015 11:21:28 +0100
From: Karel Zak <kzak@redhat.com>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fsck memory leak
Message-ID: <20151204102128.GM4955@ws.net.home>
References: <n3rei3$8l3$1@ger.gmane.org>
 <n3rgif$72q$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <n3rgif$72q$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 04, 2015 at 08:49:34AM +0100, U.Mutlu wrote:
> U.Mutlu wrote on 12/04/2015 08:15 AM:
> >Hi,
> >when I as root do "touch /forcefsck" and reboot, then fsck will be done.
> >But afterwards one has less free memory available than normal.
> >Example:
> >used mem immediately after login:
> >  without fsck during boot:  98 MB (this the normal level here)
> >  with fsck during boot   : 139 MB
> >So, there is a memory leak of about 41 MB.
> 
> This discrepancy is reproducible here, ie. happens always.
> 
> Not sure, but it could also be a kernel issue, because
> the longer the system runs the more memory gets bound.
> The source of the culprit is not easily detectable.
> I guess it gets eaten by the kernel, probably by the ext4-driver.
> 
> >fsck from util-linux 2.25.2
> >Filesys: ext4, 500 MB SSD
> 
> fix: of course 500 GB was meant
> 
> >OS: Debian 8 X86_64, uptodate

And are you talking about fsck (wrapper) or fsck.ext4 (from
e2fsprogs)?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
