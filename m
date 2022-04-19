Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035EFC433F5
	for <util-linux@archiver.kernel.org>; Tue, 19 Apr 2022 14:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiDSPA3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 Apr 2022 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353542AbiDSO7B (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2022 10:59:01 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D415034BA5
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2022 07:56:11 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0C1AE7E4;
        Tue, 19 Apr 2022 16:56:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1650380169;
        bh=7Bbj0AxNQRfWXGZ6v1pZLb2cPqbmshJZSjswCwhsYtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfpWFNhb7JMc1/bvspQ6AkEDAPalWSD2JZmSOGHvKqFON/pWIhcdj7/FbivrxXtgb
         U2MAgVB9nLLWAeTYa+ywvdPpbNsHOhxyZm25MQdxTXsF9hpj53VzwTpFa5G/TopWER
         ZesLKmPTVFyO58QqMNPH89ErjFJOkRyB+1I7/SJ49PCfG/u5LDzXriFHeaN3+9IbL3
         ETcEtFa3K+YWIbV51QnMhFGbNa3gHrE3q7IgF1CC/72pbmbFaUP+Da9Lp4ptmzSq0D
         mAOn2FgPbYmfw3Go/nTyVs3EvgxZJYqmvp6E8HUbgQhrIUfKEXuF4S3Yxi6yl6VCtC
         3tG0FvoymDMZA==
Date:   Tue, 19 Apr 2022 16:56:07 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH v3] libmount: accept X-mount.{owner,group,mode}=
Message-ID: <20220419145607.wk3wpsmudkmkdqvg@tarta.nabijaczleweli.xyz>
References: <20220406113814.twdo4mwkevwuayht@ws.net.home>
 <20220407183913.kvchb7hbrfhyxjoc@tarta.nabijaczleweli.xyz>
 <20220419111341.7n2jhxlf4446rmle@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qxnop2sthvey3dxx"
Content-Disposition: inline
In-Reply-To: <20220419111341.7n2jhxlf4446rmle@ws.net.home>
User-Agent: NeoMutt/20220415
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--qxnop2sthvey3dxx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Parsing moved to utils.c,
optstr.c uses mnt_parse_uid(),
all declarations moved to top-of-block,
lchown() and chmod() have a debug message before them if they run.

Also, re-wrote the test (and actually added them this time :v).

On Tue, Apr 19, 2022 at 01:13:41PM +0200, Karel Zak wrote:
> In this case it would be nice to be strict and use uid_t and gid_t in
> the functions.
>=20
> We already had CVE for this code, so I'd like to be paranoid here :-)

While in general I agree, and I wanted to do it Properly, util-linux is
already very cavalier about this and essentially asserts that [ug]id_t
is unsigned (or at least the same size as an unsigned; if that ever
changes you're gonna be in CVE city anyway), so I originally gave up
trying after not finding any library support for it.

Nevertheless, demonomorphised (but the bodies are essentially the same).

Updated scissor-patch below.

Best,
=D0=BD=D0=B0=D0=B1

-- >8 --
Which take a user, group, and mode, respectively, and set them on the
target after mounting

This is vaguely similar to tmpfs(5)'s [ug]id=3D and mode=3D options,
but we POSIX-parse the user- and group names

Oft requested in systemd/zram-generator, since a common use-case
is to use it to create /tmp or an equivalent directory that needs
to be a=3Drwx,o+t (or a user's private temp that needs to be owned
by them) =E2=80=92 this is impossible without terrible hacks, cf.
https://github.com/systemd/zram-generator/issues/150,
https://github.com/systemd/zram-generator/issues/146, &c.

This started off as a Set{User,Group,Mode}=3D systemd mount unit,
but was poetterung into libmount options:
https://github.com/systemd/systemd/pull/22889

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 libmount/src/context.c             |  12 ++-
 libmount/src/context_mount.c       |  87 +++++++++++++++++++-
 libmount/src/libmount.h.in         |  13 ++-
 libmount/src/mountP.h              |   7 ++
 libmount/src/optstr.c              |  19 +----
 libmount/src/utils.c               | 126 +++++++++++++++++++++++++++++
 sys-utils/mount.8.adoc             |   6 ++
 tests/expected/mount/set_ugid_mode |   1 +
 tests/ts/mount/set_ugid_mode       |  65 +++++++++++++++
 9 files changed, 315 insertions(+), 21 deletions(-)
 create mode 100644 tests/expected/mount/set_ugid_mode
 create mode 100755 tests/ts/mount/set_ugid_mode

diff --git a/libmount/src/context.c b/libmount/src/context.c
index 99ca58b9f..7927012d2 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -57,6 +57,10 @@ struct libmnt_context *mnt_new_context(void)
 	if (!cxt)
 		return NULL;
=20
+	cxt->tgt_owner =3D (uid_t) -1;
+	cxt->tgt_group =3D (gid_t) -1;
+	cxt->tgt_mode =3D (mode_t) -1;
+
 	INIT_LIST_HEAD(&cxt->addmounts);
=20
 	ruid =3D getuid();
@@ -76,7 +80,6 @@ struct libmnt_context *mnt_new_context(void)
 	DBG(CXT, ul_debugobj(cxt, "----> allocate %s",
 				cxt->restricted ? "[RESTRICTED]" : ""));
=20
-
 	return cxt;
 }
