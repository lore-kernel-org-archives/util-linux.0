Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA06AAD
	for <util-linux@vger.kernel.org>; Sat,  1 Jun 2024 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717234319; cv=none; b=HyWZSnpwPoFw3wOUABwP8ZzWBATU+vSF73uc9zRZ6v5WEFpD3q2pNX6XojdM1njNlNQbvNPZ6yCGrOm8fJQVFLsSHPWftF2kdqhaNMX+2Cocl3uKyYni0U0uynR4bf9rjfLDYAkVTfwfQjUeKSG7ydxnJy7XK9ntZpoffHcUbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717234319; c=relaxed/simple;
	bh=Q371yQvbA/BFaJnM/BmTPYtOcl7xjCFsq85I+40n5iA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H1cCCm7dxB1itrfKGA7w2iG+xsqf0cfjgs146kumBRnXSb0MIj9UocgWD09+VFizANoRBLnXVYjSm8Pkfbk+DqqdP6FL78m+7l5HNaQfG5HUQY/M3Ozbs8U9b1OKPJBaCGtk3XWzRFeRrN+Nq2H0MyuLal3uuG9fcfeVnjee3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYohdVfd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYohdVfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5A3C116B1;
	Sat,  1 Jun 2024 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717234318;
	bh=Q371yQvbA/BFaJnM/BmTPYtOcl7xjCFsq85I+40n5iA=;
	h=Date:From:To:Cc:Subject:From;
	b=YYohdVfdzW1hME5pnGpFvL64BcQN/HLOEkkDOBuyxLDBMoEkQpWY1YdvagxIENWj5
	 rvnwkVjjdpAIXv+4h38kzVd+SddgPlSbK2lOr1lEbT/RPx/ovv/B5nXyYrYRQVhfRZ
	 sa4EEBKdiOu5AgTKDzm4XjaBDWLtWhealYj+azVpNnPfMniRNVl/xzvUcFg1ZkNXU6
	 opguzTjAEFZbP2qkIlr/p5tZQ7ttmBLMjpQJcSrifQttU4aE81dMtRbXspzE+wAoaY
	 6m2deC/kIbPjKE72wjlmhN4pzH7rNruw6H5eyt4ihwJ4Yo0EFHMLVIxzTermLQeCR2
	 06Mx3nKTQPA3w==
Date: Sat, 1 Jun 2024 11:31:56 +0200
From: Alejandro Colomar <alx@kernel.org>
To: util-linux@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v1] Call prctl(2) with long integers, specify 5 arguments,
 and avoid casts
Message-ID: <20240601093150.16912-1-alx@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eooqkftngwsiyx6a"
Content-Disposition: inline


--eooqkftngwsiyx6a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: util-linux@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v1] Call prctl(2) with long integers, specify 5 arguments,
 and avoid casts
MIME-Version: 1.0

Since libc's prctl(2) wrapper is a variadic function, arguments must
have the right width.  Otherwise, the behavior is undefined.

Also, the 5 arguments must be specified always, or the behavior is also
undefined.  libc reads 5 values and passes them all to the kernel, so if
one is uninitialized, the kernel will receive garbagge, which could
result in EINVAL (most likely), or worse, a different action.

Also, avoid some casts to unsigned long, by changing the type of the
parameter to some local wrappers.

And use consistently 0L.  0UL is basically the same, and uses one more
character.  Keep it short.

Link: <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?=
id=3D6698b096a6f5342cb9b338c237ed875a8635497a>
Link: <https://lore.kernel.org/linux-man/ddbdyaiptesjalgfmztxideej67e3yaob7=
ucsmbf6qvriwxiif@dohhxrqgwhrf/T/#med306b5b003f9cc7cc2de69fcdd7ee2d056d0954>
Cc: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
Range-diff against v0:
-:  --------- > 1:  afd73139e Call prctl(2) with long integers, specify 5 a=
rguments, and avoid casts

 include/seccomp.h            |  2 +-
 lib/caputils.c               |  4 ++--
 lib/env.c                    |  4 ++--
 misc-utils/enosys.c          |  4 ++--
 schedutils/coresched.c       |  6 +++---
 sys-utils/setpriv-landlock.c |  2 +-
 sys-utils/setpriv.c          | 34 ++++++++++++++++------------------
 tests/helpers/test_mkfds.c   |  2 +-
 8 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/include/seccomp.h b/include/seccomp.h
