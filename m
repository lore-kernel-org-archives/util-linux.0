Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5B1482F6
	for <util-linux@vger.kernel.org>; Mon, 10 Jun 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042316; cv=none; b=mvw8BtzD+Be9tbhi8SvyrqwtOvPQAynT9G2ZuuwU7hl4mnn74oZy/RQnNo+A0dLZxT147oKdhdZHzL8IWetFp3lgqcZ8qJqXtRwgQK4u6AN+HxsMZqvheU0yQoKrB/IcMIRd/oIv2Q0Q7llFdryTB+DDnMedA3bO0+cvzZ7ilQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042316; c=relaxed/simple;
	bh=JXGg4n/llmR01P0V8tQHQ8+KDT47v7DraPdpOm/cuvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsD4s1zYFbtmlZnj+gy1r4eCxu7G0n8j7xF70mMxz5fl8pYUSf/A9c9i2hve4z3NwUH/JNd8actghjRK4SK+sSuzCGxAlHtWt6qXGKothw2dn4iwLgsmUf+1WS0/u6TaZtsd3hmUyOHMLzav/rCt5KWO0p0G8s0kOwuCBCr9Hbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MatZr-1srQYv3vVz-00hkbi; Mon, 10
 Jun 2024 19:33:51 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 2/2] unshare: load binfmt_misc interpreter
Date: Mon, 10 Jun 2024 19:33:49 +0200
Message-ID: <20240610173349.115913-3-laurent@vivier.eu>
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
X-Provags-ID: V03:K1:khX/Xu/rwHHuCGs8D5IklcDKatj+wM/sQbYSUqC1hnzvbDwQZVh
 uGHC3VEvSl5SeXXV/JhQ7ukFaOZhb3pLJzOBvPAy9nfxttE2rkDKn3yAOoEWAtb6iLd5vuX
 BAWOZhvT3JZNw+fvKHXp60lE5NuIS9mnY7iU0FkODxe/ZUQSW2O08JXwOgccnMe2bM3kfNB
 /pQSiWheif6RVg0gJLhDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7ne3zii9swM=;jYxfqZ21+UpSIDEy0TLvUec12wB
 z1tqBdddZNK/AJ/Ih8AtlR4cM2WmAJKVDF3rCll+xkhOyYQLWQ7Ci1Z7fi0sdv6BCbT6iI+cx
 uqd3aszPrmRmHu4PFaX2lbsyvXbQBnf23kuRlCltC5TsgDvmsjPKrQIjs4NAwnFnFKKyEkgep
 aV5/Ec0PzCpp92ZRgJKi9UQW2FXCogCzh5z61nvDuvgFp5fuZ02OUO9gU1yfQpDv1wI6Ip71K
 PMEIpMWJkDknyDsUBT+e/zakfbPt9bo8KZEGQ6/Jdktrh594bAijcVZhVrzccuX+c/Dqh/Y98
 +oNuItgWKJhWZLfAs6Tk/fzm6PbDvYIbkVoN8dcgkfFGvNsYGOfwMy6KW3z4wWEOe6BU2M74I
 Mlk/yREAM2aF2WLETPD/26llK+3XIDyVVP2ROoiuBkIWS+Q8wF82UCykA52WRP/EBA2FDG1CJ
 1ThupNIBayIEegi4s24y1i1qlXhmsbyRhYjXTt4TBAO+NBna/NmHzmsp38OnH59e9wP6cepqt
 RYG5rbAWEhUvFIGdyu+IVnl6ZbQjEa8QqE8YEJXx1WhkA3WqvZFnTxT+o7KZj2uawpBX+tBRW
 DMn9c53OfYpjXpJGHE3ikerTz7fTcsr9mEs+eTXjDqSVwORlsBV47v17BZQNbhMtOymPSowyk
 zR6Nk3ReZqyETonv8cy7yKdNNU1CxY++A19YHoYZfK9+gpjDsKZXMPXVJA8rUhrihFArs176U
 7GZdph/43QupqUesQpFPHFQGdaL+stJwn3PyiPKNDhwubKxICJWarE=

add -l, --load-interp <file> to load a binfmt_misc interpreter at startup.

The interpreter is loaded from the initial fileystem if the 'F' flags is
provided, otherwise from inside the new namespace
This makes possible to start a chroot of another architecture without
being root.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 sys-utils/unshare.1.adoc | 10 +++++++++
 sys-utils/unshare.c      | 48 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index 48d1a5579282..24ac6fb01867 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -138,6 +138,9 @@ Set the user ID which will be used in the entered namespace.
 *-G*, *--setgid* _gid_::
 Set the group ID which will be used in the entered namespace and drop supplementary groups.
 
+*-l*, **--load-interp=**__file__::
+Load binfmt_misc definition in the namespace (implies *--mount-binfmt*).
+
 *--monotonic* _offset_::
 Set the offset of *CLOCK_MONOTONIC* which will be used in the entered time namespace. This option requires unsharing a time namespace with *--time*.
 
