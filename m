Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:36131 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753376Ab2EFMKg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 6 May 2012 08:10:36 -0400
Subject: [PATCH 4/5] fdisk: remove unused function declaration
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 May 2012 14:10:23 +0200
Message-ID: <1336306223.2685.13.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 3044879..d8a9558 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -52,8 +52,6 @@
 
 #include "gpt.h"
 
-static void delete_partition(int i);
-
 unsigned char *MBRbuffer;
 int MBRbuffer_changed;
 
-- 
1.7.4.1




