Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48629 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab1LOTC5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:02:57 -0500
Received: by eekc4 with SMTP id c4so2431841eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:02:56 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 02/13] fdisk: remove possibly_osf_label variable that is only assigned
Date: Thu, 15 Dec 2011 20:02:38 +0100
Message-Id: <1323975769-21929-2-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index a6de6e2..a23f45e 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -292,8 +292,6 @@ int has_topology;
 
 enum labeltype disklabel = DOS_LABEL;	/* Current disklabel */
 
-int	possibly_osf_label = 0;
-
 jmp_buf listingbuf;
 
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
@@ -862,7 +860,6 @@ create_doslabel(void) {
 	sun_nolabel();  /* otherwise always recognised as sun */
 	sgi_nolabel();  /* otherwise always recognised as sgi */
 	disklabel = DOS_LABEL;
-	possibly_osf_label = 0;
 	partitions = 4;
 
 	/* Zero out the MBR buffer */
@@ -1155,7 +1152,6 @@ get_boot(enum action what) {
 		return 0;
 
 	if (check_osf_label()) {
-		possibly_osf_label = 1;
 		if (!valid_part_table_flag(MBRbuffer)) {
 			disklabel = OSF_LABEL;
 			return 0;
-- 
1.7.7

