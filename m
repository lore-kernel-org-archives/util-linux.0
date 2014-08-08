Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55552 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258AbaHHIov (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 8 Aug 2014 04:44:51 -0400
Date: Fri, 8 Aug 2014 10:44:46 +0200
From: Karel Zak <kzak@redhat.com>
To: "Linda A. Walsh" <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Specifying a generic and per-fs mount line in /etc/fstab as well
 as no-canonicalize.
Message-ID: <20140808084446.GC17719@x2.net.home>
References: <53E2B27C.9020305@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53E2B27C.9020305@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 06, 2014 at 03:55:56PM -0700, Linda A. Walsh wrote:
> It's a display choice for *user-convenience* that was made over
> years of feedback.
> 
> Why not allow the same paradigm in /etc/fstab and allow nocanonicalize as
> an option with mounts in /etc/fstab?

 You can use symlinks in fstab, but mount(8) canonicalizes the path
 before mount(2) syscall, because: 

 * kernel canonicalizes the path as well and we (userspace) want to
   be compatible with kernel to make it possible to compare paths in
   mtab (or another in userspace cached files) with /proc/mounts

 * you can think about mount table as about cache, how do you want
   keep the mount table up to date if you remove or change the link?

     mount /dev/foo /symlink
     rm /symlink

   note that "rmdir /mountpoint" (or rename) is very special situation 
   for kernel (-EBUSY)

 * it's also performance improvement to have canonical paths in the
   mount table when you want search in the table

 * etc..

      Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
