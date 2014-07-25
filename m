Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55789 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756912AbaGYIcW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jul 2014 04:32:22 -0400
Date: Fri, 25 Jul 2014 10:32:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: when specifying multiple types, mount will mount
Message-ID: <20140725083216.GO26781@x2.net.home>
References: <1406233871.13212.145356397.0035B2A9@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406233871.13212.145356397.0035B2A9@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 24, 2014 at 10:31:11PM +0200, Benno Schulenberg wrote:
> Current mount (2.25) will always mount a device when more
> than one type is given in a comma-separated list.  Older mount
> (2.17.2 for example) would not not do that but error out.

 We want to support list-of-types in fstab and on command line.

> For example, /dev/sda2 is of type ext4, but we are playing dumb,
> to see what mount will say:
> 
> $ sudo ./mount /dev/sda2 /place -t btrfs
> lt-mount: /dev/sda2: can't read superblock
> 
> $ sudo ./mount /dev/sda2 /place -t msdos
> lt-mount: wrong fs type, bad option, bad superblock on /dev/sda2,
>        missing codepage or helper program, or other error
> 
>        In some cases useful info is found in syslog - try
>        dmesg | tail or so.
> 
> $ sudo ./mount /dev/sda2 /place -t btrfs,msdos

this is bug, it continues with /{proc,etc}/filesystems when no found
anything useful in the list.

> $ ./mount | grep sda2
> /dev/sda2 on /place type ext4 (rw)
> 
> I find this surprising.  If -t does not support a comma-separated
> list, it should report an error.  If it does, it should, IMO, only
> try the specified types and not any others.

 yes, I'm just working on patch and regression test for all -t
 use-cases.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
