Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48629 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab1LOTDB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:03:01 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2431841eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:03:01 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 06/13] fdisk: get rid of type_open global variable
Date: Thu, 15 Dec 2011 20:02:42 +0100
Message-Id: <1323975769-21929-6-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index a8a1800..ab2e68d 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -230,9 +230,6 @@ get_random_id(void) {
 	return (unsigned int)(tv.tv_sec + (tv.tv_usec << 12) + getpid());
 }
 
-/* normally O_RDWR, -l option gives O_RDONLY */
-static int type_open = O_RDWR;
-
 /*
  * Raw disk label. For DOS-type partition tables the MBR,
  * with descriptions of the primary partitions.
@@ -1120,7 +1117,7 @@ get_boot(enum action what) {
 		goto got_dos_table;		/* skip reading disk */
 
 	if (what != try_only) {
-		if ((fd = open(disk_device, type_open)) < 0) {
+		if ((fd = open(disk_device, O_RDWR)) < 0) {
 			if ((fd = open(disk_device, O_RDONLY)) < 0)
 				fatal(unable_to_open);
 			else
@@ -2810,7 +2807,7 @@ print_partition_table_from_option(char *device)
 	if (setjmp(listingbuf))
 		return;
 	gpt_warning(device);
-	if ((fd = open(disk_device, type_open)) >= 0) {
+	if ((fd = open(disk_device, O_RDONLY)) >= 0) {
 		gb = get_boot(try_only);
 		if (gb > 0) { /* I/O error */
 		} else if (gb < 0) { /* no DOS signature */
@@ -3072,7 +3069,6 @@ main(int argc, char **argv) {
 
 	if (optl) {
 		nowarn = 1;
-		type_open = O_RDONLY;
 		if (argc > optind) {
 			int k;
 			/* avoid gcc warning:
@@ -3091,7 +3087,6 @@ main(int argc, char **argv) {
 		unsigned long long size;
 
 		nowarn = 1;
-		type_open = O_RDONLY;
 
 		opts = argc - optind;
 		if (opts <= 0)
@@ -3099,7 +3094,7 @@ main(int argc, char **argv) {
 
 		for (j = optind; j < argc; j++) {
 			disk_device = argv[j];
-			if ((fd = open(disk_device, type_open)) < 0)
+			if ((fd = open(disk_device, O_RDONLY)) < 0)
 				fatal(unable_to_open);
 			if (blkdev_get_sectors(fd, &size) == -1)
 				fatal(ioctl_error);
-- 
1.7.7

