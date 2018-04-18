Return-Path: neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Karel Zak <kzak@redhat.com>
Date: Thu, 19 Apr 2018 09:37:59 +1000
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: fix mnt_table_is_fs_mounted() for NFS bind mounts.
In-Reply-To: <20180418082219.yfq2pwq7qlztgn3x@ws.net.home>
References: <87po2xqjfp.fsf@notabene.neil.brown.name> <20180418082219.yfq2pwq7qlztgn3x@ws.net.home>
Message-ID: <87604oqe5k.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Wed, Apr 18 2018, Karel Zak wrote:

> On Wed, Apr 18, 2018 at 01:31:38PM +1000, NeilBrown wrote:
>> For nfs mounts, the fourth field is always "/", and the subdirectory
>> part is appended to the "special" (aka "device") field.  This is
>> consistent with historical NFS usage which always includes a path in
>> the fs_spec field.
>
> Interesting.
>
>>  libmount/src/tab.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> Applied with a minor change, thanks!

Thanks.  I like the minor change!

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrX1tcACgkQOeye3VZi
gblsSQ/+PwduyFSq+gUdd4mtABjz1cfEYg0CcTFO6n2pUGhgd7Pq3Zo5uaU7IaGA
Fx2kVIozgNNPu4035jitZ5TSgyGXanUT2a8J3WRWYzytZOaxrgPtIgc6LVNLXbtz
/uyb286fKkSZR0t2SAxKdtg25GfXw8wjpWsIDAK1AMwv4/8szSK+mBeK1dU1uVNO
5WpmEJXpx79azNQTtzK1+WLpLAGL1ThJ19xZ0K6UrdXmP4hbRlLkgb98fHlncw7g
iELngRKmbu207z6OhNtvxc275omYz7L0w5GBdLxyzi3rlmNHHWbczVNkVwdd1Owf
6KScmXBrTpHOxMsnEufdpMcvWBZUYVaBFr+6aqpVZ20nbWnRxXXizHVeBSyS8Zag
a1gLECzCMbhZZkNIiORNH2dIj8AUDEbTpYq2x2WcAcS2YtgA0+ejqPPikkpW6rAI
gqdUY/lqlFwjvOukSE62xASNqsq3fYKqKP+vze6MtgVxqk4KkJcUvNH+H7J3xp2Q
lZgfahKyWkduJyzsX0hH6OQ4qQgZ6PQxGH20HYMQpdytlbMUZJ16aZbnFLc0xExH
4Vh0QVQYA5IuhjFJd5l4FA6uQxSRkxK6CPIR/ruqHrnDzkA5wEAVuLnolS2z6S2S
5z2nzcZ4ytYonqlE+e8k/rhv8mzDosm4oaYO4Hf4KZfJwmTa3Ic=
=Fmzf
-----END PGP SIGNATURE-----
--=-=-=--
