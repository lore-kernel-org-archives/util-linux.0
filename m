Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36033 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdJNVfq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 14 Oct 2017 17:35:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id l10so2662359wre.3
        for <util-linux@vger.kernel.org>; Sat, 14 Oct 2017 14:35:46 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] rfkill: expand all acronyms in type string descriptions
Date: Sat, 14 Oct 2017 22:35:41 +0100
Message-Id: <20171014213541.1666-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Be as verbose as possible when user wants that.  This also fixes small typo
from 7d2a9960ad that made gps to look like a GUID Partition Table.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rfkill.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sys-utils/rfkill.c b/sys-utils/rfkill.c
index 195386c8f..2b667f7c7 100644
--- a/sys-utils/rfkill.c
+++ b/sys-utils/rfkill.c
@@ -57,16 +57,16 @@ struct rfkill_type_str {
 
 static const struct rfkill_type_str rfkill_type_strings[] = {
 	{ .type = RFKILL_TYPE_ALL,       .name = "all"           },
-	{ .type = RFKILL_TYPE_WLAN,      .name = "wlan",         .desc = "Wireless LAN" },
+	{ .type = RFKILL_TYPE_WLAN,      .name = "wlan",         .desc = "Wireless Local Area Network" },
 	{ .type = RFKILL_TYPE_WLAN,      .name = "wifi"          },				/* alias */
 	{ .type = RFKILL_TYPE_BLUETOOTH, .name = "bluetooth",    .desc = "Bluetooth" },
 	{ .type = RFKILL_TYPE_UWB,       .name = "uwb",          .desc = "Ultra-Wideband" },
 	{ .type = RFKILL_TYPE_UWB,       .name = "ultrawideband" }, /* alias */
-	{ .type = RFKILL_TYPE_WIMAX,     .name = "wimax",        .desc = "WiMAX" },
-	{ .type = RFKILL_TYPE_WWAN,      .name = "wwan",         .desc = "Wireless WAN" },
-	{ .type = RFKILL_TYPE_GPS,       .name = "gps",          .desc = "GPT" },
-	{ .type = RFKILL_TYPE_FM,        .name = "fm",           .desc = "FM" },
-	{ .type = RFKILL_TYPE_NFC,       .name = "nfc",          .desc = "NFC" },
+	{ .type = RFKILL_TYPE_WIMAX,     .name = "wimax",        .desc = "Worldwide Interoperability for Microwave Access" },
+	{ .type = RFKILL_TYPE_WWAN,      .name = "wwan",         .desc = "Wireless Wide Area Network" },
+	{ .type = RFKILL_TYPE_GPS,       .name = "gps",          .desc = "Global Positioning System" },
+	{ .type = RFKILL_TYPE_FM,        .name = "fm",           .desc = "Frequency Modulation radio" },
+	{ .type = RFKILL_TYPE_NFC,       .name = "nfc",          .desc = "Near-Field Communication" },
 	{ .type = NUM_RFKILL_TYPES,      .name = NULL            }
 };
 
-- 
2.14.2

