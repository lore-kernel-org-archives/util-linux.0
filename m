Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18479 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965066Ab1GMIcU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Jul 2011 04:32:20 -0400
Date: Wed, 13 Jul 2011 10:32:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Theodore Tso <tytso@MIT.EDU>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org,
        David Zeuthen <davidz@redhat.com>
Subject: Re: `fsck -A` and fs-specific options
Message-ID: <20110713083214.GA3486@nb.net.home>
References: <201107112259.55340.vapier@gentoo.org> <9CD6ADB9-F3AD-47EE-BF7E-251D86B7B305@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9CD6ADB9-F3AD-47EE-BF7E-251D86B7B305@mit.edu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 12, 2011 at 07:02:20AM -0400, Theodore Tso wrote:
> 
> On Jul 11, 2011, at 10:59 PM, Mike Frysinger wrote:
> > 
> > for example, some journaling file systems allow the journal to be stored 
> > separately.  reiserfs has the "jdev=" mount option and the "--journal" fsck 
> > option.  ext[34] have the "journal_dev=" mount option and the "-j" fsck 
> > option.
> 
> At least for ext[34] and external journals, e2fsck can find the external
> journal using the blkid library since the UUID of the external journal
> is in the superblock. 

 This seems like a very elegant solution. The fsck.<type> helpers have
 to be able to gather all necessary information (from FS superblock,
 /etc/fstab, ...). This is very filesystems specific and I don't think
 that we can resolve this problem in generic /sbin/fsck util. 

> > another example is with loop mounts that take an offset.  fsck cannot operate 
> > on the loop source as the start of the file is not the image.  it needs to 
> > first setup the loop with the offset, and then do the fsck on the loop point.
> > 	/tmp/foo.img /mnt/tmp ext3 loop,offset=10000

 Good point. There is demand for a generic API to assemble block
 devices (dm-crypt, MD, LVM, loopdev, ...). This functionality has
 been requested by desktop guys, dracut, udev and it seems also
 attractive for mount and fsck. I'll probably start to work on this
 task at the end of this year (I hope with DM guys).

 The idea is to have a simple library (libblkasm ?) that provide API
 to assemble a block device according to the configuration in
 /etc/fstab and /etc/blkasm.d/. The library should be modular, so
 subsystem specific modules (lvm.so, crypt.so, ...) will be maintained
 externally by subsystem developers. It seems like a good way how to
 keep the functionality up to date and minimize some communication
 problems between people :-)

 Note that the original idea is from David Zeuthen
 http://people.freedesktop.org/~david/stc-20101011/stc.conf.html, but
 David's goal was daemon.

 My goal is to provide only library and command line interface, so the
 library will be usable everywhere (for example also in some D-BUS
 daemon, dracut, etc.) 
 
    Karel
 
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
