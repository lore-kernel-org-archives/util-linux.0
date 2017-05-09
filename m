Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36471 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbdEISK6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 9 May 2017 14:10:58 -0400
Received: by mail-wr0-f194.google.com with SMTP id v42so2127724wrc.3
        for <util-linux@vger.kernel.org>; Tue, 09 May 2017 11:10:58 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/5] col: avoid extra newline if no input
Date: Tue,  9 May 2017 19:10:49 +0100
Message-Id: <20170509181052.3610-2-kerolasa@iki.fi>
In-Reply-To: <20170509181052.3610-1-kerolasa@iki.fi>
References: <20170509181052.3610-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

BSD fix missed for 22 years, and all util-linux releases so far.

Backported-from: https://github.com/dspinellis/unix-history-repo/commit/2a15260a2a3230e02f57c096fb4c5e1f797bf4f3
Addresses: https://github.com/karelzak/util-linux/issues/422
Reported-by: Pavel Raiskup <praiskup@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/col.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/text-utils/col.c b/text-utils/col.c
index b236b891f..bac48e7e3 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -391,6 +391,8 @@ int main(int argc, char **argv)
 	/* goto the last line that had a character on it */
 	for (; l->l_next; l = l->l_next)
 		this_line++;
+	if (max_line == 0)
+		return EXIT_SUCCESS;	/* no lines, so just exit */
 	flush_lines(this_line - nflushd_lines + extra_lines + 1);
 
 	/* make sure we leave things in a sane state */
-- 
2.12.2

