Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D8398FA5
	for <util-linux@vger.kernel.org>; Wed,  3 Dec 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764795034; cv=none; b=Kg/0V0cZh3Y3ayScNYoZ8pa3Wb+zu6duQC5ytZFDq/MKegj0DN/WeId6DAlnCh1UaS55AwcN2s7mf+2AzlEQP8OXTBvBS5PuvpseqZ0f0OxjPUWx5FdraOikqOdh9ZxPzNakPBTm3dM7bJO6OoB0BNRNCd2epDVgsO4J5bFrjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764795034; c=relaxed/simple;
	bh=ECvt5VSuRAUvG4fMYylhQOioQ69NxgV7emthqis+4Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhCB7qlC7vPle2gx4Fpl6WNUoJbsUf3KqhIS1XIzsgoxolPLWje1vo0oJI9RubGXulY6rJGCW0mNct8LeTbOqNVcCDFY29LK+ElRM9htDQ/aWdlDmz1OF5pKAFmpC0uPGS7IcVet6DiGFnlB1VVFWiyRQjAC+Eyg5S3rOXZJH9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MejqcMbT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MejqcMbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED9AC4CEF5;
	Wed,  3 Dec 2025 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764795033;
	bh=ECvt5VSuRAUvG4fMYylhQOioQ69NxgV7emthqis+4Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MejqcMbT3IHWFPVm/E5GTWMhAmcn/DsdPmLX66x3fE6cRDODePDLUahDRyckoA9+g
	 cD3JrufhiwSv2h56lWQzzcwxNINniBx1p78USt0hWtlQjcpHUQ7DpAwgFHddyg/WhP
	 k2mkbzIT9Wo6Ls/1zBxR/0ViYhiAN6YeWbOK2pHVbgndF11RSK8ojYOxndXAvENQU+
	 jU/b2NnDKGYK0vn8M7/VMb/nug1m3sIy/xCrtGDkhkpxIYkLLWED2btqrRDDAedFmS
	 TuJJNhsGJYt2GcK4XxU6jGImMNZxdMAoMnXHOqkgNjVdmqVojomKARKR0Hwjt3aSwO
	 VLuJC4K3HjCYw==
Date: Wed, 3 Dec 2025 21:50:30 +0100
From: Alejandro Colomar <alx@kernel.org>
To: util-linux@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 1/1] Call prctl(2) with signed long integers, and avoid
 casts
Message-ID: <c4fc41abf1197e0823da95e17993d7af173a7161.1764794880.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <20240601093150.16912-1-alx@kernel.org>
 <cover.1764794880.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1764794880.git.alx@kernel.org>

Since libc's prctl(2) wrapper is a variadic function, arguments must
have the right width.  Otherwise, the behavior is undefined.  The kernel
expects long arguments, so let's provide them.

Also, avoid some casts to unsigned long, by changing the type of the
parameter in some local wrappers.

And use consistently 0L.  0UL is basically the same, and uses one more
character.  Keep it short.  Also, unsigned integer literals are
dangerous, as the compiler can't diagnose mistakes such as overflow.

-  Casts are evil.
-  prctl(2) expects long integers, and

Link: <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=6698b096a6f5342cb9b338c237ed875a8635497a>
Link: <https://lore.kernel.org/linux-man/ddbdyaiptesjalgfmztxideej67e3yaob7ucsmbf6qvriwxiif@dohhxrqgwhrf/T/#med306b5b003f9cc7cc2de69fcdd7ee2d056d0954>
Link: <https://lore.kernel.org/util-linux/20240601093150.16912-1-alx@kernel.org/T/#u>
Link: <https://github.com/util-linux/util-linux/pull/3085>
Cc: Xi Ruoyao <xry111@xry111.site>
Cc: Thomas Weißschuh <thomas@t-8ch.de>
Cc: Karel Zak <kzak@redhat.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 lib/caputils.c               |  6 +++---
 lib/env.c                    |  4 ++--
 misc-utils/enosys.c          |  2 +-
 schedutils/coresched.c       |  6 +++---
 sys-utils/setpriv-landlock.c |  2 +-
 sys-utils/setpriv.c          | 27 +++++++++++++--------------
 tests/helpers/test_mkfds.c   |  2 +-
 7 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/lib/caputils.c b/lib/caputils.c
index 6c71c06b8..ea885ac62 100644
--- a/lib/caputils.c
+++ b/lib/caputils.c
@@ -25,10 +25,10 @@
 #include "procfs.h"
 #include "nls.h"
 
-static int test_cap(unsigned int cap)
+static int test_cap(unsigned long cap)
 {
 	/* prctl returns 0 or 1 for valid caps, -1 otherwise */
-	return prctl(PR_CAPBSET_READ, cap, 0, 0, 0) >= 0;
+	return prctl(PR_CAPBSET_READ, cap, 0L, 0L, 0L) >= 0;
 }
 
 static int cap_last_by_bsearch(int *ret)
