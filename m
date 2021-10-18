Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD8C433F5
	for <util-linux@archiver.kernel.org>; Mon, 18 Oct 2021 07:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64473610A3
	for <util-linux@archiver.kernel.org>; Mon, 18 Oct 2021 07:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhJRHma (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Oct 2021 03:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhJRHmV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 Oct 2021 03:42:21 -0400
Received: from nlay-fle-service01.in.namespace.at (nlay-fle-service01.in.namespace.at [IPv6:2a01:190:1801:100::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1454AC061745
        for <util-linux@vger.kernel.org>; Mon, 18 Oct 2021 00:40:11 -0700 (PDT)
Received: from [10.100.0.62] (helo=debbuild.in.namespace.at)
        by nlay-fle-service01.in.namespace.at with smtp (Exim 4.92)
        (envelope-from <zeha@debian.org>)
        id 1mcNFf-005uXx-5f
        for util-linux@vger.kernel.org; Mon, 18 Oct 2021 09:40:07 +0200
Received: (nullmailer pid 4098060 invoked by uid 1000);
        Mon, 18 Oct 2021 07:40:07 -0000
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Subject: [PATCH] blockdev: remove accidental non-breaking spaces
Date:   Mon, 18 Oct 2021 07:40:01 +0000
Message-Id: <20211018074001.4098046-1-zeha@debian.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

commit 9147d2ad8abb73cea5799323fc73ccdaf675826f introduced these
C2A0 spaces, but without saying anything. Likely this was an
accident.

Bug-Debian: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996751
Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
---
 disk-utils/blockdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
index c16cb1095..6721560f6 100644
--- a/disk-utils/blockdev.c
+++ b/disk-utils/blockdev.c
@@ -491,7 +491,7 @@ static void report_device(char *device, int quiet)
 	    ioctl(fd, BLKSSZGET, &ssz) == 0 &&
 	    ioctl(fd, BLKBSZGET, &bsz) == 0 &&
 	    blkdev_get_size(fd, &bytes) == 0) {
-		printf("%s %5ld %5d %5d %s %15lld   %s\n",
+		printf("%s %5ld %5d %5d %s %15lld   %s\n",
 			ro ? "ro" : "rw", ra, ssz, bsz, start_str, bytes, device);
 	} else {
 		if (!quiet)
-- 
2.33.0

