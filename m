Return-Path: <SRS0=Tf+r=CU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7F4C2BC11
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 16:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268C4221E7
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 16:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDKsmsHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgIKQp2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIKPIN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 11 Sep 2020 11:08:13 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5291C0617BA
        for <util-linux@vger.kernel.org>; Fri, 11 Sep 2020 06:54:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h6so7853134qtd.6
        for <util-linux@vger.kernel.org>; Fri, 11 Sep 2020 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5ZWCRaJisnTMRBRzViN8OD6b63f0Vx1a09H7IQ4Sac=;
        b=ZDKsmsHlMO6z3fCihYb2NWLSZ4EQ4fKw7c29JSzm4J09bC4wTyVWbWh2Gk3B7SqD//
         dOWSQSBdQCThwwDlsgiE6ipyfMP2k1ne+qT28Cdz2THmCbUei6th5dStg2vTm+z1Kmnc
         DTiCbX1tjkNTLiOXMflUmudN4BZ+WYEgNMTUR4j5C2G3jjcbXKabGKWqwtaypGIXnZ9E
         MRTed2IUlOCfRuhIiwCVAccO+wrNz4pgaS/eLK3N2fsnVaFj6e2EkKtFtMF2LntPB3s7
         PSs8SNN4xze1xoSXvEeZRl/ruQ6+ExPa7FA7lwy/ajRdn3EhOG2xr5teVTgRndzLpSjV
         iEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5ZWCRaJisnTMRBRzViN8OD6b63f0Vx1a09H7IQ4Sac=;
        b=ls4J9xurrFKlyMDJCnPPo2BsBsgVsTmpK091baB6E5f3i5JQuyZ17f1koLMXrRwKby
         exbpg79DKU/9ROVbk6x1seOx8J8b1BNBG5sIqdtJgvp9Tba2qKwU8auoXlWTzQ4OFWq8
         EXCp3kfsFwYyD8hdEMS2GcllWlTkr7o53DDa1EP14FFuSN6w3KIsChUMg4uO5HXYfjuc
         3tVk00B9AykG7QVSCVp+XoJMbveCXc0z1vX5PKVO5nMn8hmNDHSzcXqRp//C2V25XaYG
         2UtBeQqXd+GmerlpVHdiOtW12sEHP2nICyQFanrUU+U8TQuZkxhUR0ROPZvuqLM9XO+r
         e5bg==
X-Gm-Message-State: AOAM531Z1CQoq5XneY6ZrNWaK/LCZcq+zlvdoiZlwEDZ01ViDRsv5/Ue
        v9tRUoKmT9EQIcxWCoGrHlgABhibVQ==
X-Google-Smtp-Source: ABdhPJy9rwH8Je40XAkwheFK9tZdRQWgHhqKgpN6LuXWTbxtEvoUvApZ7NfdOUhkHf3ihWbvEfxPbQ==
X-Received: by 2002:ac8:44b5:: with SMTP id a21mr1968955qto.36.1599832440887;
        Fri, 11 Sep 2020 06:54:00 -0700 (PDT)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id g8sm2841124qkl.28.2020.09.11.06.54.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:54:00 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 4/4] lscpu: show physical socket on aarch64 without ACPI PPTT
Date:   Fri, 11 Sep 2020 09:53:28 -0400
Message-Id: <20200911135328.1465-5-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911135328.1465-1-msys.mizuma@gmail.com>
References: <20200911135328.1465-1-msys.mizuma@gmail.com>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Show the number of physical socket even if the sysfs doesn't have
the physical socket information.
Note, lscpu cannot show the number of socket info for unprivileged
users because it needs to access the DMI table.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 8c823c170..3e7da2eac 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -2182,9 +2182,15 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 				add_summary_n(tb, _("Book(s):"), books_per_drawer ?: desc->nbooks);
 			}
 		} else {
-			if (is_cluster)
+			if (is_cluster) {
+				int sockets = get_number_of_physical_sockets_from_dmi();
+
+				if (sockets > 0)
+					add_summary_n(tb, _("Socket(s):"), sockets);
+				else
+					add_summary_s(tb, _("Socket(s):"), "-");
 				add_summary_n(tb, _("Cluster(s):"), desc->nsockets);
-			else
+			} else
 				add_summary_n(tb, _("Socket(s):"),
 						sockets_per_book ?: desc->nsockets);
 		}
-- 
2.27.0

