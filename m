Return-Path: <SRS0=Zy3D=WL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C1FC433FF
	for <util-linux@archiver.kernel.org>; Thu, 15 Aug 2019 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8923821773
	for <util-linux@archiver.kernel.org>; Thu, 15 Aug 2019 10:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qnoAsl9O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yet7ULNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfHOKym (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 15 Aug 2019 06:54:42 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52433 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728128AbfHOKym (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Aug 2019 06:54:42 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B2B652228D
        for <util-linux@vger.kernel.org>; Thu, 15 Aug 2019 06:54:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 15 Aug 2019 06:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=7US1b1O8ytkasLHgtYKfaR7cx9
        ckYVTnkY9AbZ+UBk0=; b=qnoAsl9OfoZCTwk/Y3gMTs4U+VG1BenRbDBUlRr+b+
        WhkqcyKvrlKXoiAvlqGIb+MDY6N8mPsaC2xatBwyAwgozaYLBnbepmqrJyx/X3dv
        8DpS8/JxW/wN7nBLL3dV0Q3XzpvmC/sXzHG8J31Y6mutmZ6e6QfhCIdnMOfHI918
        3ZrjBVBv9i3laDGJF/UDdxTB64463C31B1NooL1EeXQknWg2Meb0A2r0IO/1rHII
        tfStotjV54O1jSzMZ2CyCQ3qIXMwZmaiwGB1N7FPc+c0/d1FfJ+1xiMXXXTSDMff
        j+ki11oXwfOvzKqMTdgXS2+0sSOq8F6L9SYHJTW9NZSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7US1b1O8ytkasLHgt
        YKfaR7cx9ckYVTnkY9AbZ+UBk0=; b=yet7ULNa24euzVcIVE9Byum+/rXBqe43q
        h73b4LvshNeUUe8lE7QZqIzWVadi2ZPoccNOsWMwc4Djosp48cuWCXSvMEov5qsg
        B//I4uWqmz0kD3nd772cCnSFT53WL46EeVhn6AFMJtum74gWk9cmtUWs4i472SHi
        vF4zljJ6btBU8TGDL2lG+Uj7qfu46rPPbAnnoyDAz0Vr+RSQvAGhXkt1YXSx2GQK
        v14T76WAiu411iaRRePIlL2GQgEXcd+DIIMWbi9h47oqoKZ9OFwfHG19OVcMr8GN
        RmUqy54Gf2MZHrpwiU8cjCLQVkZMl1SuPGnJo844eCcGKRzVKZeVg==
X-ME-Sender: <xms:8DlVXSYa3Yhmgpc7sPQj56eRvIEU56WZR5JlJ4Ae1wCQqfpjzdZHqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudefuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecukfhppeejkedrheegrdeiuddrheefnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:8DlVXfel90wj_IPP92jyGIk_kfiL3K5RfwLRmXQTGjGa34roGUZJ9Q>
    <xmx:8DlVXc3vG-rihHZsU7TFfmuQe0ynlMN6qLqoSP9DmgxcbQNQOIxFgw>
    <xmx:8DlVXWJDvCyhd-0MvlhC7HcoEv7IGMPTQ59g1HxoQ6-PxIuwbIdFXg>
    <xmx:8DlVXXR0e-d6J4lE-xv7ySdmpZIAIq2KqP-ZXz8Zj1scDOt5lc6urw>
Received: from NSJAIL (x4e363d35.dyn.telefonica.de [78.54.61.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id D37C5380075
        for <util-linux@vger.kernel.org>; Thu, 15 Aug 2019 06:54:39 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id a671d132 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 15 Aug 2019 10:54:35 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] unshare: allow setting up filesystems in the mount namespace
Date:   Thu, 15 Aug 2019 12:54:45 +0200
Message-Id: <3fcfc033d9d115649fee5f9ae05296c29033a7de.1565866421.git.ps@pks.im>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In order to execute commands with the least-possible privileges, it may
be desirable to provide them with a trimmed down filesystem view.
unshare naturally provides the ability to create mount namespaces, but
it doesn't yet offer much in preparing these. For now, a combination of
unshare and nsenter is required to prepare culled filesystems views,
which is kind of unwieldy.

To remedy that, this implements a new option "--mount-fs". As
parameters, one may specify a source filesystem, the destination where
this filesystem shall be mounted, the type of filesystem as well as a
set of options. unshare will then mount it using libmount right before
performing `chroot`, `chdir` and the subsequent `execve`, which allows
for preparing the `chroot` environment without using nsenter at all.

The above is useful in several different cases, for example when one
wants to execute the process in a read-only environment or execute it
with a reduced view of the filesystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sys-utils/Makemodule.am |  2 +-
 sys-utils/unshare.1     | 22 ++++++++++++++++++++
 sys-utils/unshare.c     | 46 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 1b2277321..639824f53 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -424,7 +424,7 @@ if BUILD_UNSHARE
 usrbin_exec_PROGRAMS += unshare
 dist_man_MANS += sys-utils/unshare.1
 unshare_SOURCES = sys-utils/unshare.c
-unshare_LDADD = $(LDADD) libcommon.la
+unshare_LDADD = $(LDADD) libcommon.la libmount.la
 unshare_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir)
 
 if HAVE_STATIC_UNSHARE
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index d2ba6c3a5..ccc830923 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -152,6 +152,15 @@ implies creating a new mount namespace since the /proc mount would otherwise
 mess up existing programs on the system.  The new proc filesystem is explicitly
 mounted as private (with MS_PRIVATE|MS_REC).
 .TP
+.BR \-\-mount\-fs = \fIsource\fP : \fItarget\fP : \fIfstype\fP [ :\fIoptions\fP ]
+Just before running the program, mount the filesystem \fIsource\fP of type
+\fIfstype\fP at \fIdestination\fP, which will only be visible in the child's
+mount namespace. \fIoptions\fP may be used to specify a comma separated list of
+mount options for the filesystem. This option is processed before \fB--root\fR
+and is thus useful to prepare the chroot environment of the child. Can be passed
+multiple times, in which case mounts will be processed in the given order. This
+option implies \fB--mount\fR.
+.TP
 .BR \-r , " \-\-map\-root\-user"
 Run the program only after the current effective user and group IDs have been mapped to
 the superuser UID and GID in the newly created user namespace.  This makes it possible to
@@ -250,6 +259,19 @@ Establish a persistent mount namespace referenced by the bind mount
 /root/namespaces/mnt.  This example shows a portable solution, because it
 makes sure that the bind mount is created on a shared filesystem.
 .TP
+.B # unshare
+.B    --mount-fs=none:/tmp:tmpfs
+.B    --mount-fs=/bin:/tmp/bin:none:bind,ro,X-mount.mkdir
+.B    --mount-fs=/lib:/tmp/lib:none:bind,ro,X-mount.mkdir
+.B    --mount-fs=/usr/lib:/tmp/usr/lib:none:bind,ro,X-mount.mkdir
+.B    --root=/tmp /bin/ls /
+.TQ
+bin lib usr
+.br
+Establish a tmpfs at /tmp, bind-mounts parts of the root filesystem into it
+and executes the process in a chroot. This example shows how processes can be
+spawned with a reduced view of the filesystem.
+.TP
 .B # unshare -pf --kill-child -- bash -c "(sleep 999 &) && sleep 1000" &
 .TQ
 .B # pid=$!
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 21910a4ee..c72f25bdc 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -242,6 +242,38 @@ static void bind_ns_files_from_child(pid_t *child, int fds[2])
 	}
 }
 
