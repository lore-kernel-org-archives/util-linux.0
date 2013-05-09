Return-Path: util-linux-owner@vger.kernel.org
Received: from nagini.codelibre.net ([80.68.93.164]:53621 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3EIUCE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 9 May 2013 16:02:04 -0400
Date: Thu, 9 May 2013 20:54:14 +0100
From: Roger Leigh <rleigh@codelibre.net>
To: George Mitchell <george@chinilu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: umount and findmnt commands not working with btrfs labels ...
Message-ID: <20130509195414.GU21041@codelibre.net>
References: <51882EA5.9080805@chinilu.com>
 <20130507094835.GB7086@x2.net.home>
 <51891448.5010804@chinilu.com>
 <20130509094226.GD17527@x2.net.home>
 <518BC86D.2050702@chinilu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <518BC86D.2050702@chinilu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 09, 2013 at 09:01:49AM -0700, George Mitchell wrote:
> Karel,  Your answer left me really frustrated, but after rethinking
> the whole thing, I am left wondering if this whole issue, including
> the broader issue of what should appear on the mount table in the
> first place, would be better addressed by the btrfs group simply
> abstracting the mount point like software raid has always done and
> handling all the details internally within btrfs.  I already have
> seen applications that didn't understand btrfs partitions were in
> use and bad things could result from that.  It would be nice if
> btrfs would just lock all of these partitions out and represent them
> collectively to the broader system as /dev/mntX or whatever.  That
> would surely greatly simplify things for everybody.  I am going
> broach that idea on the btrfs list.

If you do bring this up on the list, a related problem that breaks
a number of tools, and also boot-time fsck on Debian systems, is
that the device reported by stat(2) st_rdev is fictional and not
present in /dev.  This is probably because every subvolume has a
different device ID.  But it's not exposed to userspace.

If you want to get the device node to fsck from a read-only
mount, then you're stuck.  And it also breaks other tools which
expect the device number to actually have real meaning.  Btrfs is
AFAICT unique in this respect, and it's quite broken to behave in
this way.

If the filesystem could expose real devices to userspace, that
would IMO be a big improvement.  Even if it's just a virtual
"proxy" for the filesystem.


Regards,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux    http://people.debian.org/~rleigh/
 `. `'   schroot and sbuild  http://alioth.debian.org/projects/buildd-tools
   `-    GPG Public Key      F33D 281D 470A B443 6756 147C 07B3 C8BC 4083 E800
