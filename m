Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f181.google.com ([209.85.216.181]:48839 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbaA3Oyg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 30 Jan 2014 09:54:36 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so4978102qcy.40
        for <util-linux@vger.kernel.org>; Thu, 30 Jan 2014 06:54:35 -0800 (PST)
Date: Thu, 30 Jan 2014 09:54:33 -0500
From: Dave Reisner <d@falconindy.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: pivot_root depreciated?
Message-ID: <20140130145433.GE905@rampage>
References: <52E91888.4080601@ubuntu.com>
 <20140130081651.GE22884@x2.net.home>
 <52EA5E6F.6040203@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52EA5E6F.6040203@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 30, 2014 at 09:15:11AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 1/30/2014 3:16 AM, Karel Zak wrote:
> > everyone switched to our switch_root :-)
> 
> Except apparently for the systemd folks, which for some odd reason
> like the idea of keeping around the initrd for the life of the system
> so init can "return" to it ( yuck! ).
> 

To be clear, systemd uses the syscall, not the util-linux utility. I'm
not sure why you think this is a poor idea when it, in fact, solves real
problems. If your root filesystem resides on a stacked block device
(mdadm, lvm, dmraid, dm-crypt), this is the *only* way to cleanly umount
the filesystem for disassembly. Remounting the filesystem read-only
might not be enough.

Results of not doing this vary. If your root is dm-crypt, you open up
more possibilities of cold boot attacks. If you use mdadm for a fakeraid
array, your fakeraid controller might insist on rebuilding the array on
the next reboot which could take hours.

> > Anyway, I don't see any info about pivot_root syscall deprecation
> > in Linux kernel source tree.
> 
> Me neither, but then why switch_root?  I thought the whole reason it
> came about was because Linus et al considered pivot_root() to have
> been a terrible idea.

My understanding is that pivot_root is a relic from the days of
/dev/initrd. Since 2.6 and the introduction of initramfs, it's no longer
needed for this purpose.

d
