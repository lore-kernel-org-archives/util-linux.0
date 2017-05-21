Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:44641 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752119AbdEUWQn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 21 May 2017 18:16:43 -0400
From: NeilBrown <neilb@suse.com>
To: Karel Zak <kzak@redhat.com>
Date: Mon, 22 May 2017 08:16:36 +1000
Cc: util-linux@vger.kernel.org
Subject: Re: "mount -o remount,rw" sometimes doesn't work as expected.
In-Reply-To: <20170519091125.bdans7hirua3blb5@ws.net.home>
References: <87wp9djp2n.fsf@notabene.neil.brown.name> <20170519091125.bdans7hirua3blb5@ws.net.home>
Message-ID: <87r2zhkg8r.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, May 19 2017, Karel Zak wrote:

> On Fri, May 19, 2017 at 05:14:24PM +1000, NeilBrown wrote:
>> Suppose /foo and /bar are bind mounts to the same
>> filesystem which is currently mounted read-only,
>> and suppose the /etc/fstab contains
>>=20
>>   /dev/sda1 /bar ext4 defaults 0 1
>>   /bar /foo none bind 0 0
>>=20
>> Now if I want /foo to be writeable I might try:
>>=20
>>   mount /foo -o remount,rw
>>=20
>> and would then be surprised that this doesn't work.
>>=20
>> What is happening is that because only one path has been given, mount
>> needs to find the other and goes looking in /etc/fstab.
>
> Frankly remount & fstab sucks.

:-)

>
> The problem is that we want to read fstab because remount works as
> "replace all old options with new options", so if you don't read
> fstab then all options unspecified on command line will be removed.
>
> Let's imagine your command line is "-o remount,ro", but you have also
> "noexec" in your fstab. If you don't read fstab then "noexec" will be
> removed by the remount operation. This is unexpected by many users.
> They want to change only specified options (ro->rw, etc).
>
> It would be possible to read /proc/self/mountinfo on remount (to get
> old options), but unfortunately this is not backwardly compatible,
> because we have users who call=20
>
>     mount /mnt -o remount
>
> (yes, without another options) and they assume that all options will
> be reset according to fstab.

I can see how the need to support that usage make it difficult to ignore
fstab.


>
>
> *** See man mount: ***
>
> The remount functionality follows the standard way the mount command
> works with options from fstab.  This means that mount does not read
> fstab (or  mtab)  only  when  both device and dir are specified.
>
>     mount -o remount,rw /dev/foo /dir
>
> After this call all old mount options are replaced and arbitrary stuff
> from fstab (or mtab) is ignored, except the loop=3D option which is
> internally generated and maintained by the mount command.

oooh... it just occurred to me that for a mount, I can make it
read/write by:

   mount -o remount,rw none /mount/point

providing I know that no other flags are needed.  I don't need to give
the correct device path, do I?


>
>     mount -o remount,rw  /dir
>
> After this call, mount reads fstab and merges these options with the
> options from the command line (-o).  If no mountpoint is found in
> fstab, then a remount with  unspecified source is allowed.

BTW, if fstab contains just

   /bar /foo none bind 0 0


Then both
  mount -o remount,rw /bar
and
  mount -o remount,rw /foo

will try to remount /foo.  This is also surprising....
Normally you would have an entry for "/bar" listed earlier, and that
would be used for "mount -o remount,rw /bar".  So it probably isn't a
real problem.

