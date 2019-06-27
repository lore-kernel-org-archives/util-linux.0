Return-Path: <SRS0=KqhM=U2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9B9C48BD6
	for <util-linux@archiver.kernel.org>; Thu, 27 Jun 2019 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1CE20815
	for <util-linux@archiver.kernel.org>; Thu, 27 Jun 2019 09:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWfF+aZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfF0JWr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:22:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44104 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfF0JWr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 27 Jun 2019 05:22:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so948991plr.11
        for <util-linux@vger.kernel.org>; Thu, 27 Jun 2019 02:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLr1KENoCQKS1R/HnNBCeX3UIUBjJQOiV8pWTXIktAQ=;
        b=aWfF+aZHVT2oVZI5e7zVyjz2VFKidvlKjrrqQyHUxwDdq1nQ7fo/KZE6s4UO06ra4Y
         UEMYJshP1k3QH0K8Wbu/mjr4l6tdmt56P7cFPvBnTcUELxbvJxIjQ1mK2whhIC05aEaL
         R2FbXOoXvEgMDwyzDHEIc7HSFreKGUl+TnmNxPdCmSVzpu8Cf1mBZaHLO+Nz7yUQZMww
         xGFmJ1giNQS8UgyAOjGeh67xjAjcjXfk1bGgY1oW2vNIyxuzcy7TBIXiOK5qmtcIFl7V
         zGXBJxeMRDWLE6IRlle9VxEUzs2yS1HPpzDXKpHbe5n/ITKE0KIHqt+MBgxpe92lztNd
         r1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLr1KENoCQKS1R/HnNBCeX3UIUBjJQOiV8pWTXIktAQ=;
        b=XsySLw/mc6YQV53T26jJ80joRenTVD4JFqSJYrwfhlhN+rZUQ15vVprQEBjt0b5fbX
         fvxKfEvc2gew76is+nHs+PlE4aWMNIHraIWyOYuc5Yqd9LNm4ZgIS4F903BgVIwrQXko
         r2dG4cOpVo7obGkDvK8VgY/t0zR0VY19dy1HyYIVwAXa5p8Q/CSFJL9ltUtvw3v/X/PY
         +I5mkQ8iSWPdvBjaohNPXALe8jMidv6YCJt2JTvzQgKZlMsW/sS0/SmoPOl69LKNWt5Q
         +IeEqYZbEw0+XYpEalfMaFAHf1MxsgcVVgM6n2LnyKDd8I9AGynww5/pcAQSZ4BDMthr
         +0Pg==
X-Gm-Message-State: APjAAAUlB67UHtpj0JB8Jsa3/ez2z86dMKgxYJKgpH22iiOKpZ0iqfHd
        rS7q/J8QXW7YL1lF8IapHog=
X-Google-Smtp-Source: APXvYqwB2pK+DBii/ar6Udi+f5pqv6Xidd1iQ0afaSbSYs4ocH8FxgLK7V8vtIO6d77EFyj55O6JGg==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4mr3514150plb.57.1561627366103;
        Thu, 27 Jun 2019 02:22:46 -0700 (PDT)
Received: from titan.hq.cloud.yunionyun.com (165.116.92.34.bc.googleusercontent.com. [34.92.116.165])
        by smtp.gmail.com with ESMTPSA id h6sm5368244pjs.2.2019.06.27.02.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:22:45 -0700 (PDT)
From:   Yousong Zhou <yszhou4tech@gmail.com>
X-Google-Original-From: Yousong Zhou <zhouyousong@yunionyun.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org,
        Yousong Zhou <zhouyousong@yunionyun.com>
Subject: [PATCH] column: fix outputing empty column at the end of line
Date:   Thu, 27 Jun 2019 09:22:35 +0000
Message-Id: <20190627092235.36888-1-zhouyousong@yunionyun.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The following commands manifests the problem.  In old versions before
commit 4762ae9d60 ("column: use libsmartcols for --table"), both of them
should output with 2 "|"

	echo '||'  | column -o '|' -s '|' -t
	echo '|| ' | column -o '|' -s '|' -t

