Return-Path: util-linux-owner@vger.kernel.org
Received: from mailhub.sw.ru ([195.214.232.25]:45602 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143Ab3L0NuA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Dec 2013 08:50:00 -0500
From: Andrey Vagin <avagin@openvz.org>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Andrew Vagin <avagin@openvz.org>
Subject: [PATCH] hexdump: convert a variable type according with fmt
Date: Fri, 27 Dec 2013 17:45:57 +0400
Message-Id: <1388151957-9209-1-git-send-email-avagin@openvz.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Andrew Vagin <avagin@openvz.org>

hexdump works uncorrectly on Rassberry Pi (raspbian wheezy):
0000000 3200000000 3400000000 3600000000 3800000000 a00000000
000000a

The problem is that the %qx format is used for printing
the (short int) variable.

Here is the output from hexdump with this patch:
0000000 3231 3433 3635 3837 0a39
000000a

Currently raspbian uses hexdump from bsdmainutils.
bsdmainutils: /usr/bin/hexdump

Signed-off-by: Andrew Vagin <avagin@openvz.org>
---
 text-utils/hexdump-display.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/text-utils/hexdump-display.c b/text-utils/hexdump-display.c
index 67f426d..b195a01 100644
--- a/text-utils/hexdump-display.c
+++ b/text-utils/hexdump-display.c
@@ -93,15 +93,15 @@ print(struct hexdump_pr *pr, unsigned char *bp) {
 
 		switch(pr->bcnt) {
 		case 1:
-			printf(pr->fmt, *bp);
+			printf(pr->fmt, (unsigned long long) *bp);
 			break;
 		case 2:
 			memmove(&sval, bp, sizeof(sval));
-			printf(pr->fmt, sval);
+			printf(pr->fmt, (unsigned long long) sval);
 			break;
 		case 4:
 			memmove(&ival, bp, sizeof(ival));
-			printf(pr->fmt, ival);
+			printf(pr->fmt, (unsigned long long) ival);
 			break;
 		case 8:
 			memmove(&Lval, bp, sizeof(Lval));
@@ -130,15 +130,15 @@ print(struct hexdump_pr *pr, unsigned char *bp) {
 
 		switch(pr->bcnt) {
 		case 1:
-			printf(pr->fmt, *bp);
+			printf(pr->fmt, (unsigned long long) *bp);
 			break;
 		case 2:
 			memmove(&sval, bp, sizeof(sval));
-			printf(pr->fmt, sval);
+			printf(pr->fmt, (unsigned long long) sval);
 			break;
 		case 4:
 			memmove(&ival, bp, sizeof(ival));
-			printf(pr->fmt, ival);
+			printf(pr->fmt, (unsigned long long) ival);
 			break;
 		case 8:
 			memmove(&Lval, bp, sizeof(Lval));
-- 
1.8.4.2