index 2b211439e..8c65b5e8c 100644
--- a/include/seccomp.h
+++ b/include/seccomp.h
@@ -18,7 +18,7 @@ static int ul_set_seccomp_filter_spec_allow(const struct =
sock_fprog *prog)
 		return 0;
 #endif
=20
-	return prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, prog);
+	return prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, prog, 0L, 0L);
 }
=20
 #endif /* UL_SECCOMP_H */
diff --git a/lib/caputils.c b/lib/caputils.c
index 23866c071..fd7037ff9 100644
--- a/lib/caputils.c
+++ b/lib/caputils.c
@@ -29,7 +29,7 @@
 static int test_cap(unsigned int cap)
 {
 	/* prctl returns 0 or 1 for valid caps, -1 otherwise */
-	return prctl(PR_CAPBSET_READ, cap, 0, 0, 0) >=3D 0;
+	return prctl(PR_CAPBSET_READ, cap, 0L, 0L, 0L) >=3D 0;
 }
=20
 static int cap_last_by_bsearch(int *ret)
@@ -120,7 +120,7 @@ void cap_permitted_to_ambient(void)
 			continue;
=20
 		if ((effective & (1ULL << cap))
-		    && prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, cap, 0, 0) < 0)
+		    && prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, cap, 0L, 0L) < 0)
 			err(EXIT_FAILURE, _("prctl(PR_CAP_AMBIENT) failed"));
 	}
 }
diff --git a/lib/env.c b/lib/env.c
index 2bdfe5697..5d9ab2456 100644
--- a/lib/env.c
+++ b/lib/env.c
@@ -191,11 +191,11 @@ char *safe_getenv(const char *arg)
 	if ((getuid() !=3D geteuid()) || (getgid() !=3D getegid()))
 		return NULL;
 #ifdef HAVE_PRCTL
-	if (prctl(PR_GET_DUMPABLE, 0, 0, 0, 0) =3D=3D 0)
+	if (prctl(PR_GET_DUMPABLE, 0L, 0L, 0L, 0L) =3D=3D 0)
 		return NULL;
 #else
 #if (defined(linux) && defined(SYS_prctl))
-	if (syscall(SYS_prctl, PR_GET_DUMPABLE, 0, 0, 0, 0) =3D=3D 0)
+	if (syscall(SYS_prctl, PR_GET_DUMPABLE, 0L, 0L, 0L, 0L) =3D=3D 0)
 		return NULL;
 #endif
 #endif
diff --git a/misc-utils/enosys.c b/misc-utils/enosys.c
index 1410676dd..acf4428b6 100644
--- a/misc-utils/enosys.c
+++ b/misc-utils/enosys.c
@@ -290,10 +290,10 @@ int main(int argc, char **argv)
 	/* *SET* below will return EINVAL when either the filter is invalid or
 	 * seccomp is not supported. To distinguish those cases do a *GET* here
 	 */
-	if (prctl(PR_GET_SECCOMP) =3D=3D -1 && errno =3D=3D EINVAL)
+	if (prctl(PR_GET_SECCOMP, 0L, 0L, 0L, 0L) =3D=3D -1 && errno =3D=3D EINVA=
L)
 		err(EXIT_NOTSUPP, _("Seccomp non-functional"));
=20
-	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, 0L, 0L))
 		err_nosys(EXIT_FAILURE, _("Could not run prctl(PR_SET_NO_NEW_PRIVS)"));
