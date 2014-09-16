Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:42353 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbaIPUVk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Sep 2014 16:21:40 -0400
Received: by mail-wi0-f180.google.com with SMTP id ex7so48634wid.1
        for <util-linux@vger.kernel.org>; Tue, 16 Sep 2014 13:21:39 -0700 (PDT)
Received: from kerolasa-home (host-84-13-170-68.opaltelecom.net. [84.13.170.68])
        by mx.google.com with ESMTPSA id el10sm3028747wib.23.2014.09.16.13.21.38
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 13:21:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 16 Sep 2014 21:21:37 +0100 (BST)
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] pull: renice changes
In-Reply-To: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
Message-ID: <alpine.LNX.2.03.1409162118180.3712@kerolasa-home>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, 6 Sep 2014, Sami Kerola wrote:

> The renice(1) code looked a bit dated, so I decided to change it a bit
> which resulted few more changes than I thought.  The --priority <arg>
> change makes the command line interface a bit less awkward, and the
> numeric uid argument parsing is a bug fix.  Rest of the changes are clean
> ups.

Pull request I sent earlier is no longer completely up to date.  The 
renice branch is rebased on top of upstream master, and there is one new 
change 0007: reorder usage() option descriptions.


The following changes since commit a3b92242ad76a7468cf508e1d878d0815c7e031f:

   libmount: hide details about failed search in fstab/mtab (2014-09-16 15:30:03 +0200)

are available in the git repository at:

   git://github.com/kerolasa/lelux-utiliteetit.git renice

for you to fetch changes up to a32b3f68da162eadbb17ff65a585d0249805c32f:

   renice: reorder usage() option descriptions (2014-09-16 21:09:11 +0100)

----------------------------------------------------------------
Sami Kerola (7):
       renice: reorder functions to avoid need of function prototype
       rename: use usage and version print out macros
       renice: disallow --priority <arg> without pid argument
       renice: avoid having same lines of code twice
       renice: fix numeric uid argument parsing
       rename: add getpriority() message lookup table
       renice: reorder usage() option descriptions

  sys-utils/renice.c | 111 
++++++++++++++++++++++++++---------------------------
  1 file changed, 55 insertions(+), 56 deletions(-)

-->8---
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 14 Sep 2014 11:12:58 +0100
Subject: [PATCH 7/7] renice: reorder usage() option descriptions

Make the Usage: and Options: sections to be in same order, which I found
to be quicker to use than alphabetical order.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
  sys-utils/renice.c | 13 +++++++------
  1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index 994c9de..100f6a5 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -63,12 +63,13 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
  		" %1$s [-n] <priority>  -u|--user <user>...\n"),
  		program_invocation_short_name);
  	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -g, --pgrp <id>        interpret argument as process group ID\n"
-		" -n, --priority <num>   specify the nice increment value\n"
-		" -p, --pid <id>         interpret argument as process ID (default)\n"
-		" -u, --user <name|id>   interpret argument as username or user ID\n"
-		" -h, --help             display help text and exit\n"
-		" -V, --version          display version information and exit\n"), out);
+	fputs(_(" -n, --priority <num>   specify the nice increment value\n"), out);
+	fputs(_(" -p, --pid <id>         interpret argument as process ID (default)\n"), out);
+	fputs(_(" -g, --pgrp <id>        interpret argument as process group ID\n"), out);
+	fputs(_(" -u, --user <name|id>   interpret argument as username or user ID\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
  	fprintf(out, USAGE_MAN_TAIL("renice(1)"));
  	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
  }
-- 
2.1.0

