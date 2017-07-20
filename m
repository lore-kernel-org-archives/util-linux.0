Return-Path: elseifthen@gmx.com
Subject: [v3 PATCH 2/2] hwclock: fix regression from c3ae785
To: Karel Zak <kzak@redhat.com>
References: <b8d24f10-1bea-aa80-0a28-9f573dd81d2a@gmx.com>
 <13448500-dbe1-b7f8-3514-651d448f00d1@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <d3bba172-f559-2578-e6b9-d38b3680231c@gmx.com>
Date: Wed, 19 Jul 2017 21:14:53 -0400
MIME-Version: 1.0
In-Reply-To: <13448500-dbe1-b7f8-3514-651d448f00d1@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


hwclock --get foo
hwclock: 3 too many arguments given

Fixed:

hwclock --get foo
hwclock: 1 too many arguments given

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 9745158..aadf196 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1444,13 +1444,13 @@ int main(int argc, char **argv)
 		case 'h':			/* --help */
 			usage(&ctl);
 		default:
-			errtryhelp(EXIT_FAILURE);
+			errtryhelp(EX_USAGE);
 		}
 	}
 
-	if (argc > optind) {
+	if (argc -= optind) {
 		warnx(_("%d too many arguments given"), argc);
-		errtryhelp(EXIT_FAILURE);
+		errtryhelp(EX_USAGE);
 	}
 
 	if (!ctl.adj_file_name)
