Return-Path: <SRS0=LABb=AE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F9C433E1
	for <util-linux@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEE820723
	for <util-linux@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbgFWO4p convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:56:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47863 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732853AbgFWO4o (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Jun 2020 10:56:44 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-mvNglOiiPOyJmqc9Z_3LzQ-1; Tue, 23 Jun 2020 10:56:39 -0400
X-MC-Unique: mvNglOiiPOyJmqc9Z_3LzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37FA3A0C0A;
        Tue, 23 Jun 2020 14:56:38 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2AEB78EE1;
        Tue, 23 Jun 2020 14:56:36 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Karel Zak <kzak@redhat.com>, "Dmitry V. Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: [PATCH 2/2] setarch: add arm and aarch64 architectures to transition rules
Date:   Tue, 23 Jun 2020 16:56:20 +0200
Message-Id: <20200623145620.2669920-3-gladkov.alexey@gmail.com>
In-Reply-To: <20200623145620.2669920-1-gladkov.alexey@gmail.com>
References: <20200623145620.2669920-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Since aarch64 kernel can be configured with compat 32-bit support
enabled, extend translation rules in a way similar to x86/x86_64.

Suggested-by: "Dmitry V. Levin" <ldv@altlinux.org>
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 sys-utils/setarch.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index b057b4df8..6914d791b 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -206,6 +206,19 @@ static struct arch_domain *init_arch_domains(void)
 		{PER_LINUX,	"e2k12c",	"e2k"},
 		{PER_LINUX,	"e2k16c",	"e2k"},
 		{PER_LINUX,	"e2k2c3",	"e2k"},
+#endif
+#if defined(__arm__) || defined(__aarch64__)
+# ifdef __BIG_ENDIAN__
+		{PER_LINUX32,	"armv7b",	"arm"},
+		{PER_LINUX32,	"armv8b",	"arm"},
+# else
+		{PER_LINUX32,	"armv7l",	"arm"},
+		{PER_LINUX32,	"armv8l",	"arm"},
+# endif
+		{PER_LINUX32,	"armh",		"arm"},
+		{PER_LINUX32,	"arm",		"arm"},
+		{PER_LINUX,	"arm64",	"aarch64"},
+		{PER_LINUX,	"aarch64",	"aarch64"},
 #endif
 		/* place holder, will be filled up at runtime */
 		{-1,		NULL,		NULL},
@@ -266,7 +279,8 @@ static void verify_arch_domain(struct arch_domain *doms, struct arch_domain *tar
 	if (!strcmp(un.machine, target->result_arch))
 		return;
 
-	if (!strcmp(target->result_arch, "i386")) {
+	if (!strcmp(target->result_arch, "i386") ||
+	    !strcmp(target->result_arch, "arm")) {
 		struct arch_domain *dom;
 		for (dom = doms; dom->target_arch != NULL; dom++) {
 			if (!dom->result_arch || strcmp(dom->result_arch, target->result_arch))
-- 
2.25.4

