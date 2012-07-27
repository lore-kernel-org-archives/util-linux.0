Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24311 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028Ab2G0LX6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Jul 2012 07:23:58 -0400
Date: Fri, 27 Jul 2012 13:23:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: umount for deleted backing file?
Message-ID: <20120727112355.GB29738@x2.net.home>
References: <50127025.9060201@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50127025.9060201@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 27, 2012 at 12:40:37PM +0200, Bernhard Voelker wrote:
> Hi *,
> 
> shouldn't umount also work for a deleted backing file?
> 
> # rm -v /media/sdb5/berny/git/util-linux/tests/output/mount/regfile.img
> removed `/media/sdb5/berny/git/util-linux/tests/output/mount/regfile.img'
> 
> $ mount | grep regfile
> /media/sdb5/berny/git/util-linux/tests/output/mount/regfile.img (deleted) on
> /media/sdb5/berny/git/util-linux/tests/output/mount/regfile-mnt type ext3
> (rw,relatime,errors=continue,barrier=1,data=ordered)
> 
> $ ../umount -v /media/sdb5/berny/git/util-linux/tests/output/mount/regfile.img

try:
    umount /media/sdb5/berny/git/util-linux/tests/output/mount/regfile-mnt

man umount:

  A file system is specified by giving the directory where it
  has been mounted. Giving the special device on which the file system
  lives  may also work, but is obsolete...


... just in this case it's for umount difficult to translate a file
which does not exist to mountpoint (it's possible but not too robust).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
