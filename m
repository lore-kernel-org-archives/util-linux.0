Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58484 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab2CETjS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:18 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so1565228eaa.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:17 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/17] docs: TODO removal, rpmatch task is done
Date: Mon,  5 Mar 2012 20:38:43 +0100
Message-Id: <1330976334-10751-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/TODO |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/TODO b/Documentation/TODO
index 6b8c2cc..d922d7e 100644
--- a/Documentation/TODO
+++ b/Documentation/TODO
@@ -189,9 +189,6 @@ fdisk(s)
    This feature seems very attractive to users who resizing their disks 
    (for example in virtual machines).
 
- - sfdisk has to use rpmatch() for answers to y/n questions
-   (e.g. "Are you satisfied with this? [ynq]")
-
  - sfdisk rounds to cylinders is -uM (megabyte units) is specified, this is
    pretty stupid feature. It has to round to sectors if -uS or -uM is specified.
 
@@ -227,8 +224,6 @@ misc
  - add mllockall() and SCHED_FIFO to hwclock,
    see http://lkml.org/lkml/2008/10/12/132
  
- - use rpmatch() for all Y/N questions
-
  - (!) rewrite ipcs to use /proc/sys/kernel rather than unreliable syscalls
    (there are problems with 32bit userspace on 64bit kernel)
 
-- 
1.7.9.2

