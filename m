Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:59734 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932199AbcCKWDu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Mar 2016 17:03:50 -0500
From: Richard Yao <ryao@gentoo.org>
To: util-linux@vger.kernel.org
Cc: Richard Yao <ryao@gentoo.org>
Subject: [PATCH] docs: swapon.8 fix discard=pages
Date: Fri, 11 Mar 2016 17:03:27 -0500
Message-Id: <1457733807-65369-1-git-send-email-ryao@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The documentation for discard=pages is ambiguous in that it could be
interpreted to mean either that the pages are discarded immediately
after being freed or that the pages are discarded immediately before
being reused by a write. Both implementations would satisfy the
statement "discard freed swap pages before they are avaliable for
reuse", but the kernel does the former.

Doing a discard operation (which is non-queued on SATA drives before
SATA 3.1) before a write operation to the same sector is pointless
unless using, pre-SATA 3.1 drives, where discard is detrimental because
ATA TRIM is a non-queued command.

Anyone who wants discard operations on swap and interprets the man page
as describing the incorrect behavior would opt for discard=once over
discard, when discard provides the behavior of both discard=once and
discard=pages, which is what they likely want.

Lets make a small change to the documentation to clarify the behavior.

Signed-off-by: Richard Yao <ryao@gentoo.org>
---
 sys-utils/swapon.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index 299da22..9abb1b3 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -87,7 +87,7 @@ available swap discard policies:
 to perform a single-time discard operation for the whole swap area at swapon;
 or
 .BI \-\-discard=pages
-to discard freed swap pages before they are reused, while swapping.
+to asynchronously discard freed swap pages before they are avaliable for reuse.
 If no policy is selected, the default behavior is to enable both discard types.
 The
 .I /etc/fstab
-- 
2.4.10