=20
@@ -130,7 +133,6 @@ void mnt_free_context(struct libmnt_context *cxt)
  *	mnt_context_set_options_pattern(cxt, NULL);
  *	mnt_context_set_target_ns(cxt, NULL);
  *
- *
  * to reset this stuff.
  *
  * Returns: 0 on success, negative number in case of error.
@@ -155,6 +157,10 @@ int mnt_reset_context(struct libmnt_context *cxt)
 	free(cxt->orig_user);
 	free(cxt->subdir);
=20
+	cxt->tgt_owner =3D (uid_t) -1;
+	cxt->tgt_group =3D (gid_t) -1;
+	cxt->tgt_mode =3D (mode_t) -1;
+
 	cxt->fs =3D NULL;
 	cxt->mtab =3D NULL;
 	cxt->utab =3D NULL;
@@ -3108,7 +3114,7 @@ static void close_ns(struct libmnt_ns *ns)
  *
  * This function sets errno to ENOSYS and returns error if libmount is
  * compiled without namespaces support.
-*
+ *
  * Returns: 0 on success, negative number in case of error.
  *
  * Since: 2.33
diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index f09e68860..6af83e041 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -837,7 +837,7 @@ static int do_mount(struct libmnt_context *cxt, const c=
har *try_type)
 		cxt->syscall_status =3D 0;
=20
 		DBG(CXT, ul_debugobj(cxt, "FAKE mount(2) "
-				"[source=3D%s, target=3D%s, type=3D%s, "
+				"[source=3D%s, target=3D%s, type=3D%s,"
 				" mountflags=3D0x%08lx, mountdata=3D%s]",
 				src, target, type,
 				flags, cxt->mountdata ? "yes" : "<none>"));
@@ -862,7 +862,7 @@ static int do_mount(struct libmnt_context *cxt, const c=
har *try_type)
 		}
=20
 		DBG(CXT, ul_debugobj(cxt, "mount(2) "
-			"[source=3D%s, target=3D%s, type=3D%s, "
+			"[source=3D%s, target=3D%s, type=3D%s,"
 			" mountflags=3D0x%08lx, mountdata=3D%s]",
 			src, target, type,
 			flags, cxt->mountdata ? "yes" : "<none>"));
@@ -1020,6 +1020,54 @@ static int do_mount_by_pattern(struct libmnt_context=
 *cxt, const char *pattern)
 	return rc;
 }
