Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:53602 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692Ab3KBXqH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 2 Nov 2013 19:46:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: util-linux@vger.kernel.org
Cc: jason.cipriani@gmail.com, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] blkdiscard: BLKSSZGET fills in an int, not a uint64
Date: Sat,  2 Nov 2013 19:46:06 -0400
Message-Id: <1383435966-29337-1-git-send-email-tytso@mit.edu>
In-Reply-To: <20131102234451.GA10255@thunk.org>
References: <20131102234451.GA10255@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reported-by: Jason Cipriani <jason.cipriani@gmail.com>
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 sys-utils/blkdiscard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
index af9ed66..2ddcdb1 100644
--- a/sys-utils/blkdiscard.c
+++ b/sys-utils/blkdiscard.c
@@ -70,8 +70,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 int main(int argc, char **argv)
 {
 	char *path;
-	int c, fd, verbose = 0, secure = 0;
-	uint64_t end, blksize, secsize, range[2];
+	int c, fd, verbose = 0, secure = 0, secsize;
+	uint64_t end, blksize, range[2];
 	struct stat sb;
 
 	static const struct option longopts[] = {
-- 
1.7.12.rc0.22.gcdd159b

