Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:52576 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755867Ab3A3Udd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Jan 2013 15:33:33 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so3211231wgb.0
        for <util-linux@vger.kernel.org>; Wed, 30 Jan 2013 12:33:32 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/3] translation: unify exec error messages
Date: Wed, 30 Jan 2013 20:33:24 +0000
Message-Id: <1359578005-13427-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1359578005-13427-1-git-send-email-kerolasa@iki.fi>
References: <1359578005-13427-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/newgrp.c    | 2 +-
 login-utils/su-common.c | 4 ++--
 login-utils/sulogin.c   | 4 ++--
 schedutils/chrt.c       | 1 -
 schedutils/ionice.c     | 2 +-
 schedutils/taskset.c    | 2 +-
 sys-utils/flock.c       | 2 +-
 sys-utils/nsenter.c     | 2 +-
 sys-utils/prlimit.c     | 2 +-
 sys-utils/rtcwake.c     | 2 +-
 sys-utils/setarch.c     | 4 ++--
 sys-utils/setsid.c      | 2 +-
 sys-utils/swapon.c      | 2 +-
 sys-utils/unshare.c     | 2 +-
 text-utils/pg.c         | 2 +-
 15 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 4f6de12..093f042 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -178,7 +178,7 @@ int main(int argc, char *argv[])
 	fflush(stdout);
 	fflush(stderr);
 	execl(shell, shell, (char *)0);
-	warn(_("exec %s failed"), shell);
+	warn(_("failed to execute %s"), shell);
 	fflush(stderr);
 
 	return EXIT_FAILURE;
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 47e05ff..3ef4ec4 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -593,7 +593,7 @@ run_shell (char const *shell, char const *command, char **additional_args,
 
   {
     int exit_status = (errno == ENOENT ? EXIT_ENOENT : EXIT_CANNOT_INVOKE);
-    warn ("%s", shell);
+    warn (_("failed to execute %s"), shell);
     exit (exit_status);
   }
 }
@@ -913,7 +913,7 @@ su_main (int argc, char **argv, int mode)
     run_shell (shell, command, argv + optind, max (0, argc - optind));
   else {
     execvp(argv[optind], &argv[optind]);
-    err(EXIT_FAILURE, _("executing %s failed"), argv[optind]);
+    err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
   }
 }
 
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index cf429fe..db5f41e 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -736,11 +736,11 @@ static void sushell(struct passwd *pwd)
 	}
 #endif
 	execl(su_shell, shell, NULL);
-	warn(_("%s: exec failed"), su_shell);
+	warn(_("failed to execute %s"), su_shell);
 
 	setenv("SHELL", "/bin/sh", 1);
 	execl("/bin/sh", profile ? "-sh" : "sh", NULL);
-	warn(_("%s: exec failed"), "/bin/sh");
+	warn(_("failed to execute %s"), "/bin/sh");
 }
 
 static void usage(FILE *out)
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 0347914..60ec73e 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -331,7 +331,6 @@ int main(int argc, char **argv)
 	if (!pid) {
 		argv += optind + 1;
 		execvp(argv[0], argv);
-		perror("execvp");
 		err(EXIT_FAILURE, _("failed to execute %s"), argv[0]);
 	}
 
diff --git a/schedutils/ionice.c b/schedutils/ionice.c
index f74e3c4..b7e6087 100644
--- a/schedutils/ionice.c
+++ b/schedutils/ionice.c
@@ -229,7 +229,7 @@ int main(int argc, char **argv)
 		 */
 		ioprio_setpid(0, ioclass, data);
 		execvp(argv[optind], &argv[optind]);
