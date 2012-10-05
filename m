Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31838 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745Ab2JEQh5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 5 Oct 2012 12:37:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q95Gbv77019486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 5 Oct 2012 12:37:57 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 1/3] tests: fix timezone for cramfs
Date: Fri,  5 Oct 2012 18:37:38 +0200
Message-Id: <1349455060-807-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

cramfs test need explicitly set timezone otherwise
ls diff fails with
   cramfs: mkfs checksums ... FAILED (cramfs/mkfs)

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 tests/ts/cramfs/mkfs |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ts/cramfs/mkfs b/tests/ts/cramfs/mkfs
index db9b08c..99d682f 100755
--- a/tests/ts/cramfs/mkfs
+++ b/tests/ts/cramfs/mkfs
@@ -79,6 +79,7 @@ ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts" $DEVICE
 cd $TS_MOUNTPOINT
 
 ts_log "list the image"
+TZ='GMT-1'
 ls -laR --time-style=long-iso . >> $TS_OUTPUT
 echo >> $TS_OUTPUT
 
-- 
1.7.10.4

