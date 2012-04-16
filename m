Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:47172 "EHLO
	homiemail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752011Ab2DPJol (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Apr 2012 05:44:41 -0400
Subject: [PATCH 2/8] fdisk: standarize version output
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Apr 2012 11:44:36 +0200
Message-ID: <1334569476.2552.11.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 0ccabb7..0954028 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2960,8 +2960,8 @@ main(int argc, char **argv) {
 			break;
 		case 'V':
 		case 'v':
-			printf("fdisk (%s)\n", PACKAGE_STRING);
-			exit(0);
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
 		default:
 			usage(stderr);
 		}
-- 
1.7.4.1




