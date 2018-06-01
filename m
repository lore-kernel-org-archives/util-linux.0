Return-Path: kevin@scrye.com
Subject: Re: hardlink util -- files de-duplication
To: Ruediger Meier <sweet_f_a@gmx.de>, Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>, tsao@fedoraproject.org
References: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home>
 <201806011508.38470.sweet_f_a@gmx.de>
From: Kevin Fenzi <kevin@scrye.com>
Message-ID: <8f042d0b-ad2a-59aa-ac5d-69e6c197da02@scrye.com>
Date: Fri, 1 Jun 2018 13:20:29 -0700
MIME-Version: 1.0
In-Reply-To: <201806011508.38470.sweet_f_a@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4Tg3OySJrTVo2nunUWVCuEJTLq7I8MLAP"
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4Tg3OySJrTVo2nunUWVCuEJTLq7I8MLAP
Content-Type: multipart/mixed; boundary="oWUuRiBgwa4Btyy6tlOA96dqir8DcJtC7";
 protected-headers="v1"
From: Kevin Fenzi <kevin@scrye.com>
To: Ruediger Meier <sweet_f_a@gmx.de>, Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>, tsao@fedoraproject.org
Message-ID: <8f042d0b-ad2a-59aa-ac5d-69e6c197da02@scrye.com>
Subject: Re: hardlink util -- files de-duplication
References: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home>
 <201806011508.38470.sweet_f_a@gmx.de>
In-Reply-To: <201806011508.38470.sweet_f_a@gmx.de>

--oWUuRiBgwa4Btyy6tlOA96dqir8DcJtC7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/01/2018 06:08 AM, Ruediger Meier wrote:
> On Friday 01 June 2018, Karel Zak wrote:
>> For last 17 years in Red Hat based distros is available hardlink(1)
>> util, man hardlink:
>>
>>    hardlink traverses one or more directories searching for duplicate
>>    files.  When it finds duplicate files, it uses one of them as the
>>    master.  It then removes all other duplicates and places a
>> hardlink for each one pointing to the master file.  This allows for
>> conservation of disk space where multiple directories on a single
>> filesystem contain many  dupli cate files.
>>
>>    ...
>>
>> the util is little bit orphaned, what about to add this util to
>> util-linux to make it available for another distros and keep it
>> maintained in serious way? ;-)
>=20
> +1
>=20
>>
>>    https://src.fedoraproject.org/cgit/rpms/hardlink.git/
>=20
> The original and almost identical repo is this:
>   https://pagure.io/hardlink.git
>=20
> I've CC'ed the project admin Kevin Fenzi.


I've also added my co-maintainer (tsao@fedoraproject.org).
He's done most of the recent work on it, I haven't had time to do much
with it at all.

I'd personally be in favor of it moving into util-linux. Hopefully it
would get more time and attention there and more widespread use.

If tsao agrees, lets make it happen.

kevin


--oWUuRiBgwa4Btyy6tlOA96dqir8DcJtC7--

--4Tg3OySJrTVo2nunUWVCuEJTLq7I8MLAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESz7rprBJHpbnMnrQSzew2A/7u14FAlsRqo0ACgkQSzew2A/7
u1430BAA0c4nulX6qoUgoOjfxR7n5zuqAPIbAby7maZTNFV/MSZW4iNZJefTXREr
1njiimO3CjFDo4dDHdc9KtXRg004ol+G4lSQdwOHCrM+xp+FKqsqlmbX2myV0ut7
+nRjUQJywnVv0OMvdW0d5xFVRVr6tGdncmtRDsRCVTliLY5wdmw8EbUs8epwqNYx
hqEtuW86HJxfdL/KGKxU/mrzcAJTg+jSQbrPvhX89cdqvLv9yjTf5jQooEzgj+Ac
JnK3uZG5B2cexQnZMUchXryofx9mEc4g+yRzerX0ACqn3ao38jQajhcfIAFGdfb6
et/Xlr1lnqYrAIO5PrNeqTSeUiOcRa71pWWwJRCnjH9DvS0LHn53lkDqK10D3pDs
weO7dSvcTkW+3m+4GOSMz2BD43zt0Ll4Xq0uW1NsgNjQddu8uyjcims5SCOOxEQ+
Mko6/HoP7l31tDihgGYcu3zzG88IfTOtipq99UmYHPRBh8OhkjQBMV+lUieWK2cc
FqTVmPq4JXiJ5xXHsZp9hA68006HBDph2kpDHueATH4oyKHfiYJu3f53yHjp18ND
S21F2zxQNLkUkVUE2Jmh7E7INtyZy4px5n2phgX00nuVHwyNvWl/CjfSTpLjfGiR
+gpRVbLBKF5jNeOaEdTBU6bhR82D70+PR1zHEZRtTv9kfclBLyI=
=ANLH
-----END PGP SIGNATURE-----

--4Tg3OySJrTVo2nunUWVCuEJTLq7I8MLAP--
