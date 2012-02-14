Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaid.dreamhost.com ([208.97.132.83]:48377 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759682Ab2BNLN1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Feb 2012 06:13:27 -0500
Subject: [PATCH 4/4] mkfs.bfs: add setlocale
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Feb 2012 12:13:19 +0100
Message-ID: <1329217999.3269.8.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/mkfs.bfs.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
index cbb09e0..6e5f012 100644
--- a/disk-utils/mkfs.bfs.c
+++ b/disk-utils/mkfs.bfs.c
@@ -115,6 +115,10 @@ int main(int argc, char **argv)
 		{NULL, 0, NULL, 0}
 	};
 
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
 	if (argc < 2)
 		usage(stderr);
 
-- 
1.7.4.1






