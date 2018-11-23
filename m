Return-Path: <SRS0=9/K6=OC=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E8AC43441
	for <util-linux@archiver.kernel.org>; Fri, 23 Nov 2018 11:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C9320659
	for <util-linux@archiver.kernel.org>; Fri, 23 Nov 2018 11:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C9320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fatal.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbeKWVyv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:54:51 -0500
Received: from 82-209-166-85.cust.bredband2.com ([82.209.166.85]:56214 "EHLO
        pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387941AbeKWVyv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Nov 2018 16:54:51 -0500
Received: by pi.fatal.se (Postfix, from userid 1000)
        id 5BE4F247AB; Fri, 23 Nov 2018 12:10:59 +0100 (CET)
Date:   Fri, 23 Nov 2018 12:10:59 +0100
From:   Andreas Henriksson <andreas@fatal.se>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2] Add hardening settings to uuidd.service
Message-ID: <20181123111059.lsf3s67thfo623jl@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112211031.21996-1-andreas@fatal.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This limits what the uuid daemon has access to when it runs.

Further improving this with additional option or making
things even tighter is most likely possible.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 misc-utils/uuidd.service.in | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/misc-utils/uuidd.service.in b/misc-utils/uuidd.service.in
index 531672765..dd38b645c 100644
--- a/misc-utils/uuidd.service.in
+++ b/misc-utils/uuidd.service.in
@@ -7,6 +7,17 @@ ExecStart=@usrsbin_execdir@/uuidd --socket-activation
 Restart=no
 User=uuidd
 Group=uuidd
+ProtectSystem=strict
+ProtectHome=yes
+PrivateDevices=yes
+PrivateNetwork=yes
+PrivateUsers=yes
+ProtectKernelTunables=yes
+ProtectKernelModules=yes
+ProtectControlGroups=yes
+RestrictAddressFamilies=AF_UNIX
+MemoryDenyWriteExecute=yes
+SystemCallFilter=@default @file-system @basic-io @system-service @signal @io-event @network-io
 
 [Install]
 Also=uuidd.socket
-- 
2.19.2

