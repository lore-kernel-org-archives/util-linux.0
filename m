Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2886 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539Ab3KDN6P (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Nov 2013 08:58:15 -0500
Date: Mon, 4 Nov 2013 14:58:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: mount --bind /A /A multiplies mount entries
Message-ID: <20131104135808.GA21311@x2.net.home>
References: <749356890.38567.1383563352930.open-xchange@email.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <749356890.38567.1383563352930.open-xchange@email.1und1.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 04, 2013 at 12:09:12PM +0100, Bernhard Voelker wrote:
>   $ ./mount | grep sdb
>   /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
>   /dev/sdb on /home type ext4 (rw,relatime,data=ordered)

 Yes, it seems correct, use findmnt(8) to see what happen.  It's more
 tricky :-) (or see /proc/self/mountinfo where is Id<->Parent
 relationship described by two first columns).

 ... and don't forget that mounts are propagated in shared trees, so
 try to compare:

  mkdir /mnt/test

  mount --bind /mnt/test /mnt/test
  mount --make-private /mnt/test
  mount --bind /mnt/test /mnt/test
  mount --bind /mnt/test /mnt/test

 and:

  mount --bind /mnt/test /mnt/test
  mount --make-shared /mnt/test
  mount --bind /mnt/test /mnt/test
  mount --bind /mnt/test /mnt/test

you can also try to mount something else to /mnt/test/A to see what
happen.

> This is probably a kernel bug

 I don't think it's bug :-)

>, but as bind mounts to self
> are not that much of use, wouldn't it be worthwhile to
> prohibit it at all in mount(8)?

  mount --bind  /A /A

 is pretty common operation if you want to create a mountpoint
 from non-mountpoint directory.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
