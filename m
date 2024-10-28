Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA71DF266
	for <util-linux@vger.kernel.org>; Mon, 28 Oct 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139599; cv=none; b=uL2DQzzpGxvQz/BNsHcQm15dycvkUKOce+Cll38jGRWX5SgCCizqD3pJy9bpuJqCS9GSAIGwDN8A/Dt/mMPRtnygbW7j4Yy2kn5FBYU1gPOBzX2pBAO+Svs6ubdULJWuxWO8I0QWjphGJclgsCQ9GYD6LzSnSjY6QE8zBRMqErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139599; c=relaxed/simple;
	bh=Q9qliWjsScOxuU4s+s2t4di7KnmApFG8W51zg6v2kG0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDM0NlsOrz9reIGeY2iPjAUwUmzQhNB/37Kaz185Zl8jKSnH1ck1cCHPxIDujbPQcIypGICzTWJGD0IGOjeX+Cm/PbfHBz5hpdRK3JFz8NLsoF09CBTpVS398OFMXCu4VwlrZI+eqdCHNMFnroj9fwzJrKa6ezK1KTWjlCBfBN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=DhitLgj0; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="DhitLgj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1730139593;
	bh=Q9qliWjsScOxuU4s+s2t4di7KnmApFG8W51zg6v2kG0=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=DhitLgj0f5r/4JHrI2T5csqkggAiXEe6lOyTxDQOkbgjp3dOw+UAQ0NMkb0ITCUJC
	 Qt2Lhp57jIJsgb3Czab9clmV9WZnYSlkmt8mHxdwTG9QeCIhOBNCHjy1uhyTj/IeKE
	 wpSvAf54CZSIHKJ5RDjosRNxwnAk6DKII6ALUYkzC3esWSlCT/piJXMSErb9AQoYRl
	 CJBjyMcAvwHEIVJ+FUwPtu9CW6H9blEQytqhuuWdDK+M+b0q8gcQaSAO7VYizUdk8P
	 RtDy6f4RTCtR6QyeeCGOX0p0LDwboiyBSycMMr/CxiTDFJJKmErem0b/mN1L70Mili
	 A1RexDLslTvMQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DB74C5C80
	for <util-linux@vger.kernel.org>; Mon, 28 Oct 2024 19:19:53 +0100 (CET)
Date: Mon, 28 Oct 2024 19:19:53 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] hardlink: re-raise SIGINT instead of exiting
Message-ID: <2f2733fcf94bf9f1b132904303947b8c5e6f2c3c.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
References: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z77du6b5hlduim5u"
Content-Disposition: inline
In-Reply-To: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--z77du6b5hlduim5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Every TRUE return was either exit(1) or "return error;" anyway,
this is more correct (exit-status-wise) and doesn't hang pipelines weirdly

This also removes a seemingly-extraneous newline written to the standard
output stream in the interrupt handler itself?
---
 misc-utils/hardlink.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index 8c5f24aad..e996f53b5 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -428,23 +428,20 @@ static void print_stats(void)
=20
 /**
  * handle_interrupt - Handle a signal
- *
- * Returns: %TRUE on SIGINT, SIGTERM; %FALSE on all other signals.
  */
-static int handle_interrupt(void)
+static void handle_interrupt(void)
 {
 	switch (last_signal) {
-	case SIGINT:
-	case SIGTERM:
-		return TRUE;
 	case SIGUSR1:
 		print_stats();
 		putchar('\n');
 		break;
+	default:
+		signal(last_signal, SIG_DFL);
+		raise(last_signal);
+		break;
 	}
-
 	last_signal =3D 0;
-	return FALSE;
 }
=20
 #ifdef USE_XATTR
@@ -589,8 +586,7 @@ static int file_xattrs_equal(const struct file *a, cons=
t struct file *b)
 	// We now have two sorted tables of xattr names.
