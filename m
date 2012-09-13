Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12953 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756340Ab2IMKMn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 13 Sep 2012 06:12:43 -0400
Date: Thu, 13 Sep 2012 12:12:32 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Ludwig Nussel <ludwig.nussel@suse.de>
Subject: Re: runuser(1) and su(1) -g/-G
Message-ID: <20120913101232.GA1752@x2.net.home>
References: <20120904151843.GA6389@x2.net.home>
 <20120905123822.GZ1899@rampage>
 <20120905212804.GD1899@rampage>
 <20120907120716.GD23242@x2.net.home>
 <5049EB15.3080309@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5049EB15.3080309@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 07, 2012 at 01:39:49PM +0100, Pádraig Brady wrote:
> Maybe we could keep the runuser name and say
> the prefered form is to specify -u $USER, which
> will _not_ start a shell. The old interface without
> -u being retained for backwards compat?

Good idea. Implemented, see below. The su-like options -c/C, -l and -f
are mutually exclusive to -u.

(and sorry for coding style. I'm absolutely incompatible with the
 original code -- when all the changes will be in master branch we'll
 use indent to make it readable for lovers of the kernel-style ...)

    Karel

>From 6ec71facf066ade0c42b98b274d041c6e0ed6d8c Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Thu, 13 Sep 2012 11:58:00 +0200
Subject: [PATCH] runuser: add -u to not execute shell

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/runuser.1   |   20 +++++---
 login-utils/su-common.c |  138 +++++++++++++++++++++++++++++++----------------
 login-utils/su.1        |    1 +
 3 files changed, 105 insertions(+), 54 deletions(-)

diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 1f21408..9a00cb6 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -3,10 +3,21 @@
 runuser \- run a command with substitute user and group ID
 .SH SYNOPSIS
 .B runuser
-[options...] [\-] [user [args...]]
+[options] -u
+.IR user
+.IR "command " [ argument ...]
+.LP
+.B runuser
+[options] [-]
+[
+.IR "user " [ argument ...]
+]
 .SH DESCRIPTION
 .B runuser
 allows to run commands with substitute user and group ID.
+If the option \fB\-u\fR not given, fallback to
+.B su
+compatible semantic and shell is executed.
 The difference between the commands
 .B runuser
 and
@@ -37,12 +48,7 @@ and
 .B LOGNAME
 if the target
 .I user
-is not root).  It is recommended to always use the
-.B \-\-login
-option (instead it's shortcut
-.BR \- )
-to avoid side effects caused by mixing environments.
-.PP
+is not root).
 This version of
 .B runuser
 uses PAM for session management.
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 23ad57d..c6f3389 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -543,7 +543,8 @@ modify_environment (const struct passwd *pw, const char *shell)
       if (term)
 	xsetenv ("TERM", term, 1);
       xsetenv ("HOME", pw->pw_dir, 1);
-      xsetenv ("SHELL", shell, 1);
+      if (shell)
+	xsetenv ("SHELL", shell, 1);
       xsetenv ("USER", pw->pw_name, 1);
       xsetenv ("LOGNAME", pw->pw_name, 1);
       set_path(pw);
