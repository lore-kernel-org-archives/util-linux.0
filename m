Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:52615 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752346AbaJ0VSW (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Oct 2014 17:18:22 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] textual: slice up the usage text of swapon for ease of translation
Date: Mon, 27 Oct 2014 22:18:12 +0100
Message-Id: <1414444693-16407-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

A new option was added recently; seize this opportunity to cut the
usage text into small and easily managed chunks.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/swapon.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 8609ea2..f66461e 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -728,18 +728,18 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out, _(" %s [options] [<spec>]\n"), program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -a, --all                enable all swaps from /etc/fstab\n"
-		" -d, --discard[=<policy>] enable swap discards, if supported by device\n"
-		" -e, --ifexists           silently skip devices that do not exist\n"
-		" -f, --fixpgsz            reinitialize the swap space if necessary\n"
-		" -o, --options <list>     comma-separated list of swap options\n"
-		" -p, --priority <prio>    specify the priority of the swap device\n"
-		" -s, --summary            display summary about used swap devices (DEPRECATED)\n"
-		"     --show[=<columns>]   display summary in definable table\n"
-		"     --noheadings         don't print headings, use with --show\n"
-		"     --raw                use the raw output format, use with --show\n"
-		"     --bytes              display swap size in bytes in --show output\n"
-		" -v, --verbose            verbose mode\n"), out);
+	fputs(_(" -a, --all                enable all swaps from /etc/fstab\n"), out);
+	fputs(_(" -d, --discard[=<policy>] enable swap discards, if supported by device\n"), out);
+	fputs(_(" -e, --ifexists           silently skip devices that do not exist\n"), out);
+	fputs(_(" -f, --fixpgsz            reinitialize the swap space if necessary\n"), out);
+	fputs(_(" -o, --options <list>     comma-separated list of swap options\n"), out);
+	fputs(_(" -p, --priority <prio>    specify the priority of the swap device\n"), out);
+	fputs(_(" -s, --summary            display summary about used swap devices (DEPRECATED)\n"), out);
+	fputs(_("     --show[=<columns>]   display summary in definable table\n"), out);
+	fputs(_("     --noheadings         don't print table heading (with --show)\n"), out);
+	fputs(_("     --raw                use the raw output format (with --show)\n"), out);
+	fputs(_("     --bytes              display swap size in bytes in --show output\n"), out);
+	fputs(_(" -v, --verbose            verbose mode\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
-- 
1.7.0.4