=20
 	if (ul_set_seccomp_filter_spec_allow(&prog))
diff --git a/schedutils/coresched.c b/schedutils/coresched.c
index 9d8be3e12..7844f98be 100644
--- a/schedutils/coresched.c
+++ b/schedutils/coresched.c
@@ -129,20 +129,20 @@ static sched_core_cookie core_sched_get_cookie(pid_t =
pid)
=20
 static void core_sched_create_cookie(pid_t pid, sched_core_scope type)
 {
-	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, type, 0))
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, type, 0L))
 		err(EXIT_FAILURE, _("Failed to create cookie for PID %d"), pid);
 }
=20
 static void core_sched_pull_cookie(pid_t from)
 {
 	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, from,
-		  PR_SCHED_CORE_SCOPE_THREAD, 0))
+		  PR_SCHED_CORE_SCOPE_THREAD, 0L))
 		err(EXIT_FAILURE, _("Failed to pull cookie from PID %d"), from);
 }
=20
 static void core_sched_push_cookie(pid_t to, sched_core_scope type)
 {
-	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0))
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0L))
 		err(EXIT_FAILURE, _("Failed to push cookie to PID %d"), to);
 }
=20
diff --git a/sys-utils/setpriv-landlock.c b/sys-utils/setpriv-landlock.c
index 00ad38c61..18c698325 100644
--- a/sys-utils/setpriv-landlock.c
+++ b/sys-utils/setpriv-landlock.c
@@ -187,7 +187,7 @@ void do_landlock(const struct setpriv_landlock_opts *op=
ts)
 			err(SETPRIV_EXIT_PRIVERR, _("adding landlock rule failed"));
 	}
