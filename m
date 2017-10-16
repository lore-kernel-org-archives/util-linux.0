Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:53309 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbdJPSPx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 16 Oct 2017 14:15:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id y44so3822897wry.10
        for <util-linux@vger.kernel.org>; Mon, 16 Oct 2017 11:15:53 -0700 (PDT)
Date: Mon, 16 Oct 2017 19:15:44 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] rfkill: expand all acronyms in type string
 descriptions
In-Reply-To: <20171016085834.u5ywmcgadkjtxbdu@ws.net.home>
Message-ID: <alpine.LNX.2.20.1710161912540.918@imuri>
References: <20171014213541.1666-1-kerolasa@iki.fi> <20171016085834.u5ywmcgadkjtxbdu@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 16 Oct 2017, Karel Zak wrote:
> So, the default "list" output will be *again* backwardly incompatible :-)

Yep, that would not be good. I should have looked a little bit close what 
was done with these descriptiosn. Anyway, lets get the s/GPT/GPS/ fixed.

--->8----
>From 4a74c9b1675f4c4f2ff6ce69bdb5808da9c258af Mon Sep 17 00:00:00 2001
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 14 Oct 2017 22:18:21 +0100
Subject: [PATCH] rfkill: fix description name typo

Commit 7d2a9960ad made gps to look like a GUID Partition Table.

Reviewed-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rfkill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/rfkill.c b/sys-utils/rfkill.c
index 013806020..c31da7997 100644
--- a/sys-utils/rfkill.c
+++ b/sys-utils/rfkill.c
@@ -64,7 +64,7 @@ static const struct rfkill_type_str rfkill_type_strings[] = {
 	{ .type = RFKILL_TYPE_UWB,       .name = "ultrawideband" }, /* alias */
 	{ .type = RFKILL_TYPE_WIMAX,     .name = "wimax",        .desc = "WiMAX" },
 	{ .type = RFKILL_TYPE_WWAN,      .name = "wwan",         .desc = "Wireless WAN" },
-	{ .type = RFKILL_TYPE_GPS,       .name = "gps",          .desc = "GPT" },
+	{ .type = RFKILL_TYPE_GPS,       .name = "gps",          .desc = "GPS" },
 	{ .type = RFKILL_TYPE_FM,        .name = "fm",           .desc = "FM" },
 	{ .type = RFKILL_TYPE_NFC,       .name = "nfc",          .desc = "NFC" },
 	{ .type = NUM_RFKILL_TYPES,      .name = NULL            }
-- 
2.14.2

