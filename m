Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757006Ab2JaMY5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 31 Oct 2012 08:24:57 -0400
Date: Wed, 31 Oct 2012 13:24:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Matt Burgess <matthew@linuxfromscratch.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Discrepancies between real and symlinked mtab
Message-ID: <20121031122453.GB27908@x2>
References: <1351638239.1651.13.camel@kyoto.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351638239.1651.13.camel@kyoto.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 30, 2012 at 11:03:59PM +0000, Matt Burgess wrote:
> 1) mount(8)
> 
> /dev/root on / type ext3 (rw,relatime,data=ordered)

 I see (Fedora 17, util-linux 2.21.2)

   /dev/sda4 on / type ext4 (rw,relatime,data=ordered)

anyway, it's not mount(8) responsibility what you have in /proc/mounts
or /proc/self/mountinfo.

> Nope, that's not /dev/sda3.  And what is /dev/root anyway? There's no
> such node under /dev here.

if I good remember there was symlink in some distributions

> 3) lsblk(8)
> 
> NAME FSTYPE LABEL UUID                                 MOUNTPOINT
> sda3 ext3   /lfs  aaf09e8b-d50e-429e-ba8e-11fa07ab5b75 

I see:

 $ lsblk --fs /dev/sda4
 NAME FSTYPE LABEL UUID                                 MOUNTPOINT
 sda4 ext4         33230ae2-1093-4353-824c-f7ca09a2a882 /

> As all 3 utils show the same issue, I assume this is something to do
> with libblkid?

We use libmount to get information about mountpoints. The libblkid is
responsible for information about filesystems (LABEL, UUID, ...).


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
