Return-Path: <SRS0=QC14=C5=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60597C43463
	for <util-linux@archiver.kernel.org>; Sun, 20 Sep 2020 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF97220EDD
	for <util-linux@archiver.kernel.org>; Sun, 20 Sep 2020 13:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QwwRdM6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgITNQw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 20 Sep 2020 09:16:52 -0400
Received: from mout.web.de ([212.227.17.12]:51101 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgITNQv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 20 Sep 2020 09:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600607810;
        bh=EwLSluInDPXXzquUp9uhZUOHtbZacFOaIzOhkFAfdQU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QwwRdM6ejUqhn3FmsjiYHkWWQ526kCU0dt7mpDznj1G5DN0FI5ydlaRI9cmYhfLvq
         F/Fad8jS1g/gAz+asCW34An+F1pDaI9OhOqsM44Nf/CF4Dx+BS2jnVgEPrN6sZ+aGS
         MxYOPUs4o0ig6EKpuITkPdwMMauO6/5FQzE6nNKE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from archbook.fritz.box ([92.252.29.128]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgOCo-1k532Y1gZy-00NiEd; Sun, 20
 Sep 2020 15:11:48 +0200
From:   Lennard Hofmann <lennard.hofmann@web.de>
To:     util-linux@vger.kernel.org
Cc:     Lennard Hofmann <lennard.hofmann@web.de>
Subject: [PATCH 4/4] tests: column --keep-empty-lines in cols mode
Date:   Sun, 20 Sep 2020 15:08:20 +0200
Message-Id: <20200920130818.29756-3-lennard.hofmann@web.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920130818.29756-1-lennard.hofmann@web.de>
References: <20200920130818.29756-1-lennard.hofmann@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bwf1ykXtdthjYno6Y2P+xOHr4Ta9NMQqciGrvnk7LiVQWYSfAzo
 AbZNhdfSaq/CEaiuCk/DrGeBR06/cYeX6kTOzhxWMRI3bu0FzrNHRf+2RyFksdjacBCEqt8
 Jo0ASy4ZRN2NQrI2K0t9rs1JZD2mxfGrD2nlBAiEQUrtss1arz0L26bbK0N0IuedFgpDxmZ
 LieSzaAhG30t0Zbbi03aA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jkmObHVQVj4=:nLSABpq2/Q8Ls8vpuwfxAh
 Tft7P4c75txUO49WRpNjoX8H5DH71Ay3TrR3+zxoGWY/t6zGHtSCyyaSTCds9uhVx+J1u18AT
 ELfFVsy67jU7ClXWxqQcR1/aBsI1LKP9sovm6hhl8f0YlXHzqNaR1ikCrCxG+UqHMl4z9ecSu
 9tiL5fqYt0DqQql57UW2sXM9ydPg4SvJRC/K00qVgrzc9AOJiVhV/QZ073d1hY34l7w17d9T3
 zZdPZraFN/pLdYvOxkVasBwh2w5Ce62I8mZFrneH3xYUkScRjb13bat6V1hO23QKhh66DuB6L
 EY0jycNcZQ2/Y5iZCGW5OJia5B8ue8/Ur096WdgQbb5L2d8+V3BNquypWsN1Efxilvj5BRZFd
 ahNM8PcD4LYBOFEXPO2ihSxVgyDCtQuIohcKcMAUJQ5O5xIXmOPWd9KI36xwhYcSowmbWYIqd
 P4jeaGFiqQIfWgV3e4Q34BCsYsZqO7OwsEb22wVfEccB91IMDq7rTSDOAbssDb0gd8Evt8cF4
 wLM8NeQuPalGcMCT3t7qqw7+fVvwOuoqPtf5nSzeaymRGSD0VxZLn45DkPUiBNC8kv8pvs/xD
 sbo3K3+aSX13H0cqKHemmtcJ4ekPObG7R0JszVw48tDEoE625QJHveyEsJC5RbIjXwDeIdSLR
 EKfi3EQpvDDqgmmdxULno7IIBWC0EgVN/DeIhO3msMpERWnhPtHhh6DVJeOLzgVF2vHgR2UBY
 aaPj8IlWimi67y+JnSOjQKAVGEZl8kLGbhjmPG0UUx0vNzv43L8IavVf8pAB03pMcyqKIKnMM
 ZO+qtTNXXVPDEypsokX+ubVvhx0oT7wiwi6PcTyvYStSilCUG5AWIXJhmS2kZNyiFWbqE3nYz
 JD4qM0PjsqLBSlUfLYp/+8XsEtACI/eXEvEWzmGbfTii8xytqBxEMLW/e8t2OT0E96wru92pP
 4MeDC9LsAHoTPVilYWMTvEd73vfB9wtHCN8WyY0/iOMx6wWJD4MrJZmrc5Is1p9UYDC5q+O2M
 90q6d+o8yFnmbjeCnoeCcjPOmIe3p8PIvYlgquSXNLq0aO9k3druiUkAkq58G7CFv64Qk86by
 Sk53YSITVlz5XMWSfzc4UnjncGuzlTQPWuBEIC1OeVaylJho0SCqT4XLyLgLrzz+TKA7YLh1J
 rohs4f1BIcchxz5UMo34xCqRhfNmUlFq0BzGY/23+MnuCgZRYEKLZ2/kihjJWsr6qliK9Q2c5
 fzBl6Kg57nr6RPF/kuro22tBZY0gI8ZbMkCWwnw==
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add intentional whitespace to the test file `onecolumn` to test that
`column` ignores it. Add empty lines to the same test file to test that
`column--keep-empty-lines` preserves them.

Signed-off-by: Lennard Hofmann <lennard.hofmann@web.de>
=2D--
 tests/expected/column/columnate-fill-cols-keep-empty | 7 +++++++
 tests/ts/column/columnate                            | 4 ++++
 tests/ts/column/files/onecolumn                      | 5 +++++
 3 files changed, 16 insertions(+)
 create mode 100644 tests/expected/column/columnate-fill-cols-keep-empty

diff --git a/tests/expected/column/columnate-fill-cols-keep-empty b/tests/=
expected/column/columnate-fill-cols-keep-empty
new file mode 100644
index 000000000..8cc1fdf1f
=2D-- /dev/null
+++ b/tests/expected/column/columnate-fill-cols-keep-empty
@@ -0,0 +1,7 @@
+			FFFFFFFFFFFFFFFFFFF
+AAAAAAAAAAAAAAAAAAAA
+BBBBBBBBBBBBBBBBBBBBB
+CCCCCCCCCCCCCCCC	XXXXXXX
+			YYYYYYYYYYY
+DDDDDDDDDDDDDDDDD	ZZZZZZZZZZZ
+EEEEEEEEEEEEE
diff --git a/tests/ts/column/columnate b/tests/ts/column/columnate
index ebeb0c44f..e80f3b00d 100755
=2D-- a/tests/ts/column/columnate
+++ b/tests/ts/column/columnate
@@ -49,4 +49,8 @@ ts_init_subtest "fill-rows-250"
 $TS_CMD_COLUMN --fillrows -c 250 $TS_SELF/files/onecolumn >> $TS_OUTPUT 2=
>> $TS_ERRLOG
 ts_finalize_subtest

+ts_init_subtest "fill-cols-keep-empty"
+$TS_CMD_COLUMN --keep-empty-lines -c 60 $TS_SELF/files/onecolumn >> $TS_O=
UTPUT 2>> $TS_ERRLOG
+ts_finalize_subtest
+
 ts_finalize
diff --git a/tests/ts/column/files/onecolumn b/tests/ts/column/files/oneco=
lumn
index 69ec82f5d..3e579e1d4 100644
=2D-- a/tests/ts/column/files/onecolumn
+++ b/tests/ts/column/files/onecolumn
@@ -1,9 +1,14 @@
+
 AAAAAAAAAAAAAAAAAAAA
 BBBBBBBBBBBBBBBBBBBBB
 CCCCCCCCCCCCCCCC
+
 DDDDDDDDDDDDDDDDD
 EEEEEEEEEEEEE
 FFFFFFFFFFFFFFFFFFF
+
+
 XXXXXXX
 YYYYYYYYYYY
 ZZZZZZZZZZZ
+
=2D-
2.28.0

