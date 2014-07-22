Return-Path: util-linux-owner@vger.kernel.org
Received: from g4t3427.houston.hp.com ([15.201.208.55]:18269 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064AbaGVXpI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 19:45:08 -0400
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 04/13] sfdisk: remove 'short_opts' global variable
Date: Tue, 22 Jul 2014 16:44:48 -0700
Message-Id: <1406072697-20912-5-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 disk-utils/sfdisk.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 88f953d..490492b 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -2319,8 +2319,6 @@ activate_usage(void) {
     exit(EXIT_FAILURE);
 }
 
-static const char short_opts[] = "cdfghilnqsu:vx1A::C:DGH:I:LN:O:RS:TU::V";
-
 #define PRINT_ID 0400
 #define CHANGE_ID 01000
 
@@ -2456,7 +2454,8 @@ main(int argc, char **argv) {
     if (!strcmp(program_invocation_short_name, "activate"))
 	activate = 1;		/* equivalent to `sfdisk -A' */
 
-    while ((c = getopt_long(argc, argv, short_opts, long_opts, NULL)) != -1) {
+    while ((c = getopt_long(argc, argv, "cdfghilnqsu:vx1A::C:DGH:I:LN:O:RS:TU::V",
+			    long_opts, NULL)) != -1) {
 	switch (c) {
 	case 'f':
 	    force = 1;
-- 
1.8.1.4

