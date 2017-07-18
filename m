Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:64201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbdGRUCN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Jul 2017 16:02:13 -0400
Subject: [PATCH 2/2] hwclock: fix regression from c3ae785
To: Karel Zak <kzak@redhat.com>
References: <b8d24f10-1bea-aa80-0a28-9f573dd81d2a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <13448500-dbe1-b7f8-3514-651d448f00d1@gmx.com>
Date: Tue, 18 Jul 2017 16:01:57 -0400
MIME-Version: 1.0
In-Reply-To: <b8d24f10-1bea-aa80-0a28-9f573dd81d2a@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


hwclock --get foobar
hwclock: 3 too many arguments given

Fixed:

hwclock --get foobar
hwclock: 1 too many arguments given

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 9745158..9b313cf 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1448,9 +1448,10 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (argc > optind) {
+	argc -= optind;
+	if (argc > 0) {
 		warnx(_("%d too many arguments given"), argc);
-		errtryhelp(EXIT_FAILURE);
+		errtryhelp(EX_USAGE);
 	}
 
 	if (!ctl.adj_file_name)
