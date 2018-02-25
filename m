Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.73]:53247 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeBYT2C (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 25 Feb 2018 14:28:02 -0500
Received: from localhost ([93.225.50.2]) by mrelayeu.kundenserver.de (mreue102
 [212.227.15.145]) with ESMTPSA (Nemesis) id 0M8zUb-1f1sTd1ZJF-00CVRq for
 <util-linux@vger.kernel.org>; Sun, 25 Feb 2018 20:28:00 +0100
Date: Sun, 25 Feb 2018 20:27:59 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] fincore: Handle large files on 32 bit without LFS
Message-ID: <20180225192758.GB5871@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If util-linux is installed on a system without large file support,
an out of memory issue can occur while processing a file which is
2 GB in size:

$ ./configure --disable-largefile && make

$ dd if=/dev/zero of=2gb-file seek=2147483646 count=1 bs=1
$ fincore 2gb-file
(endless loop)
fincore: failed to do mmap: 2gb-file: Cannot allocate memory

Even though iterating with "len" seems counter-intuitive, it fixes
this issue. The variable len is only in the last iteration not a
multiplication of pagesize -- which is the requirement for mmap.

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 misc-utils/fincore.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/misc-utils/fincore.c b/misc-utils/fincore.c
index ab11594cc..f9534e85b 100644
--- a/misc-utils/fincore.c
+++ b/misc-utils/fincore.c
@@ -194,12 +194,11 @@ static int fincore_fd (struct fincore_control *ctl,
 		       off_t *count_incore)
 {
 	size_t window_size = N_PAGES_IN_WINDOW * ctl->pagesize;
-	off_t file_offset;
+	off_t file_offset, len;
 	int rc = 0;
 	int warned_once = 0;
 
-	for (file_offset = 0; file_offset < file_size; file_offset += window_size) {
-		off_t len;
+	for (file_offset = 0; file_offset < file_size; file_offset += len) {
 		void  *window = NULL;
 
 		len = file_size - file_offset;
-- 
2.16.2

