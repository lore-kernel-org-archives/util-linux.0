Return-Path: <SRS0=TDKU=ZL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83F2C432C0
	for <util-linux@archiver.kernel.org>; Tue, 19 Nov 2019 14:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE28222A9
	for <util-linux@archiver.kernel.org>; Tue, 19 Nov 2019 14:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8Pmyd5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfKSOeR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:34:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727456AbfKSOeR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 Nov 2019 09:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574174054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SqkEZoj+HJWOEzP0C+As6TL1EBnTwiYff1nc99AxPag=;
        b=g8Pmyd5VF7sPOuSiMjitWn+8Nagvu6dObMO9wdubYvS+uZpPw+KqpWcAb4CFup54//NJX3
        +VvQB7ED0XX76RCpWfAT8oZJ/31FqcPIXam8iOaSpkAipCdb7yig4gSs/muE1TKWBcc1Sp
        bWqSIKPokkHsipTg0qfYOWt3X/y5sgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-Dnx0lHX_PZC9IS260s0OUA-1; Tue, 19 Nov 2019 09:34:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4F44100E48E
        for <util-linux@vger.kernel.org>; Tue, 19 Nov 2019 14:34:11 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFBCF50FB8
        for <util-linux@vger.kernel.org>; Tue, 19 Nov 2019 14:34:10 +0000 (UTC)
Date:   Tue, 19 Nov 2019 15:34:08 +0100
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: [HEADS-UP]: mount(8) non-root user mount changes
Message-ID: <20191119143408.b6pcbhtsiubxdcob@10.255.255.10>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Dnx0lHX_PZC9IS260s0OUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi,

 for years users are unhappy with too strict mount/umount rules for
 non-root users.  The rules makes mount(8) useless for use-cases where
 root permissions are unnecessary. This patch changes the game.
=20
 Please, review, complain, ...

    Karel

From 6497f2d99e9cabee3531e644ba4dcffd14532200 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Tue, 19 Nov 2019 14:58:20 +0100
Subject: [PATCH] mount: no exit on EPERM, continue without suid
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The current libmount assumes that mount(8) and umount(8) are suid
binaries. For this reason it implements internal rules which
restrict what is allowed for non-root users. Unfortunately, it's
out of reality for some use-cases where root permissions are no
required. Nice example are fuse filesystems.

So, the current situation is to call exit() always when mount, umount or
libmount are unsure with non-root user rights. This patch removes the
exit() call and replaces it with suid permissions drop, after that it
continues as usually. It means after suid-drop all depend on kernel
and no another security rule is used by libmount (simply because any
rule is no more necessary).

Example:

old version:
   $ mount -t fuse.sshfs kzak@192.168.111.1:/home/kzak /home/kzak/mnt
   mount: only root can use "--types" option

new version:
   $ mount -t fuse.sshfs kzak@192.168.111.1:/home/kzak /home/kzak/mnt
   kzak@192.168.111.1's password:

   $ findmnt /home/kzak/mnt
   TARGET         SOURCE                        FSTYPE     OPTIONS
   /home/kzak/mnt kzak@192.168.111.1:/home/kzak fuse.sshfs rw,nosuid,nodev,=
relatime,user_id=3D1000,group_id=3D1000

   $ umount /home/kzak/mnt
   $=A0echo $?
   0

Note that fuse user umount is supported since v2.34 due to user_id=3D in
kernel mount table.

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 libmount/docs/libmount-sections.txt |  1 +
 libmount/src/context.c              | 25 +++++++++++++++++
 libmount/src/libmount.h.in          |  1 +
 libmount/src/libmount.sym           |  1 +
 sys-utils/mount.8                   |  6 ++++
 sys-utils/mount.c                   | 43 +++++++++++++++++------------
 sys-utils/umount.8                  | 19 +++++++++++++
 sys-utils/umount.c                  | 37 +++++++++++++++----------
 8 files changed, 102 insertions(+), 31 deletions(-)

