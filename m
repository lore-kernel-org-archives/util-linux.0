Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6140C433EF
	for <util-linux@archiver.kernel.org>; Wed, 30 Mar 2022 18:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349867AbiC3SPB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349823AbiC3SOs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 30 Mar 2022 14:14:48 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58FBB25EA
        for <util-linux@vger.kernel.org>; Wed, 30 Mar 2022 11:13:02 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 4040494
        for <util-linux@vger.kernel.org>; Wed, 30 Mar 2022 20:13:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1648663981;
        bh=FTMQ0QoNoH+DwYptWiM1E14/v2lTcRHlN4ITMXRW37w=;
        h=Date:From:To:Subject:From;
        b=rMOnlTVDXfQlTasilofptiY8Nkqs61XAMOpnLqG0EQABKB342rkD4ocT7nBA5mo3s
         XgcpDyFAAOscvJ1ykxE2s9as4c5XIujC676kCScIwH1yRd5BeIpaTjg6K5y1Vf3R7Q
         6dXz3oVhSatEIHEg1SWCnN22IqrqEOkni6wUs1ODy4Y7TNkxFWfFaw2CJb0dCdiSeR
         O+VlAynWf3Ag4HebMR/er+0Pjjvppl/1NHi7wh58jKUzdsAWGNpEs0Ls/XJBTHlTee
         TEYbIbNQTBM2PjXyZwnZDSGfEzALKARV/59n5XdBGzgYaG2avjI7i3BmOHBvf5Tu7K
         CSqgDlsVsu/nQ==
Date:   Wed, 30 Mar 2022 20:13:00 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     util-linux@vger.kernel.org
Subject: [RFC] libmount: accept X-mount.{owner,group,mode}=
Message-ID: <20220330181300.mr66k4zghcrf4l6c@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vuxukj6c3vsrvbtq"
Content-Disposition: inline
User-Agent: NeoMutt/20211029-519-ac10a7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--vuxukj6c3vsrvbtq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
As a PoC:
$ truncate -s40G /tmp/ext4; /sbin/mkfs.ext4 /tmp/ext4
# ./mount -o \
    X-mount.owner=3Dnabijaczleweli,X-mount.group=3D1212,X-mount.mode=3D1234=
 \
    /tmp/ext4 /tmp/a\ +\ b/
$ l -d /tmp/a\ +\ b/
d-w--wxr-T 3 nabijaczleweli 1212 4.0K Mar 30 20:03 '/tmp/a + b/'

I've marked this RFC because the failures are, well, not pretty
(for example, given a mis-spelled or unset username):
  mount: /tmp/a + b: filesystem was mounted, but any subsequent
  operation failed: Invalid argument.

But I'm not sure how to proceed. I've stuffed the parsing and chowning
stage into mnt_context_finalize_mount() for ease-of-PoC, but should:
  (a) the post-syscall error handling in mnt_context_get_mount_excode()
      be extended to recognise MNT_ERR_MOUNTOPT?
  (b) the parsing/chowning stages be split (parsing in pre-mount prep,
      chowning in post-mount)? with a new MNT_ERR_ flag potentially?
  (c) something else?

Best,
=D0=BD=D0=B0=D0=B1

Please keep me in CC, as I'm not subscribed.

 libmount/src/context_mount.c | 136 +++++++++++++++++++++++++++++++++++
 sys-utils/mount.8.adoc       |   6 ++
 2 files changed, 142 insertions(+)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 1fc3ff2cc..290f55ea7 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -1229,6 +1229,138 @@ static int is_source_already_rdonly(struct libmnt_c=
ontext *cxt)
 	return opts && mnt_optstr_get_option(opts, "ro", NULL, NULL) =3D=3D 0;
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
+	if (rc !=3D 0)
+		goto fail;
+	if (num > ULONG_MAX || (unsigned) num !=3D num) {
+		rc =3D -ERANGE;
+		goto fail;
+	}
+	*uid =3D (unsigned) num;
+
+	return 0;
+fail:
+	DBG(UTILS, ul_debug("failed to convert '%.*s' to number [rc=3D%d]", (int)=
 valsz, value, rc));