>
>> If finds an appropriate line and parses out the options.
>> Then the mount system call used is
>>=20
>>  mount( "/bar", "/foo", ..., MS_REMOUNT | MS_BIND ,....)
>>=20
>> This changes the per-mountpoint ro flag to rw, but doesn't change the
>> filesystem itself.  This can be seen in /proc/self/mountinfo.  There
>> are two r[wo] flags, and they are different.
>>=20
>> Had I run:
>>=20
>>   mount /foo -o remount,bind,rw
>>=20
>> I would have expected this.  But as I didn't explicitly ask for "bind",
>> it is confusing.
>>=20
>> I think it might be good to ignore "bind" in /etc/fstab when "remount"
>> is used.
>
> Another exception :-) I'll think about it, maybe it's not so bad idea
> because "remount,bind" is very special.
>
>> However.... when "remount" is used, the "device" is ignored, so there
>> isn't a lot of point hunting through /etc/fstab to find it.
>
> Yes, but then you have to specify all options on command line,
> unspecified will be removed by remount op.
>
> We have in TODO for years
>
>  - add options to control fstab/mtab mount options usage, something like:
>
>    --options-mode=3D{ignore,append,prepend,replace}      MNT_OMODE_{IGNOR=
E, ...}
>    --options-source=3D{fstab,mtab,disable}               MNT_OMODE_{FSTAB=
,MTAB,NOTAB}
>    --options-source-force                              MNT_OMODE_FORCE
>
>
> all this already supported by libmount, but no exported to the
> mount(8) command line.
>
> Maybe I should implement it :)

Maybe.  I'm currently focused on the default behaviour being a bit
confusing and this wouldn't help with that.
While the functionality that these flags provide seems sensible,
I do wonder if it would actually get used.

>
>> If mount is given just one path and the "remount" option, then maybe
>> it shouldn't try to find an /etc/fstab entry at all?
>> I guess you might want to remount a device??
>> Is
>>    mount -o remount,rw /dev/sda1
>> allowed?  In that case, don't look through /etc/fstab if the path
>> is a directory.
>>=20
>> I haven't provided a patch because I'm not 100% sure what the best
>> approach would be.
>> Does anyone have opinions on what mount should or shouldn't do when
>> remounting and only one path is given?
>>=20
>> You could possibly argue that the current behaviour is correct
>> as /foo is listed as bind mount.  That doesn't stop is being surprising.
>> Also
>>    mount /bar /foo -o remount,rw
>>=20
>> doesn't pick up the "bind" flag, so the filesystem gets remounted.
>> So I think there is definitely something wrong.
>
> That's question... "remount,bind" is really special and maybe "bind"
> from fstab should be really ignored in this case.

I think that is probably the best way forward, at least in the short
term.
I might try to dig into the code and see how easy this would be.

Thanks for your detailed response!

NeilBrown


>
>     Karel
>
> --=20
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkiEcQACgkQOeye3VZi
gbk+GA//VMPmGypd75PSqnU2pRU1ZvpGvX2BCoM8PjaAb18LtrgLd2VQFnLNFEUA
pLLj+o3sg1v7m4oZz7vUlfsjpDiCER60ooIeLRLYJ93F2L7F/KW5+QFJUzL5ms8a
4BhuprYLh91vj02uVtsGK2mpcnan9bNrL5fda3oKI4zq7DkWv9WFFcRNSAEUGpY7
LwCHcUVC5Y+8bRxNqIykS3WoQoKHxVsK+qEzO2zb+kamJovcBQHW7+yPXE8SP43a
AMVxlG7Nqrm3cZjM45Jnu3/O5EWWfRC2TPBJC1jAd/a6gt4ZbPJdkYGUwTxsMU56
gMObtK2EMColvJVZNWL3hbCBcOHkhiWQJRP/GT3rNMSl+8xeDS+Zb4Ad+34+DsCg
TUKMPtvZHx5GresbBuwYP6V3KfuD0hlXRZSb+x8uPzGp1k3ljyuIE48bBoc6FEVx
nk812+hdF4s5Q+DkBahAyc1dzsvwbSfFjDIumXyORA7Ikp9I0y0X8mXb7iUyoUk/
9W7v24qCT08s0Jq1uoJ6KKVykxJCBVTnJzBdS1Tuui4HKAZ/4Z5Y6avRbRbAPydH
T7kNEE0vFL6Br4L5ZBSRCwanj/yehPcUZVl6fecq/SM7Pij2fPSIx8ESf2oF1/zj
dt31El5AUkhTb+iB5BhCQ1HQFKnNReqxwEC78Hf/hTT1wDcXrwU=
=md6j
-----END PGP SIGNATURE-----
--=-=-=--