diff --git a/libmount/docs/libmount-sections.txt b/libmount/docs/libmount-s=
ections.txt
index 990c0394f..0bba9f835 100644
--- a/libmount/docs/libmount-sections.txt
+++ b/libmount/docs/libmount-sections.txt
@@ -40,6 +40,7 @@ mnt_context_enable_rwonly_mount
 mnt_context_enable_sloppy
 mnt_context_enable_verbose
 mnt_context_forced_rdonly
+mnt_context_force_unrestricted
 mnt_context_get_cache
 mnt_context_get_excode
 mnt_context_get_fs
diff --git a/libmount/src/context.c b/libmount/src/context.c
index 977842f7d..72a0c5a7b 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -426,6 +426,31 @@ int mnt_context_is_restricted(struct libmnt_context *c=
xt)
 =09return cxt->restricted;
 }
=20
+/**
+ * mnt_context_force_unrestricted:
+ * @cxt: mount context
+ *
+ * This function is DANGEROURS as it disables all security policies in lib=
mount.
+ * Don't use if not sure. It removes "restricted" flag from the context, s=
o
+ * libmount will use the current context as for root user.
+ *
+ * This function is designed for case you have no any suid permissions, so=
 you
+ * can depend on kernel.
+ *
+ * Returns: 0 on success, negative number in case of error.
+ *
+ * Since: 2.35
+ */
+int mnt_context_force_unrestricted(struct libmnt_context *cxt)
+{
+=09if (mnt_context_is_restricted(cxt)) {
+=09=09DBG(CXT, ul_debugobj(cxt, "force UNRESTRICTED"));
+=09=09cxt->restricted =3D 0;
+=09}
+
+=09return 0;
+}
+
 /**
  * mnt_context_set_optsmode
  * @cxt: mount context
diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index 19d4c5b53..ba54cf25d 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -705,6 +705,7 @@ extern void mnt_free_context(struct libmnt_context *cxt=
);
 extern int mnt_reset_context(struct libmnt_context *cxt);
 extern int mnt_context_is_restricted(struct libmnt_context *cxt)
 =09=09=09__ul_attribute__((nonnull));
+extern int mnt_context_force_unrestricted(struct libmnt_context *cxt);
=20
 extern int mnt_context_init_helper(struct libmnt_context *cxt,
 =09=09=09=09   int action, int flags);
diff --git a/libmount/src/libmount.sym b/libmount/src/libmount.sym
index b9a4c0d22..792d11753 100644
--- a/libmount/src/libmount.sym
+++ b/libmount/src/libmount.sym
@@ -352,6 +352,7 @@ MOUNT_2.34 {
 } MOUNT_2.33;
=20
 MOUNT_2_35 {
+=09mnt_context_force_unrestricted;
 =09mnt_context_get_target_prefix;
 =09mnt_context_set_target_prefix;
 } MOUNT_2.34;
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 9d31d8245..a6231c7c1 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -315,6 +315,12 @@ program is executed. It's strongly recommended to use =
a valid mountpoint to
 specify filesystem, otherwise \fBmount\fR may fail. For example it's bad i=
dea
 to use NFS or CIFS source on command line.
 .PP
+Since version 2.35 \fBmount\fR command does not exit when user permissions=
 are
+inadequate by internal libmount security rules.  It drops suid permissions
+and continue as regular non-root user. It allows to support use-cases wher=
e
+root permissions are not necessary (e.g. fuse filesystems, user namespaces=
,
+etc).
+.PP
 For more details, see
 .BR fstab (5).
 Only the user that mounted a filesystem can unmount it again.
diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 08da9e6a5..5842bc2ec 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -47,23 +47,24 @@
=20
 static int mk_exit_code(struct libmnt_context *cxt, int rc);
=20
-static void __attribute__((__noreturn__)) exit_non_root(const char *option=
)
+static void suid_drop(struct libmnt_context *cxt)
 {
 =09const uid_t ruid =3D getuid();
 =09const uid_t euid =3D geteuid();
=20
-=09if (ruid =3D=3D 0 && euid !=3D 0) {
-=09=09/* user is root, but setuid to non-root */
-=09=09if (option)
-=09=09=09errx(MNT_EX_USAGE, _("only root can use \"--%s\" option "
-=09=09=09=09=09 "(effective UID is %u)"),
-=09=09=09=09=09option, euid);
-=09=09errx(MNT_EX_USAGE, _("only root can do that "
-=09=09=09=09 "(effective UID is %u)"), euid);
+=09if (ruid !=3D 0 && euid =3D=3D 0) {
+=09=09if (setgid(getgid()) < 0)
+=09=09=09err(MNT_EX_FAIL, _("setgid() failed"));
+
+=09=09if (setuid(getuid()) < 0)
+=09=09=09err(MNT_EX_FAIL, _("setuid() failed"));
 =09}
