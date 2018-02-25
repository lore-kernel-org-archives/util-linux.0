Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.75]:46265 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeBYT1V (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 25 Feb 2018 14:27:21 -0500
Received: from localhost ([93.225.50.2]) by mrelayeu.kundenserver.de (mreue103
 [212.227.15.145]) with ESMTPSA (Nemesis) id 0M5IbP-1eWiVs2S23-00zYiA for
 <util-linux@vger.kernel.org>; Sun, 25 Feb 2018 20:27:19 +0100
Date: Sun, 25 Feb 2018 20:27:18 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] fincore: Handle large files correctly on 32 bit
Message-ID: <20180225192717.GA5871@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If a file is larger than 4 GB on a 32 bit system with large file
support (default), it can happen that not all pages are properly
processed. This happens due to an int truncation (off_t vs size_t).

You can reproduce this on 32 bit with these commands:

$ dd if=/dev/zero of=4gb-file seek=4294967295 count=1 bs=1
$ fincore 4gb-file
fincore: failed to do mmap: 4gb-file: Invalid argument

If a file is larger than 4 GB, the first few pages of a file won't
be properly processed. "len" will be smaller than window_size,
but the for-loop iterates "window_size" bytes, skipping some pages.

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 misc-utils/fincore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/fincore.c b/misc-utils/fincore.c
index 4641408f8..ab11594cc 100644
--- a/misc-utils/fincore.c
+++ b/misc-utils/fincore.c
@@ -199,11 +199,11 @@ static int fincore_fd (struct fincore_control *ctl,
 	int warned_once = 0;
 
 	for (file_offset = 0; file_offset < file_size; file_offset += window_size) {
-		size_t len;
+		off_t len;
 		void  *window = NULL;
 
 		len = file_size - file_offset;
-		if (len >= window_size)
+		if (len >= (off_t) window_size)
 			len = window_size;
 
 		window = mmap(window, len, PROT_NONE, MAP_PRIVATE, fd, file_offset);
-- 
2.16.2

