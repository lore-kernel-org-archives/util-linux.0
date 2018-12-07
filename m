Return-Path: <SRS0=rN/g=OQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F08EC64EB1
	for <util-linux@archiver.kernel.org>; Fri,  7 Dec 2018 10:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B96920989
	for <util-linux@archiver.kernel.org>; Fri,  7 Dec 2018 10:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B96920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=snthhacks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLGKKr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:10:47 -0500
Received: from snthhacks.com ([163.172.141.14]:49074 "EHLO smtp.snthhacks.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeLGKKr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 7 Dec 2018 05:10:47 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2018 05:10:45 EST
Received: from localhost (c-76-102-127-154.hsd1.ca.comcast.net [76.102.127.154])
        by smtp.snthhacks.com (Postfix) with ESMTPSA id E14DA1801BC
        for <util-linux@vger.kernel.org>; Fri,  7 Dec 2018 10:02:02 +0000 (UTC)
From:   Seth Girvan <snth@snthhacks.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] libuuid: fix man page typos
Date:   Fri,  7 Dec 2018 02:02:00 -0800
Message-Id: <20181207100200.23361-1-snth@snthhacks.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Seth Girvan <snth@snthhacks.com>
---
 libuuid/man/uuid.3          |  4 ++--
 libuuid/man/uuid_generate.3 | 10 +++++-----
 libuuid/man/uuid_parse.3    |  4 ++--
 libuuid/man/uuid_unparse.3  |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/libuuid/man/uuid.3 b/libuuid/man/uuid.3
index 13ab7a8f4..7d6aeb126 100644
--- a/libuuid/man/uuid.3
+++ b/libuuid/man/uuid.3
@@ -47,8 +47,8 @@ be used, for instance, to generate unique HTTP cookies across multiple
 web servers without communication between the servers, and without fear
 of a name clash.
 .SH "CONFORMING TO"
-This library generates UUIDs compatible OSF DCE 1.1, and hash based UUIDs V3 and
-V5 compatible with RFC-4122.
+This library generates UUIDs compatible with OSF DCE 1.1, and hash based UUIDs
+V3 and V5 compatible with RFC-4122.
 .SH AUTHOR
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
diff --git a/libuuid/man/uuid_generate.3 b/libuuid/man/uuid_generate.3
index d30075905..e93dc79e1 100644
--- a/libuuid/man/uuid_generate.3
+++ b/libuuid/man/uuid_generate.3
@@ -70,14 +70,14 @@ The
 .B uuid_generate_time
 function forces the use of the alternative algorithm which uses the
 current time and the local ethernet MAC address (if available).
-This algorithm used to be the default one used to generate UUID, but
+This algorithm used to be the default one used to generate UUIDs, but
 because of the use of the ethernet MAC address, it can leak
 information about when and where the UUID was generated.  This can cause
 privacy problems in some applications, so the
 .B uuid_generate
 function only uses this algorithm if a high-quality source of
 randomness is not available.  To guarantee uniqueness of UUIDs generated
-by concurrently running processes, the uuid library uses global
+by concurrently running processes, the uuid library uses a global
 clock state counter (if the process has permissions to gain exclusive access
 to this file) and/or the
 .B uuidd
@@ -90,7 +90,7 @@ whether the UUID has been generated in a safe manner, use
 .sp
 The
 .B uuid_generate_time_safe
-is similar to
+function is similar to
 .BR uuid_generate_time ,
 except that it returns a value which denotes whether any of the synchronization
 mechanisms (see above) has been used.
@@ -116,8 +116,8 @@ The newly created UUID is returned in the memory location pointed to by
 .B uuid_generate_time_safe
 returns zero if the UUID has been generated in a safe manner, \-1 otherwise.
 .SH "CONFORMING TO"
-This library generates UUIDs compatible OSF DCE 1.1, and hash based UUIDs V3 and
-V5 compatible with RFC-4122.
+This library generates UUIDs compatible with OSF DCE 1.1, and hash based UUIDs
+V3 and V5 compatible with RFC-4122.
 .SH AUTHOR
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
diff --git a/libuuid/man/uuid_parse.3 b/libuuid/man/uuid_parse.3
index 50b2c87b6..156d15ddd 100644
--- a/libuuid/man/uuid_parse.3
+++ b/libuuid/man/uuid_parse.3
@@ -53,8 +53,8 @@ stored in the location pointed to by
 .IR uu ,
 otherwise \-1 is returned.
 .SH "CONFORMING TO"
-This library parses UUIDs compatible OSF DCE 1.1, and hash based UUIDs V3 and
-V5 compatible with RFC-4122.
+This library parses UUIDs compatible with OSF DCE 1.1, and hash based UUIDs V3
+and V5 compatible with RFC-4122.
 .SH AUTHOR
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
diff --git a/libuuid/man/uuid_unparse.3 b/libuuid/man/uuid_unparse.3
index 8fb7a5956..7f708f057 100644
--- a/libuuid/man/uuid_unparse.3
+++ b/libuuid/man/uuid_unparse.3
@@ -45,7 +45,7 @@ The
 .B uuid_unparse
 function converts the supplied UUID
 .I uu
-from the binary representation into a 36-byte string (plus tailing '\e0')
+from the binary representation into a 36-byte string (plus trailing '\e0')
 of the form 1b4e28ba\-2fa1\-11d2\-883f\-0016d3cca427 and stores this
 value in the character string pointed to by
 .IR out .
-- 
2.19.2

