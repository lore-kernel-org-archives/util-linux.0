Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:51295 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756387AbaGNUx4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 16:53:56 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] cfdisk: restore the license that was lost in January
Date: Mon, 14 Jul 2014 22:53:36 +0200
Message-Id: <1405371216-7774-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1405371216-7774-1-git-send-email-bensberg@justemail.net>
References: <1405371216-7774-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index fb089f5..544e87a 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1,3 +1,17 @@
+/*
+ * cfdisk.c - Display or manipulate a disk partition table.
+ *
+ *     Copyright (C) 2014 Karel Zak <kzak@redhat.com>
+ *     Copyright (C) 1994 Kevin E. Martin (martin@cs.unc.edu)
+ *
+ *     The original cfdisk was inspired by the fdisk program
+ *           by A. V. Le Blanc (leblanc@mcc.ac.uk.
+ *
+ * cfdisk is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
-- 
1.7.0.4

