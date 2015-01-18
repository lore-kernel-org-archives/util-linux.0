Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:64690 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751596AbbARUkv (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Jan 2015 15:40:51 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] docs: fix two spellings in man page of logger
Date: Sun, 18 Jan 2015 21:40:30 +0100
Message-Id: <1421613631-5732-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1421613631-5732-1-git-send-email-bensberg@justemail.net>
References: <1421613631-5732-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/logger.1 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 235331e..ff81fce 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -130,7 +130,7 @@ The optional \fIwithout\fR argument can be a comma-separated list of
 the following values: \fBnotq\fR, \fBnotime\fR, \fBnohost\fR.
 The \fBnotq\fR value suppresses the time-quality structured data
 from the submitted message.  (The time-quality information shows whether
-the local clock was syncronized plus the maximum number of microseconds
+the local clock was synchronized plus the maximum number of microseconds
 the timestamp might be off.)  The \fBnotime\fR value (which implies
 \fBnotq\fR) suppresses the complete sender timestamp that is in
 ISO-8601 format, including microseconds and timezone.
@@ -138,7 +138,7 @@ The \fBnohost\fR value suppresses
 .BR gethostname (2)
 information from the message header.
 .IP
-The rfc5424 protocol has been default for
+The RFC 5424 protocol has been the default for
 .B logger
 since version 2.26.
 .TP
-- 
1.7.0.4

