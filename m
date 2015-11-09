Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50045 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbbKILqP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Nov 2015 06:46:15 -0500
Date: Mon, 9 Nov 2015 12:46:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] losetup: support direct-IO to backing file
Message-ID: <20151109114613.GV19508@ws.net.home>
References: <1446856818-26532-1-git-send-email-tom.leiming@gmail.com>
 <20151109102931.GU19508@ws.net.home>
 <CACVXFVOGZzGtpPBbVfYDd1=3rcZ__x-ggkvtQMx9T0+VJYfSrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVOGZzGtpPBbVfYDd1=3rcZ__x-ggkvtQMx9T0+VJYfSrw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 09, 2015 at 07:29:21PM +0800, Ming Lei wrote:
> > It's fine to use --direct-io as toggle, but it would be nice to
> > support it also when initialize the device.
> 
> OK, looks a good idea, but we still need to support the standalone
> command for direct-io for the case of 'mount -o loop'.

Sure, I understand this use-case. I have talked bout loop_set_fd(),
maybe all we need is:


diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 423f4ca..22642a0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -925,7 +925,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
 	set_device_ro(bdev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
-	lo->use_dio = false;
+	lo->use_dio = (lo_flags & LO_FLAGS_DIRECT_IO);
 	lo->lo_blocksize = lo_blocksize;
 	lo->lo_device = bdev;
 	lo->lo_flags = lo_flags;


then we can a little bit modify your losetup.c patches and support
--direct-io also for A_CREATE.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