+static int mnt_ns_filesystems(char **mounts, size_t nmounts)
+{
+	struct libmnt_context *cxt = mnt_new_context();
+	size_t i;
+
+	for (i = 0; i < nmounts; i++) {
+		char *src, *dst, *fstype, *opts;
+
+		if ((src = strtok(mounts[i], ":")) == NULL)
+			errx(EXIT_FAILURE, _("mount-fs missing src"));
+		if ((dst = strtok(NULL, ":")) == NULL)
+			errx(EXIT_FAILURE, _("mount-fs missing dst"));
+		if ((fstype = strtok(NULL, ":")) == NULL)
+			errx(EXIT_FAILURE, _("mount-fs missing fstype"));
+		opts = strtok(NULL, ":");
+
+		mnt_context_set_optsmode(cxt, MNT_OMODE_NOTAB);
+		mnt_context_set_source(cxt, src);
+		mnt_context_set_target(cxt, dst);
+		mnt_context_set_fstype(cxt, fstype);
+		mnt_context_set_options(cxt, opts);
+
+		if (mnt_context_mount(cxt) != 0)
+			err(EXIT_FAILURE, _("mount failed"));
+
+		mnt_reset_context(cxt);
+	}
+
+	mnt_free_context(cxt);
+	return 0;
+}
+
 static void __attribute__((__noreturn__)) usage(void)
 {
 	FILE *out = stdout;
@@ -268,6 +300,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --kill-child[=<signame>]  when dying, kill the forked child (implies --fork)\n"
 		"                             defaults to SIGKILL\n"), out);
 	fputs(_(" --mount-proc[=<dir>]      mount proc filesystem first (implies --mount)\n"), out);
