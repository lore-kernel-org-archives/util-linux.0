Received: from m204-227.eu.mailgun.net (m204-227.eu.mailgun.net [161.38.204.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A11A317D
	for <util-linux@vger.kernel.org>; Sun, 23 Nov 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.38.204.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763911985; cv=none; b=eziZXTN6n0gEgJRrMZi4B11lWLy1yI/YHdwfJ1QqLfhNanmwWZA+SVFYeDJF9wmGRU7GKTHXZXFDnXLA5OddF3PHV9FZpXFJXAAgXwq9wZdZ0AGbozCjrtmdv4EqwK/ZAlID5vX6H81YOEGJo52BaYsBvuHzVNVkJ5dStWSwaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763911985; c=relaxed/simple;
	bh=oHKKXUnt6nYpab13UXDGYvBfyyuAbwsQd1B9x5zPyIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhQDO/9qnwlGEiWVS1XEuqqyvJmpJDjFjuyITxgVRapZ85MgicqszHzyW2Sp+xKIjKRWF7qvLc4ifqDcl2mDQjgC9PzrcRuPJXoXzWxhOYr+gjpzbEyi/jD49wJ3duIzIZMaBsA/RQmNDJirwMEURgZFE99iCVFRQFBsmpuCp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=Q5QlpiUQ; arc=none smtp.client-ip=161.38.204.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="Q5QlpiUQ"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1763911981; x=1763919181;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=DE9mtgcr49Dhozk4Bb+jvTxsmbgYHQrB0v8M01TQHGQ=;
 b=Q5QlpiUQqBLkhgtwyon3ITrsHUwC+2VmdA4wGyqzjGrPkdR+SwPuHSAV7CuXA32zHGc7Mor8TPFaWTwH4iq1Rg71ySlpPNFCgDuGqSMOAJAYl1gUhvX+cKqsGVcsk/eH2h+RKq75/zC2cpUhPE9uYdL86nbSquDm4aR7D0A0rR4Lz+eikQawkqDAAi75MTnTwR6d+pK9k+D/y26+7el3V9xo+B1h0KzGKhnivW7YkXqvfhQn2DqFAuQZE0bQ8xlXjx+3ARI40xwK+xSHQzHlGEyovIVzuzAB8SJzUSBLpBCqyQn4HoqGgh+dP3QLy9RJjTjcO4BmDsAVU6EaCN4Qlg==
X-Mailgun-Sid: WyJlNDM3YyIsInV0aWwtbGludXhAdmdlci5rZXJuZWwub3JnIiwiNTRlZjQiXQ==
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 7cb349a42b1b1f1259b38414f775f2c20b6e7347a6127f8df26891016837968f with SMTP id
 6923292ddc9f5a643fb11cf1; Sun, 23 Nov 2025 15:33:01 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Sender: alessandro@0x65c.net
From: Alessandro Ratti <alessandro@0x65c.net>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	thomas@t-8ch.de,
	Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH 2/3] *: use ul_default_shell() for interactive shell spawning
Date: Sun, 23 Nov 2025 16:32:45 +0100
Message-ID: <20251123153246.1056874-3-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251123153246.1056874-1-alessandro@0x65c.net>
References: <20251123153246.1056874-1-alessandro@0x65c.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update tools that spawn interactive shells to use ul_default_shell()
for consistent shell resolution. This ensures these tools respect both
$SHELL and the user's configured shell from the passwd database before
falling back to _PATH_BSHELL.

Affected tools:
- script(1): fixes history truncation when invoked without $SHELL
- scriptlive(1): consistent with script(1) behavior
- flock(1): for -c command execution
- more(1): for shell escape feature
- exec_shell (used by unshare(1) and nsenter(1))

This change addresses user reports of data loss due to tools defaulting
to /bin/sh instead of the user's configured shell, particularly affecting
command history with different HISTSIZE configurations.

Addresses: https://github.com/util-linux/util-linux/issues/3865
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 lib/exec_shell.c        | 8 ++------
 sys-utils/flock.c       | 8 +++++---
 term-utils/script.c     | 5 ++---
 term-utils/scriptlive.c | 5 ++---
 text-utils/more.c       | 4 ++--
 5 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/lib/exec_shell.c b/lib/exec_shell.c
index ffe65f006..8f10ea4df 100644
--- a/lib/exec_shell.c
+++ b/lib/exec_shell.c
@@ -26,19 +26,15 @@
 #include "xalloc.h"
 
 #include "exec_shell.h"
-
-#define DEFAULT_SHELL "/bin/sh"
+#include "shells.h"
 
 void __attribute__((__noreturn__)) exec_shell(void)
 {
-	const char *shell = getenv("SHELL");
+	const char *shell = ul_default_shell(0, NULL);
 	char *shellc;
 	const char *shell_basename;
 	char *arg0;
 
-	if (!shell)
-		shell = DEFAULT_SHELL;
-
 	shellc = xstrdup(shell);
 	shell_basename = basename(shellc);
 	xasprintf(&arg0, "-%s", shell_basename);
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index fe1a71f72..a6883ac77 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -47,6 +47,7 @@
 #include "closestream.h"
 #include "monotonic.h"
 #include "timer.h"
+#include "shells.h"
 
 #ifndef F_OFD_GETLK
 #define F_OFD_GETLK	36
@@ -207,6 +208,8 @@ int main(int argc, char *argv[])
 	int conflict_exit_code = 1;
 	char **cmd_argv = NULL, *sh_c_argv[4];
 	const char *filename = NULL;
+	const char *shell = NULL;
+
 	enum {
 		OPT_VERBOSE = CHAR_MAX + 1,
 		OPT_FCNTL,
@@ -237,6 +240,7 @@ int main(int argc, char *argv[])
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	close_stdout_atexit();
+	shell = ul_default_shell(0, NULL); /* Used for -c command execution */
 
 	strutils_set_exitcode(EX_USAGE);
 
@@ -327,9 +331,7 @@ int main(int argc, char *argv[])
 				     _("%s requires exactly one command argument"),
 				     argv[optind + 1]);
 			cmd_argv = sh_c_argv;
-			cmd_argv[0] = getenv("SHELL");
-			if (!cmd_argv[0] || !*cmd_argv[0])
-				cmd_argv[0] = _PATH_BSHELL;
+			cmd_argv[0] = (char *)shell;
 			cmd_argv[1] = "-c";
 			cmd_argv[2] = argv[optind + 2];
 			cmd_argv[3] = NULL;
diff --git a/term-utils/script.c b/term-utils/script.c
index ff7f4409f..4e302347f 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -70,6 +70,7 @@
 #include "signames.h"
 #include "pty-session.h"
 #include "debug.h"
+#include "shells.h"
 
 static UL_DEBUG_DEFINE_MASK(script);
 UL_DEBUG_DEFINE_MASKNAMES(script) = UL_DEBUG_EMPTY_MASKNAMES;
@@ -966,9 +967,7 @@ int main(int argc, char **argv)
 			log_associate(&ctl, &ctl.in, timingfile, format);
 	}
 
-	shell = getenv("SHELL");
-	if (!shell)
-		shell = _PATH_BSHELL;
+	shell = ul_default_shell(0, NULL);
 
 	ctl.pty = ul_new_pty(ctl.isterm);
 	if (!ctl.pty)
diff --git a/term-utils/scriptlive.c b/term-utils/scriptlive.c
index e4a3434ed..6ac685506 100644
--- a/term-utils/scriptlive.c
+++ b/term-utils/scriptlive.c
@@ -38,6 +38,7 @@
 #include "pty-session.h"
 #include "script-playutils.h"
 #include "monotonic.h"
+#include "shells.h"
 
 
 #define SCRIPT_MIN_DELAY 0.0001		/* from original scriptreplay.pl */
@@ -281,9 +282,7 @@ main(int argc, char *argv[])
 		replay_set_delay_max(ss.setup, &maxdelay);
 	replay_set_delay_min(ss.setup, &mindelay);
 
-	shell = getenv("SHELL");
-	if (shell == NULL)
-		shell = _PATH_BSHELL;
+	shell = ul_default_shell(0, NULL);
 
 	fprintf(stdout, _(">>> scriptlive: Starting your typescript execution by %s.\n"),
 			command ? command : shell);
diff --git a/text-utils/more.c b/text-utils/more.c
index 4980aef4c..4e3cae565 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -89,6 +89,7 @@
 #include "widechar.h"
 #include "closestream.h"
 #include "env.h"
+#include "shells.h"
 
 #ifdef TEST_PROGRAM
 # define NON_INTERACTIVE_MORE 1
@@ -2110,8 +2111,7 @@ static void initterm(struct more_control *ctl)
 	if ((ctl->backspace_ch = tigetstr(TERM_BACKSPACE)) == NULL)
 		ctl->backspace_ch = BACKSPACE;
 
-	if ((ctl->shell = getenv("SHELL")) == NULL)
-		ctl->shell = _PATH_BSHELL;
+	ctl->shell = (char *)ul_default_shell(0, NULL);
 }
 
 int main(int argc, char **argv)
-- 
2.51.1

