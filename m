Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11745 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396Ab3IPLLX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Sep 2013 07:11:23 -0400
Date: Mon, 16 Sep 2013 13:11:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Gabriel de Perthuis <g2p.code@gmail.com>
Cc: Rolf Fokkens <rolf@rolffokkens.nl>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libblkid: Abort after an incorrect checksum
Message-ID: <20130916111119.GA13822@x2.net.home>
References: <1378491089-1135-1-git-send-email-g2p.code@gmail.com>
 <1378491089-1135-2-git-send-email-g2p.code@gmail.com>
 <523487DC.1070704@gmail.com>
 <20130916082413.GA6752@x2.net.home>
 <5236D921.9040400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5236D921.9040400@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 16, 2013 at 12:10:41PM +0200, Gabriel de Perthuis wrote:
> Le lun. 16 sept. 2013 10:24:13 CEST, Karel Zak a écrit :
> > On Sat, Sep 14, 2013 at 05:59:24PM +0200, Gabriel de Perthuis wrote:
> >>> Log incorrect checksums and stop the superblock probing loop when
> >>> one is encountered.
> >>> This is to avoid exposing backend devices that are supposed
> >>> to be used through a stacked device (like raid or bcache).
> >>
> >> Sorry, but some of the changes you made when applying break the patch.
> >> The intent is to stop the probing loop when a bad container is encountered;
> >> the contents shouldn't be scanned.
> >
> >  Why? This is unwanted behaviour. If there is incomplete (broken)
> >  superblock we continue with probing to check for another superblock.
> >  This is very basic libblkid feature.
> 
> No result is always safer than an incorrect one.  

 Define "incorrect one".
 
Note that libblkid does not blindly interpret last probing result as
the correct result. We always check for all superblocks and if we found
more valid superblock on the same device then the problem is reported
as "ambivalent probing result" and nothing is returned. (See
blkid_do_safeprobe().)

> Why bother giving containers higher priority if that order can be broken.

This is not about priority or order at all (it was about priority in
original libblkid in e2fsprofs -- we had very bad experience with that).

There has to be only one valid superblock on the device or nothing.
This is what udevd expects.

(Well, we have some exceptions like CDROMs.)

> >  It's pretty common that there is old obsolete superblock, but user
> >  expects a new superblock after mkfs. Unfortunately not all mkfs-like
> >  programs wipe devices.
> 
> Neither did make-bcache until two weeks ago.
> 
> >  Do you think that the content in the bad bcache could be interpreted
> >  as regular filesystem? I don't think so.
> 
> Yes, that's what I want to avoid.  Some lower-priority superblocks are
> at the end of the device.

Yes, RAIDs for example, libblkid should be able to detect such
situations and the device should not be interpreted in incorrect way.

It's much more complicated with partitioned raids where we have to
parse partition tables and raids superblock to make decision how to
interpret the device.

> And make-bcache didn't wipe existing devices,
> so any type of superblock can be exposed.

This is mistake! Really. We spend years to fix all possible mkfs-like
programs to be more paranoid and wipe devices. We have API for this
task in libblkid:

  http://karelzak.blogspot.cz/2011/11/wipefs8-improvements.html

See for example XFS patch:
http://oss.sgi.com/archives/xfs/2013-02/msg00149.html

> If you're going to verify checksums for more containers (so far there's
> just bcache, lvm and two raid types), you'll risk exposing desynced data
> for those too.

We check checksums to verify that the superblock is valid and not
overwritten by another stuff.

Note that check for checksums is just one of many possible ways how to verify
that the superblock is valid, we don't have to use if you believe
that bcache with bad checksum is expected use case. 
 
But generally speaking we want to ignore (in udevd) RAIDs and
filesystems with useless superblocks.

Finally, I don't see any difference between bcache and linux swap or
another filesystems. If we will see any collisions then it's libblkid
logic bug, but very probably nothing specific to bcache prober.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