+	fputs(_(" --mount-fs <source>:<target>:<fstype>[:<opts>]\n"
+	        "                           mount filesystem (implies --mount)\n"), out);
 	fputs(_(" --propagation slave|shared|private|unchanged\n"
 	        "                           modify mount propagation in mount namespace\n"), out);
 	fputs(_(" --setgroups allow|deny    control the setgroups syscall in user namespaces\n"), out);
@@ -288,6 +322,7 @@ int main(int argc, char *argv[])
 {
 	enum {
 		OPT_MOUNTPROC = CHAR_MAX + 1,
+		OPT_MOUNTFS,
 		OPT_PROPAGATION,
 		OPT_SETGROUPS,
 		OPT_KILLCHILD,
@@ -307,6 +342,7 @@ int main(int argc, char *argv[])
 		{ "fork",          no_argument,       NULL, 'f'             },
 		{ "kill-child",    optional_argument, NULL, OPT_KILLCHILD   },
 		{ "mount-proc",    optional_argument, NULL, OPT_MOUNTPROC   },
+		{ "mount-fs",      required_argument, NULL, OPT_MOUNTFS     },
 		{ "map-root-user", no_argument,       NULL, 'r'             },
 		{ "propagation",   required_argument, NULL, OPT_PROPAGATION },
 		{ "setgroups",     required_argument, NULL, OPT_SETGROUPS   },
@@ -324,6 +360,8 @@ int main(int argc, char *argv[])
 	const char *procmnt = NULL;
 	const char *newroot = NULL;
 	const char *newdir = NULL;
+	char **mounts = NULL;
+	size_t nmounts = 0;
 	pid_t pid = 0;
 	int fds[2];
 	int status;
@@ -381,6 +419,11 @@ int main(int argc, char *argv[])
 			unshare_flags |= CLONE_NEWNS;
 			procmnt = optarg ? optarg : "/proc";
 			break;
+		case OPT_MOUNTFS:
+			mounts = xrealloc(mounts, ++nmounts * sizeof(char *));
+			mounts[nmounts - 1] = optarg;
+			unshare_flags |= CLONE_NEWNS;
+			break;
 		case 'r':
 			unshare_flags |= CLONE_NEWUSER;
 			maproot = 1;
@@ -499,6 +542,9 @@ int main(int argc, char *argv[])
 	if ((unshare_flags & CLONE_NEWNS) && propagation)
 		set_propagation(propagation);
 
+	if (mnt_ns_filesystems(mounts, nmounts) < 0)
+		errx(EXIT_FAILURE, _("mounting namespace filesystems failed"));
+
 	if (newroot) {
 		if (chroot(newroot) != 0)
 			err(EXIT_FAILURE,
-- 
2.22.1

