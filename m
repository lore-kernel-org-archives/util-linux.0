Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 21/49] login: improve hushed mode (merge suse changes)
Date: Mon, 17 Oct 2011 13:15:00 +0200
Message-Id: <1318850128-23458-22-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 include/pathnames.h |    1 +
 login-utils/login.c |  122 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 91 insertions(+), 32 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index 025e4af..1a54a03 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -29,6 +29,7 @@
 #define _PATH_WTMPLOCK		"/etc/wtmplock"
 
 #define	_PATH_HUSHLOGIN		".hushlogin"
+#define	_PATH_HUSHLOGINS	"/etc/hushlogins"
 
 #ifndef _PATH_MAILDIR
 #define	_PATH_MAILDIR		"/var/spool/mail"
diff --git a/login-utils/login.c b/login-utils/login.c
index 1adf330..7f6048c 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -566,7 +566,7 @@ static int loginpam_err(pam_handle_t * pamh, int retcode)
  * The open(2) seems as the surest solution.
  * -- kzak@redhat.com (10-Apr-2009)
  */
-int effective_access(const char *path, int mode)
+static int effective_access(const char *path, int mode)
 {
 	int fd = open(path, mode);
 	if (fd != -1)
@@ -574,6 +574,94 @@ int effective_access(const char *path, int mode)
 	return fd == -1 ? -1 : 0;
 }
 
+/*
+ * Check per accout or global hush-login setting.
+ *
+ * Hushed mode is enabled:
+ *
+ * a) if global (e.g. /etc/hushlogins) hush file exists:
+ *     1) for ALL ACCOUNTS if the file is empty
+ *     2) for the current user if the username or shell are found in the file
+ *
+ * b) if ~/.hushlogin file exists
+ *
+ * The ~/.hushlogin is ignored if the global hush file exists.
+ *
+ * Note that shadow-utils login(1) does not support "a1)". The "a1)" is
+ * necessary if you want to use PAM for "Last login" message.
+ *
+ * -- Karel Zak <kzak@redhat.com> (26-Aug-2011)
+ *
+ *
+ * Per-account check requires some explanation: As root we may not be able to
+ * read the directory of the user if it is on an NFS mounted filesystem. We
+ * temporarily set our effective uid to the user-uid making sure that we keep
+ * root privs. in the real uid.
+ *
+ * A portable solution would require a fork(), but we rely on Linux having the
+ * BSD setreuid()
+ */
+static int get_hushlogin_status(struct passwd *pwd)
+{
+	const char *files[] = { _PATH_HUSHLOGINS, _PATH_HUSHLOGIN, NULL };
+	char buf[BUFSIZ];
+	int i;
+
+	for (i = 0; files[i]; i++) {
+		const char *file = files[i];
+		int ok = 0;
+
+		/* Global hush-file*/
+		if (*file == '/') {
+			struct stat st;
+			FILE *f;
+
+			if (stat(file, &st) != 0)
+				continue;	/* file does not exist */
+
+			if (st.st_size == 0)
+				return 1;	/* for all accounts */
+
+			f = fopen(file, "r");
+			if (!f)
+				continue;	/* ignore errors... */
+
+			while (ok == 0 && fgets(buf, sizeof(buf), f)) {
+				buf[strlen(buf) - 1] = '\0';
+				ok = !strcmp(buf, *buf == '/' ? pwd->pw_shell :
+								pwd->pw_name);
+			}
+			fclose(f);
+			if (ok)
+				return 1;	/* found username/shell */
+
+			return 0;		/* ignore per-account files */
+		}
+
+		/* Per-account setting */
+		if (strlen(pwd->pw_dir) + sizeof(file) + 2 > sizeof(buf))
+			continue;
+		else {
+			uid_t ruid = getuid();
+			gid_t egid = getegid();
+
+			sprintf(buf, "%s/%s", pwd->pw_dir, file);
+			setregid(-1, pwd->pw_gid);
+			setreuid(0, pwd->pw_uid);
+			ok = effective_access(buf, O_RDONLY) == 0;
+			setuid(0);	/* setreuid doesn't do it alone! */
+			setreuid(ruid, 0);
+			setregid(-1, egid);
+
+			if (ok)
+				return 1;	/* enabled by user */
+		}
+	}
+
+	return 0;
+}
+
+
 int main(int argc, char **argv)
 {
 	extern int optind;
@@ -879,37 +967,7 @@ int main(int argc, char **argv)
 
 	endpwent();
 
-	{
-		/*
-		 * Check per accout setting.
-		 *
-		 * This requires some explanation: As root we may not be able to
-		 * read the directory of the user if it is on an NFS mounted
-		 * filesystem. We temporarily set our effective uid to the user-uid
-		 * making sure that we keep root privs. in the real uid.
-		 *
-		 * A portable solution would require a fork(), but we rely on Linux
-		 * having the BSD setreuid()
-		 */
-		char tmpstr[PATH_MAX];
-		uid_t ruid = getuid();
-		gid_t egid = getegid();
-
-		/* avoid snprintf - old systems do not have it, or worse,
-		   have a libc in which snprintf is the same as sprintf */
-		if (strlen(pwd->pw_dir) + sizeof(_PATH_HUSHLOGIN) + 2 >
-		    PATH_MAX)
-			cxt.quiet = 0;
-		else {
-			sprintf(tmpstr, "%s/%s", pwd->pw_dir, _PATH_HUSHLOGIN);
-			setregid(-1, pwd->pw_gid);
-			setreuid(0, pwd->pw_uid);
-			cxt.quiet = (effective_access(tmpstr, O_RDONLY) == 0);
-			setuid(0);	/* setreuid doesn't do it alone! */
-			setreuid(ruid, 0);
-			setregid(-1, egid);
-		}
-	}
+	cxt.quiet = get_hushlogin_status(pwd);
 
 	log_utmp(&cxt);
 	log_audit(&cxt, 1);
-- 
1.7.6.4
