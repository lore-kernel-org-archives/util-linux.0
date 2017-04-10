Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:60473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753237AbdDJWuj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Apr 2017 18:50:39 -0400
Subject: [PATCH 1/5] hwclock: use errtryhelp()
To: Karel Zak <kzak@redhat.com>
References: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <0e533bfa-d763-a033-a7dc-dc65bd8ff1ff@gmx.com>
Date: Mon, 10 Apr 2017 18:50:28 -0400
MIME-Version: 1.0
In-Reply-To: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* sys-utils/hwclock.c: use errtryhelp() instead of usage().

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 3875bcc..a99eb6d 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1479,9 +1479,9 @@ int main(int argc, char **argv)
 			out_version();
 			return 0;
 		case 'h':			/* --help */
-		case '?':
-		default:
 			usage(&ctl, NULL);
+		default:
+			errtryhelp(EXIT_FAILURE);
 		}
 	}
 
@@ -1497,9 +1497,8 @@ int main(int argc, char **argv)
 	}
 #endif
 	if (argc > 0) {
-		usage(&ctl, _("%s takes no non-option arguments.  "
-			"You supplied %d.\n"), program_invocation_short_name,
-		      argc);
+		warnx(_("%d too many arguments given"), argc);
+		errtryhelp(EXIT_FAILURE);
 	}
 
 	if (!ctl.adj_file_name)
