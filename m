Return-Path: util-linux-owner@vger.kernel.org
Received: from mx.datacom.ind.br ([177.66.5.10]:46484 "EHLO
        mail.datacom.ind.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751501AbdF0RAi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 27 Jun 2017 13:00:38 -0400
From: Carlos Santos <casantos@datacom.ind.br>
To: util-linux@vger.kernel.org
Cc: casantos@datacom.ind.br
Subject: [PATCH] column: fix compilation when libc lacks wide-character support
Date: Tue, 27 Jun 2017 13:50:42 -0300
Message-Id: <1498582242-19840-1-git-send-email-casantos@datacom.ind.br>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit 4762ae9d removed mtsafe_strtok() but left behind calls to wcstok
and wcspbrk. This leads to build failures when libc does not have the
wide-character functions, like some uClibc builds.

Solve the broblem by using strtok_r and strpbrk when HAVE_WIDECHAR is
not defined.

Fixes:
  http://autobuild.buildroot.net/results/fd8a1a8e0cef3aeed9588540e8e663664f6b43aa
  http://autobuild.buildroot.net/results/5ad73ea8b471321988c50d80a5e50d4504151dd6
  http://autobuild.buildroot.net/results/04411b7280dc51ecd51236967981a42352bbeb3e

Signed-off-by: Carlos Santos <casantos@datacom.ind.br>
---
 text-utils/column.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/text-utils/column.c b/text-utils/column.c
index be99f94..fb57b47 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -160,14 +160,22 @@ static wchar_t *local_wcstok(wchar_t *p, const wchar_t *separator, int greedy, w
 	wchar_t *result = NULL;
 
 	if (greedy)
+#ifdef HAVE_WIDECHAR
 		return wcstok(p, separator, state);
+#else
+		return strtok_r(p, separator, state);
+#endif
 	if (!p) {
 		if (!*state || !**state)
 			return NULL;
 		p = *state;
 	}
 	result = p;
+#ifdef HAVE_WIDECHAR
 	p = wcspbrk(result, separator);
+#else
+	p = strpbrk(result, separator);
+#endif
 	if (!p)
 		*state = NULL;
 	else {
-- 
2.7.5

