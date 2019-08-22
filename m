Return-Path: <SRS0=P1gn=WS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A03C3A59D
	for <util-linux@archiver.kernel.org>; Thu, 22 Aug 2019 09:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D661F206DD
	for <util-linux@archiver.kernel.org>; Thu, 22 Aug 2019 09:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DYIeYzSh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4A2sxFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfHVJkZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:40:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41585 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727484AbfHVJkZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Aug 2019 05:40:25 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 61A592102F;
        Thu, 22 Aug 2019 05:40:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 22 Aug 2019 05:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        MT7nRMTqciKmioiI7+85H7yv2Vzahkpkx1y3TrUVOzY=; b=DYIeYzShad451Yk1
        vFYxGW6vpKk6lXSSzdeAqcETw3xHyAZOkkNxAUx6B/f0Iy1v/U5g1aCXvW1K7t0p
        qXMCdFnNEh3nc7rfKkbtkxql9dssI5vK1sTVx9ggJwiM5UB+VMqg5sONbezMfiNk
        BlA5UZoVMkR5diKx/6gyVqek1rqEGuzyHDug+U6PNwxDbZe2Tveae3VTW5prx80r
        x4QZu1Xy/mneV+Fyv+HBljHaSmuJ60a2owatH2LaRGrdxK5TlUxzL7rvWuNSWYyI
        t66XvorzZYPVon4r9VdwEJV6AZ+FYd57eaf509lgtIauhy/H5WGVuaXmHqdhhxeG
        NtV6wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=MT7nRMTqciKmioiI7+85H7yv2Vzahkpkx1y3TrUVO
        zY=; b=P4A2sxFd12gZfvU95D9pQPCC9VbrYz70TBkYck/zyFu8sc0h0pxt+Y9LB
        FMqMGpbTYqc3JiUNYoMLBRD8as2qDm4ngctCCf9U7E7LfyoIbRKs0GHbErJcyyuz
        Pct6Zr09uumivZCwcN1j/u04LItREPvVonZWkAUQs3U459dqbQzhBzB+aFQ7QEtg
        RAflGVIgGlMScJZbBq2RdIfnLHETOk/d2GmM6XRHdtPYp0wSOq/YCuiPz8UkB1FA
        yQiAi1gUsAvdrRRqoyAKm/gNeZr9TV9VjjPN0wH/Yr0ZBslDSUmBEuCpTkNjcazK
        nT/MC17ejlIdxnQI+zz61IEsV90Lg==
X-ME-Sender: <xms:BmNeXQpokgvY9VxLFyVNuVRSsbg-G6ws6RIVUwiDg0eNcQWZFPxiRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeghedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecukfhppeejkedrhe
    egrddvheegrdduhedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:BmNeXfGAdxQ2vzeHtNf6rlz9QHdzvxTDxqgiYVZ4U8eXnbPnBcx2PA>
    <xmx:BmNeXTxGOk0RmYWtsvr48zyHAzYFNJoLPcPBTNdj4JBJEgIwA4s3ow>
    <xmx:BmNeXWqPAr9TmatAM0QC9z6Z3h9OQbqldBGMgHcXxXc_dTPKQj3LMQ>
    <xmx:B2NeXVRoIyPdJL6H0xQkPpU1-Dl6Rc8oLm5HvUDpPkTRGTLLNwqNOA>
Received: from NSJAIL (x4e36fe96.dyn.telefonica.de [78.54.254.150])
        by mail.messagingengine.com (Postfix) with ESMTPA id EEBE980061;
        Thu, 22 Aug 2019 05:40:21 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 009774c7 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 22 Aug 2019 09:40:16 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Karel Zak <kzak@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v2] include/closestream: fix assignment to read-only standard streams
Date:   Thu, 22 Aug 2019 11:40:15 +0200
Message-Id: <3e5f8ff67edc6ae34ff67124c956a71dcf49ea98.1566466780.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
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
introduced code to set the standard output and error streams to `NULL`.
As musl libc defines standard streams as constant pointers, the change
causes compiler errors on systems with that libc. According to ISO C89,
being able to assign to the standard text streams is not a requirement
for any C implementation, see footnote 238 in chapter §7.19.5.6:

    The primary use of the freopen function is to change the file
    associated with a standard text stream (stderr, stdin, or stdout),
    as those identifiers need not be modifiable lvalues to which the
    value returned by the fopen function may be assigned.

This commit implements a new function `flush_standard_stream` that tries
to reliably flush standard streams without actually closing them. By not
calling fclose(3P), we can neatly avoid the issue of accessing standard
streams in an unspecified state and thus remove the infringing `NULL`
assignments.

Properly flushing standard streams without fclose(3P) proves to be more
intricate than one may expect, though, as some filesystems like NFS may
defer flushing until they see a close(3P) of the underlying descriptor.
One may call fsync(3P) to remedy that, but this may incur a heavy
performance penalty in some scenarios. To work around the issue and
still get proper errors, we duplicate the stream's file descriptor and
close that one instead, which is sufficient to cause a flush.

Note that both `close_stdout` and `close_stdout_atexit` are misnamed
after this change, as we do not actually close the streams now. In order
to avoid unnecessary code churn, we still retain their current names.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 include/closestream.h | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/closestream.h b/include/closestream.h
index 83df1ee7d..41afbe208 100644
--- a/include/closestream.h
+++ b/include/closestream.h
@@ -35,11 +35,37 @@ close_stream(FILE * stream)
 	return 0;
 }
 
+static inline int
+flush_standard_stream(FILE *stream)
+{
+	int fd;
+
+	errno = 0;
+
+	if (ferror(stream) != 0 || fflush(stream) != 0)
+		goto error;
+
+	/*
+	 * Calling fflush is not sufficient on some filesystems
+	 * like e.g. NFS, which may defer the actual flush until
+	 * close. Calling fsync would help solve this, but would
+	 * probably result in a performance hit. Thus, we work
+	 * around this issue by calling close on a dup'd file
+	 * descriptor from the stream.
+	 */
+	if ((fd = fileno(stream)) < 0 || (fd = dup(fd)) < 0 || close(fd) != 0)
+		goto error;
+
+	return 0;
+error:
+	return (errno == EBADF) ? 0 : EOF;
+}
+
 /* Meant to be used atexit(close_stdout); */
 static inline void
 close_stdout(void)
 {
-	if (stdout && close_stream(stdout) != 0 && !(errno == EPIPE)) {
+	if (flush_standard_stream(stdout) != 0 && !(errno == EPIPE)) {
 		if (errno)
 			warn(_("write error"));
 		else
@@ -47,11 +73,8 @@ close_stdout(void)
 		_exit(CLOSE_EXIT_CODE);
 	}
 
-	if (stderr && close_stream(stderr) != 0)
+	if (flush_standard_stream(stderr) != 0)
 		_exit(CLOSE_EXIT_CODE);
-
-	stdout = NULL;
-	stderr = NULL;
 }
 
 static inline void
-- 
2.23.0

