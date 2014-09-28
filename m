Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:57184 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaI1TxG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:53:06 -0400
Received: by mail-we0-f180.google.com with SMTP id x48so1136142wes.11
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:53:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 19/23] lscpu: add missing initializers to struct lscpu_coldesc
Date: Sun, 28 Sep 2014 20:51:52 +0100
Message-Id: <1411933916-30576-20-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

warning: missing field 'is_abbr' initializer [-Wmissing-field-initializers]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/lscpu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index ef59410..30f2be6 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -300,17 +300,17 @@ struct lscpu_coldesc {
 static struct lscpu_coldesc coldescs[] =
 {
 	[COL_CPU]          = { "CPU", N_("logical CPU number"), 1 },
-	[COL_CORE]         = { "CORE", N_("logical core number") },
-	[COL_SOCKET]       = { "SOCKET", N_("logical socket number") },
-	[COL_NODE]         = { "NODE", N_("logical NUMA node number") },
-	[COL_BOOK]         = { "BOOK", N_("logical book number") },
-	[COL_CACHE]        = { "CACHE", N_("shows how caches are shared between CPUs") },
-	[COL_POLARIZATION] = { "POLARIZATION", N_("CPU dispatching mode on virtual hardware") },
-	[COL_ADDRESS]      = { "ADDRESS", N_("physical address of a CPU") },
-	[COL_CONFIGURED]   = { "CONFIGURED", N_("shows if the hypervisor has allocated the CPU") },
-	[COL_ONLINE]       = { "ONLINE", N_("shows if Linux currently makes use of the CPU") },
-	[COL_MAXMHZ]	   = { "MAXMHZ", N_("shows the maximum MHz of the CPU") },
-	[COL_MINMHZ]	   = { "MINMHZ", N_("shows the minimum MHz of the CPU") }
+	[COL_CORE]         = { "CORE", N_("logical core number"), 0 },
+	[COL_SOCKET]       = { "SOCKET", N_("logical socket number"), 0 },
+	[COL_NODE]         = { "NODE", N_("logical NUMA node number"), 0 },
+	[COL_BOOK]         = { "BOOK", N_("logical book number"), 0 },
+	[COL_CACHE]        = { "CACHE", N_("shows how caches are shared between CPUs"), 0 },
+	[COL_POLARIZATION] = { "POLARIZATION", N_("CPU dispatching mode on virtual hardware"), 0 },
+	[COL_ADDRESS]      = { "ADDRESS", N_("physical address of a CPU"), 0 },
+	[COL_CONFIGURED]   = { "CONFIGURED", N_("shows if the hypervisor has allocated the CPU"), 0 },
+	[COL_ONLINE]       = { "ONLINE", N_("shows if Linux currently makes use of the CPU"), 0 },
+	[COL_MAXMHZ]	   = { "MAXMHZ", N_("shows the maximum MHz of the CPU"), 0 },
+	[COL_MINMHZ]	   = { "MINMHZ", N_("shows the minimum MHz of the CPU"), 0 }
 };
 
 static int
-- 
2.1.1

