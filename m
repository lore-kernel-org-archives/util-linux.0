Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 17/49] login: utmp code refactoring
Date: Mon, 17 Oct 2011 13:14:56 +0200
Message-Id: <1318850128-23458-18-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 configure.ac        |    1 -
 login-utils/login.c |  170 +++++++++++++++++++++++----------------------------
 2 files changed, 77 insertions(+), 94 deletions(-)

diff --git a/configure.ac b/configure.ac
index 66d0794..0baff21 100644
--- a/configure.ac
+++ b/configure.ac
@@ -194,7 +194,6 @@ AC_CHECK_FUNCS(
 	usleep \
 	nanosleep \
 	personality \
-	updwtmp \
 	jrand48 \
 	lchown \
 	llseek \
diff --git a/login-utils/login.c b/login-utils/login.c
index 91f5b81..c4f3d9c 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -289,9 +289,8 @@ static void logbtmp(struct login_context *cxt)
 			memcpy(&ut.ut_addr_v6, cxt->hostaddress,
 			       sizeof(ut.ut_addr_v6));
 	}
-#if HAVE_UPDWTMP		/* bad luck for ancient systems */
+
 	updwtmp(_PATH_BTMP, &ut);
-#endif
 }
 
 static int child_pid = 0;
@@ -390,6 +389,81 @@ static void log_lastlog(struct login_context *cxt)
 	close(fd);
 }
 
