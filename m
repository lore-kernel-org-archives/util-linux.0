Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33445 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab1I1O0U (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 28 Sep 2011 10:26:20 -0400
Received: by eya28 with SMTP id 28so5673890eya.19
        for <util-linux@vger.kernel.org>; Wed, 28 Sep 2011 07:26:18 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 1/3] ipcrm: add static keyword to some functions
Date: Wed, 28 Sep 2011 16:25:29 +0200
Message-Id: <1317219931-20496-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 sys-utils/ipcrm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 90767d6..dc47f90 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -64,7 +64,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-int remove_id(int type, int iskey, int id)
+static int remove_id(int type, int iskey, int id)
 {
         int ret;
 	char *errmsg;
@@ -163,7 +163,7 @@ static int deprecated_main(int argc, char **argv)
 	return 1;
 }
 
-unsigned long strtokey(const char *str, const char *errmesg)
+static unsigned long strtokey(const char *str, const char *errmesg)
 {
 	unsigned long num;
 	char *end = NULL;
@@ -230,7 +230,7 @@ static int key_to_id(type_id type, char *optarg)
 	return id;
 }
 
-int remove_all(type_id type)
+static int remove_all(type_id type)
 {
 	int ret = 0;
 	int id, rm_me, maxid;
-- 
1.7.3.4

