Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB12C5519F
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9F62236F
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmcHd9yZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgKTFGc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 20 Nov 2020 00:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgKTFGc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 20 Nov 2020 00:06:32 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11BEC0613CF
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:30 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x18so7514308ilq.4
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0D3lvSQCifRKYyos9GODnI8aeHLvbCsRXnlRXoSbPI4=;
        b=FmcHd9yZlYjjzTzc+Z3fgwT6yBBqpE2UfgZQFqTWn56hDffjs6cH5sFoyoAM1eCBrI
         jIdCKqXnfG3H8uuDmdGTZnfV9/rDxexSJeGvz/iMrk9EJCdXyM1uMLxe1M1BjbkY1am+
         3uwzggGqlXB0FB35XlwvNtJDMWEBu6St4olxAgmyD4PvwAtMYSmQPpOxHGRsUA4oddTK
         NoGRRI6cDsiUAH6Gy+k+8HuLw+lYW7E4UoLLZlbVtIKfD4w+7tz5YfgwsU67Su2LujiN
         DyhEmnMCdSb0VUq8Zng6AN2U4xM/IG8RQfdryOxw+0bxs8wQZeAe7auQeujsEfU4CKy8
         MbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0D3lvSQCifRKYyos9GODnI8aeHLvbCsRXnlRXoSbPI4=;
        b=hBRZH5/2MbxXBuxIDL1DIAdZDoO/e1CTwU+i6Di8AjTQS9kti+OSDH98KH+l9zBS2A
         pVEcbWJB+jkNJhcefLzggAOy5/U3HbAw+uWqOHIdwxxIsrIK6Whqhoc6qdQNeCLHdea/
         v5DTFrDu5NHPsRCdkVho5kpP5PutAc1Zqx22WL29XdGoyton7sONnwaOW4MwM2xRqUEU
         zp4IMRvsziP0wGfAPoMZCoOFgyfvn03nW6FNTG3Az9mtoEq5vqgqMfl8nw0c2SWj8Exs
         nHZ+irotMj9eqvSNtOHcIXdU+u/Gd0oBDtbLRcEd/UXgW1lLDUiXo3xNWjYEz85v4we3
         bFAw==
X-Gm-Message-State: AOAM532mhhBtxqtTjXp5xscuWs+L3N+igchwUTQDRU3vBWd0Wx8xTDN0
        pUreEtfbemWKBiVeDB57pnw8zdAnDQ==
X-Google-Smtp-Source: ABdhPJyFDn4KpcSrXxeyY3JuijwrXpkl/3KxKDgejw0VWqt5xw74dlw1cTMUMXR9gW71dWPefWtSEg==
X-Received: by 2002:a05:6e02:be9:: with SMTP id d9mr1869251ilu.134.1605848789971;
        Thu, 19 Nov 2020 21:06:29 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id o3sm1039050ilk.27.2020.11.19.21.06.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 21:06:29 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v3 5/5] lscpu: show the number of physical socket on aarch64 machine without ACPI PPTT
Date:   Fri, 20 Nov 2020 00:06:09 -0500
Message-Id: <20201120050609.17409-6-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120050609.17409-1-msys.mizuma@gmail.com>
References: <20201120050609.17409-1-msys.mizuma@gmail.com>
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
index 9391cca54..9e259673c 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -360,6 +360,8 @@ static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 
 	arm_ids_decode(ct);
 	arm_rXpY_decode(ct);
+	if (cxt->is_cluster)
+		ct->nr_socket_on_cluster = get_number_of_physical_sockets_from_dmi();
 }
 
 static int lscpu_is_cluster_arm(struct lscpu_cxt *cxt)
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index b9b8940a8..85d1d0acb 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -862,10 +862,15 @@ print_summary_cputype(struct lscpu_cxt *cxt,
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
index 74c647e3a..623c07998 100644
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

