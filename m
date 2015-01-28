Return-Path: jack@suse.cz
From: Jan Kara <jack@suse.cz>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH] mount: Add documentation of FAT mount option time_offset
Date: Wed, 28 Jan 2015 10:00:25 +0100
Message-Id: <1422435625-25101-1-git-send-email-jack@suse.cz>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Jan Kara <jack@suse.cz>
---
 sys-utils/mount.8 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 15f8bfc7f512..bfa82a0d7635 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2011,6 +2011,18 @@ useful when mounting devices (like digital cameras)
 that are set to UTC in order to avoid the pitfalls of
 local time.
 .TP
+.BI time_offset= minutes
+Set offset for conversion of timestamps from local time used by FAT to UTC.
+I.e.,
+.I minutes
+minutes will be subtracted from each timestamp to convert it to UTC used
+internally by Linux. This is useful when the time zone set in the kernel via
+.BR settimeofday (2)
+is not the time zone used by the filesystem. Note
+that this option still does not provide correct time stamps in all cases in
+presence of DST - time stamps in a different DST setting will be off by one
+hour.
+.TP
 .B quiet
 Turn on the
 .I quiet
-- 
2.1.2