=20
+/*
+ * Process X-mount.owner=3D, X-mount.group=3D, X-mount.mode=3D.
+ */
+static int parse_ownership_mode(struct libmnt_context *cxt)
+{
+	int rc;
+	char *value;
+	size_t valsz;
+
+	const char *o =3D mnt_fs_get_user_options(cxt->fs);
+	if (!o)
+		return 0;
+
+	if ((rc =3D mnt_optstr_get_option(o, "X-mount.owner", &value, &valsz)) < =
0)
+		return -MNT_ERR_MOUNTOPT;
+	if (!rc) {
+		if (!valsz)
+			return errno =3D EINVAL, -MNT_ERR_MOUNTOPT;
+
+		if (mnt_parse_uid(value, valsz, &cxt->tgt_owner))
+			return -MNT_ERR_MOUNTOPT;
+	}
+
+	if ((rc =3D mnt_optstr_get_option(o, "X-mount.group", &value, &valsz)) < =
0)
+		return -MNT_ERR_MOUNTOPT;
+	if (!rc) {
+		if (!valsz)
+			return errno =3D EINVAL, -MNT_ERR_MOUNTOPT;
+
+		if (mnt_parse_gid(value, valsz, &cxt->tgt_group))
+			return -MNT_ERR_MOUNTOPT;
+	}
+
+	if ((rc =3D mnt_optstr_get_option(o, "X-mount.mode", &value, &valsz)) < 0)
+		return -MNT_ERR_MOUNTOPT;
+	if (!rc) {
+		if (!valsz)
+			return errno =3D EINVAL, -MNT_ERR_MOUNTOPT;
+
+		if ((rc =3D mnt_parse_mode(value, valsz, &cxt->tgt_mode)))
+			return -MNT_ERR_MOUNTOPT;
+	}
+
+	DBG(CXT, ul_debugobj(cxt, "ownership %d:%d, mode %04o", cxt->tgt_owner, c=
xt->tgt_group, cxt->tgt_mode));
+
+	return 0;
+}
+
 /**
  * mnt_context_prepare_mount:
  * @cxt: context
@@ -1064,6 +1112,8 @@ int mnt_context_prepare_mount(struct libmnt_context *=
cxt)
 		rc =3D mnt_context_guess_fstype(cxt);
 	if (!rc)
 		rc =3D mnt_context_prepare_target(cxt);
+	if (!rc)
+		rc =3D parse_ownership_mode(cxt);
 	if (!rc)
 		rc =3D mnt_context_prepare_helper(cxt, "mount", NULL);
=20
@@ -1089,6 +1139,25 @@ end:
 	return rc;
 }
=20
+static int set_ownership_mode(struct libmnt_context *cxt)
+{
+	const char *target =3D mnt_fs_get_target(cxt->fs);
+
+	if (cxt->tgt_owner !=3D (uid_t) -1 || cxt->tgt_group !=3D (uid_t) -1) {
+		DBG(CXT, ul_debugobj(cxt, "mount: lchown(%s, %u, %u)", target, cxt->tgt_=
owner, cxt->tgt_group));
+		if (lchown(target, cxt->tgt_owner, cxt->tgt_group) =3D=3D -1)
+			return -MNT_ERR_CHOWN;
+	}
+
+	if (cxt->tgt_mode !=3D (mode_t) -1) {
+		DBG(CXT, ul_debugobj(cxt, "mount: chmod(%s, %04o)", target, cxt->tgt_mod=
e));
+		if (chmod(target, cxt->tgt_mode) =3D=3D -1)
+			return -MNT_ERR_CHMOD;
+	}
+
+	return 0;
+}
+
 /**
  * mnt_context_do_mount
  * @cxt: context
@@ -1191,6 +1260,9 @@ int mnt_context_do_mount(struct libmnt_context *cxt)
 	if (mnt_context_is_veritydev(cxt))
 		mnt_context_deferred_delete_veritydev(cxt);
=20
+	if (!res)
+		res =3D set_ownership_mode(cxt);
+
 	if (!mnt_context_switch_ns(cxt, ns_old))
 		return -MNT_ERR_NAMESPACE;
=20
@@ -1841,7 +1913,18 @@ int mnt_context_get_mount_excode(
 			if (buf)
 				snprintf(buf, bufsz, _("filesystem was mounted, but failed to switch n=
amespace back"));
 			return MNT_EX_SYSERR;
+		}
+
+		if (rc =3D=3D -MNT_ERR_CHOWN) {
+			if (buf)
+				snprintf(buf, bufsz, _("filesystem was mounted, but failed to change o=
wnership to %u:%u: %m"), cxt->tgt_owner, cxt->tgt_group);
+			return MNT_EX_SYSERR;
+		}
=20
+		if (rc =3D=3D -MNT_ERR_CHMOD) {
+			if (buf)
+				snprintf(buf, bufsz, _("filesystem was mounted, but failed to change m=
ode to %04o: %m"), cxt->tgt_mode);
+			return MNT_EX_SYSERR;
 		}
=20
 		if (rc < 0)
diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index 43d8e44ce..0ab1d6ece 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -220,6 +220,18 @@ enum {
  * filesystem mounted, but --onlyonce specified
  */
 #define MNT_ERR_ONLYONCE    5010
