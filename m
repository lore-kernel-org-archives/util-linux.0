Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50558 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753236AbdFSArk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 18 Jun 2017 20:47:40 -0400
Subject: [PATCH 09/12] hwclock: add --update-drift check
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <7d4b3895-4b1b-eabe-e09a-eccb5b8b8fb9@gmx.com>
Date: Sun, 18 Jun 2017 20:47:24 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Only allow --update-drift for --set or --systohc

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 3 +--
 sys-utils/hwclock.c    | 7 ++++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index cf33e63..72b842e 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -376,9 +376,8 @@ in learning about the internal operations of hwclock.
 .B \-\-update\-drift
 Update the Hardware Clock's drift factor in
 .IR @ADJTIME_PATH@ .
-It is used with
+It can only be used with
 .BR \-\-set " or " \%\-\-systohc ,
-otherwise it is ignored.
 .sp
 A minimum four hour period between settings is required.  This is to
 avoid invalid calculations.  The longer the period, the more precise the
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 5868ad6..7d69b7a 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1233,7 +1233,7 @@ usage(const struct hwclock_control *ctl, FILE *out)
 #if defined(__linux__) && defined(__alpha__)
 	fputs(_("     --epoch <year>   epoch input for --setepoch\n"), out);
 #endif
-	fputs(_("     --update-drift   update drift factor (requires --set or --systohc)\n"), out);
+	fputs(_("     --update-drift   update the RTC drift factor\n"), out);
 	fprintf(out, _(
 		"     --noadjfile      do not use %1$s\n"
 		"     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
@@ -1465,6 +1465,11 @@ int main(int argc, char **argv)
 	if (!ctl.adj_file_name)
 		ctl.adj_file_name = _PATH_ADJTIME;
 
+	if (ctl.update && !ctl.set && !ctl.systohc) {
+		warnx(_("--update-drift requires --set or --systohc"));
+		hwclock_exit(&ctl, EX_USAGE);
+	}
+
 	if (ctl.noadjfile && !ctl.utc && !ctl.local_opt) {
 		warnx(_("With --noadjfile, you must specify "
 			"either --utc or --localtime"));
