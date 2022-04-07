Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B1DC433EF
	for <util-linux@archiver.kernel.org>; Thu,  7 Apr 2022 18:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiDGSlW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiDGSlV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 7 Apr 2022 14:41:21 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2190E1A3AFA
        for <util-linux@vger.kernel.org>; Thu,  7 Apr 2022 11:39:16 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D56D1956;
        Thu,  7 Apr 2022 20:39:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1649356754;
        bh=2I2kb4fpGlT67i5QU/e2GzDV13xFYsWP6RSK2kxVbdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACKuhDm8eLT8I+gY0C5KG3+XqXRoHjfjR3urJOT6Coo10Fyhl3B/Ul3thl8HG3hNe
         oUMe/v3k64ZIf4aAd1IP1xIlEKYGb1lPO8cbNk+5N/nzgnM6l9VMzO6Xp+mMCcMliN
         pr+6RTawzS55/v5gDvpl25ulewiEcZtpPP7DquIGiIjU7Q757ksFvkrgHr7U8iIqPb
         mcBq6cA84axwU487g+2Y6j9XsMGm5Ky2lwpIavJ98DvID3D9ALrl4oR8PuzqBwoJTr
         cRcp6xi1qOIHMkoY14thhvWnOrcAFrDAHCpvkJ/RzcRb2DpJX0UJHpB+qEU+fgl3PV
         82J9WTt4Qf5kQ==
Date:   Thu, 7 Apr 2022 20:39:13 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [RFC v2] libmount: accept X-mount.{owner,group,mode}=
Message-ID: <20220407183913.kvchb7hbrfhyxjoc@tarta.nabijaczleweli.xyz>
References: <20220406113814.twdo4mwkevwuayht@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7hwtv7vlyuc5ytq4"
Content-Disposition: inline
In-Reply-To: <20220406113814.twdo4mwkevwuayht@ws.net.home>
User-Agent: NeoMutt/20211029-557-7a7327
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--7hwtv7vlyuc5ytq4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the pointers!

Please see below for updated scissor-patch, which
  * splits parsing from setting
  * integrates parsing into _prepare_mount()
  * integrates setting into _do_mount()
  * has tests
  * returns MNT_ERR_MOUNTOPT (with errno set to an unambiguous value)
    on parsing errors
  * returns MNT_ERR_CHOWN/MNT_ERR_CHMOD on setting errors
  * explicitly mentions that username/group parsing happens in the
    target namespace, which I assume is what you meant by
	"before mnt_context_switch_ns()", because that's literal there
	(I also don't know if that's, uh, valid?);
	if you meant the transitive namespace switch via
	mnt_context_switch_target_ns() then it's trivial to hoist it up
	above it in _prepare() =E2=80=92 this is why I marked this RFC

Best,
=D0=BD=D0=B0=D0=B1

-- >8 --
Which take an user, group, and mode, respectively, and set them on the
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
---
 .gitignore                   |   1 +
 libmount/src/context.c       |  12 ++-
 libmount/src/context_mount.c | 157 +++++++++++++++++++++++++++++++++++
 libmount/src/libmount.h.in   |  13 ++-
 libmount/src/mountP.h        |   4 +
 sys-utils/mount.8.adoc       |   6 ++
 6 files changed, 189 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index 840f64615..51a019307 100644
--- a/.gitignore
+++ b/.gitignore
@@ -71,6 +71,7 @@ ylwrap
 /blkdiscard
 /blkzone
 /blkid
+/blkpr
 /blockdev
 /cal
 /cfdisk
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
index f09e68860..13209d861 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -1020,6 +1020,132 @@ static int do_mount_by_pattern(struct libmnt_contex=
t *cxt, const char *pattern)
 	return rc;
 }
