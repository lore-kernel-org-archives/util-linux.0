Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224D8F6D
	for <util-linux@vger.kernel.org>; Mon, 10 Jun 2024 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041148; cv=none; b=a2sWjq8DqnbtgU5XLTsYpdPSgTQm0kHfXW4Ds3yl3KPg+N/kNFRtbe+PtmYiReAo/o1wqeElpq84yIe4jsCUjc0j0EosJSsElONeCs1Hz/PVyzKh+tycNsU8UEN8AmRRL7EAC7ILvDSG+AGjS7oPOzcCYK+k7M+LpkhLfPFb/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041148; c=relaxed/simple;
	bh=lQCmHfyvJN14z4ShhxYQT6lpr11veFMPVxwD5NBsIdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rG5L2B7GC8vwa5f37OkRfWFwS7shdoZeGdnUvYEC7DElwtYaIvg1HmAuflEALxSfjdn9d586M0rxD9kXhRg8dvMOmz63CtImCAH+28ddPGyzezG2kLRlve4n7cLd9QDM9ldwaoeq/3I8RPgd5CfIzlDLPjaF/rPTJL+3/JGGeNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MmU9R-1sgwxz3CV7-00np9s; Mon, 10
 Jun 2024 19:33:50 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 1/2] unshare: mount binfmt_misc
Date: Mon, 10 Jun 2024 19:33:48 +0200
Message-ID: <20240610173349.115913-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240610173349.115913-1-laurent@vivier.eu>
References: <20240610173349.115913-1-laurent@vivier.eu>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DZKF2QYZF6MwImrjHW2qPHpP1qMqkx79X8XMCT0J/JsGvbksvmu
 J9iRZng2XrhFQOS/1uYTZXnD5cGdEO3AGyMyIpZkRkEF77xNSfwsgEGDg/mLLx4PzuW1FsU
 7iuIkOtNke6b4RO8zugvnaZh8jPENHNZNIOZpMMrNh3QqSs/k3guR/FFT3Tow24KuYW/nFV
 U8HP3Oy2vzY9aWm4rYTjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G9nGXSGDQf4=;5z8SOpIraUiTPBUpJTTCjLZ9bFt
 dvDzm0I/njrRBOuJ8LwMyKW/Ys6YCScVr4ONxHe4YRclZYHpi6pix8z2MVNKqXmc+gdd8wzcO
 vIew1XM/BkHbU9avhEVUWQO92kgySp1/NsJ4JWJoj74onaKZzcJL6Hw6A7lp83Ub4QRB/OSVW
 X3G0Lc05SBi3QNmJZtmyeFvCgsvlwLppMKBsfscVo9m1qHmZ3BdlqKCesxkRVrTc06f68RyxD
 RYYBcIKd9iPCY9fqp0xEX4nhoOwoi1QX+MJVP3sq39QbTZ5IXUDfAowJ3gwz7mVgkOIxi1Nyf
 WQUZ4u+KYlo1j9N0zhlj6VCpb6kv2ZaVxNCwZXMPflaJs98CFoVbrcj5V3MtNqC+2TOLlZa2w
 flgdeswLdPynxg1Qad8BRNB82hWiv1Dryl9vjWDwMq//mCNnDiwEURruGwJqIZa4Qz5SRnm69
 wN/HfBYhaTMreb+VKvs2X1X3629TMRtkFMRPbdVWbK1+k3BhUkXm8UeWhTdrJrz5Uaprbey0J
 piN7CtI1l59GGo7fGck9z1Tua0fQHLHS/h93wh+Rz6uXUSC3XLee4a2BpnGEz42MseT+tjlVW
 VYIcFaXth8bPZrYkJSPSlboo/AAe1koMgpX+OSrenIbbhjntANciz1CsrF/tLbR7b6Hpvir5F
 d5fxKElHA/G9efCmePxp0U4sKs/3PdKw995dbryIBIiN3f7RtCTB7L4XWEp4EGdLrCWzj6mAE
 8DDiUPu/6hoxmWpFLhiMMy7aIRyhzwSzVcWaxEtBNh+1A2IKvCekVk=

add --mount-binfmt[=<dir>] to mount binfmt_misc filesystem,
this results in clearing inherited interpreters from the previous namespace

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/pathnames.h      |  2 ++
 sys-utils/unshare.1.adoc |  3 +++
 sys-utils/unshare.c      | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/pathnames.h b/include/pathnames.h
index 81fa405f63c7..6a7f506951d5 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -204,6 +204,8 @@
 /* sysctl fs paths */
 #define _PATH_PROC_SYS_FS	"/proc/sys/fs"
 #define _PATH_PROC_PIPE_MAX_SIZE	_PATH_PROC_SYS_FS "/pipe-max-size"
+#define _PATH_PROC_BINFMT_MISC	_PATH_PROC_SYS_FS "/binfmt_misc"
+#define _PATH_PROC_BINFMT_MISC_REGISTER	_PATH_PROC_BINFMT_MISC "/register"
 
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
index 57f3b8744fb5..06a9a427c524 100644
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
@@ -913,6 +917,12 @@ int main(int argc, char *argv[])
 			unshare_flags |= CLONE_NEWNS;
 			procmnt = optarg ? optarg : "/proc";
 			break;
+		case OPT_MOUNTBINFMT:
+			unshare_flags |= CLONE_NEWNS | CLONE_NEWUSER;
+			binfmt_mnt = optarg ? optarg : _PATH_PROC_BINFMT_MISC;
+			if (!optarg && !procmnt)
+				procmnt = "/proc";
+			break;
 		case OPT_MAPUSER:
 			unshare_flags |= CLONE_NEWUSER;
 			mapuser = get_user(optarg, _("failed to parse uid"));
@@ -1178,6 +1188,12 @@ int main(int argc, char *argv[])
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