+/**
+ * MNT_ERR_CHOWN:
+ *
+ * filesystem mounted, but subsequent X-mount.owner=3D/X-mount.group=3D lc=
hown(2) failed
+ */
+#define MNT_ERR_CHOWN    5011
+/**
+ * MNT_ERR_CHMOD:
+ *
+ * filesystem mounted, but subsequent X-mount.mode=3D chmod(2) failed
+ */
+#define MNT_ERR_CHMOD    5012
=20
=20
 /*
@@ -246,7 +258,6 @@ enum {
  *
  * [u]mount(8) exit code: out of memory, cannot fork, ...
  */
-
 #define MNT_EX_SYSERR	2
=20
 /**
diff --git a/libmount/src/mountP.h b/libmount/src/mountP.h
index 561ddcd8c..26158e8d9 100644
--- a/libmount/src/mountP.h
+++ b/libmount/src/mountP.h
@@ -109,6 +109,9 @@ extern int mnt_chdir_to_parent(const char *target, char=
 **filename);
 extern char *mnt_get_username(const uid_t uid);
 extern int mnt_get_uid(const char *username, uid_t *uid);
 extern int mnt_get_gid(const char *groupname, gid_t *gid);
+extern int mnt_parse_uid(const char *user, size_t user_len, uid_t *gid);
+extern int mnt_parse_gid(const char *group, size_t group_len, gid_t *gid);
+extern int mnt_parse_mode(const char *mode, size_t mode_len, mode_t *gid);
 extern int mnt_in_group(gid_t gid);
=20
 extern int mnt_open_uniq_filename(const char *filename, char **name);
@@ -294,6 +297,10 @@ struct libmnt_context
=20
 	char	*subdir;		/* X-mount.subdir=3D */
=20
+	uid_t	tgt_owner;		/* X-mount.owner=3D */
+	gid_t	tgt_group;		/* X-mount.group=3D */
+	mode_t	tgt_mode;		/* X-mount.mode=3D */
+
 	struct libmnt_fs *fs;		/* filesystem description (type, mountpoint, devic=
e, ...) */
 	struct libmnt_fs *fs_template;	/* used for @fs on mnt_reset_context() */
