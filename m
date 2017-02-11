Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33074 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbdBKOLA (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 11 Feb 2017 09:11:00 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so10979711wmv.0
        for <util-linux@vger.kernel.org>; Sat, 11 Feb 2017 06:10:59 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/3] man: improve blkreport(8) and blkreset(8) manual pages
Date: Sat, 11 Feb 2017 14:10:51 +0000
Message-Id: <20170211141052.26154-3-kerolasa@iki.fi>
In-Reply-To: <20170211141052.26154-1-kerolasa@iki.fi>
References: <20170211141052.26154-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Tell in manual page what ZAC and ZBC acronyms mean.  Include explanation to
blkreport output, so that users do not need to search source code to
understand what the tool informed.  And fix couple dot double space issues.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/blkreport.8 | 29 ++++++++++++++++++++++++++++-
 sys-utils/blkreset.8  |  9 ++++-----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/sys-utils/blkreport.8 b/sys-utils/blkreport.8
index 81417d4ad..1d00bfd24 100644
--- a/sys-utils/blkreport.8
+++ b/sys-utils/blkreport.8
@@ -12,7 +12,8 @@ blkreport \- report zones on a device
 .SH DESCRIPTION
 .B blkreport
 is used to report device zone information.  This is useful for
-zoned devices that support the ZAC or ZBC command set.
+devices that support the Zoned Block Commands (ZBC) or Zoned-device ATA
+Commands (ZAC).
 .PP
 By default,
 .B blkreport
@@ -52,6 +53,32 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
+.SH REPORT OUTPUT
+.TS
+tab(:);
+left l l.
+start:Zone start sector
+len:Zone length in number of sectors
+wptr:Zone write pointer position
+reset:Reset write pointer recommended
+non-seq:Non-sequential write resources active
+cond:Zone condition
+type:Zone type
+.TE
+.SS Zone conditions
+.TS
+tab(:);
+left l l.
+Cl:closed
+cv:conventional zone
+e0:empty
+fu:full
+Oe:open explicit
+Oi:open implicit
+OL:offline
+ro:read only
+x?:reserved conditions (should not be reported)
+.TE
 .SH AUTHOR
 .MT shaun@tancheff.com
 Shaun Tancheff
diff --git a/sys-utils/blkreset.8 b/sys-utils/blkreset.8
index 598d89fa8..250699196 100644
--- a/sys-utils/blkreset.8
+++ b/sys-utils/blkreset.8
@@ -10,15 +10,14 @@ blkreset \- Reset a range of zones
 .IR count ]
 .SH DESCRIPTION
 .B blkreset
-is used to reset one or more zones.  This is useful for
-zoned devices that support the ZAC or ZBC command set.
-Unlike
+is used to reset one or more zones.  This is useful for devices that support
+Zoned Block Commands (ZBC) or Zoned-device ATA Commands (ZAC).  Unlike
 .BR sg_reset_wp (8) ,
 this command operates from the block layer and can reset a range of zones.
 .PP
 By default,
 .B blkreset
-will operate on the zone at device logical sector 0. Options may be used to
+will operate on the zone at device logical sector 0.  Options may be used to
 modify this behavior as well as specify the operation to be performed on
 the zone, as explained below.
 .PP
@@ -43,7 +42,7 @@ The provided offset in sector units (512 bytes) should match the start of a zone
 The default value is zero.
 .TP
 .BR \-c , " \-\-count "\fIlength\fP
-The number of zones to be reset starting from offset. Default is 1 zone.
+The number of zones to be reset starting from offset.  Default is 1 zone.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-- 
2.11.1

