Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A4FC63699
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8E22225D
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4pc8lPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKNENc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 23:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgKNENc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 13 Nov 2020 23:13:32 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FB5C0613D1
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:31 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id g19so6075529qvy.2
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=517kMUgcbQg+5jm+gqFkv/SPxquNC+sBNaQnptVK/vA=;
        b=C4pc8lPDCHXRp8Jacib+OMiaBcjjbs+nDUU5+hJY/3iTbO1+AZKhtBn2mK2vBIlZoF
         XhAsgVUX1tzSfIgMWCRnKGH+4Yk5B0tgaHzJKmPuUJqXO/3ZRzI7lqZmSDg8qVYYGYRu
         jcH7b2uf2ZehqBGuorzinigt9GRQtmsC3+HJ0yAk4AcD+uh0zd07cm4l2J+GA0q8ZTZL
         Xq4xf8J9UoBe3gOzoof1ztkT7+q4Q51XGT7v0Q9ZUIYas4tZnrVCYsIbLcgSYS40yM5m
         gw9mA9JkWHaXHtN8McvrLI6dcf8+Ey7gOyMPOc9T6ZI8FF5Dky8Lz+7IcDkCutnV/ZIp
         VNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=517kMUgcbQg+5jm+gqFkv/SPxquNC+sBNaQnptVK/vA=;
        b=fZ8Z/6yvo6cu3KLJjv0Tveh57omci7gKacH07sEZFE75UTH/aZqmX8ovlRhDjvqJFK
         CLa+SoFESOzpq+E1nY6+rNeby85efIVrsO2vHcc3GlG6zM9oiNKoNxmECl2tQGqvaveW
         8bLpcgXaY981DoYMG8V0uYsSrs6Jl75NcbEchR8+cBEaH28drMHTXu/Q8uPRyorQ/UGL
         Sr2Oflm/V6kybmln3K2MiHdinakoD+kirPaNBBXqDCaG98NhGtn2i9SDrTFiNuc4fGAD
         PI4TKveveQxWaKzH18OkDZL7aKRwl2fGvJVUwWnp14CSFOWtGXAbn11JMBxhWmXNLJcp
         8Iwg==
X-Gm-Message-State: AOAM5317Brgda2CrzxjYpfy7S5kfb7M2qfxhwuSPVO1n9PO9N2DjJPeP
        KrR+AQ8fbQgNwDSYQtGRbKOGPB03Sg==
X-Google-Smtp-Source: ABdhPJx9r9aPhygUQaFNiwWRBKTOOoSiRJpru555jBDCtK42WgpVZH0kEpmppBv4hjRVLoh47Dc6UA==
X-Received: by 2002:a0c:99e6:: with SMTP id y38mr5893901qve.28.1605327211147;
        Fri, 13 Nov 2020 20:13:31 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id j124sm8346765qkf.113.2020.11.13.20.13.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 20:13:30 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v2 5/5] lscpu: show the number of physical socket on aarch64 machine without ACPI PPTT
Date:   Fri, 13 Nov 2020 23:12:29 -0500
Message-Id: <20201114041229.26417-6-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201114041229.26417-1-msys.mizuma@gmail.com>
References: <20201114041229.26417-1-msys.mizuma@gmail.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Show the number of the number of physical socket even if the sysfs doesn't
have the physical socket information.

Note, lscpu shows the number of physical socket as 'Socket(s):' only if
root user runs it because accessing the DMI table requires root
privilege.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu-arm.c | 2 ++
 sys-utils/lscpu.c     | 9 +++++++--
 sys-utils/lscpu.h     | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 7ef05e8e7..72c2abf65 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -360,6 +360,8 @@ static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 
 	arm_ids_decode(ct);
 	arm_rXpY_decode(ct);
+	if (cxt->is_cluster)
+		ct->nr_socket_on_cluster = get_number_of_physical_sockets_from_dmi();
 }
 
 int lscpu_is_cluster_arm(struct lscpu_cxt *cxt)
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index c5a4cc984..0c7d86a00 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -868,10 +868,15 @@ print_summary_cputype(struct lscpu_cxt *cxt,
 		} else
 			add_summary_n(tb, sec, _("Book(s):"), ct->nbooks_per_drawer ?: ct->nbooks);
 	} else {
-		if (cxt->is_cluster)
+		if (cxt->is_cluster) {
+			if (ct->nr_socket_on_cluster > 0)
+				add_summary_n(tb, sec, _("Socket(s):"), ct->nr_socket_on_cluster);
+			else
+				add_summary_s(tb, sec, _("Socket(s):"), "-");
+
 			add_summary_n(tb, sec, _("Cluster(s):"),
 					ct->nsockets_per_book ?: ct->nsockets);
-		else
+		} else
 			add_summary_n(tb, sec, _("Socket(s):"),
 					ct->nsockets_per_book ?: ct->nsockets);
 	}
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index d137b94b1..4511c317c 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -101,6 +101,8 @@ struct lscpu_cputype {
 			has_configured : 1,
 			has_polarization : 1,
 			has_addresses : 1;
+
+	size_t nr_socket_on_cluster; /* the number of sockets if the is_cluster is 1 */
 };
 
 /* dispatching modes */
-- 
2.27.0

