Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C81A08B6
	for <util-linux@vger.kernel.org>; Thu, 31 Oct 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386615; cv=none; b=mxxeh/Dr3XbGHt+TdMMQTQGkuD89M17WUxk1vpG97VNvyuGHY3jh6Ov8dR7f9B8CVOLuugiLgTz4JXpW37K5apJxaNKPKwLFmXIQOyZpyruldE41nLPzd3Is/gsu+LC4Lf29qzajE9w2zl5eXkKg4/sdGYLCkQIFFZ6mgy+h1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386615; c=relaxed/simple;
	bh=tW2ird1varJi3W8zD0lQXdJ2bAtlDLVGtTvmChSwd3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSzUnTQDdXtruEyJM21qT3xjDEOyBYW2+ktmZDyOAZ2ZY1KTNkdsaLTJRjqN0Stui3QcX/tail7sGksmLVzdlV96e/7F+8GUwByRNDhdCx5baYFajJy9mNo8wUYKOrsrrhYbOXnroyTfAHBoK1ufeme8PyNE7juOv+e/xbvSmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=BZJRZdpI; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="BZJRZdpI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1730386600;
	bh=tW2ird1varJi3W8zD0lQXdJ2bAtlDLVGtTvmChSwd3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZJRZdpI/HF+jNRnTAjjjcCbcNHUEJEBen4O+XPpkmAGJM0hhVIOqjQztsjd31J85
	 iz2hX5nKioBQ9ucWBSR50inW+PgD0xNQfLLYc5HPT2yHNWonWX+jYEooqbPbtuztWX
	 nn5P6h86ie3mC6XdsVSi1DqaLhk5inwUTVGHgPYVvFdKL8WlTUVEtvYaWn2mxQLcVk
	 RCwHD9J60EyLVb7rkddMuagZ7OwRXJQeQKtW4fJTENAKiMDO5DA3LQyXbxNbJ2xny7
	 E7AZ0Q58ONg96/K4WmRbiNzJWMl3WfZEa9X94mhbyooAyTpAaxmuMBd+WIseXatVAF
	 ytkD8wckrReZg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id CA62B54F4;
	Thu, 31 Oct 2024 15:56:40 +0100 (CET)
Date: Thu, 31 Oct 2024 15:56:40 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] hardlink: add --list-duplicates and --zero
Message-ID: <geq2cawx3udvbe3b3tjton2cuim7ccemndul2sfknvxdll22sg@tarta.nabijaczleweli.xyz>
References: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
 <b22071e3546940d6d0fa6e1d9d03f292e18229e2.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
 <ivgbtqt2qjlpzxgh6tkdapfohjwu677heddtn7cpkpaqjyoi6g@brl4uxsj6lsv>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cfs7dhugxb6mdr7t"
Content-Disposition: inline
In-Reply-To: <ivgbtqt2qjlpzxgh6tkdapfohjwu677heddtn7cpkpaqjyoi6g@brl4uxsj6lsv>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--cfs7dhugxb6mdr7t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 09:58:19AM +0100, Karel Zak wrote:
> On Mon, Oct 28, 2024 at 07:19:30PM GMT, =D0=BD=D0=B0=D0=B1 wrote:
> > --list-duplicates codifies what everyone keeps re-implementing with
> > find -exec b2sum or src:perforate's finddup or whatever.
> >=20
> > hardlink already knows this, so make the data available thusly,
> > in a format well-suited for pipeline processing
> > (fixed-width key for uniq/cut/&c.,
> >  tab delimiter for cut &a.,
> >  -z for correct filename handling).
>=20
> Why do we need a 16-byte discriminator? The list consists of absolute
> paths, so it should be unique enough. This seems like an unusual
> thing,
Well, the point is to have a list of lists of files, right.
hardlink(1) finds, within the given domain,
a set of sets of "these files are identical"
(or, the logical set of "these are the link names of this file"
 for all eligible files).
The only way to flatten this is to a single-layer list is by having a
list of filenames discriminated by the set in which they belong, so
  [[a, b], [c, d, e]]
discriminated as
  0 a
  0 b
  1 c
  1 d
  1 e
