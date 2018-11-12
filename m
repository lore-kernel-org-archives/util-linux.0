Return-Path: <SRS0=jXkZ=NX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6D1C43441
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 18:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E11224E0
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 18:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E11224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fatal.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeKMEkV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:40:21 -0500
Received: from 82-209-166-85.cust.bredband2.com ([82.209.166.85]:56038 "EHLO
        pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeKMEkV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Nov 2018 23:40:21 -0500
Received: by pi.fatal.se (Postfix, from userid 1000)
        id 2A2BF246B9; Mon, 12 Nov 2018 19:45:51 +0100 (CET)
From:   Andreas Henriksson <andreas@fatal.se>
To:     util-linux@vger.kernel.org
Cc:     Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] Add Documentation key to fstrim.service
Date:   Mon, 12 Nov 2018 19:45:51 +0100
Message-Id: <20181112184551.19818-1-andreas@fatal.se>
X-Mailer: git-send-email 2.11.0
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

---
 sys-utils/fstrim.service.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/fstrim.service.in b/sys-utils/fstrim.service.in
index d70367eea..2d5daf99d 100644
--- a/sys-utils/fstrim.service.in
+++ b/sys-utils/fstrim.service.in
@@ -1,5 +1,6 @@
 [Unit]
 Description=Discard unused blocks on filesystems from /etc/fstab
+Documentation=man:fstrim(8)
 
 [Service]
 Type=oneshot
-- 
2.19.1

