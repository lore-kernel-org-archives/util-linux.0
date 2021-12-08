Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3E4C433EF
	for <util-linux@archiver.kernel.org>; Wed,  8 Dec 2021 17:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhLHRNZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 8 Dec 2021 12:13:25 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45172 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbhLHRNZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 8 Dec 2021 12:13:25 -0500
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 215A220B7179; Wed,  8 Dec 2021 09:09:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 215A220B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638983393;
        bh=jE36F6KBc2nqbn3PAMOeWqyb3jYdmhIQ393vXSRf9yc=;
        h=Date:From:To:Cc:Subject:From;
        b=Pgo6fV7W6VB9i33llAw8oQTrWAN9pAYxlBUBOxuZvqgPzPFh/hAhlctywCBNLT2q9
         mURX/4aOfcGwo3uiwhFuE0pI5Q+VGlwReR2WxJD1jYWobmN3c+3DBZ9VfIVq/7xmmC
         H689+eTQfsZ3itjTw0kMHEytSSx4KjUxMHwuscSs=
Date:   Wed, 8 Dec 2021 09:09:53 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     util-linux@vger.kernel.org
Cc:     jpiotrowski@microsoft.com
Subject: [PATCH] libblkid/src/probe: check for ENOMEDIUM from
 ioctl(CDROM_LAST_WRITTEN)
Message-ID: <20211208170953.GA18252@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The CD device on Azure VMs returns CDS_DISC_OK from CDROM_DRIVE_STATUS even
when no disc is present. In that case an ENOMEDIUM from CDROM_LAST_WRITTEN
follows. Catch that and return error to prevent probing which results in
hundreds of "unaligned transfer" warnings in the kernel logbuffer.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@microsoft.com>
---
 libblkid/src/probe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 3685ea5e1..513649916 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -994,8 +994,12 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 		}
 
 # ifdef CDROM_LAST_WRITTEN
-		if (ioctl(fd, CDROM_LAST_WRITTEN, &last_written) == 0)
+		if (ioctl(fd, CDROM_LAST_WRITTEN, &last_written) == 0) {
 			pr->flags |= BLKID_FL_CDROM_DEV;
+		} else {
+			if (errno == ENOMEDIUM)
+				goto err;
+		}
 # endif
 
 		if (pr->flags & BLKID_FL_CDROM_DEV) {
-- 
2.32.0

