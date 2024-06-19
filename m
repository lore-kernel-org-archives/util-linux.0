Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0B7E0E9
	for <util-linux@vger.kernel.org>; Wed, 19 Jun 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785203; cv=none; b=H17jPFl+/yqnFNSiLBX3kXhNxO1sEBC+3NMpPaaziWINrGHrffvJdfKZPpRAaMvtB2S/3BdAsF/p6T+9TebjDAC9Ys0G2ALea9R1ogx8M0kAa3f+vL5CGW93kldcqjoiWObYmh8OCxfa369zuBRbTNYwP8o1mSvtacMnaDSOVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785203; c=relaxed/simple;
	bh=xKjmyKlMhFjo3uFX02jWjTLTvnDFY1wrC3j6LoZkiQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYwdkmzZQzIslynFCR5XkqscjHhb5k1jz38Pfh/wTegX+5Kp55doKV1bu/4FvYf14AzLdRBYmZaEp9DnmLO6DR1yCTYOrkqBF/ADPRe5Kfy81Cy4EKZXsXZRoarTcqvv9HXaJ7UjUcOXeg78tZTn2TvWVg14xNdBxavBSjlbaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MhTt7-1soDYR3knL-00jpqW; Wed, 19
 Jun 2024 10:19:52 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 2/2] unshare: load binfmt_misc interpreter
Date: Wed, 19 Jun 2024 10:19:51 +0200
Message-ID: <20240619081951.656640-3-laurent@vivier.eu>
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
X-Provags-ID: V03:K1:Pptj6jQUTLwPmhZSvkB4r/hczuHi5SB18BKFpmnT1QF552ynnhj
 O7O46uCdEeTkXg622e7NkK9QANx9NwYZ2DRPdrs2qIfb7mflSp1plf+E0cQLjnv1RXw2M45
 BmJOh2d7V9lvnua0J+X8FuZI9+cqQSxHvkh1vEllkVgcq3kr+qAu1PaNHOsca7Ea+MMAUS1
 bVXT9ruMmvliGfcGnJkCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kXnD6SRe5VU=;l40jRsbk5fMHLSovsc/iHmGy7Mu
 ITjVeZ22I0ZkRyCsUjHgWBchT1DhMSxl/mrfa45D01OE8785MJFDzvW3DPHTv4dXhyzAre7CQ
 wkMle/wVb0YcDhOENa9YDOE3JGKqHpzOBoljHH8eyBB7etj628d0RxpL9UGbCKwpDL3TqhiFV
 Rt1g/STIky+m/Njx639+k6ix/Yq0Pwm4Hr8IBNGGM/fXXUXBOl7aUcITKfl3RCn+TeJ+bW2zL
 B2+ZB65Bs4PvvUU/VEs+I+WmIB6bwdN16De1y8YVjohmetP+4xdeTs5w8ZLViFWs6jvhP4pp6
 PGZYlTGnRZE4iJmFfXjVtXQTDSnRDBC2m4bX4oEsoNd8dkUfauV8CDqi+1tVVl66GZX2FKwdo
 iu7Z54t3/100plIB1vMmFdyJ5ednLIgVhaHPmj0EBFQPOhnB0HmIlxSvVBH5F1Fpugx7Peu+k
 4UYsl0fBfa6AXjFHrJ5o0BQVIwjlmvi+PYBzjSYNO+2G25gJR8Msb7lNhRhVWLNLKBWPaf15k
 eGIGLV5GjRplBRARHxN9D0ie/pjnrnbV3MOME3Ibe9AKSrsdmD0LK6OcQLZe2x8T5ivAbTD9Y
 qmO8IWOmlG508wxLY8eq6elTdFV4FQbKy6kBQCC16C06S8g2kz40O/4ikX6WjCKwU52pokUC5
 V0fMlGS2zZ/2Eai1I8v5dOVaqpusns4/qjzSPjQFO6tOKDOhOMy5aOmyD7zwN1A8VG2/QNhB+
 B2OISHunUseF6j+hRdAF3gKLO3F5ZK1kTtUY7a+sM12XKsuWQAkaZQ=

add -l, --load-interp <file> to load a binfmt_misc interpreter at startup.

The interpreter is loaded from the initial fileystem if the 'F' flags is
provided, otherwise from inside the new namespace
This makes possible to start a chroot of another architecture without
being root.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v3:
      - update man page
      - load interpreter before the chroot only if there is the a chroot
    
    v2:
      - use <binfmt_mnt>/register rather than _PATH_PROC_BINFMT_MISC_REGISTER
        to load the interpreter

 sys-utils/unshare.1.adoc | 18 ++++++++++++++
 sys-utils/unshare.c      | 52 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index 48d1a5579282..6396c4892ddf 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -138,6 +138,10 @@ Set the user ID which will be used in the entered namespace.
 *-G*, *--setgid* _gid_::
 Set the group ID which will be used in the entered namespace and drop supplementary groups.
 
+*-l*, **--load-interp=**__string__::
+Load binfmt_misc definition in the namespace (implies *--mount-binfmt*). The __string__ argument is ``:name:type:offset:magic:mask:interpreter:flags``. For more details about new binary type registration see  https://www.kernel.org/doc/Documentation/admin-guide/binfmt-misc.rst.
+To manage the F flag in ``flags`` with **--root** parameter, binfmt_misc is mounted twice, once before the chroot to load the interpreter from the caller filesystem and once after to make it available from the chroot userspace.
+
 *--monotonic* _offset_::
 Set the offset of *CLOCK_MONOTONIC* which will be used in the entered time namespace. This option requires unsharing a time namespace with *--time*.
 
@@ -256,6 +260,20 @@ up 21 hours, 30 minutes
 up 9 years, 28 weeks, 1 day, 2 hours, 50 minutes
 ....
 
+The following example execute a chroot into the directory /chroot/powerpc/jessie and install the interpreter /bin/qemu-ppc-static to execute the powerpc binaries.
+
+....
+$  unshare --map-root-user --fork --pid --load-interp=":qemu-ppc:M::\\x7fELF\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x02\\x00\\x14:\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\x00\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/bin/qemu-ppc-static:OCF" --root=/chroot/powerpc/jessie /bin/bash -l
+....
+
+The ``load-interp`` parameter can be read as following::
+``qemu-ppc``::: is the name of the new file created below ``/proc/sys/fs/binfmt_misc`` to register the interpreter
+``M``::: defines the interpreter for a given type of magic number
+``\\x7fELF\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x02\\x00\\x1``::: is the magic number to recognize the file to interpret (in this case, the ELF header for PPC32)
+``\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\x00\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff``::: the mask to apply to the magic number
+``/bin/qemu-ppc-static``::: the interpreter to use with the file
+``OCF``::: the file is open by the kernel with credential and security tokens of the file itself and loaded as soon as we register it.
+
 == AUTHORS
 
 mailto:dottedmag@dottedmag.net[Mikhail Gusarov],
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index d79aa1125955..e48e4c9f55a5 100644
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
 
+	if (newinterp && is_fixed(newinterp) && newroot) {
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
+	if (newinterp && !(is_fixed(newinterp) && newroot))
+		load_interp(binfmt_mnt, newinterp);
 
 	if (force_gid) {
 		if (setgroups(0, NULL) != 0)	/* drop supplementary groups */
-- 
2.45.2

