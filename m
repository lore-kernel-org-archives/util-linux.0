Return-Path: <SRS0=LABb=AE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F748C433E0
	for <util-linux@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573DC20723
	for <util-linux@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbgFWO4o convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:56:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58950 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732853AbgFWO4n (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 Jun 2020 10:56:43 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-sT7fJIXrNDieAoZXiZIkHA-1; Tue, 23 Jun 2020 10:56:37 -0400
X-MC-Unique: sT7fJIXrNDieAoZXiZIkHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 973228018A5;
        Tue, 23 Jun 2020 14:56:36 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67BA75BAE5;
        Tue, 23 Jun 2020 14:56:35 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Karel Zak <kzak@redhat.com>, "Dmitry V. Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: [PATCH 1/2] setarch: make verify_arch_domain extendable
Date:   Tue, 23 Jun 2020 16:56:19 +0200
Message-Id: <20200623145620.2669920-2-gladkov.alexey@gmail.com>
In-Reply-To: <20200623145620.2669920-1-gladkov.alexey@gmail.com>
References: <20200623145620.2669920-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gladkov.alexey@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

When other compatible architectures are introduced, they will also have
to be added to the verifier.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 sys-utils/setarch.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index cb4b08157..b057b4df8 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -254,22 +254,29 @@ static struct arch_domain *get_arch_domain(struct arch_domain *doms, const char
 	return !d || d->perval < 0 ? NULL : d;
 }
 
-static void verify_arch_domain(struct arch_domain *dom, const char *wanted)
+static void verify_arch_domain(struct arch_domain *doms, struct arch_domain *target, const char *wanted)
 {
 	struct utsname un;
 
-	if (!dom || !dom->result_arch)
+	if (!doms || !target || !target->result_arch)
 		return;
 
 	uname(&un);
-	if (strcmp(un.machine, dom->result_arch) != 0) {
-		if (strcmp(dom->result_arch, "i386") != 0
-		    || (strcmp(un.machine, "i486") != 0
-			&& strcmp(un.machine, "i586")
-			&& strcmp(un.machine, "i686") != 0
-			&& strcmp(un.machine, "athlon") != 0))
-			errx(EXIT_FAILURE, _("Kernel cannot set architecture to %s"), wanted);
+
+	if (!strcmp(un.machine, target->result_arch))
+		return;
+
+	if (!strcmp(target->result_arch, "i386")) {
+		struct arch_domain *dom;
+		for (dom = doms; dom->target_arch != NULL; dom++) {
+			if (!dom->result_arch || strcmp(dom->result_arch, target->result_arch))
+				continue;
+			if (!strcmp(dom->target_arch, un.machine))
+				return;
+		}
 	}
+
+	errx(EXIT_FAILURE, _("Kernel cannot set architecture to %s"), wanted);
 }
 
 int main(int argc, char *argv[])
@@ -279,7 +286,7 @@ int main(int argc, char *argv[])
 	int verbose = 0;
 	int archwrapper;
 	int c;
-	struct arch_domain *doms, *target = NULL;
+	struct arch_domain *doms = NULL, *target = NULL;
 	unsigned long pers_value = 0;
 	char *shell = NULL, *shell_arg = NULL;
 
@@ -434,7 +441,7 @@ set_arch:
 
 	/* make sure architecture is set as expected */
 	if (arch)
-		verify_arch_domain(target, arch);
+		verify_arch_domain(doms, target, arch);
 
 	if (!argc) {
 		shell = "/bin/sh";
-- 
2.25.4