@@ -256,6 +259,13 @@ up 21 hours, 30 minutes
 up 9 years, 28 weeks, 1 day, 2 hours, 50 minutes
 ....
 
+The following example execute a chroot into the directory /chroot/powerpc/jessie and install the interpreter /bin/qemu-ppc-static to execute the powerpc binaries.
+If the interpreter is defined with the flag F, the interpreter is loaded before the chroot otherwise the interpreter is loaded from inside the chroot.
+
+....
+$  unshare --map-root-user --fork --pid --load-interp=":qemu-ppc:M::\\x7fELF\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x02\\x00\\x14:\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\x00\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/bin/qemu-ppc-static:OCF" --root=/chroot/powerpc/jessie /bin/bash -l
+....
+
 == AUTHORS
 
 mailto:dottedmag@dottedmag.net[Mikhail Gusarov],
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 06a9a427c524..7b7b24138056 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -725,6 +725,31 @@ static pid_t map_ids_from_child(int *fd, uid_t mapuser,
 	exit(EXIT_SUCCESS);
 }
 
+static int is_fixed(const char *interp)
+{
+	const char *flags;
+
+	flags = strrchr(interp, ':');
+
+	return strchr(flags, 'F') != NULL;
+}
+
+static void load_interp(const char *interp)
+{
+	int fd;
+
+	fd = open(_PATH_PROC_BINFMT_MISC_REGISTER, O_WRONLY);
+	if (fd < 0)
+		err(EXIT_FAILURE, _("cannot open %s"),
+		    _PATH_PROC_BINFMT_MISC_REGISTER);
+
+	if (write_all(fd, interp, strlen(interp)))
+		err(EXIT_FAILURE, _("write failed %s"),
+		    _PATH_PROC_BINFMT_MISC_REGISTER);
+
+	close(fd);
+}
+
 static void __attribute__((__noreturn__)) usage(void)
 {
 	FILE *out = stdout;
@@ -772,6 +797,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -G, --setgid <gid>        set gid in entered namespace\n"), out);
 	fputs(_(" --monotonic <offset>      set clock monotonic offset (seconds) in time namespaces\n"), out);
 	fputs(_(" --boottime <offset>       set clock boottime offset (seconds) in time namespaces\n"), out);
+	fputs(_(" -l, --load-interp <file>  load binfmt definition in the namespace (implies --mount-binfmt)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(27));
@@ -830,6 +856,7 @@ int main(int argc, char *argv[])
 		{ "wd",		   required_argument, NULL, 'w'		    },
 		{ "monotonic",     required_argument, NULL, OPT_MONOTONIC   },
 		{ "boottime",      required_argument, NULL, OPT_BOOTTIME    },
+		{ "load-interp",   required_argument, NULL, 'l'		    },
 		{ NULL, 0, NULL, 0 }
 	};
 
@@ -846,6 +873,7 @@ int main(int argc, char *argv[])
 	const char *newroot = NULL;
 	const char *newdir = NULL;
 	pid_t pid_bind = 0, pid_idmap = 0;
+	const char *newinterp = NULL;
 	pid_t pid = 0;
 #ifdef UL_HAVE_PIDFD
 	int fd_parent_pid = -1;
@@ -868,7 +896,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	close_stdout_atexit();
 
-	while ((c = getopt_long(argc, argv, "+fhVmuinpCTUrR:w:S:G:c", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "+fhVmuinpCTUrR:w:S:G:cl:", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'f':
 			forkit = 1;
@@ -1008,6 +1036,15 @@ int main(int argc, char *argv[])
 			boottime = strtos64_or_err(optarg, _("failed to parse boottime offset"));
 			force_boottime = 1;
 			break;
+		case 'l':
+			unshare_flags |= CLONE_NEWNS | CLONE_NEWUSER;
+			if (!binfmt_mnt) {
+				if (!procmnt)
+					procmnt = "/proc";
+				binfmt_mnt = _PATH_PROC_BINFMT_MISC;
+			}
+			newinterp = optarg;
+			break;
 
 		case 'h':
 			usage();
@@ -1162,6 +1199,13 @@ int main(int argc, char *argv[])
 	if ((unshare_flags & CLONE_NEWNS) && propagation)
 		set_propagation(propagation);
 
+	if (newinterp && is_fixed(newinterp)) {
+		if (mount("binfmt_misc", _PATH_PROC_BINFMT_MISC, "binfmt_misc",
+			  MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0)
+			err(EXIT_FAILURE, _("mount %s failed"), _PATH_PROC_BINFMT_MISC);
+		load_interp(newinterp);
+	}
+
 	if (newroot) {
 		if (chroot(newroot) != 0)
 			err(EXIT_FAILURE,
@@ -1193,6 +1237,8 @@ int main(int argc, char *argv[])
 			  MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0)
 			err(EXIT_FAILURE, _("mount %s failed"), binfmt_mnt);
 	}
+	if (newinterp && !is_fixed(newinterp))
+		load_interp(newinterp);
 
 	if (force_gid) {
 		if (setgroups(0, NULL) != 0)	/* drop supplementary groups */
-- 
2.45.2

