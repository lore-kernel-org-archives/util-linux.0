Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36346 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1046085AbdDWU6r (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Apr 2017 16:58:47 -0400
Received: by mail-wm0-f50.google.com with SMTP id u65so9498340wmu.1
        for <util-linux@vger.kernel.org>; Sun, 23 Apr 2017 13:58:46 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/10] sulogin: reduce vulnerability surface
Date: Sun, 23 Apr 2017 21:58:18 +0100
Message-Id: <20170423205821.7444-8-kerolasa@iki.fi>
In-Reply-To: <20170423205821.7444-1-kerolasa@iki.fi>
References: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hopefully these changes are unreachable code, but better safe than sorry
when dealing with setuid root code that is installed everywhere.  Quite
obviously the introduced abort() calls protect from impossible inputs.

Secondly set all possible data to be read-only in attempt to make it more
difficult to alter anything at all.

Reference: https://www.securecoding.cert.org/confluence/display/c/DCL00-C.+Const-qualify+immutable+objects
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/su-common.c        | 53 +++++++++++++++++++++++-------------------
 login-utils/sulogin-consoles.c | 20 ++++++++--------
 login-utils/sulogin.c          | 39 ++++++++++++-------------------
 3 files changed, 54 insertions(+), 58 deletions(-)

diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 41f2b1cea..08f327c50 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -126,7 +126,7 @@ static pam_handle_t *pamh = NULL;
 static int restricted = 1;	/* zero for root user */
 
 