-=09if (option)
-=09=09errx(MNT_EX_USAGE, _("only root can use \"--%s\" option"), option);
-=09errx(MNT_EX_USAGE, _("only root can do that"));
+
+=09/* be paranoid and check it, setuid(0) has to fail */
+=09if (ruid !=3D 0 && setuid(0) =3D=3D 0)
+=09=09errx(MNT_EX_FAIL, _("drop permissions failed."));
+
+=09mnt_context_force_unrestricted(cxt);
 }
=20
 static void __attribute__((__noreturn__)) mount_print_version(void)
@@ -672,7 +673,7 @@ int main(int argc, char **argv)
 =09=09    !strchr("hlLUVvrist", c) &&
 =09=09    c !=3D MOUNT_OPT_TARGET &&
 =09=09    c !=3D MOUNT_OPT_SOURCE)
-=09=09=09exit_non_root(option_to_longopt(c, longopts));
+=09=09=09suid_drop(cxt);
=20
 =09=09err_exclusive_options(c, longopts, excl, excl_st);
=20
@@ -872,7 +873,7 @@ int main(int argc, char **argv)
 =09/* Non-root users are allowed to use -t to print_all(),
 =09   but not to mount */
 =09if (mnt_context_is_restricted(cxt) && types)
-=09=09exit_non_root("types");
+=09=09suid_drop(cxt);
=20
 =09if (oper && (types || all || mnt_context_get_source(cxt))) {
 =09=09warnx(_("bad usage"));
@@ -905,7 +906,7 @@ int main(int argc, char **argv)
 =09=09if (mnt_context_is_restricted(cxt) &&
 =09=09    mnt_context_get_source(cxt) &&
 =09=09    mnt_context_get_target(cxt))
-=09=09=09exit_non_root(NULL);
+=09=09=09suid_drop(cxt);
=20
 =09} else if (argc =3D=3D 1 && (!mnt_context_get_source(cxt) ||
 =09=09=09=09 !mnt_context_get_target(cxt))) {
@@ -933,7 +934,7 @@ int main(int argc, char **argv)
 =09=09if (mnt_context_is_restricted(cxt) &&
 =09=09    mnt_context_get_source(cxt) &&
 =09=09    mnt_context_get_target(cxt))
-=09=09=09exit_non_root(NULL);
+=09=09=09suid_drop(cxt);
=20
 =09} else if (argc =3D=3D 2 && !mnt_context_get_source(cxt)
 =09=09=09     && !mnt_context_get_target(cxt)) {
@@ -941,7 +942,7 @@ int main(int argc, char **argv)
 =09=09 * D) mount <source> <target>
 =09=09 */
 =09=09if (mnt_context_is_restricted(cxt))
-=09=09=09exit_non_root(NULL);
+=09=09=09suid_drop(cxt);
=20
 =09=09mnt_context_set_source(cxt, argv[0]);
 =09=09mnt_context_set_target(cxt, argv[1]);
@@ -963,6 +964,14 @@ int main(int argc, char **argv)
 =09=09mnt_context_set_optsmode(cxt, MNT_OMODE_NOTAB);
=20
 =09rc =3D mnt_context_mount(cxt);
+
+=09if (rc =3D=3D -EPERM
+=09    && mnt_context_is_restricted(cxt)
+=09    && !mnt_context_syscall_called(cxt)) {
+=09=09/* Try it again without permissions */
+=09=09suid_drop(cxt);
+=09=09rc =3D mnt_context_mount(cxt);
+=09}
 =09rc =3D mk_exit_code(cxt, rc);
