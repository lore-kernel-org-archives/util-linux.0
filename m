Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34629 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbeDESAR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2018 14:00:17 -0400
Received: by mail-pl0-f66.google.com with SMTP id z5-v6so2069095pln.1
        for <util-linux@vger.kernel.org>; Thu, 05 Apr 2018 11:00:16 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: [PATCH] fstrim: Return EXIT_FAILURE when FTRIM ioctl fails
Date: Thu,  5 Apr 2018 11:00:06 -0700
Message-Id: <20180405180006.213759-1-gwendal@chromium.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

commit 36c370cbf1481aa8724dff8b7b7fec4a8ba9930b add fstrim_filesystem
that return -1 or 1 depending on the FTRIM ioctl failures.
Without this change, main() returns -1 if the fstrim_filesystem()
returns -1.
Returns EXIT_FAILURE in both cases.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 sys-utils/fstrim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index ce52063e1..66b126b9f 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -339,10 +339,10 @@ int main(int argc, char **argv)
 		rc = fstrim_all(&range, verbose);
 	else {
 		rc = fstrim_filesystem(path, &range, verbose);
-		if (rc == 1) {
+		if (rc == 1)
 			warnx(_("%s: the discard operation is not supported"), path);
+		if (rc != 0)
 			rc = EXIT_FAILURE;
-		}
 	}
 
 	return rc;
-- 
2.17.0.484.g0c8726318c-goog

