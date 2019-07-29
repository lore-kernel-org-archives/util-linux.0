Return-Path: <SRS0=n+tz=V2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6610BC7618F
	for <util-linux@archiver.kernel.org>; Mon, 29 Jul 2019 01:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308812070B
	for <util-linux@archiver.kernel.org>; Mon, 29 Jul 2019 01:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoc5TEUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfG2BYw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 28 Jul 2019 21:24:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32815 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfG2BYw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 28 Jul 2019 21:24:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so26766756plo.0
        for <util-linux@vger.kernel.org>; Sun, 28 Jul 2019 18:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GVcZynWgN3NQI/FBXUJ2NsDWXcspFAcaTpyEnt1fYGw=;
        b=hoc5TEUxvMa+F0f3RPrwr5vqV8Q3/ex5nEEJkY+XD63qfjdCc+sXkBMS0H+kNZWxYq
         gD6oTXuLWIv8BjH4mAdBjKavuSu5iK60mITbevNdXR0CXyZDssYuPtEklLlq5EOQu+5X
         We7pfi4IRjXN9Cs2FxmA/d01hLcbg9Fz+e6M3HaJpgYCXptagbe8E63J22nDeqAMUmd9
         /CbmXU4PFcqHlEc/LmU5YeMyPIXsn9BAgI9ngiVTG6C/MAGJuyyCggem221fSJhuyh7l
         uMU00uq8umhvpiGaE6O5iPdJ87FeqgiFccMsR1zvsnG0luRXt6DyxrNnE8VM7RjIDS/q
         vFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GVcZynWgN3NQI/FBXUJ2NsDWXcspFAcaTpyEnt1fYGw=;
        b=eP+8BbjB4NnSRRlQzHXdAIALwpmS7q/aZasMDyvtNmpNR8+cz8NqWg+da35WokVh1x
         YUVyLXBllyi88aXX9UV9gI08uJVGqBqpiQ4JEIKAccqyr6ykVWgcPe89KUf+B5q8yLpq
         NCTf7XlguaB94Lzw7EiiyHSzz+ZL7VdDTdWY3pH4S1JSrkr2n42SgXVK1b7h3bxApK1V
         I0wSH6pcopJ/UhQjoOHsb59EyE9n/8YIKSzJHYZ2T2rguGocVWSmYut/xOcZlUfW+6ER
         XAiEQB/JH4AG14pAffd7DZm8VTpEV9HLUBIsxtchqKHfrnbckaU5L0nUa8ulizwd4PEj
         4hig==
X-Gm-Message-State: APjAAAXZ5QjoQOdAhttgAKowWnriFxR5pAiadQ6zX5ZeOklLXFdi7WOa
        npwC2FWIbm7GGkdsUIv8y/E=
X-Google-Smtp-Source: APXvYqwc+C5tS10J59AfnGBxPjt5i6lsvgAwSq77/tl7mX+AYPiYTvuFFTjp448mpxyLpxt6NCcdsw==
X-Received: by 2002:a17:902:f301:: with SMTP id gb1mr105781966plb.292.1564363491705;
        Sun, 28 Jul 2019 18:24:51 -0700 (PDT)
Received: from titan.hq.cloud.yunionyun.com ([47.244.19.249])
        by smtp.gmail.com with ESMTPSA id u6sm52164458pjx.23.2019.07.28.18.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 18:24:50 -0700 (PDT)
From:   Yousong Zhou <yszhou4tech@gmail.com>
X-Google-Original-From: Yousong Zhou <zhouyousong@yunionyun.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org,
        Yousong Zhou <zhouyousong@yunionyun.com>,
        Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH v2] column: fix outputing empty column at the end of line
Date:   Mon, 29 Jul 2019 01:24:29 +0000
Message-Id: <20190729012429.55953-1-zhouyousong@yunionyun.com>
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
Reviewed-by: Sami Kerola <kerolasa@iki.fi>
---
v2 <- v1 Simplify the patch as suggested by @kerolaso.  It seems that
only local_wcstok() needs to be changed.

 tests/expected/column/table-empty-column-at-eol  | 1 +
 tests/expected/column/table-empty-column-at-eol2 | 1 +
 tests/ts/column/table                            | 8 ++++++++
 text-utils/column.c                              | 2 +-
 4 files changed, 11 insertions(+), 1 deletion(-)
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
index 13b39537e..9d56e514c 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -169,7 +169,7 @@ static wchar_t *local_wcstok(wchar_t *p, const wchar_t *separator, int greedy, w
 		return strtok_r(p, separator, state);
 #endif
 	if (!p) {
-		if (!*state || !**state)
+		if (!*state)
 			return NULL;
 		p = *state;
 	}
