Return-Path: util-linux-owner@vger.kernel.org
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:45066 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbaAYTUk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 25 Jan 2014 14:20:40 -0500
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: util-linux@vger.kernel.org
Cc: Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 1/3] fallocate: Clarify that space can also be deallocated
Date: Sat, 25 Jan 2014 19:17:26 +0000
Message-Id: <1390677448-7173-2-git-send-email-rodrigo@sdfg.com.ar>
In-Reply-To: <1390677448-7173-1-git-send-email-rodrigo@sdfg.com.ar>
References: <1390677448-7173-1-git-send-email-rodrigo@sdfg.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The functionality is already there, with --punch-hole, but the text was for the
preallocation case only.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 sys-utils/fallocate.1 | 11 ++++++-----
 sys-utils/fallocate.c |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index d462cee..efa42c1 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -1,7 +1,7 @@
 .\" -*- nroff -*-
 .TH FALLOCATE 1 "September 2011" "util-linux" "User Commands"
 .SH NAME
-fallocate \- preallocate space to a file
+fallocate \- preallocate or deallocate space to a file
 .SH SYNOPSIS
 .B fallocate
 .RB [ \-n ]
@@ -13,10 +13,11 @@ fallocate \- preallocate space to a file
 .I filename
 .SH DESCRIPTION
 .B fallocate
-is used to preallocate blocks to a file.  For filesystems which support the
-fallocate system call, this is done quickly by allocating blocks and marking
-them as uninitialized, requiring no IO to the data blocks.  This is much faster
-than creating a file by filling it with zeros.
+is used to manipulate the allocated disk space for a file, either to deallocate
+or preallocate it. For filesystems which support the fallocate system call,
+preallocation is done quickly by allocating blocks and marking them as
+uninitialized, requiring no IO to the data blocks. This is much faster than
+creating a file by filling it with zeros.
 .PP
 As of the Linux Kernel v2.6.31, the fallocate system call is supported by the
 btrfs, ext4, ocfs2, and xfs filesystems.
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index cd35b2d..55e8411 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -62,8 +62,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -n, --keep-size     don't modify the length of the file\n"
 		" -p, --punch-hole    punch holes in the file\n"
-		" -o, --offset <num>  offset of the allocation, in bytes\n"
-		" -l, --length <num>  length of the allocation, in bytes\n"), out);
+		" -o, --offset <num>  offset of the (de)allocation, in bytes\n"
+		" -l, --length <num>  length of the (de)allocation, in bytes\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
-- 
1.8.5.2