=20
diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
index 43b983ebb..0ad5bfdc6 100644
--- a/libmount/src/optstr.c
+++ b/libmount/src/optstr.c
@@ -1019,15 +1019,13 @@ int mnt_optstr_fix_user(char **optstr)
 /*
  * Converts value from @optstr addressed by @name to uid.
  *
- * Returns: 0 on success, 1 if not found, <0 on error
+ * Returns: 0 on success, <0 on error
  */
 int mnt_optstr_get_uid(const char *optstr, const char *name, uid_t *uid)
 {
 	char *value =3D NULL;
 	size_t valsz =3D 0;
-	char buf[sizeof(stringify_value(UINT64_MAX))];
 	int rc;
-	uint64_t num;
=20
 	assert(optstr);
 	assert(name);
@@ -1037,20 +1035,11 @@ int mnt_optstr_get_uid(const char *optstr, const ch=
ar *name, uid_t *uid)
 	if (rc !=3D 0)
 		goto fail;
=20
-	if (valsz > sizeof(buf) - 1) {
-		rc =3D -ERANGE;
+	rc =3D mnt_parse_uid(value, valsz, uid);
+	if (rc !=3D 0) {
+		rc =3D -errno;
 		goto fail;
 	}
-	mem2strcpy(buf, value, valsz, sizeof(buf));
-
-	rc =3D ul_strtou64(buf, &num, 10);
-	if (rc !=3D 0)
-		goto fail;
-	if (num > ULONG_MAX || (uid_t) num !=3D num) {
-		rc =3D -ERANGE;
-		goto fail;
-	}
-	*uid =3D (uid_t) num;
=20
 	return 0;
 fail:
diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index ff3acfb55..a138abe7e 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -635,6 +635,132 @@ int mnt_get_gid(const char *groupname, gid_t *gid)
 	return rc;
 }
=20
+static int parse_uid_numeric(const char *value, size_t valsz, uid_t *uid)
+{
+	uint64_t num;
+
+	assert(value);
+	assert(uid);
+
+	if (valsz > sizeof(stringify_value(UINT64_MAX)) - 1) {
+		errno =3D ERANGE;
+		goto fail;
+	}
+
+	if (ul_strtou64(value, &num, 10) !=3D 0) {
+		errno =3D ENOENT;
+		goto fail;
+	}
+	if (num > ULONG_MAX || (uid_t) num !=3D num) {
+		errno =3D ERANGE;
+		goto fail;
+	}
+	*uid =3D (uid_t) num;
+
+	return 0;
+fail:
+	DBG(UTILS, ul_debug("failed to convert '%s' to number [errno=3D%d]", valu=
e, errno));
+	return -1;
+}
+
+/* POSIX-parse user_len-sized user; -1 and errno set, or 0 on success */
+int mnt_parse_uid(const char *user, size_t user_len, uid_t *uid)
+{
+	char *user_tofree =3D NULL;
+	int rc;
+
+	if (user[user_len]) {
+		user =3D user_tofree =3D strndup(user, user_len);
+		if (!user)
+			return -1;
+	}
+
+	rc =3D mnt_get_uid(user, uid);
+	if (rc !=3D 0 && isdigit(*user))
+		rc =3D parse_uid_numeric(user, user_len, uid);
+
+	free(user_tofree);
+	return rc;
+}
+
+static int parse_gid_numeric(const char *value, size_t valsz, gid_t *gid)
+{
+	uint64_t num;
+
+	assert(value);
+	assert(gid);
+
+	if (valsz > sizeof(stringify_value(UINT64_MAX)) - 1) {
+		errno =3D ERANGE;
+		goto fail;
+	}
+
+	if (ul_strtou64(value, &num, 10) !=3D 0) {
+		errno =3D ENOENT;
+		goto fail;
+	}
+	if (num > ULONG_MAX || (gid_t) num !=3D num) {
+		errno =3D ERANGE;
+		goto fail;
+	}
+	*gid =3D (gid_t) num;
+
+	return 0;
+fail:
+	DBG(UTILS, ul_debug("failed to convert '%s' to number [errno=3D%d]", valu=
e, errno));
+	return -1;
+}
+
+/* POSIX-parse group_len-sized group; -1 and errno set, or 0 on success */
+int mnt_parse_gid(const char *group, size_t group_len, gid_t *gid)
+{
+	char *group_tofree =3D NULL;
+	int rc;
+
+	if (group[group_len]) {
+		group =3D group_tofree =3D strndup(group, group_len);
+		if (!group)
+			return -1;
+	}
+
+	rc =3D mnt_get_gid(group, gid);
+	if (rc !=3D 0 && isdigit(*group))
+		rc =3D parse_gid_numeric(group, group_len, gid);
+
+	free(group_tofree);
+	return rc;
+}
+
+int mnt_parse_mode(const char *mode, size_t mode_len, mode_t *uid)
+{
+	char buf[sizeof(stringify_value(UINT32_MAX))];
+	uint32_t num;
+
+	assert(mode);
+	assert(uid);
+
+	if (mode_len > sizeof(buf) - 1) {
+		errno =3D ERANGE;
+		goto fail;
+	}
+	mem2strcpy(buf, mode, mode_len, sizeof(buf));
+
+	if (ul_strtou32(buf, &num, 8) !=3D 0) {
+		errno =3D EINVAL;
+		goto fail;
+	}
+	if (num > 07777) {
+		errno =3D ERANGE;
+		goto fail;
+	}
+	*uid =3D (mode_t) num;
+
+	return 0;
+fail:
+	DBG(UTILS, ul_debug("failed to convert '%.*s' to mode [errno=3D%d]", (int=
) mode_len, mode, errno));
+	return -1;
+}
+
 int mnt_in_group(gid_t gid)
 {
 	int rc =3D 0, n, i;
diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 7465fcd0d..5f0ddd05b 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -636,6 +636,12 @@ Allow to make a target directory (mountpoint) if it do=
es not exist yet. The opti
 **X-mount.subdir=3D**__directory__::
 Allow mounting sub-directory from a filesystem instead of the root directo=
ry. For now, this feature is implemented by temporary filesystem root direc=
tory mount in unshared namespace and then bind the sub-directory to the fin=
al mount point and umount the root of the filesystem. The sub-directory mou=
nt shows up atomically for the rest of the system although it is implemente=
d by multiple *mount*(2) syscalls. This feature is EXPERIMENTAL.
=20
+*X-mount.owner*=3D_username_|_UID_, *X-mount.group*=3D_group_|_GID_::
+Set _mountpoint_'s ownership after mounting. Names resolved in the target =
mount namespace, see *-N*.
+
+*X-mount.mode*=3D_mode_::
+Set _mountpoint_'s mode after mounting.
+
 *nosymfollow*::
 Do not follow symlinks when resolving paths. Symlinks can still be created=
, and *readlink*(1), *readlink*(2), *realpath*(1), and *realpath*(3) all st=
ill work properly.
=20
diff --git a/tests/expected/mount/set_ugid_mode b/tests/expected/mount/set_=
ugid_mode
new file mode 100644
index 000000000..35821117c
--- /dev/null
+++ b/tests/expected/mount/set_ugid_mode
@@ -0,0 +1 @@
+Success
diff --git a/tests/ts/mount/set_ugid_mode b/tests/ts/mount/set_ugid_mode
new file mode 100755
index 000000000..810f81f38
--- /dev/null
+++ b/tests/ts/mount/set_ugid_mode
@@ -0,0 +1,65 @@
+#!/bin/bash
+# SPDX-License-Identifier: 0BSD
+
+
+TS_TOPDIR=3D"${0%/*}/../.."
+TS_DESC=3D"X-mount.{owner,group,mode}=3D"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
+ts_skip_nonroot
+ts_check_losetup
+ts_check_prog "mkfs.ext2"
+ts_check_prog "id"
+ts_check_prog "ls"
+
+
+do_one() {
+	expected=3D"$1"; shift
+	what=3D"$1"; shift
+	where=3D"$1"; shift
+	$TS_CMD_MOUNT "$@" "$what" "$where" >> $TS_OUTPUT 2>> $TS_ERRLOG
+	read -r m _ o g _ < <(ls -nd "$where")
+	actual=3D"$m $o $g"
+	[ "$actual" =3D "$expected" ] || echo "$*: $actual !=3D $expected" >> $TS=
_ERRLOG
+	$TS_CMD_UMOUNT "$where" >> $TS_OUTPUT 2>> $TS_ERRLOG
+}
+
+ts_device_init
+
+mkfs.ext2 "$TS_LODEV" > /dev/null 2>&1  || ts_die "Cannot make ext2 on $TS=
_LODEV"
+ts_device_has "TYPE" "ext2" "$TS_LODEV" || ts_die "Cannot find ext2 on $TS=
_LODEV"
+
+user_1=3D"$(id -un 1)"
+group_2=3D"$(id -gn 2)"
+
+
+mkdir -p "$TS_MOUNTPOINT"
+
+do_one "drwxr-xr-x 0 0"     "$TS_LODEV" "$TS_MOUNTPOINT"
+do_one "drwxr-xr-x 1 0"     "$TS_LODEV" "$TS_MOUNTPOINT" -o "X-mount.owner=
=3D$user_1"
+do_one "drwxr-xr-x 1 2"     "$TS_LODEV" "$TS_MOUNTPOINT" -o "X-mount.group=
=3D$group_2"
+do_one "d-w--wxr-T 132 2"   "$TS_LODEV" "$TS_MOUNTPOINT" -o "X-mount.owner=
=3D132,X-mount.mode=3D1234"
+do_one "d-ws-w---x 132 123" "$TS_LODEV" "$TS_MOUNTPOINT" -o "X-mount.mode=
=3D4321,X-mount.group=3D123"
+do_one "d-ws-w---x 1 321"   "$TS_LODEV" "$TS_MOUNTPOINT" -o "X-mount.owner=
=3D$user_1,X-mount.group=3D321"
+
+
+> "$TS_MOUNTPOINT/bind"
+> "$TS_MOUNTPOINT/bindsrc"
+
+do_one "-rw-r--r-- 0 0"     "$TS_MOUNTPOINT/bindsrc" "$TS_MOUNTPOINT/bind"=
 --bind
+do_one "-rw-r--r-- 1 0"     "$TS_MOUNTPOINT/bindsrc" "$TS_MOUNTPOINT/bind"=
 --bind -o "X-mount.owner=3D$user_1"
+do_one "-rw-r--r-- 1 2"     "$TS_MOUNTPOINT/bindsrc" "$TS_MOUNTPOINT/bind"=
 --bind -o "X-mount.group=3D$group_2"
+do_one "--w--wxr-T 132 2"   "$TS_MOUNTPOINT/bindsrc" "$TS_MOUNTPOINT/bind"=
 --bind -o "X-mount.owner=3D132,X-mount.mode=3D1234"
+do_one "--ws-w---x 132 123" "$TS_MOUNTPOINT/bindsrc" "$TS_MOUNTPOINT/bind"=
 --bind -o "X-mount.mode=3D4321,X-mount.group=3D123"
+do_one "--wx-w---x 1 321"   "$TS_MOUNTPOINT/bindsrc" "$TS_MOUNTPOINT/bind"=
 --bind -o "X-mount.owner=3D$user_1,X-mount.group=3D321"
+
+
+rm -fd "$TS_MOUNTPOINT/bind"  "$TS_MOUNTPOINT/bindsrc" "$TS_MOUNTPOINT"
+
+ts_log "Success"
+ts_finalize
--=20
2.30.2

--qxnop2sthvey3dxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJezYcACgkQvP0LAY0m
WPEYWA/9GlIUEKim6fni1/g4iEIbnw60/vW+j/9jXdJysMdjbeCkdeRNJsSz8w1m
o54U1j1tsmE61DgbpmRcmOAvHWUAGcaElkwFS5cyF2dfcqJrkDJoYhTa93XPKqjt
P1J7se1EBCJfatdy9j04ZAzzB4/4u7jhgCTGmgt9X7x7SgQOWhtLGky3wDZOtWLH
izTstoTKnJqh38QcQY4aFpILfuwYUDxv8VqkEaI2gX+t4/wnY9JdMnFMd9erZxxc
ogTZkBWxCnwgiSvQSwnglTKS1k4EaTiBbHXaxj23wgn8u2fweEKzW9O5xNhBT0sN
oKO4nJnK1FhkOOUYfJ6vYD1+6DGqya3jJqmQmGm5LGILuTmutgV4Uxsqf0ScQuGr
XbjLd9iyYScm7FafWZNf+Aoupgv0CUaazwkW8IKVpgeIOAS4J7Sudj6maQfhno+u
2zSngOOE1i2avudR+O8BSt4EfTT4S6AM5VkrTaswQ3bYErG0oPnWvaOp0+FeCf/2
vcXlD+Q5X4Vsk/fRPPJk8sGmFwo8Tn1Qx+uFsMKDU+2zT7IjFhXkR3/lH8GFWDZF
vTLrkVtxuxTqrUI2j7UdLdh5q0D8JGXGqzWw/kNP9EC3udvououetwecH6C//nnl
WuwB+LSqkOL7usqutok+vpRju0QydFCFbKMWyB5lRvE3H9jIcbQ=
=hXNO
-----END PGP SIGNATURE-----

--qxnop2sthvey3dxx--
