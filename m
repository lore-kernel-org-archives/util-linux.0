Return-Path: <SRS0=UJgV=WK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FE5C32757
	for <util-linux@archiver.kernel.org>; Wed, 14 Aug 2019 16:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702CE2084F
	for <util-linux@archiver.kernel.org>; Wed, 14 Aug 2019 16:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qA+tDuAK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQL82ljp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfHNQpI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:45:08 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:53873 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727799AbfHNQpI (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Aug 2019 12:45:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6486A533
        for <util-linux@vger.kernel.org>; Wed, 14 Aug 2019 12:45:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 14 Aug 2019 12:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        gtqVwhS4ucpOqo+xs63iJzWY3e7tavL/EPWmLUwFP5Y=; b=qA+tDuAKevCZp4h5
        +pCXpFNwRvDRKlVHSfYdyMdOeilLh0cyzqesVxovJG9fxUd3Hf+Ma38+UNnuVAV9
        vSadaWK+IpiLcSSztn1GdeIo8XIJC7bhpIQho7A7vvhCbukDAz/pWy1Z1v/z8slt
        7zyCWt2eoFYQjB6wb+tOKuShJNHA6BaP2de783B1YwLdL8GYQx1H7Q2np2jkeEga
        4go2nmQUcPmSuzdEa25qNTFu28qe65mQPuzxZJKNVow3Sh++ARxFdgYP70jvXtKh
        xxG9bRg5JGiTrWPpclA+AOTUFBsRVDlNeeAqFKRcYTKvWhSaoKiLlx49cZ/s2bg3
        lNx0Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=gtqVwhS4ucpOqo+xs63iJzWY3e7tavL/EPWmLUwFP
        5Y=; b=JQL82ljpBSifj8+7GIAmMGOR7JAlFFIVChWhT71nkYgDsTBZ9RKMzTb+0
        nFv+oRBtvJmimDczmIaQPMM8sUIB2m1yOCufHVx3N5Z6ubEhxdSkcWeV+OiPJZ63
        pDAmiWY4a2IpOTjlLPyva7B11fdMRtByPd97u9IrTUbdHTLjl3q8j/TzUN4zKstb
        FY1ltUQKbkZDWDn76GsfW4VM7Xb+9h32Pq55OQJQLx/3hnjyQ04MIgWpx37638d+
        UfFIzkKY8RwxszBSqr/rDHK7mcjDddhRB2Yswldu6jwnXwZjgF7QhwJ2obrzzbT3
        nLVdrGVKozZxSSWhoW4arXB7CO0fQ==
X-ME-Sender: <xms:kjpUXUnZ8xK2FlGbjSQxiic5b1uwwsmE1PmXGexUNou_hKJlkJ-PYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvledggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhggtgfgsehtke
    ertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucfkphepjeekrdehgedrudejvddrvdduheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:kjpUXcQRIGNGn-exMXz9FOG6cwEiClj5vp1YUPdqsH79PKMDSh1nQg>
    <xmx:kjpUXYTS4uoUEktgU-eyfJCltYUSKzqqUuYo6GWlS1K7XKYCOf_jmA>
    <xmx:kjpUXUph1lhhyKYXFN-d-TWgkZ5v3zdzSXPe7980cDg1JXQNBTII0A>
    <xmx:kjpUXXozbCS2xDkzYljpuP8ytvfGIlqPzgWG0Oydl_mMyZWQuTesNw>
Received: from NSJAIL (x4e36acd7.dyn.telefonica.de [78.54.172.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E447380087
        for <util-linux@vger.kernel.org>; Wed, 14 Aug 2019 12:45:06 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 517f9db6 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 14 Aug 2019 16:45:01 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/4] lib/closestream: fix assignment to read-only standard streams
Date:   Wed, 14 Aug 2019 18:45:07 +0200
Message-Id: <65bc4f34fde3a24431b1b2ef0403addd72c8f324.1565800625.git.ps@pks.im>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <cover.1565800625.git.ps@pks.im>
References: <cover.1565800625.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In order to avoid closing standard streams multiple times, commit
52aa1a661 (include/closestream: avoid close more than once, 2019-06-13)
started to set the standard output and error streams to `NULL`.
According to ISO C89, being able to assign to the standard text streams
is not a requirement for any C implementation. See footnote 238 in
chapter §7.19.5.6:

    The primary use of the freopen function is to change the file
    associated with a standard text stream (stderr, stdin, or stdout),
    as those identifiers need not be modifiable lvalues to which the
    value returned by the fopen function may be assigned.

Fix the issue by instead using a local static variable `streams_closed`
that gets set to `1` when the standard streams have been closed. This
unbreaks compilation on musl libc systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 lib/closestream.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/closestream.c b/lib/closestream.c
index d735e4f01..e5d04fe69 100644
--- a/lib/closestream.c
+++ b/lib/closestream.c
@@ -19,6 +19,8 @@
 # define CLOSE_EXIT_CODE EXIT_FAILURE
 #endif
 
+static int streams_closed = 0;
+
 int
 close_stream(FILE * stream)
 {
@@ -44,7 +46,7 @@ close_stream(FILE * stream)
 static inline void
 close_stdout(void)
 {
-	if (stdout && close_stream(stdout) != 0 && !(errno == EPIPE)) {
+	if (!streams_closed && close_stream(stdout) != 0 && !(errno == EPIPE)) {
 		if (errno)
 			warn(_("write error"));
 		else
@@ -52,11 +54,10 @@ close_stdout(void)
 		_exit(CLOSE_EXIT_CODE);
 	}
 
-	if (stderr && close_stream(stderr) != 0)
+	if (!streams_closed && close_stream(stderr) != 0)
 		_exit(CLOSE_EXIT_CODE);
 
-	stdout = NULL;
-	stderr = NULL;
+	streams_closed = 1;
 }
 
 void close_stdout_atexit(void)
-- 
2.22.1

