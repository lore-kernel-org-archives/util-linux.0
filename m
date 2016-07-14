Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48635 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbcGNOtT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 10:49:19 -0400
Date: Thu, 14 Jul 2016 16:49:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/7] safe implementation of loop reuse
Message-ID: <20160714144917.uejh6ygt4kbeqsvn@ws.net.home>
References: <ecb4b89d-f9ad-a854-80e5-c3fb49b200a2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <ecb4b89d-f9ad-a854-80e5-c3fb49b200a2@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


I'll review the patches later this week. Thanks.

On Thu, Jul 14, 2016 at 03:28:11PM +0200, Stanislav Brabec wrote:
> Thing that should be done, but they are above scope of this patch set:
> 
> - The current API does not support passing the name of the conflicting
>   loop device to the error reported to the user. Just now, only debug
>   messages contain it.

Maybe it would be enough to add "for more details see losetup" to the
error message :-)

> - The same what is done for mount needs to be done for losetup.
>   API is now ready for it, so it should be simple.

OK

> - Add mount option looprw. It would allow to mount read only but
>   initialize loop device R/W. Required for things like:
>   mount -oro,loop,looprw,subvol=snapshots/1 -tbtrfs\
>    /home.img /home-snapshots/1
>   mount -oloop -tbtrfs /home.img /home
>   (Without looprw, /home will be mounted read-only.)

It seem like an over-engineering, if you really need so complicated
setup then you can use losetup (rw) and + mount (or).

(All the loopdev support in mount(8) is questionable, there is many
another ways how you can create block device without mount(8) support.
The loopdev has extra support in mount(8) because it has been the
first one.)

> - I am not sure, whether loop reuse with combination of autoclear flag
>   differences could cause preliminary releasing of loop device or
>   keeping orphan loop device in some situations.

Reuse means another mount, I guess kernel keeps the loopdev alive 
until there is any reference (e.g. VFS mount).

# mount /home/archive/fs-images/filesystems/ext2.img /mnt/test1

# losetup 
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO
/dev/loop0         0      0         1  0 /home/archive/fs-images/filesystems/ext2.img   0

# mount /dev/loop0 /mnt/test2
# umount /mnt/test1

# losetup 
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO
/dev/loop0         0      0         1  0 /home/archive/fs-images/filesystems/ext2.img   0

# umount /mnt/test2
# losetup 
<nothing>


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
