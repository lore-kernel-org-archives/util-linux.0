Return-Path: <SRS0=wda/=2E=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2157C43603
	for <util-linux@archiver.kernel.org>; Sat, 14 Dec 2019 00:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2903206DA
	for <util-linux@archiver.kernel.org>; Sat, 14 Dec 2019 00:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLNAVC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Dec 2019 19:21:02 -0500
Received: from outpost.hi.is ([130.208.165.166]:38532 "EHLO outpost.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfLNAVC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 13 Dec 2019 19:21:02 -0500
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by outpost.hi.is (8.14.7/8.14.7) with ESMTP id xBE0CXsj014781
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Sat, 14 Dec 2019 00:12:34 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 outpost.hi.is xBE0CXsj014781
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id xBE0CVt2005028
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Sat, 14 Dec 2019 00:12:31 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is xBE0CVt2005028
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id xBE0CUeZ030964
        for <util-linux@vger.kernel.org>; Sat, 14 Dec 2019 00:12:30 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id xBE0CUGB030963
        for util-linux@vger.kernel.org; Sat, 14 Dec 2019 00:12:30 GMT
Date:   Sat, 14 Dec 2019 00:12:30 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] man pages: Make the number of .RS/.RE equal
Message-ID: <20191214001230.GA30935@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  Add or remove one of the pairs .RS/.RE to make their number equal.

  The output from "nroff" and "groff" is unchanged.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 sys-utils/mount.8    | 1 -
 text-utils/hexdump.1 | 1 +
 text-utils/more.1    | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 110198126..0b914b03e 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2413,7 +2413,6 @@ If the FEC device is embedded in the source volume,
 .TP
 \fBverity.fecroots=\fP\,\fIvalue\fP
 Parity bytes for FEC (default: 2). Optional.
-.RE
 .PP
 Supported since util-linux v2.35.
 .PP
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index 5651a6f41..1ff33256b 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -250,6 +250,7 @@ l l l l l l.
 018 can|019 em|01A sub|01B esc|01C fs|01D gs
 01E rs|01F us|0FF del
 .TE
+.RE
 .SS Colors
 When put at the end of a format specifier, hexdump highlights the
 respective string with the color specified.  Conditions, if present, are
diff --git a/text-utils/more.1 b/text-utils/more.1
index c4420e09a..8b2407ec6 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -197,6 +197,7 @@ Display current file name and line number.
 .TP
 .B \&.
 Repeat previous command.
+.RE
 .SH ENVIRONMENT
 The
 .B more
-- 
2.24.0
