Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:41089 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbaBGWKi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Feb 2014 17:10:38 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] fix mkfs --verbose and man page
Date: Fri,  7 Feb 2014 17:01:20 -0500
Message-Id: <1391810480-2475-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

mkfs did not actually accept the long form --verbose option.
Also the man page seemed to indicate that version/verbose/help
options were passed to the filesystem specific utility when this
is not the case.

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 disk-utils/mkfs.8 | 7 +------
 disk-utils/mkfs.c | 1 +
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/disk-utils/mkfs.8 b/disk-utils/mkfs.8
index 9e82bc4..3b905b2 100644
--- a/disk-utils/mkfs.8
+++ b/disk-utils/mkfs.8
@@ -53,8 +53,6 @@ If not specified, the default filesystem type
 .TP
 .I fs-options
 Filesystem-specific options to be passed to the real filesystem builder.
-Although not guaranteed, the following options are supported
-by most filesystem builders.
 .TP
 .BR \-V , " \-\-verbose"
 Produce verbose output, including all filesystem-specific commands
@@ -73,10 +71,7 @@ Display help text and exit.
 .SH BUGS
 All generic options must precede and not be combined with
 filesystem-specific options.
-Some filesystem-specific programs do not support the
-.B -V
-(verbose) option, nor return meaningful exit codes.
-Also, some filesystem-specific programs do not automatically
+Some filesystem-specific programs do not automatically
 detect the device size and require the
 .I size
 parameter to be specified.
diff --git a/disk-utils/mkfs.c b/disk-utils/mkfs.c
index a6795cb..cb34951 100644
--- a/disk-utils/mkfs.c
+++ b/disk-utils/mkfs.c
@@ -73,6 +73,7 @@ int main(int argc, char **argv)
 	static const struct option longopts[] = {
 		{"type", required_argument, NULL, 't'},
 		{"version", no_argument, NULL, VERSION_OPTION},
+		{"verbose", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
-- 
1.8.3.2

