Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41832 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbbKYJjh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Nov 2015 04:39:37 -0500
Date: Wed, 25 Nov 2015 10:39:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: Can not move tmpfs mounts
Message-ID: <20151125093935.GF4955@ws.net.home>
References: <56552586.2040007@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56552586.2040007@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 24, 2015 at 10:05:42PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> mount --move fails with -EINVAL on tmpfs mounts.  Is there some reason
> for this, or is it a long standing kernel bug?

Are you sure the problem is tmpfs? I guess you have problem with
propagation flags (shared vs. private), probably systemd based system
where all is shared by default.

# mount -t tmpfs tmpfs  /mnt/test

# strace -e mount mount --move /mnt/test /mnt/test2
mount("/mnt/test", "/mnt/test2", 0x563e27385f00, MS_MGC_VAL|MS_MOVE, NULL) = -1 EINVAL (Invalid argument)
mount: bad option. Note that moving a mount residing under a shared
       mount is unsupported.

See the mount(8) output message (it's also in mount(8) man page),
let's fix it:

# findmnt -o TARGET,PROPAGATION /mnt
TARGET PROPAGATION
/mnt   shared

# mount --make-private /mnt

# strace -e mount mount --move /mnt/test /mnt/test2 
mount("/mnt/test", "/mnt/test2", 0x55a092f54f00, MS_MGC_VAL|MS_MOVE, NULL) = 0


Note that the problem is not with the mountpoint (/mnt/test in my
example), but with parent -- unfortunately usually "/" ("/mnt" in my
example).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