=20
+/* Extracted from mnt_optstr_get_uid() */
+static int parse_ugid(const char *value, size_t valsz, unsigned *uid)
+{
+	char buf[sizeof(stringify_value(UINT64_MAX))];
+	int rc;
+	uint64_t num;
+
+	assert(value);
+	assert(uid);
+
+	if (valsz > sizeof(buf) - 1) {
+		rc =3D -ERANGE;
+		goto fail;
+	}
+	mem2strcpy(buf, value, valsz, sizeof(buf));
+
+	rc =3D ul_strtou64(buf, &num, 10);
+	if (rc !=3D 0) {
+		errno =3D ENOENT;
+		goto fail;
+	}
+	if (num > ULONG_MAX || (unsigned) num !=3D num) {
+		errno =3D ERANGE;
+		goto fail;
+	}
+	*uid =3D (unsigned) num;
+
+	return 0;
+fail:
+	DBG(UTILS, ul_debug("failed to convert '%.*s' to number [errno=3D%d]", (i=
nt) valsz, value, errno));
+	return -1;
+}
+
+static int parse_mode(const char *value, size_t valsz, mode_t *uid)
+{
+	char buf[sizeof(stringify_value(UINT64_MAX))];
+	int rc;
+	uint64_t num;
+
+	assert(value);
+	assert(uid);
+
+	if (valsz > sizeof(buf) - 1) {
+		rc =3D -ERANGE;
+		goto fail;
+	}
+	mem2strcpy(buf, value, valsz, sizeof(buf));
+
+	rc =3D ul_strtou64(buf, &num, 8);
+	if (rc !=3D 0) {
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
) valsz, value, errno));
+	return -1;
+}
+
+/*
+ * Process X-mount.owner=3D, X-mount.group=3D, X-mount.mode=3D.
+ */
+static int parse_ownership_mode(struct libmnt_context *cxt)
+{
+	int rc;
+
+	const char *o =3D mnt_fs_get_user_options(cxt->fs);
+	if (!o)
+		return 0;
+
+	char *owner;
+	size_t owner_len;
+	if ((rc =3D mnt_optstr_get_option(o, "X-mount.owner", &owner, &owner_len)=
) < 0) {
+		return -MNT_ERR_MOUNTOPT;}
+	if (!rc) {
+		if (!owner_len)
+			return errno =3D EINVAL, -MNT_ERR_MOUNTOPT;
+
+		char *owner_tofree =3D NULL;
+		rc =3D mnt_get_uid(owner[owner_len] ? (owner_tofree =3D strndup(owner, o=
wner_len)) : owner, &cxt->tgt_owner);
+		free(owner_tofree);
+		if (cxt->tgt_owner =3D=3D (uid_t) -1 && isdigit(*owner))
+			rc =3D parse_ugid(owner, owner_len, &cxt->tgt_owner);
+		if (rc)
+			return -MNT_ERR_MOUNTOPT;
+	}
+
+	char *group;
+	size_t group_len;
+	if ((rc =3D mnt_optstr_get_option(o, "X-mount.group", &group, &group_len)=
) < 0)
+		return -MNT_ERR_MOUNTOPT;
+	if (!rc) {
+		if (!group_len)
+			return errno =3D EINVAL, -MNT_ERR_MOUNTOPT;
+
+		char *group_tofree =3D NULL;
+		rc =3D mnt_get_uid(group[group_len] ? (group_tofree =3D strndup(group, g=
roup_len)) : group, &cxt->tgt_group);
+		free(group_tofree);
+		if (cxt->tgt_group =3D=3D (uid_t) -1 && isdigit(*group))
+			rc =3D parse_ugid(group, group_len, &cxt->tgt_group);
+		if (rc)
+			return errno =3D ENOENT, -MNT_ERR_MOUNTOPT;
+	}
+
+	char *mode;
+	size_t mode_len;
+	if ((rc =3D mnt_optstr_get_option(o, "X-mount.mode", &mode, &mode_len)) <=
 0)
+		return -MNT_ERR_MOUNTOPT;
+	if (!rc) {
+		if (!mode_len)
+			return errno =3D EINVAL, -MNT_ERR_MOUNTOPT;
+		if ((rc =3D parse_mode(mode, mode_len, &cxt->tgt_mode)))
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
@@ -1064,6 +1190,8 @@ int mnt_context_prepare_mount(struct libmnt_context *=
cxt)
 		rc =3D mnt_context_guess_fstype(cxt);
 	if (!rc)
 		rc =3D mnt_context_prepare_target(cxt);
+	if (!rc)
+		rc =3D parse_ownership_mode(cxt);
 	if (!rc)
 		rc =3D mnt_context_prepare_helper(cxt, "mount", NULL);
=20
@@ -1089,6 +1217,21 @@ end:
 	return rc;
 }
=20
+static int set_ownership_mode(struct libmnt_context *cxt)
+{
+	const char *target =3D mnt_fs_get_target(cxt->fs);
+
+	if (cxt->tgt_owner !=3D (uid_t) -1 || cxt->tgt_group !=3D (uid_t) -1)
+		if (lchown(target, cxt->tgt_owner, cxt->tgt_group) =3D=3D -1)
+			return -MNT_ERR_CHOWN;
+
+	if (cxt->tgt_mode !=3D (mode_t) -1)
+		if (chmod(target, cxt->tgt_mode) =3D=3D -1)
+			return -MNT_ERR_CHMOD;
+
+	return 0;
+}
+
 /**
  * mnt_context_do_mount
  * @cxt: context
@@ -1191,6 +1334,9 @@ int mnt_context_do_mount(struct libmnt_context *cxt)
 	if (mnt_context_is_veritydev(cxt))
 		mnt_context_deferred_delete_veritydev(cxt);
=20
+	if (!res)
+		res =3D set_ownership_mode(cxt);
+
 	if (!mnt_context_switch_ns(cxt, ns_old))
 		return -MNT_ERR_NAMESPACE;
=20
@@ -1841,7 +1987,18 @@ int mnt_context_get_mount_excode(
 			if (buf)
 				snprintf(buf, bufsz, _("filesystem was mounted, but failed to switch n=
amespace back"));
 			return MNT_EX_SYSERR;
+		}
=20
+		if (rc =3D=3D -MNT_ERR_CHOWN) {
+			if (buf)
+				snprintf(buf, bufsz, _("filesystem was mounted, but failed to change o=
wnership to %u:%u: %m"), cxt->tgt_owner, cxt->tgt_group);
+			return MNT_EX_SYSERR;
+		}
+
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
index 561ddcd8c..c63eb1029 100644
--- a/libmount/src/mountP.h
+++ b/libmount/src/mountP.h
@@ -294,6 +294,10 @@ struct libmnt_context
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
--=20
2.30.2

--7hwtv7vlyuc5ytq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJPL9EACgkQvP0LAY0m
WPFxZA//RvJeIERf5DORIR1xuDNO9d7UHqY8A9n3oYSQ5nfrY7eyyWTbJ4yVGv5G
j2Wp7DVfxf5XpCmFfNPRgVi3TRrzIv6T8TSrDpzIEPNZSGslJuyIRhwv4Ysn1oW0
DVjlYO0nubeZH5DF0kND3+tX2nftI4jd+yX6YHmoEn5zwShIGRhgYM4jV+N5nquf
0xiN12JmDyHGJExtZUxk117eHSPVBvraRciDYz4mmzVJ02r1kX8wAuryzTLJWCyZ
yInCu7pfWmTwiCpoKswf6wrk001THkzj4q2zMRGUa3MGokywITeneDT2WxIXNkFu
NSyKa1Y4Ek6DTMmLxVM3i2Tks0lwnkBUVeSfZ9w3SoEnrxFU8TE5ny5CbR7hua+D
zk4+ZXgxo2HBA5zT3mMCUEEfzomiDoZ0Snr+56/KgrW1/0xXT3/lfbHBFN8lEBwq
uqgQS54n2BndXrJ7fyedSPV9XnCechoroUuQHhZrHnZZyCMsqK1wmlmtck54C0to
8isx5GRUGuwVLhcCaDozICXf2o7a1kaNwC7RSsTH9mQg/vmHMxSxxP5sDAuEE/MY
7OMsni9aOrun2i5bE+mRVBnEUCfccunOD660tZuzAlvkmWp5NEi+5K5bEwxo5gzH
qYWARUI+yG6mPkWuXlyjd3xvALUidGx7jNB1lz9TM94WgU9iTeU=
=yT8B
-----END PGP SIGNATURE-----

--7hwtv7vlyuc5ytq4--
