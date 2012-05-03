Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58888 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab2ECMTB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 May 2012 08:19:01 -0400
Received: by wibhj6 with SMTP id hj6so311393wib.1
        for <util-linux@vger.kernel.org>; Thu, 03 May 2012 05:19:00 -0700 (PDT)
Message-ID: <4FA277AF.20902@gmail.com>
Date: Thu, 03 May 2012 14:18:55 +0200
From: =?UTF-8?B?VmxhZGltaXIgJ8+GLWNvZGVyL3BoY29kZXInIFNlcmJpbmVua28=?=
	<phcoder@gmail.com>
MIME-Version: 1.0
To: dave@gnu.org
CC: util-linux@vger.kernel.org
Subject: Re: mkfs.minix -3 creates incorrect and limited filesystem
References: <4FA1417D.8010704@gmail.com> <1335970369.2734.17.camel@offbook>
In-Reply-To: <1335970369.2734.17.camel@offbook>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig35C582E2B15BEDF8CC4B706C"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig35C582E2B15BEDF8CC4B706C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02.05.2012 16:52, Davidlohr Bueso wrote:
> On Wed, 2012-05-02 at 16:15 +0200, Vladimir '=CF=86-coder/phcoder' Serb=
inenko
> wrote:
>> --- util-linux-2.20.1/disk-utils/mkfs.minix.c	2011-10-11 15:23:46.0000=
00000 +0200
>> +++ util-linux-2.20.1-mod/disk-utils/mkfs.minix.c	2012-05-02 13:56:09.=
993347189 +0200
>> @@ -487,7 +487,7 @@ static void setup_tables(void) {
>> =20
>>  	if (fs_version =3D=3D 3) {
>>  		Super3.s_log_zone_size =3D 0;
>> -		Super3.s_blocksize =3D BLOCKS;
>> +		Super3.s_blocksize =3D MINIX_BLOCK_SIZE;
>>  	}
>>  	else {
>>  		Super.s_log_zone_size =3D 0;
>> @@ -773,7 +773,7 @@ int main(int argc, char ** argv) {
>>  	if (fs_version =3D=3D 3)
>>  		magic =3D MINIX3_SUPER_MAGIC;
>> =20
>> -	if (fs_version =3D=3D 2) {
>> +	else if (fs_version =3D=3D 2) {
>>  		if (namelen =3D=3D 14)
>>  			magic =3D MINIX2_SUPER_MAGIC;
>>  		else
>>
> Correct, however this is already fixed in new versions.
Ok, sorry for noise then, I've used Debian version. I've discovered this
and few other Linux and tools bugs when writing automatic tests for GRUB
fs drivers.
> Thanks,
> Davidlohr
>
>
>


--=20
Regards
Vladimir '=CF=86-coder/phcoder' Serbinenko



--------------enig35C582E2B15BEDF8CC4B706C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iF4EAREKAAYFAk+id68ACgkQNak7dOguQgk1/wEAut0vydVpkPDicwGocWAaW+ct
Bp+qco0yy8aSKsNCLUMA/2gJ+1wE9p2VMx629yHF3AO5HMh+rBJ9fDwGR24m++Xt
=6LWH
-----END PGP SIGNATURE-----

--------------enig35C582E2B15BEDF8CC4B706C--
