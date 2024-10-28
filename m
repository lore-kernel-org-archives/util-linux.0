Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E631DF97F
	for <util-linux@vger.kernel.org>; Mon, 28 Oct 2024 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139579; cv=none; b=Bcr4o94ySqUEwk8I2faaGDEg8REnUe3ybQuCfZQnkZNaFHIpE0kM2VAHDVO8Chgke4BaL4pO/ZWK93uI4q/TmdCLP8gOkBBP/wRk1bPE12REeanxxlkEgwDuS+bezaLAnTTCe0r36PibmcW8YN48r9OEoG0UI5JP3Zvu+BWfhQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139579; c=relaxed/simple;
	bh=Xqvw6bwrq4NhTWYvfNCGWvONUdCXNS/IUpUho7Se09k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXCMn2foEpGAlYMOefu5i6dSGY/vUUVGCsRdmGu1LIKkHp1K/4xd203jeb0XQl0Z8p9KkLiQ0bIhsMjq3UE/VC06cJDPxkiKgfZkGuj0P3J1nxhiL0CAPI5zmQj7s++kcSglDPQqnAnOfEClmeNHyg9NpuMd4J6DGJ70I9mV1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=GmMZLInN; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="GmMZLInN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1730139571;
	bh=Xqvw6bwrq4NhTWYvfNCGWvONUdCXNS/IUpUho7Se09k=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=GmMZLInNlpf9XWlH+KX2vox2GILDY/vHhY+zSt02R6a4nbYahBszestrjcYUTGuJ8
	 MPoxo1hHpkqH4dHI962zsXK8BX7s/9gdy459jctWUkQVy39XYKT+xaD+f1MmqRnxNW
	 7PVXmw1WOfxKo3vHqDJSWrQpErgVA8MibrVaV2hQB/l34LrhUB1zPhlTZ8EwZOKU25
	 Fm66USGPt4YtJXXcJOxvPeZdbd54LLcYNbZ7dML3nhhzh7tlPufOzIwkbhzMC9r22u
	 P/6mV/DlUxkkNTljxSVem8IozBSdhqq+NWOoBwDg0b5t285WqToE7Qm9TXTNTK1tma
	 BxtNhXhVBS3mw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 00E9E567C
	for <util-linux@vger.kernel.org>; Mon, 28 Oct 2024 19:19:31 +0100 (CET)
Date: Mon, 28 Oct 2024 19:19:30 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] hardlink: add --list-duplicates and --zero
Message-ID: <b22071e3546940d6d0fa6e1d9d03f292e18229e2.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
References: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sac2mshpbvduakkv"
Content-Disposition: inline
In-Reply-To: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--sac2mshpbvduakkv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

--list-duplicates codifies what everyone keeps re-implementing with
find -exec b2sum or src:perforate's finddup or whatever.

hardlink already knows this, so make the data available thusly,
in a format well-suited for pipeline processing
(fixed-width key for uniq/cut/&c.,
 tab delimiter for cut &a.,
 -z for correct filename handling).
---
 misc-utils/hardlink.1.adoc |  6 ++++++
 misc-utils/hardlink.c      | 21 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/misc-utils/hardlink.1.adoc b/misc-utils/hardlink.1.adoc
index b6f07ba70..b85ba09d4 100644
--- a/misc-utils/hardlink.1.adoc
+++ b/misc-utils/hardlink.1.adoc
@@ -76,6 +76,12 @@
 *-n*, *--dry-run*::
 Do not act, just print what would happen.
=20
+*-l*, *--list-duplicates*::
+Don't link anything, but list the absolute path of every duplicate file, o=
ne per line, preceded by a unique 16-byte discriminator and a tab.
+
+*-z*, *--zero*::
+Separate lines with a NUL instead of a newline in *-l* mode.
+
 *-o*, *--ignore-owner*::
 Link and compare files even if their owner information (user and group) di=
