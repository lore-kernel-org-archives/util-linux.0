Return-Path: davidlohr@hp.com
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 10/13] sfdisk: update [embarrassingly] old man-page
Date: Tue, 22 Jul 2014 16:44:54 -0700
Message-Id: <1406072697-20912-11-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
List-ID: <util-linux.vger.kernel.org>

... sheeeeesh. A little dignity, please.

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 disk-utils/sfdisk.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 1e84a11..d9d9b3e 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -402,7 +402,7 @@ that are going to be overwritten to
 .I file
 (where hopefully
 .I file
-resides on another block device, or on a floppy).
+resides on another block device).
 .TP
 .BI \-I " file"
 After destroying your filesystems with an unfortunate
-- 
1.8.1.4
