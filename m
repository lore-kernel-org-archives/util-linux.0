Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:42502 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752855AbeASCW7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 18 Jan 2018 21:22:59 -0500
Received: from vapier.lan (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with ESMTP id A1BC9335C0A
        for <util-linux@vger.kernel.org>; Fri, 19 Jan 2018 02:22:58 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] mount(8): point people to the proc(5) page for mount options
Date: Thu, 18 Jan 2018 21:22:46 -0500
Message-Id: <20180119022246.26617-1-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This page is out of date wrt proc mount options, so point it to the
proc(5) page which is kept up to date.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/mount.8 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index c6089a7ad23a..954a4d3858b9 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2067,9 +2067,9 @@ The upperdir is normally on a writable filesystem.
 The workdir needs to be an empty directory on the same filesystem as upperdir.
 
 .SS "Mount options for proc"
-.TP
-\fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
-These options are recognized, but have no effect as far as I can see.
+See the options section of the
+.BR proc (5)
+man page.
 
 .SS "Mount options for ramfs"
 Ramfs is a memory based filesystem.  Mount it and you have it.  Unmount it
-- 
2.15.1