ffers. Results may be unpredictable.
=20
diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index e4b44c6c6..643df7cf2 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -189,6 +189,8 @@ static struct options {
 	unsigned int keep_oldest:1;
 	unsigned int prio_trees:1;
 	unsigned int dry_run:1;
+	unsigned int list_duplicates:1;
+	char line_delim;
 	uintmax_t min_size;
 	uintmax_t max_size;
 	size_t io_size;
@@ -206,6 +208,7 @@ static struct options {
 	.respect_xattrs =3D FALSE,
 	.keep_oldest =3D FALSE,
 	.prio_trees =3D FALSE,
+	.line_delim =3D '\n',
 	.min_size =3D 1,
 	.cache_size =3D 10*1024*1024
 };
@@ -1152,6 +1155,10 @@ static void visitor(const void *nodep, const VISIT w=
hich, const int depth)
=20
 	/* final cleanup */
 	for (other =3D begin; other !=3D NULL; other =3D other->next) {
+		if (opts.list_duplicates && other->st.st_nlink > 1)
+			for (struct link *l =3D other->links; l; l =3D l->next)
+				printf("%016zu\t%s%c", (size_t)other, l->path, opts.line_delim);
+
 		if (ul_fileeq_data_associated(&other->data))
 			ul_fileeq_data_deinit(&other->data);
 	}
@@ -1182,6 +1189,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	        "                              lowest hardlink count\n"), out);
 	fputs(_(" -M, --minimize             reverse the meaning of -m\n"), out);
 	fputs(_(" -n, --dry-run              don't actually link anything\n"), ou=
t);
+	fputs(_(" -l, --list-duplicates      print every group of duplicate files=
\n"), out);
+	fputs(_(" -z, --zero                 delimit output with NULs instead of =
newlines\n"), out);
 	fputs(_(" -o, --ignore-owner         ignore owner changes\n"), out);
 	fputs(_(" -F, --prioritize-trees     files found in the earliest specifie=
d top-level\n"
                 "                              directory have higher prior=
ity (lower precedence\n"
@@ -1223,7 +1232,7 @@ static int parse_options(int argc, char *argv[])
 		OPT_REFLINK =3D CHAR_MAX + 1,
 		OPT_SKIP_RELINKS
 	};
-	static const char optstr[] =3D "VhvndfpotXcmMFOx:y:i:r:S:s:b:q";
+	static const char optstr[] =3D "VhvndfpotXcmMFOlzx:y:i:r:S:s:b:q";
 	static const struct option long_options[] =3D {
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
@@ -1252,6 +1261,8 @@ static int parse_options(int argc, char *argv[])
 		{"content", no_argument, NULL, 'c'},
 		{"quiet", no_argument, NULL, 'q'},
 		{"cache-size", required_argument, NULL, 'r'},
+		{"list-duplicates", no_argument, NULL, 'l'},
+		{"zero", no_argument, NULL, 'z'},
 		{NULL, 0, NULL, 0}
 	};
 	static const ul_excl_t excl[] =3D {
@@ -1329,6 +1340,14 @@ static int parse_options(int argc, char *argv[])
 		case 'b':
 			opts.io_size =3D strtosize_or_err(optarg, _("failed to parse I/O size")=
);
 			break;
+		case 'l':
+			opts.list_duplicates =3D TRUE;
+			opts.dry_run =3D TRUE;
+			quiet =3D TRUE;
+			break;
+		case 'z':
+			opts.line_delim =3D '\0';
+			break;
 #ifdef USE_REFLINK
 		case OPT_REFLINK:
 			reflink_mode =3D REFLINK_AUTO;
--=20
2.39.2


--sac2mshpbvduakkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmcf1bIACgkQvP0LAY0m
WPGfDg/9FdqOIcjyDXL8iPOriiRbs6QAdNRQI53ehdwN+a5yFT95jAcX+3aabh97
8ne8fddjXrSMsUgrRWSd0bbRTqxt6oWGW3+9LrTv3JJv5FrjOPr5JhjG61JeTr2K
kqVvKy8jfXr61Huz2EuriXeuzUyFuGTZC3bTD/lejt4aoyF9PqnQ1jx95rrheAPp
LoB8kTrdoSGyyouddM8fNkBZOdDmN7Ak5jq8Q/QtDN1IsPPkF5iOKyxAJqiw7T5P
ld1k//x9R8Qwir15L0anIKVfUsY+JQyua/4QR2Y+iTFN/IWF/RppbBvLj/UwCh1P
zCShslVQ8IJT9GQcNi3NxHWSW0geKi8COeGaFMBYhsh8f23DeOaWFgk4zpXqJslp
TAZLPk60vzkQNrwfpoLPIZDzmwWI/uFjfmODZicKodL9PQuCWzHjitelY+Bp+MFb
b368qbhUsQB+RC/qaCIzJ/SYHD8Ca9HBZ6kXyla/4sYlaU8hONEQxJ3dsP0orfQC
8abnksOYNj+k2I/B8tP0/zFlR0fihkilC4b+yTdmgAni2+owBxEK6CrJKqyKdPIG
bNAy0a6l1WIX2QqsMN6LWSCjUAS4recDzOEFbj+nqI42LFyEdoWifk1UvTUwFaiI
s/SOZmpqeKpWpVHxYLqOsia0wP5vsJV/nOrvrXQjhjHlH4RoQAU=
=hh8f
-----END PGP SIGNATURE-----

--sac2mshpbvduakkv--
