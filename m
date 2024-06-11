Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DCE171D2
	for <util-linux@vger.kernel.org>; Tue, 11 Jun 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095712; cv=none; b=qDM6XSo6yopHsTt/oeVP/pqn4kV7I2HUAn19Fp9ug7Sc4Vw+fulq/kfwVnz7YzghMREvnO9et6KPZ0eTifKROD43oddke3I1744M7rd95XMsRVmZBD5OztepLEPMgKrNkl7XljStHmGDN1ZqzGu4oQiJf2M2tpheqiXLFuf6ews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095712; c=relaxed/simple;
	bh=wI/4ISuVjGBBRXww4q8Nei4UcMs/bKUeHMWTkgSmtGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yw9GvOqeuZpIJ4ds631vk9N9UhDLwChhu10r19jMVHnhxiizYHyDFrTvnwAqm7OhucGqRs/0KsAcfBMGA4xE79tdSplw9VgORYEVkAAnvC0usodlUV+LgtlP3tlzYhi2IsG9ORAW04zvlj02ukrhLIo+hg2rV4aOcMbowNg7DwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mr8vG-1snaDd34Ni-00gHuI; Tue, 11
 Jun 2024 10:43:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 2/2] unshare: load binfmt_misc interpreter
Date: Tue, 11 Jun 2024 10:43:14 +0200
Message-ID: <20240611084314.183913-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611084314.183913-1-laurent@vivier.eu>
References: <20240611084314.183913-1-laurent@vivier.eu>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eRAD6W3LPWuwYz9lFhxdw5noHPFJqUeIpdQDjmTTczfgw6mzsgs
 BGmfEFwbM++6GEvFiAGvw15q4qBDVf/KonALx9hkWRDX3NsYjKQG6uPShrwH2/Q3gu6KU4K
 fJIqlbk7OtT02p25beU4p5dXJzasQDkQcssd9fPgE1EeXGWArv7PvDRDSEbhi0xuD9xyJck
 KuwnIJ9q2aHv3xNJI4Www==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WhWkHV/fTAo=;hnw9mNNwh2LSwhG1DPMBmrkeNoq
 H4+1FbRYSQUX6mzyS3Jb5mUjy+9pfiqP+K0uGPoqEXjueh7CFSYUFM40YzDIPsl3EEIhJEV3T
 SnQ3xemoAM4+bZyayXvLMD5jRNqsjIThJrpbsvI2A8dQ1vm7H7D8QiPdI7IcmTtH0/E/dyzeU
 WkYhZ2kg/IjWSkr/DbS0I994fBkber2KVSefDA/8AGnA4jtiMj2nHEhcjH8W6GFfMaGjo3XNU
 BWLUQYfaDnu81kGAWwi0ycpKXjqYzCDE8ytQLHmoaQdn4NVAyy8zeQpl2M0TbPbjdpMK5q/le
 cz/WXt9XdN6LQ3/QtrlyvpD4c+DNQ7NLGd0DKJ3/A0czk1wm0OTqdbDQEXyKT74o+6DjuiH59
 UIknvRYNJkF3/YI+6SVd1jHpaiGdImciZo0cgGNApIaaq6t8mzkSoQ9p66N0GO/J9LItNVek0
 /Jo11fd3v+CrIz6deG6FZXz6FGOQyPw0cMaX/PtXkXb1aDlK9r21Wvi7dl47Zbjj58xcbBLGE
 zru7BKgdxQs1bxYUH8+3hZs7XHNuqzzRU9TSKQp94HR3pE8OLV5NV2Y807e0INHRWXFZusr/O
 utYKTTLkm4qy9q+jOdJK/pg5znaTzsPQDjJNmXaSZdQMft+6CrDpRW7Q63OBAdqDcA2seTxDj
 PxCweHTYpmrTqYVzNP0rjB8SxkV+BoQafHWNPfnAFp9qThQ22PnDpieCc5/FVMuKq8tRcrmRN
 z3MMQdzyfAr4lPc/e08Y6ZIy61zKd55pD6ZOmvzW0RC57yjUKCJqcY=

add -l, --load-interp <file> to load a binfmt_misc interpreter at startup.

