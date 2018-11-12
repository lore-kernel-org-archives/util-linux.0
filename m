Return-Path: <SRS0=jXkZ=NX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC831C43441
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 21:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2362243E
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 21:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2362243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fatal.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeKMHIj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:08:39 -0500
Received: from 82-209-166-85.cust.bredband2.com ([82.209.166.85]:56044 "EHLO
        pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbeKMHIj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Nov 2018 02:08:39 -0500
Received: by pi.fatal.se (Postfix, from userid 1000)
        id B3F2C246BD; Mon, 12 Nov 2018 22:13:38 +0100 (CET)
From:   Andreas Henriksson <andreas@fatal.se>
To:     util-linux@vger.kernel.org
Cc:     Andreas Henriksson <andreas@fatal.se>
Subject: [RFC/PATCH] Add hardening settings to uuidd.service
Date:   Mon, 12 Nov 2018 22:10:31 +0100
Message-Id: <20181112211031.21996-1-andreas@fatal.se>
X-Mailer: git-send-email 2.11.0
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This limits what the uuid daemon has access to when it runs.

Further improving this with additional option or making
things even tighter is most likely possible.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 misc-utils/uuidd.service.in | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/misc-utils/uuidd.service.in b/misc-utils/uuidd.service.in
index 45f1f7334..dd38b645c 100644
--- a/misc-utils/uuidd.service.in
+++ b/misc-utils/uuidd.service.in
@@ -17,8 +17,7 @@ ProtectKernelModules=yes
 ProtectControlGroups=yes
 RestrictAddressFamilies=AF_UNIX
 MemoryDenyWriteExecute=yes
-SystemCallFilter=@default @file-system @basic-io @system-service @signal @io-eve
-nt @network-io
+SystemCallFilter=@default @file-system @basic-io @system-service @signal @io-event @network-io
 
 [Install]
 Also=uuidd.socket
-- 
2.19.1

