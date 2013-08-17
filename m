Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:38463 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSPs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:15:48 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so2661355wes.34
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:15:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/16] docs: update TODO
Date: Sat, 17 Aug 2013 19:15:07 +0100
Message-Id: <1376763321-22782-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The minix type fixes took place December 2012.

Commit: a180dc6c54f90896d6491f9bdf704523236dd99c
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/TODO | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/TODO b/Documentation/TODO
index fe67f12..89b147b 100644
--- a/Documentation/TODO
+++ b/Documentation/TODO
@@ -25,11 +25,6 @@ lscpu
   - detect more hypervisors, see 'virt-what' shell script
     http://people.redhat.com/~rjones/virt-what/
 
-minix (fsck, mkfs)
-------------------
-
- - clean up types -- use ino_t, size_t and ssize_t
-
 libmount (mount/umount)
 -----------------------
 
-- 
1.8.3.4

