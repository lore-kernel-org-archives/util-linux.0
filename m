Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54112 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932148AbdD0DjY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Apr 2017 23:39:24 -0400
Subject: [PATCH 3/4] hwclock: remove unneeded braces
To: Karel Zak <kzak@redhat.com>
References: <50c7367a-c086-2c18-af81-9f86f1c2560a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <b4c42a42-a6d3-4d2c-4a09-50cc1a3824a2@gmx.com>
Date: Wed, 26 Apr 2017 23:39:14 -0400
MIME-Version: 1.0
In-Reply-To: <50c7367a-c086-2c18-af81-9f86f1c2560a@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 4a187c5..e66acd2 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -392,9 +392,8 @@ set_hardware_clock(const struct hwclock_control *ctl, const time_t newtime)
 
 	if (ctl->testing)
 		printf(_("Test mode: clock was not changed\n"));
-	else {
+	else
 		ur->set_hardware_clock(ctl, &new_broken_time);
-	}
 }
 
 /*