=20
 =09if (rc =3D=3D MNT_EX_SUCCESS && mnt_context_is_verbose(cxt))
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index f94d2f41f..9bec521e7 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -190,6 +190,25 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
+.SH "NON-SUPERUSER UMOUNTS"
+Normally, only the superuser can umount filesystems.
+However, when
+.I fstab
+contains the
+.B user
+option on a line, anybody can umount the corresponding filesystem.  For mo=
re details see
+.BR mount (8)
+man page.
+.PP
+Since version 2.34 \fBumount\fR command allows to perform umount operation=
 also
+for fuse filesystems if kernel mount table contains user's ID.  In this ca=
se fstab
+user=3D mount option is not required.
+.PP
+Since version 2.35 \fBumount\fR command does not exit when user permission=
s are
+inadequate by internal libmount security rules.  It drops suid permissions
+and continue as regular non-root user. It allows to support use-cases wher=
e
+root permissions are not necessary (e.g. fuse filesystems, user namespaces=
,
+etc).
 .SH "LOOP DEVICE"
 The
 .B umount
diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index 397e0ebfc..74d87d671 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -112,24 +112,24 @@ static void __attribute__((__noreturn__)) usage(void)
 =09exit(MNT_EX_SUCCESS);
 }
=20
-static void __attribute__((__noreturn__)) exit_non_root(const char *option=
)
+static void suid_drop(struct libmnt_context *cxt)
 {
 =09const uid_t ruid =3D getuid();
 =09const uid_t euid =3D geteuid();
=20
-=09if (ruid =3D=3D 0 && euid !=3D 0) {
-=09=09/* user is root, but setuid to non-root */
-=09=09if (option)
-=09=09=09errx(MNT_EX_USAGE,
-=09=09=09=09_("only root can use \"--%s\" option "
-=09=09=09=09 "(effective UID is %u)"),
-=09=09=09=09=09option, euid);
-=09=09errx(MNT_EX_USAGE, _("only root can do that "
-=09=09=09=09 "(effective UID is %u)"), euid);
+=09if (ruid !=3D 0 && euid =3D=3D 0) {
+=09=09if (setgid(getgid()) < 0)
+=09=09=09err(MNT_EX_FAIL, _("setgid() failed"));
+
+=09=09if (setuid(getuid()) < 0)
+=09=09=09err(MNT_EX_FAIL, _("setuid() failed"));
 =09}
-=09if (option)
-=09=09errx(MNT_EX_USAGE, _("only root can use \"--%s\" option"), option);
-=09errx(MNT_EX_USAGE, _("only root can do that"));
+
+=09/* be paranoid and check it, setuid(0) has to fail */
+=09if (ruid !=3D 0 && setuid(0) =3D=3D 0)
+=09=09errx(MNT_EX_FAIL, _("drop permissions failed."));
+
+=09mnt_context_force_unrestricted(cxt);
 }
=20
 static void success_message(struct libmnt_context *cxt)
@@ -220,6 +220,15 @@ static int umount_one(struct libmnt_context *cxt, cons=
t char *spec)
 =09=09err(MNT_EX_SYSERR, _("failed to set umount target"));
=20
 =09rc =3D mnt_context_umount(cxt);
+
+=09if (rc =3D=3D -EPERM
+=09    && mnt_context_is_restricted(cxt)
+=09    && !mnt_context_syscall_called(cxt)) {
+=09=09/* Failed somewhere in libmount, drop perms and try it again */
+=09=09suid_drop(cxt);
+=09=09rc =3D mnt_context_umount(cxt);
+=09}
+
 =09rc =3D mk_exit_code(cxt, rc);
=20
 =09if (rc =3D=3D MNT_EX_SUCCESS && mnt_context_is_verbose(cxt))
@@ -494,7 +503,7 @@ int main(int argc, char **argv)
=20
 =09=09/* only few options are allowed for non-root users */
 =09=09if (mnt_context_is_restricted(cxt) && !strchr("hdilqVv", c))
-=09=09=09exit_non_root(option_to_longopt(c, longopts));
+=09=09=09suid_drop(cxt);
=20
 =09=09err_exclusive_options(c, longopts, excl, excl_st);
=20
--=20
2.21.0

