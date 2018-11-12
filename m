Return-Path: <SRS0=jXkZ=NX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E03C43441
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 20:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0F722419
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 20:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0F722419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fatal.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbeKMGnm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:43:42 -0500
Received: from 82-209-166-85.cust.bredband2.com ([82.209.166.85]:56042 "EHLO
        pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeKMGnm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Nov 2018 01:43:42 -0500
Received: by pi.fatal.se (Postfix, from userid 1000)
        id 82302246BC; Mon, 12 Nov 2018 21:48:45 +0100 (CET)
From:   Andreas Henriksson <andreas@fatal.se>
To:     util-linux@vger.kernel.org
Cc:     Andreas Henriksson <andreas@fatal.se>
Subject: [RFC/PATCH] Add hardening settings to fstrim.service
Date:   Mon, 12 Nov 2018 21:48:43 +0100
Message-Id: <20181112204843.21641-1-andreas@fatal.se>
X-Mailer: git-send-email 2.11.0
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This limits what the fstrim process has access to when it runs.

PrivateUsers can't be enabled because of:
"If this mode is enabled, all unit processes are run without privileges
in the host user namespace[...]"

Further improving this with additional option or making
things even tighter is most likely possible.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 sys-utils/fstrim.service.in | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sys-utils/fstrim.service.in b/sys-utils/fstrim.service.in
index 2d5daf99d..0bab91a9c 100644
--- a/sys-utils/fstrim.service.in
+++ b/sys-utils/fstrim.service.in
@@ -5,3 +5,13 @@ Documentation=man:fstrim(8)
 [Service]
 Type=oneshot
 ExecStart=@sbindir@/fstrim -Av
+ProtectSystem=strict
+ProtectHome=yes
+PrivateDevices=no
+PrivateNetwork=yes
+PrivateUsers=no
+ProtectKernelTunables=yes
+ProtectKernelModules=yes
+ProtectControlGroups=yes
+MemoryDenyWriteExecute=yes
+SystemCallFilter=@default @file-system @basic-io @system-service
-- 
2.19.1