Fixes: 4762ae9d60 ("column: use libsmartcols for --table")
Signed-off-by: Yousong Zhou <zhouyousong@yunionyun.com>
---
 tests/expected/column/table-empty-column-at-eol  |  1 +
 tests/expected/column/table-empty-column-at-eol2 |  1 +
 tests/ts/column/table                            |  8 ++++++++
 text-utils/column.c                              | 15 ++++++++++-----
 4 files changed, 20 insertions(+), 5 deletions(-)
 create mode 100644 tests/expected/column/table-empty-column-at-eol
 create mode 100644 tests/expected/column/table-empty-column-at-eol2

diff --git a/tests/expected/column/table-empty-column-at-eol b/tests/expected/column/table-empty-column-at-eol
new file mode 100644
index 000000000..948cf947f
--- /dev/null
+++ b/tests/expected/column/table-empty-column-at-eol
@@ -0,0 +1 @@
+|
diff --git a/tests/expected/column/table-empty-column-at-eol2 b/tests/expected/column/table-empty-column-at-eol2
new file mode 100644
index 000000000..7c4378506
--- /dev/null
+++ b/tests/expected/column/table-empty-column-at-eol2
@@ -0,0 +1 @@
+||
diff --git a/tests/ts/column/table b/tests/ts/column/table
index bd1f16f3f..e64dee746 100755
--- a/tests/ts/column/table
+++ b/tests/ts/column/table
@@ -116,4 +116,12 @@ ts_init_subtest "empty-column"
 printf ':a:b\n' | $TS_CMD_COLUMN --table --separator ':' --output-separator  ':' >> $TS_OUTPUT 2>&1
 ts_finalize_subtest
 
+ts_init_subtest "empty-column-at-eol"
+printf '|' | $TS_CMD_COLUMN --separator '|' --output-separator '|' --table >> $TS_OUTPUT 2>&1
+ts_finalize_subtest
+
+ts_init_subtest "empty-column-at-eol2"
+printf '||' | $TS_CMD_COLUMN --separator '|' --output-separator '|' --table >> $TS_OUTPUT 2>&1
+ts_finalize_subtest
+
 ts_finalize
diff --git a/text-utils/column.c b/text-utils/column.c
index 13b39537e..64f1cf7e9 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -169,8 +169,9 @@ static wchar_t *local_wcstok(wchar_t *p, const wchar_t *separator, int greedy, w
 		return strtok_r(p, separator, state);
 #endif
 	if (!p) {
-		if (!*state || !**state)
+		if (!*state) {
 			return NULL;
+		}
 		p = *state;
 	}
 	result = p;
@@ -435,7 +436,7 @@ static int add_line_to_table(struct column_control *ctl, wchar_t *wcs)
 	if (!ctl->tab)
 		init_table(ctl);
 
-	while ((wcdata = local_wcstok(wcs, ctl->input_separator, ctl->greedy, &sv))) {
+	while ((wcdata = local_wcstok(wcs, ctl->input_separator, ctl->greedy, &sv)) || sv) {
 		char *data;
 
 		if (scols_table_get_ncols(ctl->tab) < n + 1) {
@@ -452,9 +453,13 @@ static int add_line_to_table(struct column_control *ctl, wchar_t *wcs)
 				err(EXIT_FAILURE, _("failed to allocate output line"));
 		}
 
-		data = wcs_to_mbs(wcdata);
-		if (!data)
-			err(EXIT_FAILURE, _("failed to allocate output data"));
+		if (wcdata) {
+			data = wcs_to_mbs(wcdata);
+			if (!data)
+				err(EXIT_FAILURE, _("failed to allocate output data"));
+		} else {
+			data = NULL;
+		}
 		if (scols_line_refer_data(ln, n, data))
 			err(EXIT_FAILURE, _("failed to add output data"));
 		n++;
