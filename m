Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.10]:58195 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbcGNT2p (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Jul 2016 15:28:45 -0400
Date: Thu, 14 Jul 2016 21:28:34 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH] Fix previously adjusted segfault patch
Message-ID: <20160714192834.GA3861@localhost>
References: <20160710141407.GA26802@localhost>
 <20160714101215.ckr3tl22fmpcumwa@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160714101215.ckr3tl22fmpcumwa@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Casting the value to be checked to size_t renders the check useless.
If st_size is SIZE_MAX+1, it will be truncated to 0 and the check
succeeds. In fact, this check can never be false because every value
stored in a size_t is smaller or equal to SIZE_MAX.

I think this adjustment was meant to fix a compiler warning for 64 bit
systems for which sizeof(off_t) is sizeof(size_t), but the signedness
differs. One possibility is to do a "binary and" operation with the
value SIZE_MAX. If the original value and the and-operated value differ,
it means that a higher bit was set and therefore the file was too large.

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 text-utils/tailf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index 6219aa2..5ddbee9 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -284,7 +284,7 @@ int main(int argc, char **argv)
 		errx(EXIT_FAILURE, _("%s: is not a file"), filename);
 
 	/* mmap is based on size_t */
-	if (st.st_size && (size_t) st.st_size <= SIZE_MAX)
+	if (st.st_size && st.st_size == (st.st_size & SIZE_MAX))
 		tailf(filename, lines, &st);
 
 #ifdef HAVE_INOTIFY_INIT
-- 
2.9.0