=20
-	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) =3D=3D -1)
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, 0L, 0L) =3D=3D -1)
 		err(SETPRIV_EXIT_PRIVERR, _("disallow granting new privileges for landlo=
ck failed"));
=20
 	if (landlock_restrict_self(fd, 0) =3D=3D -1)
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 4b0543101..0db09bf74 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -165,7 +165,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	exit(EXIT_SUCCESS);
 }
=20
-static int has_cap(enum cap_type which, unsigned int i)
+static int has_cap(enum cap_type which, unsigned long i)
 {
 	switch (which) {
 	case CAP_TYPE_EFFECTIVE:
@@ -174,8 +174,7 @@ static int has_cap(enum cap_type which, unsigned int i)
 	case CAP_TYPE_PERMITTED:
 		return capng_have_capability((capng_type_t)which, i);
 	case CAP_TYPE_AMBIENT:
-		return prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_IS_SET,
-				(unsigned long) i, 0UL, 0UL);
+		return prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_IS_SET, i, 0L, 0L);
 	default:
 		warnx(_("invalid capability type"));
 		return -1;
@@ -223,7 +222,7 @@ static void dump_one_secbit(int *first, int *bits, int =
bit, const char *name)
 static void dump_securebits(void)
 {
 	int first =3D 1;
-	int bits =3D prctl(PR_GET_SECUREBITS, 0, 0, 0, 0);
+	int bits =3D prctl(PR_GET_SECUREBITS, 0L, 0L, 0L, 0L);
=20
 	if (bits < 0) {
 		warnx(_("getting process secure bits failed"));
@@ -323,7 +322,7 @@ static void dump_pdeathsig(void)
 {
 	int pdeathsig;
=20
-	if (prctl(PR_GET_PDEATHSIG, &pdeathsig) !=3D 0) {
+	if (prctl(PR_GET_PDEATHSIG, &pdeathsig, 0L, 0L, 0L) !=3D 0) {
 		warn(_("get pdeathsig failed"));
 		return;
 	}
@@ -363,7 +362,7 @@ static void dump(int dumplevel)
=20
 	dump_groups();
=20
-	x =3D prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+	x =3D prctl(PR_GET_NO_NEW_PRIVS, 0L, 0L, 0L, 0L);
 	if (0 <=3D x)
 		printf("no_new_privs: %d\n", x);
 	else
@@ -449,7 +448,7 @@ static void parse_groups(struct privctx *opts, const ch=
ar *str)
 static void parse_pdeathsig(struct privctx *opts, const char *str)
 {
 	if (!strcmp(str, "keep")) {
-		if (prctl(PR_GET_PDEATHSIG, &opts->pdeathsig) !=3D 0)
+		if (prctl(PR_GET_PDEATHSIG, &opts->pdeathsig, 0L, 0L, 0L) !=3D 0)
 			errx(SETPRIV_EXIT_PRIVERR,
 				 _("failed to get parent death signal"));
 	} else if (!strcmp(str, "clear")) {
@@ -495,8 +494,7 @@ static void bump_cap(unsigned int cap)
 		capng_update(CAPNG_ADD, CAPNG_EFFECTIVE, cap);
 }
=20
-static int cap_update(capng_act_t action,
-		enum cap_type type, unsigned int cap)
+static int cap_update(capng_act_t action, enum cap_type type, unsigned lon=
g cap)
 {
 	switch (type) {
 		case CAP_TYPE_EFFECTIVE:
@@ -510,10 +508,10 @@ static int cap_update(capng_act_t action,
=20
 			if (action =3D=3D CAPNG_ADD)
 				ret =3D prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE,
-						(unsigned long) cap, 0UL, 0UL);
+						cap, 0L, 0L);
 			else
 				ret =3D prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_LOWER,
-						(unsigned long) cap, 0UL, 0UL);
+						cap, 0L, 0L);
=20
 			return ret;
 		}
@@ -565,7 +563,7 @@ static void parse_securebits(struct privctx *opts, cons=
t char *arg)
 	char *c;
=20
 	opts->have_securebits =3D 1;
-	opts->securebits =3D prctl(PR_GET_SECUREBITS, 0, 0, 0, 0);
+	opts->securebits =3D prctl(PR_GET_SECUREBITS, 0L, 0L, 0L, 0L);
 	if (opts->securebits < 0)
 		err(SETPRIV_EXIT_PRIVERR, _("getting process secure bits failed"));
=20
@@ -687,10 +685,10 @@ static void do_seccomp_filter(const char *file)
 	/* *SET* below will return EINVAL when either the filter is invalid or
 	 * seccomp is not supported. To distinguish those cases do a *GET* here
 	 */
-	if (prctl(PR_GET_SECCOMP) =3D=3D -1 && errno =3D=3D EINVAL)
+	if (prctl(PR_GET_SECCOMP, 0L, 0L, 0L, 0L) =3D=3D -1 && errno =3D=3D EINVA=
L)
 		err(SETPRIV_EXIT_PRIVERR, _("Seccomp non-functional"));
=20
-	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, 0L, 0L))
 		err(SETPRIV_EXIT_PRIVERR, _("Could not run prctl(PR_SET_NO_NEW_PRIVS)"));
=20
 	if (ul_set_seccomp_filter_spec_allow(&prog))
@@ -1059,7 +1057,7 @@ int main(int argc, char **argv)
 		do_reset_environ(pw);
 	}
=20
-	if (opts.nnp && prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) =3D=3D -1)
+	if (opts.nnp && prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, 0L, 0L) =3D=3D -1)
 		err(EXIT_FAILURE, _("disallow granting new privileges failed"));
=20
 	if (opts.selinux_label)
@@ -1069,7 +1067,7 @@ int main(int argc, char **argv)
 	if (opts.seccomp_filter)
 		do_seccomp_filter(opts.seccomp_filter);
=20
-	if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0) =3D=3D -1)
+	if (prctl(PR_SET_KEEPCAPS, 1L, 0L, 0L, 0L) =3D=3D -1)
 		err(EXIT_FAILURE, _("keep process capabilities failed"));
