Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16581 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab3EJI2f (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 10 May 2013 04:28:35 -0400
Date: Fri, 10 May 2013 10:28:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Roger Leigh <rleigh@codelibre.net>
Cc: George Mitchell <george@chinilu.com>, util-linux@vger.kernel.org
Subject: Re: umount and findmnt commands not working with btrfs labels ...
Message-ID: <20130510082804.GA26163@x2.net.home>
References: <51882EA5.9080805@chinilu.com>
 <20130507094835.GB7086@x2.net.home>
 <51891448.5010804@chinilu.com>
 <20130509094226.GD17527@x2.net.home>
 <518BC86D.2050702@chinilu.com>
 <20130509195414.GU21041@codelibre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130509195414.GU21041@codelibre.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 09, 2013 at 08:54:14PM +0100, Roger Leigh wrote:
> On Thu, May 09, 2013 at 09:01:49AM -0700, George Mitchell wrote:
> > Karel,  Your answer left me really frustrated, but after rethinking
> > the whole thing, I am left wondering if this whole issue, including
> > the broader issue of what should appear on the mount table in the
> > first place, would be better addressed by the btrfs group simply
> > abstracting the mount point like software raid has always done and
> > handling all the details internally within btrfs.  I already have
> > seen applications that didn't understand btrfs partitions were in
> > use and bad things could result from that.  It would be nice if
> > btrfs would just lock all of these partitions out and represent them
> > collectively to the broader system as /dev/mntX or whatever.  That
> > would surely greatly simplify things for everybody.  I am going
> > broach that idea on the btrfs list.
> 
> If you do bring this up on the list, a related problem that breaks
> a number of tools, and also boot-time fsck on Debian systems, is
> that the device reported by stat(2) st_rdev is fictional and not
> present in /dev.  This is probably because every subvolume has a
> different device ID.  But it's not exposed to userspace.

 Good point, this is the worst thing I don't like on btrfs.

  https://bugzilla.redhat.com/show_bug.cgi?id=711881


    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
