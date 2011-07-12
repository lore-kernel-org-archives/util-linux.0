Return-Path: util-linux-owner@vger.kernel.org
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:54175 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752958Ab1GLLCY convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Jul 2011 07:02:24 -0400
Subject: Re: `fsck -A` and fs-specific options
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Theodore Tso <tytso@MIT.EDU>
In-Reply-To: <201107112259.55340.vapier@gentoo.org>
Date: Tue, 12 Jul 2011 07:02:20 -0400
Cc: util-linux@vger.kernel.org
Message-Id: <9CD6ADB9-F3AD-47EE-BF7E-251D86B7B305@mit.edu>
References: <201107112259.55340.vapier@gentoo.org>
To: Mike Frysinger <vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Jul 11, 2011, at 10:59 PM, Mike Frysinger wrote:
> 
> for example, some journaling file systems allow the journal to be stored 
> separately.  reiserfs has the "jdev=" mount option and the "--journal" fsck 
> option.  ext[34] have the "journal_dev=" mount option and the "-j" fsck 
> option.

At least for ext[34] and external journals, e2fsck can find the external
journal using the blkid library since the UUID of the external journal
is in the superblock.   (In fact that's why the blkid library was originally
written, and why it was originally included as part of e2fsprogs.)

> another example is with loop mounts that take an offset.  fsck cannot operate 
> on the loop source as the start of the file is not the image.  it needs to 
> first setup the loop with the offset, and then do the fsck on the loop point.
> 	/tmp/foo.img /mnt/tmp ext3 loop,offset=10000

How often are people using loopback mounts as a default, standard thing which
need to be mounted and checked as part of the boot sequence?   I'm just
curious what the use case is for this?

I suppose if this was something people really did care about, the /etc/fstab
format could be extended to add a new field at the end for fsck options ---
but it's more complexity, and could break programs try to programmatically
modify /etc/fstab.

-- Ted

