Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE647C2B9F4
	for <util-linux@archiver.kernel.org>; Mon, 14 Jun 2021 20:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C9561107
	for <util-linux@archiver.kernel.org>; Mon, 14 Jun 2021 20:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhFNUsH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Jun 2021 16:48:07 -0400
Received: from wforward2-smtp.messagingengine.com ([64.147.123.31]:41071 "EHLO
        wforward2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233151AbhFNUsG (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Jun 2021 16:48:06 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jun 2021 16:48:06 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailforward.west.internal (Postfix) with ESMTP id 64A279CD
        for <util-linux@vger.kernel.org>; Mon, 14 Jun 2021 16:40:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 14 Jun 2021 16:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=InN/eVwlbW17sYYom
        jNPvGxmsiO7R+78F1r0gagOmwY=; b=dQwy+VdnIpXZl3PMW0lFX+Nzb6N11qGNu
        oq3YjcPYOnxaU1Jbh8d9W7o2pNGyoG8IGzu7kb4lb/JPC/S5I2K0nYEqHobViY/v
        D15b9KueNYZZ1IiCpSPTvCmMCYOjC+W0e3TH8rQDpPzyuelAw5JRz7iBQ1fyBx+K
        ahxpe/5GJlCr3Zm+VDHDnw9yMvxCp7/ISCJoqjZOpNgBmxG6pk32a35wqWG7ihUR
        b6UbT8H6NKW+HMoHEF/ErKcq3nbgSj9wCInGe6E7ZudoioUAwo6h5maaide3sqEU
        DSl1IC+HZtGPTPkBUBT66FMqIn9hXvccd4kDVthg+TQSAw2EWCSMQ==
X-ME-Sender: <xms:yr7HYLiMzm3BZ9sAbauEAbgHwOKGtROsE8MK5sJmkkwkbW1boVrghA>
    <xme:yr7HYIBW9eQZNDg9R3DlmZLqZhXXPLGgIxk0au-V9FiRI2ZF1xtwKrmN3a-kpmzkp
    FB730IL3HYs7Q1b3Q>
X-ME-Received: <xmr:yr7HYLEsjZ2iQQchsHmWIpdRiPCZdCJInFFwVXTHEyeZW4AcB-6zwX4ur90zRtjMNPC65Fb-kV-jKj6tBYj_zw6_qI4nYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvhedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhs
    qeenucggtffrrghtthgvrhhnpeehvdffgffhteeijefgteeftdfghfdvheeuhedvjedugf
    eggfeljefgleefvefgfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehqhihlihhsshesvghvvgdrqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:yr7HYIR5UuGLSCC8uVBwwUgJriLZEdQ44zx1zlnDj70K0VoI1y_Muw>
    <xmx:yr7HYIwZPsN8o94zHQ50j-aq1KRe1es4j-v1dg30chZRIfW4pQR1NQ>
    <xmx:yr7HYO5EW2LChugIhmfNl6MfWdRQWCDoLMGqtXuejg5SHPB0_D76XA>
    <xmx:y77HYFvZnVSrWEGzP2cLCLM6e7xYoLlLeR1pNm7Go29maadYJv7SDuj9u5s>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <util-linux@vger.kernel.org>; Mon, 14 Jun 2021 16:40:42 -0400 (EDT)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 9C42A37; Mon, 14 Jun 2021 20:40:39 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     util-linux@vger.kernel.org
Cc:     Alyssa Ross <hi@alyssa.is>
Subject: [PATCH] libblkid: match uppercase UUIDs
Date:   Mon, 14 Jun 2021 20:40:17 +0000
Message-Id: <20210614204017.49499-1-hi@alyssa.is>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In a script, I wanted to look up the device node for the booted EFI
partition.  systemd-boot exposes this in an EFI variable but it's
uppercase, so when I tried to do this, it didn't work:

    findfs "(< /sys/firmware/efi/vars/LoaderDevicePartUUID-4a67b082-0a4c-41cf-b6c7-440)"

This was very confusing to me, and I lost some time trying to figure
out what was wrong before I realised that case of UUIDs was
significant to findfs.

Here, I've made comparisons of UUID and PARTUUID case-insensitive in
libblkid, which fixes the command above.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 libblkid/src/evaluate.c | 12 ++++++++++++
 libblkid/src/tag.c      | 22 +++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/libblkid/src/evaluate.c b/libblkid/src/evaluate.c
index 710eac956..ceaa63cc7 100644
--- a/libblkid/src/evaluate.c
+++ b/libblkid/src/evaluate.c
@@ -135,6 +135,15 @@ int blkid_send_uevent(const char *devname, const char *action)
 	return rc;
 }
 
+static void ascii_downcase(char *s)
+{
+	while (*s) {
+		if ('A' <= *s && *s <= 'Z')
+			*s += 'a' - 'A';
+		s++;
+	}
+}
+
 static char *evaluate_by_udev(const char *token, const char *value, int uevent)
 {
 	char dev[PATH_MAX];
@@ -163,6 +172,9 @@ static char *evaluate_by_udev(const char *token, const char *value, int uevent)
 	if (blkid_encode_string(value, &dev[len], sizeof(dev) - len) != 0)
 		return NULL;
 
+	if (!strcmp(token, "UUID") || !strcmp(token, "PARTUUID"))
+		ascii_downcase(dev);
+
 	DBG(EVALUATE, ul_debug("expected udev link: %s", dev));
 
 	if (stat(dev, &st))
diff --git a/libblkid/src/tag.c b/libblkid/src/tag.c
index 390a64864..ca81c6921 100644
--- a/libblkid/src/tag.c
+++ b/libblkid/src/tag.c
@@ -10,10 +10,13 @@
  * %End-Header%
  */
 
-#include <unistd.h>
+#include <locale.h>
+#include <stdbool.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <stdio.h>
+#include <strings.h>
+#include <unistd.h>
 
 #include "blkidP.h"
 
@@ -101,6 +104,19 @@ static blkid_tag blkid_find_head_cache(blkid_cache cache, const char *type)
 	return head;
 }
 
+static bool tag_value_matches(const char *type, const char *expected,
+			      const char *actual)
+{
+	if (!strcmp(type, "UUID") || !strcmp(type, "PARTUUID")) {
+		locale_t posix = newlocale(0, "POSIX", 0);
+		bool r = !strcasecmp_l(expected, actual, posix);
+		freelocale(posix);
+		return r;
+	}
+
+	return !strcmp(expected, actual);
+}
+
 /*
  * Set a tag on an existing device.
  *
@@ -345,7 +361,7 @@ try_again:
 			blkid_tag tmp = list_entry(p, struct blkid_struct_tag,
 						   bit_names);
 
-			if (!strcmp(tmp->bit_val, value) &&
+			if (tag_value_matches(type, tmp->bit_val, value) &&
 			    (tmp->bit_dev->bid_pri > pri) &&
 			    !access(tmp->bit_dev->bid_name, F_OK)) {
 				dev = tmp->bit_dev;
-- 
2.31.1