=20
 	/* We're going to want CAP_SETPCAP, CAP_SETUID, and CAP_SETGID if
@@ -1102,7 +1100,7 @@ int main(int argc, char **argv)
 			err(SETPRIV_EXIT_PRIVERR, _("setgroups failed"));
 	}
=20
-	if (opts.have_securebits && prctl(PR_SET_SECUREBITS, opts.securebits, 0, =
0, 0) !=3D 0)
+	if (opts.have_securebits && prctl(PR_SET_SECUREBITS, opts.securebits, 0L,=
 0L, 0L) !=3D 0)
 		err(SETPRIV_EXIT_PRIVERR, _("set process securebits failed"));
=20
 	if (opts.bounding_set) {
@@ -1123,7 +1121,7 @@ int main(int argc, char **argv)
 	}
=20
 	/* Clear or set parent death signal */
-	if (opts.pdeathsig && prctl(PR_SET_PDEATHSIG, opts.pdeathsig < 0 ? 0 : op=
ts.pdeathsig) !=3D 0)
+	if (opts.pdeathsig && prctl(PR_SET_PDEATHSIG, opts.pdeathsig < 0 ? 0L : o=
pts.pdeathsig, 0L, 0L, 0L) !=3D 0)
 		err(SETPRIV_EXIT_PRIVERR, _("set parent death signal failed"));
=20
 	do_landlock(&opts.landlock);
diff --git a/tests/helpers/test_mkfds.c b/tests/helpers/test_mkfds.c
index 60ebdd676..cfaa1f2ac 100644
--- a/tests/helpers/test_mkfds.c
+++ b/tests/helpers/test_mkfds.c
@@ -4372,7 +4372,7 @@ static void list_parameters(const char *factory_name)
=20
 static void rename_self(const char *comm)
 {
-	if (prctl(PR_SET_NAME, (unsigned long)comm, 0, 0, 0) < 0)
+	if (prctl(PR_SET_NAME, (unsigned long)comm, 0L, 0L, 0L) < 0)
 		err(EXIT_FAILURE, "failed to rename self via prctl: %s", comm);
 }
=20
--=20
2.45.1


--eooqkftngwsiyx6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZa6osACgkQnowa+77/
2zJQmA/+JffOEeNtaBronYfeda+mDkGoZqXpeaJ1UM8AKzEBceTZDXSxAMnprcpF
0tbAVOabZypBEOE5mVlwO4Jtg+pTe1M3HrE+HMWF6imbeQ8dBzQiVfgKzLv0d/mP
r6JD63AzwjY049FGOnm3sfhEw28qt9MvnJIjxsIkERU1LNV9av3ujAvzpci+wjRZ
BP4o95EcTUs726mAuR0FbUt7h7zXJLmWXXYREAt2125uWIXtqli0m9Y+LbL8V0iY
6kYM+fPsxkgmZoWE1CzE4VuZEEwr5is/h0+bcozHjPTKuUDsBZaStdLx+/mFeMrI
mYev675hCE1UjPLe8+9IPZDy3TUS3gBbc4aGhtJyHwGDA00n0wp7Fy7f6xoGbVHH
upR2vV4mhGWcY3rCvrG5dVkfBbOVaNKcvoHurZk06XmsxUFq1nXGrRggwu+xNsRr
TJN7vuQtYGfKIPTgfZ1BOSEpkSuArLTjGKF2ce6O+ohzhFk6Lqf2DZqZ+XkAV5bD
5qWHAHhf+LB4+6Gk/GgTSRFs1rlIVGFzKqx+7z/K7zJmFG1BoWZu6xg5HLjIJZAG
eokecsgkfGJ+z2rxVPnJgWRpdhJSOrWhso6xDGWyPTMYf804lXR9BXcfSCpBrR27
Z4ZGvh4l96FzI8bWb9bor2MW+M5CeAe1fLJivvatnw4yfDD4CIU=
=Eitd
-----END PGP SIGNATURE-----

--eooqkftngwsiyx6a--
