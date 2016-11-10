Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34451 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755262AbcKJK77 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 05:59:59 -0500
Received: by mail-wm0-f66.google.com with SMTP id g23so2350469wme.1
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 02:59:59 -0800 (PST)
Subject: [PATCH 09/12] SEE ALSO: add cross reference to namespaces(7)
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <543d6dbe-969f-b140-2274-da5531716e4e@gmail.com>
Date: Thu, 10 Nov 2016 11:59:57 +0100
MIME-Version: 1.0
In-Reply-To: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Rationale: both of these pages are about namespaces.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/nsenter.1 | 3 ++-
 sys-utils/unshare.1 | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index e6969bf..5f850c1 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -181,7 +181,8 @@ Display version information and exit.
 Display help text and exit.
 .SH SEE ALSO
 .BR clone (2),
-.BR setns (2)
+.BR setns (2),
+.BR namespaces (7)
 .SH AUTHORS
 .UR biederm@xmission.com
 Eric Biederman
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index a82ba9c..98a4863 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -188,6 +188,7 @@ makes sure that the bind mount is created on a shared filesystem.
 .SH SEE ALSO
 .BR clone (2),
 .BR unshare (2),
+.BR namespaces (7),
 .BR mount (8)
 .SH AUTHORS
 .UR dottedmag@dottedmag.net
-- 
2.5.5

