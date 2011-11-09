Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15020 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999Ab1KIJXR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Nov 2011 04:23:17 -0500
Date: Wed, 9 Nov 2011 10:23:12 +0100
From: Karel Zak <kzak@redhat.com>
To: KIMURA Masaru <hiyuh.root@gmail.com>
Cc: util-linux@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: behavior of "# mount /dev"
Message-ID: <20111109092312.GI16397@nb.net.home>
References: <CAPYQg32qP3Xb_gS45Md6ArqJGx22xZUdCg-W4z5f1ji2id7aSA@mail.gmail.com> <1320797364.3005.10.camel@offbook> <CAPYQg31aC1PDvZGtgtbvLZsLLYKo-SufL-qsDHAU5b+r3eErXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPYQg31aC1PDvZGtgtbvLZsLLYKo-SufL-qsDHAU5b+r3eErXQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 09, 2011 at 10:47:45AM +0900, KIMURA Masaru wrote:
> 
> Same here on my Gentoo and Ubuntu 11.10.
> "# mount /sys" does fail and warn "already mounted" but "# mount /dev" doesn't.
> 
> First of all, /dev is mounted on tmpfs which is a filesystem on memory.
> And /sys is mounted on sysfs which is another filesystem on memory.

Yes, this normal filesystem specific behavior.

[...]

> Summary:
> - "# mount /dev" hides udev managed /dev.
> - because it doesn't return a busy error.
> - because it uses tmpfs.
> - using tmpfs, we are not able to treat this case as error in kernel.

 Sure, it's not a bug.

 It would be nice to have mount option (VFS flag) to control this behavior,
 something like:

    # mount -t tmpfs none /dev -o nooverlay

    # mount -t tmpfs none /dev      --> EBUSY


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