The interpreter is loaded from the initial fileystem if the 'F' flags is
provided, otherwise from inside the new namespace
This makes possible to start a chroot of another architecture without
being root.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2:
      - use <binfmt_mnt>/register rather than _PATH_PROC_BINFMT_MISC_REGISTER
        to load the interpreter

 sys-utils/unshare.1.adoc | 10 ++++++++
 sys-utils/unshare.c      | 52 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

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
index d79aa1125955..f8e1141840ca 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -725,6 +725,35 @@ static pid_t map_ids_from_child(int *fd, uid_t mapuser,
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
+static void load_interp(const char *binfmt_mnt, const char *interp)
+{
+	int dirfd, fd;
+
+	dirfd = open(binfmt_mnt, O_PATH | O_DIRECTORY);
+	if (dirfd < 0)
+		err(EXIT_FAILURE, _("cannot open %s"), binfmt_mnt);
+
+	fd = openat(dirfd, "register", O_WRONLY);
+	if (fd < 0)
+		err(EXIT_FAILURE, _("cannot open %s/register"), binfmt_mnt);
+
+	if (write_all(fd, interp, strlen(interp)))
+		err(EXIT_FAILURE, _("write failed %s/register"), binfmt_mnt);
+
+	close(fd);
+
+	close(dirfd);
+}
+
 static void __attribute__((__noreturn__)) usage(void)
 {
 	FILE *out = stdout;
@@ -772,6 +801,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -G, --setgid <gid>        set gid in entered namespace\n"), out);
 	fputs(_(" --monotonic <offset>      set clock monotonic offset (seconds) in time namespaces\n"), out);
 	fputs(_(" --boottime <offset>       set clock boottime offset (seconds) in time namespaces\n"), out);
+	fputs(_(" -l, --load-interp <file>  load binfmt definition in the namespace (implies --mount-binfmt)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(27));
@@ -830,6 +860,7 @@ int main(int argc, char *argv[])
 		{ "wd",		   required_argument, NULL, 'w'		    },
 		{ "monotonic",     required_argument, NULL, OPT_MONOTONIC   },
 		{ "boottime",      required_argument, NULL, OPT_BOOTTIME    },
+		{ "load-interp",   required_argument, NULL, 'l'		    },
 		{ NULL, 0, NULL, 0 }
 	};
 
@@ -846,6 +877,7 @@ int main(int argc, char *argv[])
 	const char *newroot = NULL;
 	const char *newdir = NULL;
 	pid_t pid_bind = 0, pid_idmap = 0;
+	const char *newinterp = NULL;
 	pid_t pid = 0;
 #ifdef UL_HAVE_PIDFD
 	int fd_parent_pid = -1;
@@ -868,7 +900,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	close_stdout_atexit();
 
-	while ((c = getopt_long(argc, argv, "+fhVmuinpCTUrR:w:S:G:c", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "+fhVmuinpCTUrR:w:S:G:cl:", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'f':
 			forkit = 1;
@@ -1011,6 +1043,15 @@ int main(int argc, char *argv[])
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
@@ -1165,6 +1206,13 @@ int main(int argc, char *argv[])
 	if ((unshare_flags & CLONE_NEWNS) && propagation)
 		set_propagation(propagation);
 
+	if (newinterp && is_fixed(newinterp)) {
+		if (mount("binfmt_misc", _PATH_PROC_BINFMT_MISC, "binfmt_misc",
+			  MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0)
+			err(EXIT_FAILURE, _("mount %s failed"), _PATH_PROC_BINFMT_MISC);
+		load_interp(_PATH_PROC_BINFMT_MISC, newinterp);
+	}
+
 	if (newroot) {
 		if (chroot(newroot) != 0)
 			err(EXIT_FAILURE,
@@ -1196,6 +1244,8 @@ int main(int argc, char *argv[])
 			  MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0)
 			err(EXIT_FAILURE, _("mount %s failed"), binfmt_mnt);
 	}
+	if (newinterp && !is_fixed(newinterp))
+		load_interp(binfmt_mnt, newinterp);
 
 	if (force_gid) {
 		if (setgroups(0, NULL) != 0)	/* drop supplementary groups */
-- 
2.45.2