which allows you to reconstuct the sets live while stream-processing
(the implementation uses a unique ASLR-randomised discriminator
 because the order isn't stable anyway I think? but same difference).

A list of just filenames is useless.

> as I cannot recall any other tool that uses something like
> this.
This is what the b2sum/sha1sum/&c. family does.
(And, in a worse and less structured manner, sum/cksum.)
If you were to implement this with one of those,
you'd do something like
  find -type f -exec b2sum {} + | sort | uniq -Dw128
which works but has other issues
(not tab-delimited, slow, harder than necessary to configure,
 actually you want to sprinkle -z everywhere, &c.).

There's no other commonly-accepted program that does this,
I want to say it's because (a) hardlink is The Util-Linux Implementation
which doesn't necessarily exclude others, but certainly discourages them,
(b) hardlink doesn't tell you, so (c) if you're querying something
in a way that hardlink doesn't support,
you're doing it ad-hoc with whatever you think of,
and you're wondering why hardlink won't just tell you.

Debian has, in src:perforate, finddup, which implements this.
It's very much 1996 (it reads the whole file into memory, in Perl,
before uniquifying by MD5(!)), and the output format is
  84 './build-output/dsh-0.25.10.obsolete.1730308699.8166876/debian/watch' =
'./build-output/dsh-0.25.10.obsolete.1730308753.583969/debian/watch'
  84 './build-output/dsh-0.25.10.obsolete.1730306971.4697168/debian/watch' =
'./build-output/dsh-0.25.10.obsolete.1730306296.9378986/debian/watch' './bu=
ild-output/dsh-0.25.10.obsolete.1730306808.9797611/debian/watch'
which is not in any way useful (the prefix is the size).

This then lets you process the equivalence sets separately
(I hope to replace this monstrosity I run commonly:
   find -exec b2sum {} + | sort | mawk '{h =3D substr($0, 1, 128); fn =3D s=
ubstr($0, 1 + 128 + 2);  if(h =3D=3D hash) {tgt =3D "." fname; split(fn, cu=
rs, "/"); if(curs[2] =3D=3D fnames[2]) tgt =3D fnames[3];  print "[ -s \"" =
fn "\" ] && ln -sf -- \"" tgt "\" \"" fn "\""} else {hash =3D h; fname =3D =
fn; split(fname, fnames, "/")}}'  | sh
 with something hardlink--l-based.
 Actually this would want hardlink -L ideally;
 would you accept a patch that adds -L?).

On Thu, Oct 31, 2024 at 09:51:00AM +0100, Karel Zak wrote:
> The new option should also be added to the "bash-completion/hardlink"
> file. However, I can fix this after merging locally.
I missed this. I'll include it in v2 if we get to v2 but if we don't,
please do, thanks.

--cfs7dhugxb6mdr7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmcjmqYACgkQvP0LAY0m
WPEXiw/9GpfBuZ1rcsQZuZI4jY6G4y6phxY5Wr3x8b6xyYnQ+ajYjxQcUVXsr3C6
rQOqSHZW/tDedtSZWI49RuYVDo21pGnSFqbUAms35+1pFflkhtFNBtqpv96VtkH4
SyVL5OyP8/X8YN3Mcmpm6Wh25wwse/aSXZwJj9HrEwm5r0OvEXwIgD+K0JVMdvWA
mswIKn2NqrY4mIje3cXj6MjGJcw//y6ljLXbH2LgLlLQUrry5/+PkyEpCMVq1ceH
Ceg4mTx+GDopbmHu8ufAZewvJ2WjaH6WEUkUv7vChUNrq3BNMdlz7yrlcELaUfin
9EwdhDOUiMvBJOjYihIQZgg0v2Z9IUW2k3Y2zxu3EVcOx3lihTwWwl8S8qPhb31T
4zJgI/rdx8T8RD9ZiO/L2KuYnFGc885GcXroqy3YqNiZMiIXvT/Cfoh3eiCAAMiU
P1UKhz5M7verPFgg0nMnS9F/HlmI0Rl8P2bF+qzpKZ+12wiW0Y6B66gh/R2zjYoY
umU2q97pPcKW64F3NECnxVebFUBNdCw0AWrUsv5q5ZuGdber9sPfwRiV8w5aAFhG
ZregBpaByBynfasLOngE6twO71i7Yyxh7i6cC3aG2nnvctW/dMqP+Z35m5pAvOpV
GUpXJg3zP5L6gfZ+zxxXZIpGubPM5Isd3j0ymz6S8IJQLa72M0E=
=zEmG
-----END PGP SIGNATURE-----

--cfs7dhugxb6mdr7t--
