Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:38550 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759952Ab2EQHl1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 May 2012 03:41:27 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 05A698FFDD
	for <util-linux@vger.kernel.org>; Thu, 17 May 2012 09:41:27 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 4/4] libuuid: use max() from c.h
Date: Thu, 17 May 2012 09:41:09 +0200
Message-Id: <1337240469-24539-4-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1337240469-24539-1-git-send-email-petr.uzel@suse.cz>
References: <1337240469-24539-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libuuid/src/gen_uuid.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 9d5575b..613da02 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -91,6 +91,7 @@
 #include "uuidP.h"
 #include "uuidd.h"
 #include "randutils.h"
+#include "c.h"
 
 #ifdef HAVE_TLS
 #define THREAD_LOCAL static __thread
@@ -150,9 +151,6 @@ static int get_node_id(unsigned char *node_id)
  * just sizeof(struct ifreq)
  */
 #ifdef HAVE_SA_LEN
-#ifndef max
-#define max(a,b) ((a) > (b) ? (a) : (b))
-#endif
 #define ifreq_size(i) max(sizeof(struct ifreq),\
      sizeof((i).ifr_name)+(i).ifr_addr.sa_len)
 #else
-- 
1.7.7

