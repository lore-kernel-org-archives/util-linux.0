Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33170 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdA1S4t (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 28 Jan 2017 13:56:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so5402376wmv.0
        for <util-linux@vger.kernel.org>; Sat, 28 Jan 2017 10:56:44 -0800 (PST)
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Jan Kara <jack@suse.cz>
Subject: Re: UDF label change since commit 2f2730bc77c9
Date: Sat, 28 Jan 2017 19:46:57 +0100
Cc: sbrabec@suse.cz, kzak@redhat.com, util-linux@vger.kernel.org
References: <20160810123859.GA31140@quack2.suse.cz> <20160815102642.GI30047@pali> <20160816102114.GF27284@quack2.suse.cz>
In-Reply-To: <20160816102114.GF27284@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1562149.W45JCRCZTH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201701281946.58075@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1562149.W45JCRCZTH
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 16 August 2016 12:21:14 Jan Kara wrote:
> On Mon 15-08-16 12:26:42, Pali Roh=C3=A1r wrote:
> > On Monday 15 August 2016 11:43:37 Jan Kara wrote:
> > > On Wed 10-08-16 16:23:06, Pali Roh=C3=A1r wrote:
> > > > On Wednesday 10 August 2016 15:39:02 Jan Kara wrote:
> > > > > Hi,
> > > > >=20
> > > > > On Wed 10-08-16 14:53:49, Pali Roh=C3=A1r wrote:
> > > > > > On Wednesday 10 August 2016 14:38:59 Jan Kara wrote:
> > > > > > > we have noticed that since commit 2f2730bc77c9 "libblkid:
> > > > > > > udf: Fix reading LABEL, add support for UUID and other
> > > > > > > udf identifiers" some volumes have changed labels which
> > > > > > > are reported by blkid. See [1] for an example.
> > > > > >=20
> > > > > > "You are not authorized to access bug #983165."
> > > > >=20
> > > > > Ah, sorry. I forgot the bug is reported against SLES and so
> > > > > is not publically visible. Anyway, the initial comment which
> > > > > is interesting is:
> > > > >=20
> > > > > I have a shared paritition with an UDF filesystem. In Win7
> > > > > 64bit its label is 'ssd120_docs'. In SLES12SP1 its label is
> > > > > 'ssd120_dokumente'. In Tumbleweed (and most likely also SP2
> > > > > Beta) its label is 'ssd120_dosemut' (or similar garbage).
> > > > >=20
> > > > > I think there should be some consistency in
> > > > > /dev/disk/by-label/*. ---
> > > > >=20
> > > > > As an explanation, SLES12SP1 uses util-linux 2.25 (i.e.,
> > > > > before your patch), Tumbleweed is the rolling distro with
> > > > > the latest & greatest version.
> > > > >=20
> > > > > > > This is
> > > > > > > because that commit changed what is used for the label -
> > > > > > > previously we have used 'ident' in the Primary Volume
> > > > > > > Descriptor, and after that commit we use Logical Volume
> > > > > > > ID.
> > > > > >=20
> > > > > > Yes, thats true.
> > > > > >=20
> > > > > > > I think it would be better to keep consistency with older
> > > > > > > util-linux releases (e.g. valid /etc/fstab that uses
> > > > > > > labels may be broken by this change) but I'm not sure
> > > > > > > whether there is a point once the new behavior has been
> > > > > > > released in the util-linux release. But still I wanted
> > > > > > > to raise this since I'm not sure how much util-linux
> > > > > > > cares about these changes and also so that people are
> > > > > > > aware of the change...
> > > > > > >=20
> > > > > > > 								Honza
> > > > > > >=20
> > > > > > > [1] https://bugzilla.suse.com/show_bug.cgi?id=3D983165
> > > > > >=20
> > > > > > Reason why I proposed that change is because all other
> > > > > > software use Logical Volume Identifier as label. Just
> > > > > > linux blkid used something other.
> > > > > >=20
> > > > > > Basically Linux was incompatible with whole world and I
> > > > > > think this was a bug. Also UDF specification say something
> > > > > > that LVI is displayed to user. IIRC also Grub2 uses LVI as
> > > > > > label identification.
> > > > > >=20
> > > > > > So I do not agree with reverting back old behaviour which
> > > > > > is incompatible with everything except old util-linux
> > > > > > versions...
> > > > >=20
> > > > > Well, this somewhat does not match the description in the
> > > > > bug. Apparently Win7 uses yet another identifier in the UDF
> > > > > filesystem...
> > > >=20
> > > > Not good :-( Anyway, are you able to produce/create UDF disk
> > > > image/dump which show different label under Win7 and new
> > > > util-linux? With that we can inspect which field is Win7 using
> > > > and could test also other systems (like some BSD or Grub2)
> > > > what see...
> > > >=20
> > > > Maybe there could be different behaviour for CD, DVD, HDD or
> > > > multisession CD/DVD...
> > >=20
> > > The reporter has UDF filesystem created on HDD AFAIU. I've asked
> > > him to run udf_test program on the fs image. From its output we
> > > should be able to see various identifiers of the filesystem and
> > > thus see whan Win7 uses.
> >=20
> > Ok, that should help us to detect how Win7 get label...
> >=20
> > Anyway, for such output is good tool udfdump from UDFClient project
> > [1]. It has better license so it can be found in some linux
> > distributions.
> >=20
> > [1] - http://www.13thmonkey.org/udfclient/
>=20
> Ah, good to know. Thanks! Sadly the reporter doesn't have the image
> anymore. Just out of curiosity I've dumped information for Win 8.1
> installation DVD I had lying around and there is one ID string in
> Physical Volume Descriptor, one ID string in Physical Volume Set
> Descriptor and then one ID string used for Logical Volume, Logical
> Volume Set, and all other similar stuff. And this string looks the
> most reasonable for a label. So I don't see much room for difference
> between what Windows show and what current util-linux uses. Once
> I'll reboot my machine to Win7, I'll check how it names the DVD.
>=20
> 								Honza

Now I formatted USB disk with command:

$ mkudffs -b 512 --lvid=3Dlogical-volume-ident --vid=3Dvolume-ident --vsid=
=3Dvolume-set-ident --fsid=3Dfile-set-ident

And connected to Windows 10 machine. Windows identifies it as
"logical-volume-ident" in "This PC".

So I think nothing was changed in Windows 10 and behaviour is same as
in linux-util.

Maybe there can be problem for optical discs where is bridged UDF with
ISO filesystem and UDF part has different identifiers as those in ISO
part?

And maybe... it is possible that some UDF filesystems on HDDs have also
ISO identifiers and linux-util is confused what should use as label?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1562149.W45JCRCZTH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEUEABECAAYFAliM5yIACgkQi/DJPQPkQ1JRNACYr7lXbkDdXkKdTb38ExUAX8Wi
lACfSelUwfR1ZG8x1boEuXnDj+4WlS4=
=73gx
-----END PGP SIGNATURE-----

--nextPart1562149.W45JCRCZTH--
