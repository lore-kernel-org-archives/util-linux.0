Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48202 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab3JKOfJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Oct 2013 10:35:09 -0400
Date: Fri, 11 Oct 2013 16:09:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Matthias Schniedermeyer <ms@citd.de>, util-linux@vger.kernel.org
Subject: Re: Filesystem specific mount options mixed with auto fs type
Message-ID: <20131011140954.GD24613@x2.net.home>
References: <5256B7CF.7010103@ubuntu.com>
 <20131010170330.GA19031@citd.de>
 <5256E3EA.4000304@ubuntu.com>
 <20131011083742.GA14457@x2.net.home>
 <525800EB.9060208@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <525800EB.9060208@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 11, 2013 at 09:45:15AM -0400, Phillip Susi wrote:
> > Maybe we can improve mount(8) to test all entries from /etc/fstab 
> > with the same mountpoint (if you want to mount-by-mountpoint) until
> > the filesystem will be mounted successfully. But I have doubts that
> > we really need to resolve this very old disadvantage.
> 
> Maybe something like:
> 
> /dev/fd0 /mnt/floppy auto,vfat utf8
                       ^^^^^^^^^
 This is unacceptable, fstab is de-facto standard. We have to be
 backwardly compatible.

> /dev/fd0 /mnt/floppy auto generic-options
> 
> The auto would trigger blkid to identify the filesystem, and then only
> if it matches one of the additional listed filesystems would that line
> be applied.
 
 I thought something like:

        /dev/fd0 /mnt/floppy    vfat    utf8
        /dev/fd0 /mnt/floppy    auto    default

 and then try in loop all the filesystem types for the mountpoint (or 
 make it smart and ask blkid for the type).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
