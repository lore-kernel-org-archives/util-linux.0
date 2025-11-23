Received: from m204-227.eu.mailgun.net (m204-227.eu.mailgun.net [161.38.204.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C62D7386
	for <util-linux@vger.kernel.org>; Sun, 23 Nov 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.38.204.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763911988; cv=none; b=jtWSgbBRiMySvvdIyATwOo1vdaaFbVjcVz7yYgmhvMRR3iWKkdKPqunR7cH4V20ApUBzrR8vJcf6qwFS69mL6MDnrEIzei1BiOXjrmxb77zMJQaZxtipgIuilpKv9O5oGJsAkhHmBQPlTY9MQk4zh8B7rhhP0yHBW91Q5fwB9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763911988; c=relaxed/simple;
	bh=TGIbu/kVrAHN8o3DB4AWCxN02Xr/4m9wEXbJURnZiWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyCJsb5ydXrLRWmuVkFIcz5Ko1trHrpl+ZGf6mU+kyGsYDzl4tmUOS7S/3OhYHEcSQv3ekb6yIYD8UGFT6mT9FDx1pOY7YXCp0+W0ruX520Ue5qBejYHxnzG+TNh4PtYKuJO2u38w9Po4VIiRPs0yIrUyzrToE7R8Q2vKnCyJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=NI3tUizG; arc=none smtp.client-ip=161.38.204.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="NI3tUizG"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1763911981; x=1763919181;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=jII3tL99zdjOH1itfQLiEpv23O/jP3i29jmF3T3l8dA=;
 b=NI3tUizGEJP0FhHHJEe2vJ9lTbc1LQyki1dH6t58Qn9RaP4DyGIVEH3wFiRTuZl912vbpPhyvx04YPzTxk0TjVkh+2XcFHtce8wKc5zUDKVbT6k7K/SBIZQXEao7o2n+kkF31NmGwe/G3aUslSJegvRN0XIOEPnyjysG/jjK68RLDFqxUG8PGyiTdaMVIo60ZdHRUGxkPiYUy9ebxjC3KDc8iCperZNs3+oAgnLJXDSECn7A7Cix1YkrkbdYNtdxuVXaHVcKgrWp32J1AY9CDaYv6/rpLg3WeIyTu57HjOjZko3mBsiQvpoD/2iMH25Sa0fWZTsk6+93GokuLNSoVQ==
X-Mailgun-Sid: WyJlNDM3YyIsInV0aWwtbGludXhAdmdlci5rZXJuZWwub3JnIiwiNTRlZjQiXQ==
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 7cb349a42b1b1f1259b38414f775f2c20b6e7347a6127f8df26891016837968f with SMTP id
 6923292dff9709f65d28f17d; Sun, 23 Nov 2025 15:33:01 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Sender: alessandro@0x65c.net
From: Alessandro Ratti <alessandro@0x65c.net>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	thomas@t-8ch.de,
	Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH 3/3] login-utils, sys-utils: use _PATH_BSHELL consistently
Date: Sun, 23 Nov 2025 16:32:46 +0100
Message-ID: <20251123153246.1056874-4-alessandro@0x65c.net>
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

Remove local DEFAULT_SHELL definitions and hardcoded "/bin/sh" strings
in favor of the standard _PATH_BSHELL macro from <paths.h>. This
provides consistency across the codebase while following libc
conventions.

These tools already perform their own passwd lookups and only need a
fallback value, so they don't require the full ul_default_shell()
resolution logic.

Affected tools:
- su(1): already checks pw_shell validity
- sulogin(8): emergency login with explicit shell handling
- setpriv(1): already has passwd entry for environment setup

Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 login-utils/su-common.c | 5 +----
 login-utils/sulogin.c   | 9 +++++----
 sys-utils/setpriv.c     | 6 ++----
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 4d54eab31..c6232ce7a 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -105,9 +105,6 @@ UL_DEBUG_DEFINE_MASKNAMES(su) = UL_DEBUG_EMPTY_MASKNAMES;
 
 #define is_pam_failure(_rc)	((_rc) != PAM_SUCCESS)
 
-/* The shell to run if none is given in the user's passwd entry.  */
-#define DEFAULT_SHELL "/bin/sh"
-
 /* The user to become if none is specified.  */
 #define DEFAULT_USER "root"
 
@@ -1167,7 +1164,7 @@ int su_main(int argc, char **argv, int mode)
 	su->old_user = xgetlogin();
 
 	if (!su->pwd->pw_shell || !*su->pwd->pw_shell)
-		su->pwd->pw_shell = DEFAULT_SHELL;
+		su->pwd->pw_shell = _PATH_BSHELL;
 
 	if (use_supp && !use_gid)
 		su->pwd->pw_gid = groups[0];
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index eb4609db6..c546cc7c1 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -34,6 +34,7 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <pwd.h>
+#include <paths.h>
 #include <shadow.h>
 #include <termios.h>
 #include <errno.h>
@@ -892,7 +893,7 @@ static void sushell(struct passwd *pwd, struct console *con)
 		if (pwd->pw_shell[0])
 			su_shell = pwd->pw_shell;
 		else
-			su_shell = "/bin/sh";
+			su_shell = _PATH_BSHELL;
 	}
 	if ((p = strrchr(su_shell, '/')) == NULL)
 		p = su_shell;
@@ -941,9 +942,9 @@ static void sushell(struct passwd *pwd, struct console *con)
 	execl(su_shell, shell, (char *)NULL);
 	warn(_("failed to execute %s"), su_shell);
 
-	xsetenv("SHELL", "/bin/sh", 1);
-	execl("/bin/sh", profile ? "-sh" : "sh", (char *)NULL);
-	warn(_("failed to execute %s"), "/bin/sh");
+	xsetenv("SHELL", _PATH_BSHELL, 1);
+	execl(_PATH_BSHELL, profile ? "-sh" : "sh", (char *)NULL);
+	warn(_("failed to execute %s"), _PATH_BSHELL);
 }
 
 #ifdef HAVE_LIBSELINUX
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index c218be8e5..505d1ee5b 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -30,6 +30,7 @@
 #include <sys/prctl.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <paths.h>
 
 #include "all-io.h"
 #include "c.h"
@@ -56,9 +57,6 @@
 
 #define SETPRIV_EXIT_PRIVERR 127	/* how we exit when we fail to set privs */
 
-/* The shell to set SHELL env.variable if none is given in the user's passwd entry.  */
-#define DEFAULT_SHELL "/bin/sh"
-
 static gid_t get_group(const char *s, const char *err);
 
 enum cap_type {
@@ -741,7 +739,7 @@ static void do_reset_environ(struct passwd *pw)
 	if (pw->pw_shell && *pw->pw_shell)
 		xsetenv("SHELL", pw->pw_shell, 1);
 	else
-		xsetenv("SHELL", DEFAULT_SHELL, 1);
+		xsetenv("SHELL", _PATH_BSHELL, 1);
 
 	xsetenv("HOME", pw->pw_dir, 1);
 	xsetenv("USER", pw->pw_name, 1);
-- 
2.51.1