@@ -555,7 +556,8 @@ modify_environment (const struct passwd *pw, const char *shell)
       if (change_environment)
         {
           xsetenv ("HOME", pw->pw_dir, 1);
-          xsetenv ("SHELL", shell, 1);
+	  if (shell)
+            xsetenv ("SHELL", shell, 1);
 	  if (getlogindefs_bool ("ALWAYS_SET_PATH", 0))
 	    set_path(pw);
 	  else
@@ -690,35 +692,47 @@ restricted_shell (const char *shell)
 static void __attribute__((__noreturn__))
 usage (int status)
 {
-  if (status != EXIT_SUCCESS)
-    fprintf (stderr, _("Try `%s --help' for more information.\n"),
-	     program_invocation_short_name);
-  else
-    {
-      fputs(USAGE_HEADER, stdout);
-      printf (_(" %s [options] [-] [USER [arg]...]\n"), program_invocation_short_name);
-      fputs (_("\n\
- Change the effective user id and group id to that of USER.\n\
- A mere - implies -l.   If USER not given, assume root.\n"), stdout);
-      fputs(USAGE_OPTIONS, stdout);
-      fputs (_("\
- -, -l, --login               make the shell a login shell\n\
- -c, --command <command>      pass a single command to the shell with -c\n\
- --session-command <command>  pass a single command to the shell with -c\n\
-                              and do not create a new session\n\
- -g --group=group             specify the primary group\n\
- -G --supp-group=group        specify a supplemental group\n\
- -f, --fast                   pass -f to the shell (for csh or tcsh)\n\
- -m, --preserve-environment   do not reset environment variables\n\
- -p                           same as -m\n\
- -s, --shell <shell>          run shell if /etc/shells allows it\n\
-"), stdout);
-
-      fputs(USAGE_SEPARATOR, stdout);
-      fputs(USAGE_HELP, stdout);
-      fputs(USAGE_VERSION, stdout);
-      printf(USAGE_MAN_TAIL("su(1)"));
-    }
+  if (su_mode == RUNUSER_MODE) {
+    fputs(USAGE_HEADER, stdout);
+    printf (_(" %s [options] -u <USER> COMMAND\n"), program_invocation_short_name);
+    printf (_(" %s [options] [-] [USER [arg]...]\n"), program_invocation_short_name);
+    fputs (_("\n"
+    "Run COMMAND with the effective <user> id and group id. If -u not\n"
+    "given, fallback to su(1) compatible semantic and shell is executed.\n"
+    "The options -l, -c, -f, -s are mutually exclusive to -u.\n"), stdout);
+
+    fputs(USAGE_OPTIONS, stdout);
+
+    fputs (_(
+    " -u, --user <user>               username\n"), stdout);
+
+  } else {
+    fputs(USAGE_HEADER, stdout);
+    printf (_(" %s [options] [-] [USER [arg]...]\n"), program_invocation_short_name);
+    fputs (_("\n"
+    "Change the effective user id and group id to that of USER.\n"
+    "A mere - implies -l.   If USER not given, assume root.\n"), stdout);
+
+    fputs(USAGE_OPTIONS, stdout);
+  }
+
+  fputs (_(
+    " -m, -p, --preserve-environment  do not reset environment variables\n"
+    " -g, --group <group>             specify the primary group\n"
+    " -G, --supp-group <group>        specify a supplemental group\n\n"), stdout);
+
+  fputs (_(
+    " -, -l, --login                  make the shell a login shell\n"
+    " -c, --command <command>         pass a single command to the shell with -c\n"
+    " --session-command <command>     pass a single command to the shell with -c\n"
+    "                                 and do not create a new session\n"
+    " -f, --fast                      pass -f to the shell (for csh or tcsh)\n"
+    " -s, --shell <shell>             run shell if /etc/shells allows it\n"), stdout);
+
+  fputs(USAGE_SEPARATOR, stdout);
+  fputs(USAGE_HELP, stdout);
+  fputs(USAGE_VERSION, stdout);
+  printf(USAGE_MAN_TAIL(su_mode == SU_MODE ? "su(1)" : "runuser(1)"));
   exit (status);
 }
 
@@ -754,7 +768,7 @@ int
 su_main (int argc, char **argv, int mode)
 {
   int optc;
-  const char *new_user = DEFAULT_USER;
+  const char *new_user = DEFAULT_USER, *runuser_user = NULL;
   char *command = NULL;
   int request_same_session = 0;
   char *shell = NULL;
@@ -774,6 +788,7 @@ su_main (int argc, char **argv, int mode)
     {"shell", required_argument, NULL, 's'},
     {"group", required_argument, NULL, 'g'},
     {"supp-group", required_argument, NULL, 'G'},
+    {"user", required_argument, NULL, 'u'},		/* runuser only */
     {"help", no_argument, 0, 'h'},
     {"version", no_argument, 0, 'V'},
     {NULL, 0, NULL, 0}
@@ -789,7 +804,7 @@ su_main (int argc, char **argv, int mode)
   simulate_login = false;
   change_environment = true;
 
-  while ((optc = getopt_long (argc, argv, "c:fg:G:lmps:hV", longopts, NULL)) != -1)
+  while ((optc = getopt_long (argc, argv, "+c:fg:G:lmps:u:hV", longopts, NULL)) != -1)
     {
       switch (optc)
 	{
@@ -839,6 +854,12 @@ su_main (int argc, char **argv, int mode)
 	  shell = optarg;
 	  break;
 
+	case 'u':
+	  if (su_mode != RUNUSER_MODE)
+	    usage (EXIT_FAILURE);
+	  runuser_user = optarg;
+	  break;
+
 	case 'h':
 	  usage(0);
 
@@ -858,8 +879,21 @@ su_main (int argc, char **argv, int mode)
       simulate_login = true;
       ++optind;
     }
-  if (optind < argc)
+
+  /* if not "-u <user>" specified then fallback to classic su(1) */
+  if (!runuser_user && optind < argc)
     new_user = argv[optind++];
+  else {
+      /* runuser -u <command> */
+    new_user = runuser_user;
+    if (shell || fast_startup || command || simulate_login) {
+      errx(EXIT_FAILURE,
+	   _("options --{shell,fast,command,session-command,login} and "
+	     "--user are mutually exclusive."));
+    }
+    if (optind == argc)
+      errx(EXIT_FAILURE, _("COMMAND not specified."));
+  }
 
   if ((num_supp_groups || use_gid) && restricted)
     errx(EXIT_FAILURE, _("only root can specify alternative groups"));
@@ -903,18 +937,23 @@ su_main (int argc, char **argv, int mode)
   if (request_same_session || !command || !pw->pw_uid)
     same_session = 1;
 
-  if (!shell && !change_environment)
-    shell = getenv ("SHELL");
-  if (shell && getuid () != 0 && restricted_shell (pw->pw_shell))
-    {
-      /* The user being su'd to has a nonstandard shell, and so is
-	 probably a uucp account or has restricted access.  Don't
-	 compromise the account by allowing access with a standard
-	 shell.  */
-      warnx (_("using restricted shell %s"), pw->pw_shell);
-      shell = NULL;
-    }
-  shell = xstrdup (shell ? shell : pw->pw_shell);
+  /* initialize shell variable only if "-u <user>" not specified */
+  if (runuser_user) {
+    shell = NULL;
+  } else {
+    if (!shell && !change_environment)
+      shell = getenv ("SHELL");
+    if (shell && getuid () != 0 && restricted_shell (pw->pw_shell))
+      {
+	/* The user being su'd to has a nonstandard shell, and so is
+	   probably a uucp account or has restricted access.  Don't
+	   compromise the account by allowing access with a standard
+	   shell.  */
+	warnx (_("using restricted shell %s"), pw->pw_shell);
+	shell = NULL;
+      }
+    shell = xstrdup (shell ? shell : pw->pw_shell);
+  }
 
   init_groups (pw, groups, num_supp_groups);
 
@@ -933,7 +972,12 @@ su_main (int argc, char **argv, int mode)
   if (simulate_login && chdir (pw->pw_dir) != 0)
     warn (_("warning: cannot change directory to %s"), pw->pw_dir);
 
-  run_shell (shell, command, argv + optind, max (0, argc - optind));
+  if (shell)
+    run_shell (shell, command, argv + optind, max (0, argc - optind));
+  else {
+    execvp(argv[optind], &argv[optind]);
+    err(EXIT_FAILURE, _("executing %s failed"), argv[optind]);
+  }
 }
 
 // vim: sw=2 cinoptions=>4,n-2,{2,^-2,\:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
diff --git a/login-utils/su.1 b/login-utils/su.1
index 59e1731..c82b941 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -216,6 +216,7 @@ command specific logindef config file
 global logindef config file
 .PD 1
 .SH "SEE ALSO"
+.BR runuser (8),
 .BR pam (8),
 .BR shells (5),
 .BR login.defs (5)
-- 
1.7.7.6

