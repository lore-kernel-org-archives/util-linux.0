Return-Path: util-linux-owner@vger.kernel.org
Received: from dmz-mailsec-scanner-2.mit.edu ([18.9.25.13]:58587 "EHLO
        dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753444AbcJSWlN (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 19 Oct 2016 18:41:13 -0400
Date: Wed, 19 Oct 2016 18:35:57 -0400 (EDT)
From: Anders Kaseorg <andersk@mit.edu>
To: util-linux@vger.kernel.org
cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] getopt: Terminate long_options even if add_long_options is
 never called
Message-ID: <alpine.DEB.2.10.1610191834080.52298@buzzword-bingo.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

v2.26-rc1~140^2 “getopt: avoid re-terminating long_option list at
every update” forgot to terminate the long_options list in the case
where -l/--longoptions was not specified at all, so that
add_long_options is never called.  The resulting garbage may crash
getopt if any long options are provided:

$ LANG=de_DE getopt -o c -- --help
Segmentation fault (core dumped)

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 misc-utils/getopt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 01b5883..08e92c0 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -397,6 +397,10 @@ int main(int argc, char *argv[])
 	}
 
 	add_longopt(&ctl, NULL, 0);	/* init */
+	ctl.long_options[0].name = NULL;
+	ctl.long_options[0].has_arg = 0;
+	ctl.long_options[0].flag = NULL;
+	ctl.long_options[0].val = 0;
 	getopt_long_fp = getopt_long;
 
 	if (argv[1][0] != '-' || ctl.compatible) {
-- 
2.10.1

