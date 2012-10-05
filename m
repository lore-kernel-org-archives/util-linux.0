Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32769 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab2JEQh6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 5 Oct 2012 12:37:58 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q95GbwFe018081
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 5 Oct 2012 12:37:58 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 2/3] tests: ignore test if kernel doesn't support minix fs
Date: Fri,  5 Oct 2012 18:37:39 +0200
Message-Id: <1349455060-807-2-git-send-email-mbroz@redhat.com>
In-Reply-To: <1349455060-807-1-git-send-email-mbroz@redhat.com>
References: <1349455060-807-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Minix mount test returs failure if kernel have no minix support,
 minix: mkfs ... FAILED (minix/mkfs)
ignore test result instead in this case.

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 tests/ts/minix/mkfs |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/ts/minix/mkfs b/tests/ts/minix/mkfs
index 93de4e6..39185ad 100755
--- a/tests/ts/minix/mkfs
+++ b/tests/ts/minix/mkfs
@@ -35,7 +35,8 @@ ts_log "create mountpoint dir"
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
 ts_log "mount the filesystem"
-$TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+($TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT || true) \
+        | grep -q "unknown filesystem type" && ts_skip "mkfs: minix fs not supported by kernel"
 
 # check it
 ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts" $DEVICE
-- 
1.7.10.4