+/*
+ * Update wtmp and utmp logs
+ */
+static void log_utmp(struct login_context *cxt)
+{
+	struct utmp ut;
+	struct utmp *utp;
+	struct timeval tv;
+
+	utmpname(_PATH_UTMP);
+	setutent();
+
+	/* Find pid in utmp.
+	 *
+	 * login sometimes overwrites the runlevel entry in /var/run/utmp,
+	 * confusing sysvinit. I added a test for the entry type, and the
+	 * problem was gone. (In a runlevel entry, st_pid is not really a pid
+	 * but some number calculated from the previous and current runlevel).
+	 * -- Michael Riepe <michael@stud.uni-hannover.de>
+	 */
+	while ((utp = getutent()))
+		if (utp->ut_pid == cxt->pid
+		    && utp->ut_type >= INIT_PROCESS
+		    && utp->ut_type <= DEAD_PROCESS)
+			break;
+
+	/* If we can't find a pre-existing entry by pid, try by line.
+	 * BSD network daemons may rely on this.
+	 */
+	if (utp == NULL) {
+		setutent();
+		ut.ut_type = LOGIN_PROCESS;
+		strncpy(ut.ut_line, cxt->tty_name, sizeof(ut.ut_line));
+		utp = getutline(&ut);
+	}
+
+	if (utp)
+		memcpy(&ut, utp, sizeof(ut));
+	else
+		/* some gettys/telnetds don't initialize utmp... */
+		memset(&ut, 0, sizeof(ut));
+
+	if (ut.ut_id[0] == 0)
+		strncpy(ut.ut_id, cxt->tty_number, sizeof(ut.ut_id));
+
+	strncpy(ut.ut_user, cxt->username, sizeof(ut.ut_user));
+	xstrncpy(ut.ut_line, cxt->tty_name, sizeof(ut.ut_line));
+
+#ifdef _HAVE_UT_TV		/* in <utmpbits.h> included by <utmp.h> */
+	gettimeofday(&tv, NULL);
+	ut.ut_tv.tv_sec = tv.tv_sec;
+	ut.ut_tv.tv_usec = tv.tv_usec;
+#else
+	{
+		time_t t;
+		time(&t);
+		ut.ut_time = t;	/* ut_time is not always a time_t */
+				/* glibc2 #defines it as ut_tv.tv_sec */
+	}
+#endif
+	ut.ut_type = USER_PROCESS;
+	ut.ut_pid = cxt->pid;
+	if (cxt->hostname) {
+		xstrncpy(ut.ut_host, cxt->hostname, sizeof(ut.ut_host));
+		if (cxt->hostaddress && *cxt->hostaddress)
+			memcpy(&ut.ut_addr_v6, cxt->hostaddress,
+			       sizeof(ut.ut_addr_v6));
+	}
+
+	pututline(&ut);
+	endutent();
+
+	updwtmp(_PATH_WTMP, &ut);
+}
+
 /* encapsulate stupid "void **" pam_get_item() API */
 static int loginpam_get_username(pam_handle_t * pamh, char **name)
 {
@@ -772,97 +846,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	/* for linux, write entries in utmp and wtmp */
-	{
-		struct utmp ut;
-		struct utmp *utp;
-		struct timeval tv;
-
-		utmpname(_PATH_UTMP);
-		setutent();
-
-		/* Find pid in utmp.
-		   login sometimes overwrites the runlevel entry in /var/run/utmp,
-		   confusing sysvinit. I added a test for the entry type, and the problem
-		   was gone. (In a runlevel entry, st_pid is not really a pid but some number
-		   calculated from the previous and current runlevel).
-		   Michael Riepe <michael@stud.uni-hannover.de>
-		 */
-		while ((utp = getutent()))
-			if (utp->ut_pid == cxt.pid
-			    && utp->ut_type >= INIT_PROCESS
-			    && utp->ut_type <= DEAD_PROCESS)
-				break;
-
-		/* If we can't find a pre-existing entry by pid, try by line.
-		   BSD network daemons may rely on this. (anonymous) */
-		if (utp == NULL) {
-			setutent();
-			ut.ut_type = LOGIN_PROCESS;
-			strncpy(ut.ut_line, cxt.tty_name, sizeof(ut.ut_line));
-			utp = getutline(&ut);
-		}
-
-		if (utp) {
-			memcpy(&ut, utp, sizeof(ut));
-		} else {
-			/* some gettys/telnetds don't initialize utmp... */
-			memset(&ut, 0, sizeof(ut));
-		}
-
-		if (ut.ut_id[0] == 0)
-			strncpy(ut.ut_id, cxt.tty_number, sizeof(ut.ut_id));
-
-		strncpy(ut.ut_user, cxt.username, sizeof(ut.ut_user));
-		xstrncpy(ut.ut_line, cxt.tty_name, sizeof(ut.ut_line));
-#ifdef _HAVE_UT_TV		/* in <utmpbits.h> included by <utmp.h> */
-		gettimeofday(&tv, NULL);
-		ut.ut_tv.tv_sec = tv.tv_sec;
-		ut.ut_tv.tv_usec = tv.tv_usec;
-#else
-		{
-			time_t t;
-			time(&t);
-			ut.ut_time = t;	/* ut_time is not always a time_t */
-			/* glibc2 #defines it as ut_tv.tv_sec */
-		}
-#endif
-		ut.ut_type = USER_PROCESS;
-		ut.ut_pid = cxt.pid;
-		if (cxt.hostname) {
-			xstrncpy(ut.ut_host, cxt.hostname, sizeof(ut.ut_host));
-			if (cxt.hostaddress[0])
-				memcpy(&ut.ut_addr_v6, cxt.hostaddress,
-				       sizeof(ut.ut_addr_v6));
-		}
-
-		pututline(&ut);
-		endutent();
-
-#if HAVE_UPDWTMP
-		updwtmp(_PATH_WTMP, &ut);
-#else
-		/* Probably all this locking below is just nonsense,
-		   and the short version is OK as well. */
-		{
-			int lf, wtmp;
-			if ((lf =
-			     open(_PATH_WTMPLOCK, O_CREAT | O_WRONLY,
-				  0660)) >= 0) {
-				flock(lf, LOCK_EX);
-				if ((wtmp =
-				     open(_PATH_WTMP,
-					  O_APPEND | O_WRONLY)) >= 0) {
-					write(wtmp, (char *)&ut, sizeof(ut));
-					close(wtmp);
-				}
-				flock(lf, LOCK_UN);
-				close(lf);
-			}
-		}
-#endif
-	}
-
+	log_utmp(&cxt);
 	log_audit(&cxt, pwd, 1);
 	log_lastlog(&cxt);
 
-- 
1.7.6.4
