Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37386 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab2IJVHj convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Sep 2012 17:07:39 -0400
Received: by pbbrr13 with SMTP id rr13so3046168pbb.19
        for <util-linux@vger.kernel.org>; Mon, 10 Sep 2012 14:07:39 -0700 (PDT)
From: "John Calcote" <john.calcote@gmail.com>
To: <util-linux@vger.kernel.org>
Subject: libblkid licensing patch
Date: Mon, 10 Sep 2012 15:07:35 -0600
Message-ID: <028201cd8f98$4e9522d0$ebbf6870$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello util-linux maintainers - 

We’d like to use libblkid, but our lawyers are pedantic. Please accept this
patch, which changes two of the comment headers in libblkid to reflect the
license specified in libblkid/COPYING file. 

Summary: Two files, one line each.

Thanks,
John

--- util-linux-2.22-original/libblkid/libblkid.3        2012-07-23
15:21:56.304319734 -0600
+++ util-linux-2.22-modified/libblkid/libblkid.3        2012-09-10
14:58:29.955114641 -0600
@@ -2,7 +2,7 @@
.\"
.\" This man page was created for libblkid.so.1.0 from e2fsprogs-1.24.
.\"
-.\" This file may be copied under the terms of the GNU Public License.
+.\" This file may be copied under the terms of the GNU Lesser General
Public License.
.\"
.\" Created  Wed Sep 14 12:02:12 2001, Andreas Dilger
.TH LIBBLKID 3 "May 2009" "util-linux" "Programmer's Manual"
diff -Naur util-linux-2.22-original/libblkid/src/version.c
util-linux-2.22-modified/libblkid/src/version.c
--- util-linux-2.22-original/libblkid/src/version.c     2012-06-11
04:06:53.689196193 -0600
+++ util-linux-2.22-modified/libblkid/src/version.c     2012-09-10
14:58:54.743114750 -0600
@@ -4,7 +4,7 @@
  * Copyright (C) 2004 Theodore Ts'o.
  *
  * %Begin-Header%
- * This file may be redistributed under the terms of the GNU Public
+ * This file may be redistributed under the terms of the GNU Lesser General
Public
  * License.
  * %End-Header%
  */