@@ -119,7 +119,7 @@ void cap_permitted_to_ambient(void)
 			continue;
 
 		if ((effective & (1ULL << cap))
-		    && prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, cap, 0, 0) < 0)
+		    && prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, cap, 0L, 0L) < 0)
 			err(EXIT_FAILURE, _("prctl(PR_CAP_AMBIENT) failed"));
 	}
 }
diff --git a/lib/env.c b/lib/env.c
index 039fad0dc..7669a17b8 100644
--- a/lib/env.c
+++ b/lib/env.c
@@ -263,11 +263,11 @@ char *safe_getenv(const char *arg)
 	if (is_privileged_execution())
 		return NULL;
 #ifdef HAVE_PRCTL
-	if (prctl(PR_GET_DUMPABLE, 0, 0, 0, 0) == 0)
+	if (prctl(PR_GET_DUMPABLE, 0L, 0L, 0L, 0L) == 0)
 		return NULL;
 #else
 #if (defined(linux) && defined(SYS_prctl))
-	if (syscall(SYS_prctl, PR_GET_DUMPABLE, 0, 0, 0, 0) == 0)
+	if (syscall(SYS_prctl, PR_GET_DUMPABLE, 0L, 0L, 0L, 0L) == 0)
 		return NULL;
 #endif
 #endif
diff --git a/misc-utils/enosys.c b/misc-utils/enosys.c
index f1438b8e8..11f183901 100644
--- a/misc-utils/enosys.c
+++ b/misc-utils/enosys.c
@@ -298,7 +298,7 @@ int main(int argc, char **argv)
 	if (prctl(PR_GET_SECCOMP) == -1 && errno == EINVAL)
 		err(EXIT_NOTSUPP, _("Seccomp non-functional"));
 
-	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, 0L, 0L))
 		err_nosys(EXIT_FAILURE, _("Could not run prctl(PR_SET_NO_NEW_PRIVS)"));
 
 	if (ul_set_seccomp_filter_spec_allow(&prog))
diff --git a/schedutils/coresched.c b/schedutils/coresched.c
index 419745897..aaacf4027 100644
--- a/schedutils/coresched.c
+++ b/schedutils/coresched.c
@@ -122,20 +122,20 @@ static sched_core_cookie core_sched_get_cookie(pid_t pid)
 
 static void core_sched_create_cookie(pid_t pid, sched_core_scope type)
 {
-	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, type, 0))
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, type, 0L))
 		err(EXIT_FAILURE, _("Failed to create cookie for PID %d"), pid);
 }
 
 static void core_sched_pull_cookie(pid_t from)
 {
 	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
-		  PR_SCHED_CORE_SCOPE_THREAD, 0))
+		  PR_SCHED_CORE_SCOPE_THREAD, 0L))
 		err(EXIT_FAILURE, _("Failed to pull cookie from PID %d"), from);
 }
 
 static void core_sched_push_cookie(pid_t to, sched_core_scope type)
 {
-	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0))
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0L))
 		err(EXIT_FAILURE, _("Failed to push cookie to PID %d"), to);
 }
 
diff --git a/sys-utils/setpriv-landlock.c b/sys-utils/setpriv-landlock.c
index 90ab8954b..9089a3c95 100644
--- a/sys-utils/setpriv-landlock.c
+++ b/sys-utils/setpriv-landlock.c
@@ -191,7 +191,7 @@ void do_landlock(const struct setpriv_landlock_opts *opts)
 			err(SETPRIV_EXIT_PRIVERR, _("adding landlock rule failed"));
 	}
 
-	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) == -1)
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, 0L, 0L) == -1)
 		err(SETPRIV_EXIT_PRIVERR, _("disallow granting new privileges for landlock failed"));
 
 	if (landlock_restrict_self(fd, 0) == -1)
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index c218be8e5..f0f423819 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -171,7 +171,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	exit(EXIT_SUCCESS);
 }
 
-static int has_cap(enum cap_type which, unsigned int i)
+static int has_cap(enum cap_type which, unsigned long i)
 {
 	switch (which) {
 	case CAP_TYPE_EFFECTIVE:
@@ -180,8 +180,7 @@ static int has_cap(enum cap_type which, unsigned int i)
 	case CAP_TYPE_PERMITTED:
 		return capng_have_capability((capng_type_t)which, i);
 	case CAP_TYPE_AMBIENT:
-		return prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_IS_SET,
-				(unsigned long) i, 0UL, 0UL);
+		return prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_IS_SET, i, 0L, 0L);
 	default:
 		warnx(_("invalid capability type"));
 		return -1;
