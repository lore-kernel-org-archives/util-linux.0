Return-Path: bernhard.voelker@siemens-enterprise.com
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Matt Burgess <matthew@linuxfromscratch.org>, Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Date: Mon, 12 Mar 2012 15:09:37 +0100
Subject: RE: mount -f regression in v2.21's new-mount
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0F0D366C09@MCHP058A.global-ad.net>
References: <20120309105304.GF17711@x2.net.home>
	 <5fde29ffbccb41cf5eb3a286c2f7e954@quantum.linuxfromscratch.org>
	 <20120309122926.GH17711@x2.net.home>
 <1331492786.1816.2.camel@kyoto.localdomain>
In-Reply-To: <1331492786.1816.2.camel@kyoto.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Matt Burgess wrote:
> Karel Zak wrote:
> > Matt Burgess wrote:
> > > Thanks!  Is there a consensus opinion on whether users should be
> > > using a regular mtab or a symlink to /proc/self/mountinfo?
> >=20
> >  - disadvantage is that some userspace utils (e.g. df(1) are not able
> >    to de-duplicate list of mounted filesystem (bind mounts))
> >=20
> >  + advantage is that there is only one list of mounted filesystems
> >    with always valid mount options (on systems with mtab is not problem
> >    to have 'rw' in mtab for read-only NFS, etc.), no problems with
> >    namespaces, not writable files in /etc, no mtab lock, etc.
> >=20
> >  The symlink is required for systemd.
>=20
> Thanks for the info.  Looks like there are more advantages than
> disadvantages.  Without wishing to stray too far off-topic, do you know
> if the Coreutils folks are aware of/looking at the 'df' issue?

It is:
http://lists.gnu.org/archive/html/bug-coreutils/2011-12/msg00153.html=20
(along with the point that the long uuid names of the devices
are annoying).

Have a nice day,
Berny=
