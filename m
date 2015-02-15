Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:46327 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbbBOMIS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Feb 2015 07:08:18 -0500
Date: Sun, 15 Feb 2015 07:10:45 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: util-linux@vger.kernel.org, Mikhail Gusarov <dottedmag@dottedmag.net>
Subject: Re: [PATCH 2/2] unshare: allow persisting namespaces
Message-ID: <20150215121045.GA3910@vapier>
References: <1419798218-3174-1-git-send-email-lkundrak@v3.sk>
 <1419798218-3174-2-git-send-email-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
In-Reply-To: <1419798218-3174-2-git-send-email-lkundrak@v3.sk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28 Dec 2014 21:23, Lubomir Rintel wrote:
> Bind mount the namespace file to a given location after creating it if
> requested (analogously to what "ip netns" and other tools do).

since i found out about `ip netns`, i've wanted this in unshare ;).  althou=
gh=20
the two implementations seem to differ: iproute uses a common location=20
(/run/netns/$NAME) while this implementation requires specifying the full p=
ath=20
all the time.  would it be possible to rectify this ?

maybe if you give it a plain name, it defaults to a common location ?  so=
=20
something like this would "just work":
  $ ip netns add foo
  $ unshare --net=3Dfoo ...
(yes, i'm aware of `ip netns exec ...`)

using /run/${type}ns/ for all paths seems a bit ugly ... maybe claim=20
/run/ns/${type}/ instead ?

> The ugly bit about this patch is the clone(2) call, arguably not our
> fault. The stack size glibc requires for its clone(2) wrapper is not
> documented anywhere and its semantics (stack growth direction) is arch
> dependent. We could figure it out by comparing a return value of a helper
> function that would return an address of its local variable with caller's
> local variable address, but I guess that would be even more messed-up.

are you sure this is strictly a glibc requirement ?  seems like it's mostly=
=20
hardware/ABI related (certainly direction is).  i'd also point out that ia6=
4=20
doesn't implement clone either ... it has __clone2().

> +static struct namespace_file {

const

> +	int nstype;
> +	const char *proc_name;
> +	const char *target_name;
> +} namespace_files[] =3D {
> +	{ .nstype =3D CLONE_NEWUSER, .proc_name =3D "ns/user", .target_name =3D=
 NULL },
> +	{ .nstype =3D CLONE_NEWIPC,  .proc_name =3D "ns/ipc",  .target_name =3D=
 NULL },
> +	{ .nstype =3D CLONE_NEWUTS,  .proc_name =3D "ns/uts",  .target_name =3D=
 NULL },
> +	{ .nstype =3D CLONE_NEWNET,  .proc_name =3D "ns/net",  .target_name =3D=
 NULL },
> +	{ .nstype =3D CLONE_NEWPID,  .proc_name =3D "ns/pid",  .target_name =3D=
 NULL },
> +	{ .nstype =3D CLONE_NEWNS,   .proc_name =3D "ns/mnt",  .target_name =3D=
 NULL },
> +	{ .nstype =3D 0, .proc_name =3D NULL, .target_name =3D NULL }

use ARRAY_SIZE instead and you don't need the sentinel entry

> +int c, forkit =3D 0, maproot =3D 0;
> +const char *procmnt =3D NULL;

static

> +	fputs(_(" -m, --mount[=3D<file>]      unshare mounts namespace\n"), out=
);
> +	fputs(_(" -u, --uts[=3D<file>]        unshare UTS namespace (hostname e=
tc)\n"), out);
> +	fputs(_(" -i, --ipc[=3D<file>]        unshare System V IPC namespace\n"=
), out);
> +	fputs(_(" -n, --net[=3D<file>]        unshare network namespace\n"), ou=
t);
> +	fputs(_(" -p, --pid[=3D<file>]        unshare pid namespace\n"), out);
> +	fputs(_(" -U, --user[=3D<file>]       unshare user namespace\n"), out);

probably want <path> instead of <file> since it can be either

> +static void persist_ns(pid_t pid)
> +{
> +	struct namespace_file *nsfile;
> +
> +	for (nsfile =3D namespace_files; nsfile->nstype; nsfile++) {
> +		char pathbuf[PATH_MAX];
> +
> +		if (!nsfile->target_name)
> +			continue;
> +
> +		snprintf(pathbuf, sizeof(pathbuf), "/proc/%u/%s", pid,
> +			nsfile->proc_name);

use xasprintf to avoid the PATH_MAX constant

> +		if (-1 =3D=3D mknod(nsfile->target_name, 0666, 0)) {
> +			warn(_("failed to create %s"), nsfile->target_name);
> +			continue;
> +		}
> +
> +		if (-1 =3D=3D mount(pathbuf, nsfile->target_name, NULL, MS_BIND, NULL)=
) {
> +			warn(_("mount %s failed"), nsfile->target_name);
> +			unlink(nsfile->target_name);

generally the codebase uses the other style -- constants go on the right

> +static int in_child (void *arg)

no space before the (
-mike

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU4IzFAAoJEEFjO5/oN/WBAaEQAJmGcdm/Utn5UpOe16Herwym
74freBpwWeRbYnBw+PjOnCm/HD4cPUSs9NJm04lsvdVCZQRtMNMRZ3OH3X2hKQ11
qZtPcYZDxBajlHDFCQr5tmEuof6sk4jknQBoDk0EYy8FSrjgS1ObZLR84Cfp/XXk
wzo2iyHRY3QLVtlvCYfZdvILA51ZA06laBZ1Aln69XuIknDzF4mGAGsnU1cokoww
u58Qhh6OoxTL3Xqm3qqRNJMTGxWoBpDLt2NOdKA9tTVd9W2vvCtgYsH+cuy3kjct
wRMEMKfgbYBFvQkYkxqk3zCCTEj5ooaXAlK8/VLJZVEZOw5JbqJ7pnnL1a54jSkl
79qoVZYPWZydIjLsE9h5Eu5XgePcB78W8PglOXj6kYQERv4+U6wOkUT612NJIBSD
Rm8eUDPkUq3J75xiqlkHw/N1cyC0fAUYRr3ADyy9E0xFE837rnvku13A2HW9m/IZ
eyHhc8V5YxIYYmWredVMROAIX42PW1kTqcxv2uhFDt0pW5nxh0YFm++YBE/z2ajH
ji1rJMi3x3cTPKq3q0rKH4S+nVoMl9bFuGc3VG1YU96QkTM8ftHRoIkol1pc2Uwa
2K088JUFzZF/qVKy+wft8Hjgq5H65bIYxexrg52Ke8WuXxc3jzEr3BZGt4JYxiHD
B0A1l6RgZXbU8F8S2Fj9
=4eeZ
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
