Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7E7C6C9
	for <util-linux@vger.kernel.org>; Wed, 19 Jun 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785198; cv=none; b=K/lmvuSEKFZRImYRAsweDqmcHHt0bpwU0IP1FLdF15nRwf89M1fEmVXXmCi3thSSgzcij1u0u3gK5x+OtK4U1nDsomsj0T+VaHDQE+EXuDECFIaNZoV6PmtkMB+RjYCGucxB0Gdg+mUtt9hWkk7aDmgwijzm5IPE6oPu8B2flgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785198; c=relaxed/simple;
	bh=LCATPotSz2ATRD7CPZiRXHBkg12fcf+9FklB+vEJs/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9x4o9M2BRtTHGPgksIdG0dyxZMMXNlrjclP2XdXC0BXlBS97lQgh5qvd+Rl4f7qtkuIWVFfLaEye58j6/Ppelb2FX1zBvTINfSTq3hbM014eGq2ODcJ0cT0BBLcnlKZ4TMQFv62ybWhavVc4iFusFglAbWn/fqDLzypu5kMN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N0nSN-1sYKb732rF-00zrMQ; Wed, 19
 Jun 2024 10:19:52 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 1/2] unshare: mount binfmt_misc
Date: Wed, 19 Jun 2024 10:19:50 +0200
Message-ID: <20240619081951.656640-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619081951.656640-1-laurent@vivier.eu>
References: <20240619081951.656640-1-laurent@vivier.eu>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HHFtJBZ002hzm8TgTYCSMvCPySdm/wbpKEUGWKElhDWrGk+ph0A
 hl2mtiloKDAj4s0e5cJdeQ4SrduNRVtxhyH2RcsaOsh4VNGbWweenUuREBOdMPBfoinuFxE
 0zuGU1Dr9+efHNVQCMlrgDgxp6sgesSORt2MCRbUNzkz3eYpdhCWP9dkV0fJX1dMEsin6Ov
 gk8Am8SoNrXPg/pWiqU3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1Zpfowan6tg=;/Lubza+DIYyoO+JxdNy4UQoEcb8
 96DqOtGzBeOWvTeEy8whzaogue1cpjQT5HjarCAjflap5zdhfc9XpJ53O3ptJGxYYxX5QPLnP
 9RpSTJx5ofi6CUYRME8Fu2OK+BvmuSbcbRzY6izBTc/SebUa25n2ErDh82op1otN9nCM41sXM
 XI5moU9phga3tK2zgfsqb4+++a5V9TOr9S/kmayiTedSJfyT1X7H0MLK1X1ifMOUWqDELY+K4
 Q7wAC6h8BliCyTOhVuNymAhi4IWkmudyWToVYgGu9vEWp6hQ0Qh5sqooTY443SOzN7LH+IaEY
 Q7MQjPsNEJ5An5AGEJamrZjaenailQ/+zzJ0KpapO4+4hyPD6ZGkk5qwty9zaUmX/p/1SsIXS
 sVJnB60Wyp96jI7rnZM00KsGxNBIVSRsXW9UfdJAWu13xAmpKM/0CQ7ANR77XoFB+EFxJkkEX
 TyP8rCWs1eGagVocDFhfPVPglxvbSyiCF6JEoY13Kwrrso+mgv/BN25Cxr6NpwK3pOeLHJMso
 nNqaaww1b6RAapuN2QIjmIvfL8cvBL96zeJZ8k5XUcEIJmpgGXkNOvdd3r64l+6Q8jNOzPTI5
 OINYmUg3L5b0TPGw/nqzeUjmWeiBdmXOM24KFtsdZOriohIJgr42jJsAv3fEBxaZg62rXWnKg
 0oabE8A7rEkoBIPI/X7tAT8rENIMWejZErIKBeUVM5zne2Bbff/Ubj8dx7QxzXvJ4GgU6+hsd
 yCc7PbsD71OREcdmDMj69bRTM+2K9e+hUI2A8cJTxv1RBmFfq5ckdQ=

add --mount-binfmt[=<dir>] to mount binfmt_misc filesystem,
this results in clearing inherited interpreters from the previous namespace

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2:
      - remove definition of _PATH_PROC_BINFMT_MISC_REGISTER

 include/pathnames.h      |  1 +
 sys-utils/unshare.1.adoc |  3 +++
 sys-utils/unshare.c      | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/pathnames.h b/include/pathnames.h
index 81fa405f63c7..569bef17f982 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -204,6 +204,7 @@
 /* sysctl fs paths */
 #define _PATH_PROC_SYS_FS	"/proc/sys/fs"
 #define _PATH_PROC_PIPE_MAX_SIZE	_PATH_PROC_SYS_FS "/pipe-max-size"
