Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:41350 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbaLGKOG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:14:06 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so4082713wgh.40
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:14:05 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: [PATCH 04/11] getopt: remove function prototypes
Date: Sun,  7 Dec 2014 10:13:48 +0000
Message-Id: <1417947235-24229-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Functions are in right order so they do not need prototypes, with effect
of not needing to keep function argument changes in sync in two locations.

CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index d7918b1..383bbd1 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -87,16 +87,6 @@ static int quote = 1;		/* 1 is do quote. */
 int (*getopt_long_fp) (int argc, char *const *argv, const char *optstr,
 		       const struct option * longopts, int *longindex);
 
-/* Function prototypes */
-static const char *normalize(const char *arg);
-static int generate_output(char *argv[], int argc, const char *optstr,
-			   const struct option *longopts);
-static void parse_error(const char *message);
-static void add_long_options(char *options);
-static void add_longopt(const char *name, int has_arg);
-static void print_help(void);
-static void set_shell(const char *new_shell);
-
 /*
  * This function 'normalizes' a single argument: it puts single quotes
  * around it and escapes other special characters. If quote is false, it
-- 
2.1.3