=20
 	for (i =3D 0; i < n_a; i++) {
-		if (handle_interrupt())
-			goto exit;	// user wants to quit
+		handle_interrupt();
=20
 		if (strcmp(name_ptrs_a[i], name_ptrs_b[i]) !=3D 0)
 			goto exit;	// names at same slot differ
@@ -845,8 +841,7 @@ static int inserter(const char *fpath, const struct sta=
t *sb,
 	int included;
 	int excluded;
=20
-	if (handle_interrupt())
-		return 1;
+	handle_interrupt();
 	if (typeflag =3D=3D FTW_DNR || typeflag =3D=3D FTW_NS)
 		warn(_("cannot read %s"), fpath);
 	if (typeflag !=3D FTW_F || !S_ISREG(sb->st_mode))
@@ -1072,8 +1067,7 @@ static void visitor(const void *nodep, const VISIT wh=
ich, const int depth)
 		size_t nnodes, memsiz;
 		int may_reflink =3D 0;
=20
-		if (handle_interrupt())
-			exit(EXIT_FAILURE);
+		handle_interrupt();
 		if (master->links =3D=3D NULL)
 			continue;
=20
@@ -1098,8 +1092,7 @@ static void visitor(const void *nodep, const VISIT wh=
ich, const int depth)
 		for (other =3D master->next; other !=3D NULL; other =3D other->next) {
 			int eq;
=20
-			if (handle_interrupt())
-				exit(EXIT_FAILURE);
+			handle_interrupt();
=20
 			assert(other !=3D other->next);
 			assert(other->st.st_size =3D=3D master->st.st_size);
@@ -1413,12 +1406,7 @@ static void to_be_called_atexit(void)
 */
 static void sighandler(int i)
 {
-	UL_PROTECT_ERRNO;
-	if (last_signal !=3D SIGINT)
-		last_signal =3D i;
-	if (i =3D=3D SIGINT)
-		/* can't use stdio on signal handler */
-		ignore_result(write(STDOUT_FILENO, "\n", sizeof("\n")-1));
+	last_signal =3D i;
 }
=20
 int main(int argc, char *argv[])
@@ -1430,7 +1418,6 @@ int main(int argc, char *argv[])
 	sa.sa_flags =3D SA_RESTART;
 	sigfillset(&sa.sa_mask);
=20
-	/* If we receive a SIGINT, end the processing */
 	sigaction(SIGINT, &sa, NULL);
 	sigaction(SIGUSR1, &sa, NULL);
=20
--=20
2.39.2

--z77du6b5hlduim5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmcf1ckACgkQvP0LAY0m
WPE1ChAAhNnZLhk3Qhf9NS5VCqjEP/ucbBs5YjtjNEsDhiPfceRZGR386rQ4K/Uk
aNOZ1D6yVA5UlEE4lDdYJu9eAXnfyqgjl6dihIrMTSmkcAtchJINtOfjCIpJLEis
UcXO4lCLhjFmKFrJIJOlikc1WhdK0nuJzwQ5L50VdogFaBrgMzY9D0p5RZ+bHZms
rGxWsnTfcsl59ARE1osZcU16TqkHHKIp8M1DgFGNE289haG5SGt9aozYGx2LayZX
pAe+akonVgCrxwR3KRqEEP1Lqd7ZVImk5BuvZqkMrTjKgNOPxDGsJHdbLlGVmn7L
56rGnxMdoqcNHD9vZarwcDdkwGpBTq3cpczCkIdsEHEYpIMsldSXct2kGrsxtl5b
9I8q2cTjmmJAcSMfr3wrxTZrd2gV+mSm330kcU7ZhHjA+Oq9MJHvLy+mMM9KvOzA
cZI/a5HomvXR01OTjMtmXf+5LW66i/6fS+3vsBtNVB79iMSD0UjLQ2jCN30R2TFo
pOp7E1TR0BqEG8f483yxFbYPE0TahfnjD0q+QxDMtcIlJDCIW5wKV6i3U/A5sIB6
0YbNiqDCpF9qtUd39dVxKKr0zyW4PiTd8ciGiIOda3YeXnigX2WaYY1axJXV6BGu
t55ZH1bGtPnUGeFbAajlK/ro2X3Nls2ZuTBWoFtW7lwi4nK58bA=
=XHLs
-----END PGP SIGNATURE-----

--z77du6b5hlduim5u--