+#define _PATH_PROC_BINFMT_MISC	_PATH_PROC_SYS_FS "/binfmt_misc"
 
 /* irqtop paths */
 #define _PATH_PROC_INTERRUPTS	"/proc/interrupts"
diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index e6201e28fffd..48d1a5579282 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -90,6 +90,9 @@ When *unshare* terminates, have _signame_ be sent to the forked child process. C
 *--mount-proc*[**=**__mountpoint__]::
 Just before running the program, mount the proc filesystem at _mountpoint_ (default is _/proc_). This is useful when creating a new PID namespace. It also implies creating a new mount namespace since the _/proc_ mount would otherwise mess up existing programs on the system. The new proc filesystem is explicitly mounted as private (with *MS_PRIVATE*|*MS_REC*).
 
+*--mount-binfmt*[**=**__mountpoint__]::
+Just before running the program, mount the binfmt_misc filesystem at _mountpoint_ (default is /proc/sys/fs/binfmt_misc).  It also implies creating a new mount namespace since the binfmt_misc mount would otherwise mess up existing programs on the system.  The new binfmt_misc filesystem is explicitly mounted as private (with *MS_PRIVATE*|*MS_REC*).
+
 **--map-user=**__uid|name__::
 Run the program only after the current effective user ID has been mapped to _uid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
 
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 57f3b8744fb5..d79aa1125955 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -760,6 +760,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --kill-child[=<signame>]  when dying, kill the forked child (implies --fork)\n"
 		"                             defaults to SIGKILL\n"), out);
 	fputs(_(" --mount-proc[=<dir>]      mount proc filesystem first (implies --mount)\n"), out);
+	fputs(_(" --mount-binfmt[=<dir>]    mount binfmt filesystem first (implies --user and --mount)\n"), out);
 	fputs(_(" --propagation slave|shared|private|unchanged\n"
 	        "                           modify mount propagation in mount namespace\n"), out);
 	fputs(_(" --setgroups allow|deny    control the setgroups syscall in user namespaces\n"), out);
@@ -783,6 +784,7 @@ int main(int argc, char *argv[])
 {
 	enum {
 		OPT_MOUNTPROC = CHAR_MAX + 1,
+		OPT_MOUNTBINFMT,
 		OPT_PROPAGATION,
 		OPT_SETGROUPS,
 		OPT_KILLCHILD,
@@ -811,6 +813,7 @@ int main(int argc, char *argv[])
 		{ "fork",          no_argument,       NULL, 'f'             },
 		{ "kill-child",    optional_argument, NULL, OPT_KILLCHILD   },
 		{ "mount-proc",    optional_argument, NULL, OPT_MOUNTPROC   },
+		{ "mount-binfmt",  optional_argument, NULL, OPT_MOUNTBINFMT },
 		{ "map-user",      required_argument, NULL, OPT_MAPUSER     },
 		{ "map-users",     required_argument, NULL, OPT_MAPUSERS    },
 		{ "map-group",     required_argument, NULL, OPT_MAPGROUP    },
@@ -839,6 +842,7 @@ int main(int argc, char *argv[])
 	struct map_range *groupmap = NULL;
 	int kill_child_signo = 0; /* 0 means --kill-child was not used */
 	const char *procmnt = NULL;
+	const char *binfmt_mnt = NULL;
 	const char *newroot = NULL;
 	const char *newdir = NULL;
 	pid_t pid_bind = 0, pid_idmap = 0;
@@ -913,6 +917,15 @@ int main(int argc, char *argv[])
 			unshare_flags |= CLONE_NEWNS;
 			procmnt = optarg ? optarg : "/proc";
 			break;
+		case OPT_MOUNTBINFMT:
+			unshare_flags |= CLONE_NEWNS | CLONE_NEWUSER;
+			binfmt_mnt = optarg;
+			if (!binfmt_mnt) {
+				if (!procmnt)
+					procmnt = "/proc";
+				binfmt_mnt = _PATH_PROC_BINFMT_MISC;
+			}
+			break;
 		case OPT_MAPUSER:
 			unshare_flags |= CLONE_NEWUSER;
 			mapuser = get_user(optarg, _("failed to parse uid"));
@@ -1178,6 +1191,12 @@ int main(int argc, char *argv[])
 			err(EXIT_FAILURE, _("mount %s failed"), procmnt);
 	}
 
+	if (binfmt_mnt) {
+		if (mount("binfmt_misc", binfmt_mnt, "binfmt_misc",
+			  MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0)
+			err(EXIT_FAILURE, _("mount %s failed"), binfmt_mnt);
+	}
+
 	if (force_gid) {
 		if (setgroups(0, NULL) != 0)	/* drop supplementary groups */
 			err(EXIT_FAILURE, _("setgroups failed"));
-- 
2.45.2