@@ -229,7 +228,7 @@ static void dump_one_secbit(int *first, int *bits, int bit, const char *name)
 static void dump_securebits(void)
 {
 	int first = 1;
-	int bits = prctl(PR_GET_SECUREBITS, 0, 0, 0, 0);
+	int bits = prctl(PR_GET_SECUREBITS, 0L, 0L, 0L, 0L);
 
 	if (bits < 0) {
 		warnx(_("getting process secure bits failed"));
@@ -369,7 +368,7 @@ static void dump(int dumplevel)
 
 	dump_groups();
 
-	x = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+	x = prctl(PR_GET_NO_NEW_PRIVS, 0L, 0L, 0L, 0L);
 	if (0 <= x)
 		printf("no_new_privs: %d\n", x);
 	else
@@ -513,7 +512,7 @@ static void bump_cap(unsigned int cap)
 }
 
 static int cap_update(capng_act_t action,
-		enum cap_type type, unsigned int cap)
+		enum cap_type type, unsigned long cap)
 {
 	switch (type) {
 		case CAP_TYPE_EFFECTIVE:
@@ -527,10 +526,10 @@ static int cap_update(capng_act_t action,
 
 			if (action == CAPNG_ADD)
 				ret = prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE,
-						(unsigned long) cap, 0UL, 0UL);
+						cap, 0L, 0L);
 			else
 				ret = prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_LOWER,
-						(unsigned long) cap, 0UL, 0UL);
+						cap, 0L, 0L);
 
 			return ret;
 		}
@@ -584,7 +583,7 @@ static void parse_securebits(struct privctx *opts, const char *arg)
 	char *c;
 
 	opts->have_securebits = 1;
-	opts->securebits = prctl(PR_GET_SECUREBITS, 0, 0, 0, 0);
+	opts->securebits = prctl(PR_GET_SECUREBITS, 0L, 0L, 0L, 0L);
 	if (opts->securebits < 0)
 		err(SETPRIV_EXIT_PRIVERR, _("getting process secure bits failed"));
 
@@ -709,7 +708,7 @@ static void do_seccomp_filter(const char *file)
 	if (prctl(PR_GET_SECCOMP) == -1 && errno == EINVAL)
 		err(SETPRIV_EXIT_PRIVERR, _("Seccomp non-functional"));
 
-	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, 0L, 0L))
 		err(SETPRIV_EXIT_PRIVERR, _("Could not run prctl(PR_SET_NO_NEW_PRIVS)"));
 
 	if (ul_set_seccomp_filter_spec_allow(&prog))
@@ -1086,7 +1085,7 @@ int main(int argc, char **argv)
 		do_reset_environ(pw);
 	}
 
-	if (opts.nnp && prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) == -1)
+	if (opts.nnp && prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, 0L, 0L) == -1)
 		err(EXIT_FAILURE, _("disallow granting new privileges failed"));
 
 	if (opts.selinux_label)
@@ -1096,7 +1095,7 @@ int main(int argc, char **argv)
 	if (opts.seccomp_filter)
 		do_seccomp_filter(opts.seccomp_filter);
 
-	if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0) == -1)
+	if (prctl(PR_SET_KEEPCAPS, 1L, 0L, 0L, 0L) == -1)
 		err(EXIT_FAILURE, _("keep process capabilities failed"));
 
 	/* We're going to want CAP_SETPCAP, CAP_SETUID, and CAP_SETGID if
@@ -1129,7 +1128,7 @@ int main(int argc, char **argv)
 			err(SETPRIV_EXIT_PRIVERR, _("setgroups failed"));
 	}
 
-	if (opts.have_securebits && prctl(PR_SET_SECUREBITS, opts.securebits, 0, 0, 0) != 0)
+	if (opts.have_securebits && prctl(PR_SET_SECUREBITS, opts.securebits, 0L, 0L, 0L) != 0)
 		err(SETPRIV_EXIT_PRIVERR, _("set process securebits failed"));
 
 	if (opts.bounding_set) {
@@ -1150,7 +1149,7 @@ int main(int argc, char **argv)
 	}
 
 	/* Clear or set parent death signal */
-	if (opts.pdeathsig && prctl(PR_SET_PDEATHSIG, opts.pdeathsig < 0 ? 0 : opts.pdeathsig) != 0)
+	if (opts.pdeathsig && prctl(PR_SET_PDEATHSIG, opts.pdeathsig < 0 ? 0L : opts.pdeathsig) != 0)
 		err(SETPRIV_EXIT_PRIVERR, _("set parent death signal failed"));
 
 	if (opts.have_ptracer) {
diff --git a/tests/helpers/test_mkfds.c b/tests/helpers/test_mkfds.c
index 57f99e5a3..ee2d95da8 100644
--- a/tests/helpers/test_mkfds.c
+++ b/tests/helpers/test_mkfds.c
@@ -4413,7 +4413,7 @@ static void list_output_values(const char *factory_name)
 
 static void rename_self(const char *comm)
 {
-	if (prctl(PR_SET_NAME, (unsigned long)comm, 0, 0, 0) < 0)
+	if (prctl(PR_SET_NAME, (unsigned long)comm, 0L, 0L, 0L) < 0)
 		err(EXIT_FAILURE, "failed to rename self via prctl: %s", comm);
 }
 
-- 
2.51.0