-static struct passwd *
+static const struct passwd *
 current_getpwuid(void)
 {
   uid_t ruid;
@@ -149,7 +149,7 @@ current_getpwuid(void)
    if SUCCESSFUL is true, they gave the correct password, etc.  */
 
 static void
-log_syslog(struct passwd const *pw, bool successful)
+log_syslog(struct passwd const * const pw, const bool successful)
 {
   const char *new_user, *old_user, *tty;
 
@@ -161,7 +161,7 @@ log_syslog(struct passwd const *pw, bool successful)
     {
       /* getlogin can fail -- usually due to lack of utmp entry.
 	 Resort to getpwuid.  */
-      struct passwd *pwd = current_getpwuid();
+      const struct passwd *pwd = current_getpwuid();
       old_user = pwd ? pwd->pw_name : "";
     }
 
@@ -180,7 +180,7 @@ log_syslog(struct passwd const *pw, bool successful)
 /*
  * Log failed login attempts in _PATH_BTMP if that exists.
  */
-static void log_btmp(struct passwd const *pw)
+static void log_btmp(struct passwd const * const pw)
 {
 	struct utmpx ut;
 	struct timeval tv;
@@ -230,9 +230,9 @@ static struct pam_conv conv =
 };
 
 static void
-cleanup_pam (int retcode)
+cleanup_pam (const int retcode)
 {
-  int saved_errno = errno;
+  const int saved_errno = errno;
 
   if (_pam_session_opened)
     pam_close_session (pamh, 0);
@@ -275,9 +275,8 @@ create_watching_parent (void)
   sigset_t ourset;
   struct sigaction oldact[3];
   int status = 0;
-  int retval;
+  const int retval = pam_open_session (pamh, 0);;
 
-  retval = pam_open_session (pamh, 0);
   if (is_pam_failure(retval))
     {
       cleanup_pam (retval);
@@ -425,7 +424,7 @@ create_watching_parent (void)
 }
 
 static void
-authenticate (const struct passwd *pw)
+authenticate (const struct passwd * const pw)
 {
   const struct passwd *lpw = NULL;
   const char *cp, *srvname = NULL;
@@ -508,7 +507,7 @@ done:
 }
 
 static void
-set_path(const struct passwd* pw)
+set_path(const struct passwd * const pw)
 {
   int r;
   if (pw->pw_uid)
@@ -525,7 +524,7 @@ set_path(const struct passwd* pw)
    the value for the SHELL environment variable.  */
 
 static void
-modify_environment (const struct passwd *pw, const char *shell)
+modify_environment (const struct passwd * const pw, const char * const shell)
 {
   if (simulate_login)
     {
@@ -573,7 +572,7 @@ modify_environment (const struct passwd *pw, const char *shell)
 /* Become the user and group(s) specified by PW.  */
 
 static void
-init_groups (const struct passwd *pw, gid_t *groups, size_t num_groups)
+init_groups (const struct passwd * const pw, const gid_t * const groups, const size_t num_groups)
 {
   int retval;
 
@@ -599,7 +598,7 @@ init_groups (const struct passwd *pw, gid_t *groups, size_t num_groups)
 }
 
 static void
-change_identity (const struct passwd *pw)
+change_identity (const struct passwd * const pw)
 {
   if (setgid (pw->pw_gid))
     err (EXIT_FAILURE,  _("cannot set group id"));
@@ -613,17 +612,17 @@ change_identity (const struct passwd *pw)
    are N_ADDITIONAL_ARGS extra arguments.  */
 
 static void
-run_shell (char const *shell, char const *command, char **additional_args,
-	   size_t n_additional_args)
+run_shell (char const * const shell, char const * const command, char ** const additional_args,
+	   const size_t n_additional_args)
 {
-  size_t n_args = 1 + fast_startup + 2 * !!command + n_additional_args + 1;
-  char const **args = xcalloc (n_args, sizeof *args);
+  const size_t n_args = 1 + fast_startup + 2 * !!command + n_additional_args + 1;
+  const char const **args = xcalloc (n_args, sizeof *args);
   size_t argno = 1;
 
   if (simulate_login)
     {
       char *arg0;
-      char *shell_basename;
+      const char *shell_basename;
 
       shell_basename = basename (shell);
       arg0 = xmalloc (strlen (shell_basename) + 2);
@@ -655,7 +654,7 @@ run_shell (char const *shell, char const *command, char **additional_args,
    getusershell), else false, meaning it is a standard shell.  */
 
 static bool
-restricted_shell (const char *shell)
+restricted_shell (const char * const shell)
 {
   char *line;
 
@@ -673,7 +672,7 @@ restricted_shell (const char *shell)
 }
 
 static void __attribute__((__noreturn__))
-usage (int status)
+usage (const int status)
 {
   if (su_mode == RUNUSER_MODE) {
     fputs(USAGE_HEADER, stdout);
@@ -726,6 +725,9 @@ void load_config(void)
   case RUNUSER_MODE:
     logindefs_load_file(_PATH_LOGINDEFS_RUNUSER);
     break;
+  default:
+    abort();
+    break;
   }
 
   logindefs_load_file(_PATH_LOGINDEFS);
@@ -737,8 +739,8 @@ void load_config(void)
 static int
 evaluate_uid(void)
 {
-  uid_t ruid = getuid();
-  uid_t euid = geteuid();
+  const uid_t ruid = getuid();
+  const uid_t euid = geteuid();
 
   /* if we're really root and aren't running setuid */
   return (uid_t) 0 == ruid && ruid == euid ? 0 : 1;
@@ -771,9 +773,9 @@ su_main (int argc, char **argv, int mode)
 {
   int optc;
   const char *new_user = DEFAULT_USER, *runuser_user = NULL;
-  char *command = NULL;
+  const char *command = NULL;
   int request_same_session = 0;
-  char *shell = NULL;
+  const char *shell = NULL;
   struct passwd *pw;
   struct passwd pw_copy;
 
@@ -901,6 +903,9 @@ su_main (int argc, char **argv, int mode)
     if (optind < argc)
       new_user = argv[optind++];
     break;
+  default:
+    abort();
+    break;
   }
 
   if ((use_supp || use_gid) && restricted)
diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index 30a0f042a..2c0eed3a4 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -75,7 +75,7 @@ static int consoles_debug;
 		} while (0)
 
 static inline void __attribute__ ((__format__ (__printf__, 1, 2)))
-dbgprint(const char *mesg, ...)
+dbgprint(const char * const mesg, ...)
 {
 	va_list ap;
 	va_start(ap, mesg);
@@ -151,7 +151,7 @@ void emergency_do_mounts(void) { }
  * the caller has to free the result
  */
 static __attribute__((__nonnull__))
-char *oneline(const char *file)
+char *oneline(const char * const file)
 {
 	FILE *fp;
 	char *ret = NULL;
@@ -182,7 +182,7 @@ char *oneline(const char *file)
  *  /sys/class/tty, the caller has to free the result.
  */
 static __attribute__((__malloc__))
-char *actattr(const char *tty)
+char *actattr(const char * const tty)
 {
 	char *ret, *path;
 
@@ -201,7 +201,7 @@ char *actattr(const char *tty)
  * /sys/class/tty.
  */
 static
-dev_t devattr(const char *tty)
+dev_t devattr(const char * const tty)
 {
 	dev_t dev = 0;
 	char *path, *value;
@@ -234,11 +234,11 @@ static
 #ifdef __GNUC__
 __attribute__((__nonnull__,__malloc__,__hot__))
 #endif
-char* scandev(DIR *dir, dev_t comparedev)
+char* scandev(DIR *dir, const dev_t comparedev)
 {
 	char path[PATH_MAX];
 	char *name = NULL;
-	struct dirent *dent;
+	const struct dirent *dent;
 	int len, fd;
 
 	DBG(dbgprint("scanning /dev for %u:%u", major(comparedev), minor(comparedev)));
@@ -313,10 +313,10 @@ static
 #ifdef __GNUC__
 __attribute__((__hot__))
 #endif
-int append_console(struct list_head *consoles, const char *name)
+int append_console(struct list_head *consoles, const char * const name)
 {
 	struct console *restrict tail;
-	struct console *last = NULL;
+	const struct console *last = NULL;
 
 	DBG(dbgprint("appenging %s", name));
 
@@ -549,7 +549,7 @@ done:
 
 #ifdef TIOCGDEV
 static int detect_consoles_from_tiocgdev(struct list_head *consoles,
-					int fallback,
+					const int fallback,
 					const char *device)
 {
 	unsigned int devnum;
@@ -619,7 +619,7 @@ done:
  * Returns 1 if stdout and stderr should be reconnected and 0
  * otherwise or less than zero on error.
  */
-int detect_consoles(const char *device, int fallback, struct list_head *consoles)
+int detect_consoles(const char *device, const int fallback, struct list_head *consoles)
 {
 	int fd, reconnect = 0, rc;
 	dev_t comparedev = 0;
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 9f539d791..0d6e6a914 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -89,7 +89,7 @@ static volatile sig_atomic_t sigchild;
 # define WEXITED 0
 #endif
 
-static int locked_account_password(const char *passwd)
+static int locked_account_password(const char * const passwd)
 {
 	if (passwd && (*passwd == '*' || *passwd == '!'))
 		return 1;
@@ -101,9 +101,9 @@ static int locked_account_password(const char *passwd)
  */
 static void tcinit(struct console *con)
 {
-	int mode = 0, flags = 0;
+	int flags = 0;
 	struct termios *tio = &con->tio;
-	int fd = con->fd;
+	const int mode = 0, fd = con->fd;
 #ifdef USE_PLYMOUTH_SUPPORT
 	struct termios lock;
 	int i = (plymouth_command(MAGIC_PING)) ? PLYMOUTH_TERMIOS_FLAGS_DELAY : 0;
@@ -216,8 +216,8 @@ setattr:
  */
 static void tcfinal(struct console *con)
 {
-	struct termios *tio;
-	int fd;
+	struct termios *tio = &con->tio;
+	const int fd = con->fd;
 
 	if ((con->flags & CON_SERIAL) == 0) {
 		xsetenv("TERM", "linux", 1);
@@ -233,9 +233,6 @@ static void tcfinal(struct console *con)
 #else
 	xsetenv("TERM", "vt102", 1);
 #endif
-	tio = &con->tio;
-	fd = con->fd;
-
 	tio->c_iflag |= (IXON | IXOFF);
 	tio->c_lflag |= (ICANON | ISIG | ECHO|ECHOE|ECHOK|ECHOKE);
 	tio->c_oflag |= OPOST;
@@ -557,22 +554,17 @@ err:
  */
 static void setup(struct console *con)
 {
-	pid_t pid, pgrp, ppgrp, ttypgrp;
-	int fd;
+	int fd = con->fd;
+	const pid_t pid = getpid(), pgrp = getpgid(0), ppgrp =
+	    getpgid(getppid()), ttypgrp = tcgetpgrp(fd);
 
 	if (con->flags & CON_NOTTY)
 		return;
-	fd = con->fd;
 
 	/*
 	 * Only go through this trouble if the new
 	 * tty doesn't fall in this process group.
 	 */
-	pid = getpid();
-	pgrp = getpgid(0);
-	ppgrp = getpgid(getppid());
-	ttypgrp = tcgetpgrp(fd);
-
 	if (pgrp != ttypgrp && ppgrp != ttypgrp) {
 		if (pid != getsid(0)) {
 			if (pid == getpgid(0))
@@ -608,21 +600,20 @@ static void setup(struct console *con)
  * Ask for the password. Note that there is no default timeout as we normally
  * skip this during boot.
  */
-static char *getpasswd(struct console *con)
+static const char *getpasswd(struct console *con)
 {
 	struct sigaction sa;
 	struct termios tty;
 	static char pass[128], *ptr;
 	struct chardata *cp;
-	char *ret = pass;
+	const char *ret = pass;
 	unsigned char tc;
 	char c, ascval;
 	int eightbit;
-	int fd;
+	const int fd = con->fd;
 
 	if (con->flags & CON_NOTTY)
 		goto out;
-	fd = con->fd;
 	cp = &con->cp;
 	tty = con->tio;
 
@@ -728,8 +719,8 @@ static void sushell(struct passwd *pwd)
 {
 	char shell[PATH_MAX];
 	char home[PATH_MAX];
-	char *p;
-	char *su_shell;
+	char const *p;
+	char const *su_shell;
 
 	/*
 	 * Set directory and shell.
@@ -831,8 +822,8 @@ int main(int argc, char **argv)
 	struct console *con;
 	char *tty = NULL;
 	struct passwd *pwd;
-	struct timespec sigwait = { .tv_sec = 0, .tv_nsec = 50000000 };
-	siginfo_t status = {};
+	const struct timespec sigwait = { .tv_sec = 0, .tv_nsec = 50000000 };
+	siginfo_t status = { 0 };
 	sigset_t set;
 	int c, reconnect = 0;
 	int opt_e = 0;
-- 
2.12.2