-		err(EXIT_FAILURE, _("executing %s failed"), argv[optind]);
+		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
 	} else
 		usage(stderr);
 
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index 9039598..aba0b6f 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -234,7 +234,7 @@ int main(int argc, char **argv)
 	if (!pid) {
 		argv += optind + 1;
 		execvp(argv[0], argv);
-		err(EXIT_FAILURE, _("executing %s failed"), argv[0]);
+		err(EXIT_FAILURE, _("failed to execute %s"), argv[0]);
 	}
 
 	return EXIT_SUCCESS;
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 11c44b6..beda20f 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -318,7 +318,7 @@ int main(int argc, char *argv[])
 				close(fd);
 			execvp(cmd_argv[0], cmd_argv);
 			/* execvp() failed */
-			warn("%s", cmd_argv[0]);
+			warn(_("failed to execute %s"), cmd_argv[0]);
 			_exit((errno == ENOMEM) ? EX_OSERR : EX_UNAVAILABLE);
 		} else {
 			do {
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index b6e6dc1..3df4338 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -319,5 +319,5 @@ int main(int argc, char *argv[])
 
 	execvp(argv[optind], argv + optind);
 
-	err(EXIT_FAILURE, _("exec %s failed"), argv[optind]);
+	err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
 }
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index a619bea..9098e49 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -637,7 +637,7 @@ int main(int argc, char **argv)
 	if (argc > optind) {
 		/* prlimit [options] COMMAND */
 		execvp(argv[optind], &argv[optind]);
-		err(EXIT_FAILURE, _("executing %s failed"), argv[optind]);
+		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
 	}
 
 	return EXIT_SUCCESS;
diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 0edf7dc..f0dada2 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -573,7 +573,7 @@ int main(int argc, char **argv)
 		if (!dryrun) {
 			execv(arg[0], arg);
 
-			warn(_("unable to execute %s"),	_PATH_SHUTDOWN);
+			warn(_("failed to execute %s"), _PATH_SHUTDOWN);
 			rc = EXIT_FAILURE;
 		}
 
diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index d13cdd6..afa2d1b 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -279,7 +279,7 @@ int main(int argc, char *argv[])
        if (set_arch(p, 0L))
            err(EXIT_FAILURE, _("Failed to set personality to %s"), p);
        execl("/bin/bash", NULL);
-       err(EXIT_FAILURE, "/bin/bash");
+       err(EXIT_FAILURE, _("failed to execute %s"), "/bin/bash");
    }
   #endif
 
@@ -342,7 +342,7 @@ int main(int argc, char *argv[])
 
   if (!argc) {
     execl("/bin/sh", "-sh", NULL);
-    err(EXIT_FAILURE, "/bin/sh");
+    err(EXIT_FAILURE, _("failed to execute %s"), "/bin/sh");
   }
 
   execvp(argv[0], argv);
diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index 071ccc4..6c35280 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -94,5 +94,5 @@ int main(int argc, char **argv)
 			warn(_("failed to set the controlling terminal"));
 	}
 	execvp(argv[optind], argv + optind);
-	err(EXIT_FAILURE, _("execvp failed"));
+	err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
 }
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 6efe482..d5b7e37 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -279,7 +279,7 @@ static int swap_reinitialize(const char *device,
 		cmd[idx++] = (char *) device;
 		cmd[idx++] = NULL;
 		execv(cmd[0], cmd);
-		err(EXIT_FAILURE, _("execv failed"));
+		err(EXIT_FAILURE, _("failed to execute %s"), cmd[0]);
 
 	default: /* parent */
 		do {
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 4639ac8..62d2fcb 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -115,5 +115,5 @@ int main(int argc, char *argv[])
 
 	execvp(argv[optind], argv + optind);
 
-	err(EXIT_FAILURE, _("exec %s failed"), argv[optind]);
+	err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
 }
diff --git a/text-utils/pg.c b/text-utils/pg.c
index 95f59a9..ab7a85a 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -1348,7 +1348,7 @@ static void pgfile(FILE *f, const char *name)
 						my_sigset(SIGTERM, oldterm);
 						execl(sh, sh, "-c",
 						      cmd.cmdline + 1, NULL);
-						warn("%s", sh);
+						warn(_("failed to execute %s"), sh);
 						_exit(0177);
 						/* NOTREACHED */
 					}
-- 
1.8.1.2