+	return rc;
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
+	if (rc !=3D 0)
+		goto fail;
+	if (num > 07777) {
+		rc =3D -ERANGE;
+		goto fail;
+	}
+	*uid =3D (mode_t) num;
+
+	return 0;
+fail:
+	DBG(UTILS, ul_debug("failed to convert '%.*s' to mode [rc=3D%d]", (int) v=
alsz, value, rc));
+	return rc;
+}
+
+/*
+ * Process X-mount.owner=3D, X-mount.group=3D, X-mount.mode=3D.
+ */
+static int set_ownership_mode(struct libmnt_context *cxt)
+{
+	int rc;
+
+	uid_t new_owner =3D (uid_t) -1;
+	uid_t new_group =3D (uid_t) -1;
+	mode_t new_mode =3D (mode_t) -1;
+
+	const char *o =3D mnt_fs_get_user_options(cxt->fs);
+
+	char *owner;
+	size_t owner_len;
+	if ((rc =3D mnt_optstr_get_option(o, "X-mount.owner", &owner, &owner_len)=
) < 0)
+		return rc;
+	if (!rc) {
+		if (!owner_len)
+			return -EINVAL;
+
+		char *owner_tofree =3D NULL;
+		rc =3D mnt_get_uid(owner[owner_len] ? (owner_tofree =3D strndup(owner, o=
wner_len)) : owner, &new_owner);
+		free(owner_tofree);
+		if (new_owner =3D=3D (uid_t) -1 && isdigit(*owner))
+			rc =3D parse_ugid(owner, owner_len, &new_owner);
+		if (rc)
+			return rc;
+	}
+
+	char *group;
+	size_t group_len;
+	if ((rc =3D mnt_optstr_get_option(o, "X-mount.group", &group, &group_len)=
) < 0)
+		return rc;
+	if (!rc) {
+		if (!group_len)
+			return -EINVAL;
+
+		char *group_tofree =3D NULL;
+		rc =3D mnt_get_uid(group[group_len] ? (group_tofree =3D strndup(group, g=
roup_len)) : group, &new_group);
+		free(group_tofree);
+		if (new_group =3D=3D (uid_t) -1 && isdigit(*group))
+			rc =3D parse_ugid(group, group_len, &new_group);
+		if (rc)
+			return rc;
+	}
+
+	char *mode;
+	size_t mode_len;
+	if ((rc =3D mnt_optstr_get_option(o, "X-mount.mode", &mode, &mode_len)) <=
 0)
+		return rc;
+	if (!rc) {
+		if (!group_len)
+			return -EINVAL;
+		if ((rc =3D parse_mode(mode, mode_len, &new_mode)))
+			return rc;
+	}
+
+	const char *target =3D mnt_fs_get_target(cxt->fs);
+
+	if (new_owner !=3D (uid_t) -1 || new_group !=3D (uid_t) -1)
+		if (lchown(target, new_owner, new_group) =3D=3D -1)
+			return -errno;
+
+	if (new_mode !=3D (mode_t) -1)
+		if (chmod(target, new_mode) =3D=3D -1)
+			return -errno;
+
+	return 0;
+}
+
 /**
  * mnt_context_finalize_mount:
  * @cxt: context
@@ -1250,6 +1382,8 @@ int mnt_context_finalize_mount(struct libmnt_context =
*cxt)
 	rc =3D mnt_context_prepare_update(cxt);
 	if (!rc)
 		rc =3D mnt_context_update_tabs(cxt);
+	if (!rc)
+		rc =3D set_ownership_mode(cxt);
 	return rc;
 }
=20
@@ -1328,6 +1462,8 @@ again:
 		rc =3D mnt_context_do_mount(cxt);
 	if (!rc)
 		rc =3D mnt_context_update_tabs(cxt);
+	if (!rc)
+		rc =3D set_ownership_mode(cxt);
=20
 	/*
 	 * Read-only device or already read-only mounted FS.
diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 343d7e297..53a0bbb34 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -633,6 +633,12 @@ Allow to make a target directory (mountpoint) if it do=
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
+Set _mountpoint_'s ownership after mounting.
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

--vuxukj6c3vsrvbtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJEnasACgkQvP0LAY0m
WPEotw/+OMlpXSvIjxmA2MakXwPfuUn37am8iP9Ek4670LeGR7YKpTzanIVhkf+B
+SFRb5SYzDtXsNaaMEaxU3JzfEMDbZHqy9ZakPasGC9nnKZjcaigAQLIXNtYWimO
emP34eGzEN9rhfXLUf9YCXtNEXVAIkADXOEtru0hkUDbtEiabsSlyJv8+JLp1OWZ
nkDDDYOnBfAoN08k3jsac+Y/xmKqwJdx7TY0/9hK1fY8KAv9QXO53ZOi7VHOdBBN
x2WuN8K8/6LdLXmiVrPxqQ7yljptb9QvdwlGBnTGfpi+kTiDD/OieOmBhpyUwuBi
S7LrDBNatcJU0bh3kXOz13T6YS6wTUaaGJkbF0HiU0F6t3kYl2YlaX1Jxa/HEVvR
tf/Xs13yIlg4+qIewRziX7dkhDqrGZpkBErXWb+q2Lp9BUtul7xpDPFdDl4pgNvr
UhYG7Wwe44BgOcahh4Ms4YlQFRj3SPgHvqt8jsxtTpSZfSXp0BPeldGqDdnHK9y+
dFDWYf3H3yJwPqbFtfeVfpbgp2Ks2Bg19oyDbP3BW2fgHNCjNMu+5/PRQGhmecXi
BBSAmXTqF1DeicJa3PV7eb7isMWsn5qB875UlL+JbzcuKTnpNM/sEG7KLme4vy6K
o3j+YqoNEgrfJvYkj2UKDVjgXCJG7I755B3zxrT58r9zooVol9Y=
=LZh6
-----END PGP SIGNATURE-----

--vuxukj6c3vsrvbtq--
