Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937AEC4332F
	for <util-linux@archiver.kernel.org>; Fri, 18 Nov 2022 13:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbiKRNiN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242193AbiKRNhm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 18 Nov 2022 08:37:42 -0500
X-Greylist: delayed 774 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Nov 2022 05:36:40 PST
Received: from nlay-fle-service01.in.namespace.at (nlay-fle-service01.in.namespace.at [IPv6:2a01:190:1801:100::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE461B9EB
        for <util-linux@vger.kernel.org>; Fri, 18 Nov 2022 05:36:40 -0800 (PST)
Received: from [10.100.0.62] (helo=debbuild.in.namespace.at)
        by nlay-fle-service01.in.namespace.at with smtp (Exim 4.94.2)
        (envelope-from <zeha@debian.org>)
        id 1ow1LK-00H5iS-Sh; Fri, 18 Nov 2022 14:23:42 +0100
Received: (nullmailer pid 616160 invoked by uid 1000);
        Fri, 18 Nov 2022 13:23:42 -0000
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Cc:     =?UTF-8?q?=D0=BD=D0=B0=D0=B1?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: [PATCH] script: abort if unused arguments are given
Date:   Fri, 18 Nov 2022 13:23:37 +0000
Message-Id: <20221118132337.616146-1-zeha@debian.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

scripts uses either a free-standing "file" argument, or the value
passed as --log-out "file". Additional filenames are ignored.
They are also ignored if --log-in "file" is given, as it turns off
output logging by default (can still be overriden by adding --log-out).
Avoid surprises when passing multiple filenames by writing usage
message instead.

Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
Reported-by: наб <nabijaczleweli@nabijaczleweli.xyz>
Bug-Debian: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1016193
---
 term-utils/script.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 516a6cf93..c4b8e3337 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -889,9 +889,11 @@ int main(int argc, char **argv)
 
 	/* default if no --log-* specified */
 	if (!outfile && !infile) {
-		if (argc > 0)
+		if (argc > 0) {
 			outfile = argv[0];
-		else {
+			argc--;
+			argv++;
+		} else {
 			die_if_link(&ctl, DEFAULT_TYPESCRIPT_FILENAME);
 			outfile = DEFAULT_TYPESCRIPT_FILENAME;
 		}
@@ -900,6 +902,12 @@ int main(int argc, char **argv)
 		log_associate(&ctl, &ctl.out, outfile, SCRIPT_FMT_RAW);
 	}
 
+	if (argc > 0) {
+		/* only one filename is accepted. if --log-out was given,
+		 * freestanding filename is ignored */
+		usage();
+	}
+
 	if (timingfile) {
 		/* the old SCRIPT_FMT_TIMING_SIMPLE should be used when
 		 * recoding output only (just for backward compatibility),
-- 
2.38.1

