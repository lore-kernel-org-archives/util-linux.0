Return-Path: util-linux-owner@vger.kernel.org
Received: from mta04.eastlink.ca ([24.224.136.10]:44786 "EHLO
	mta04.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbBYCpJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 21:45:09 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta04.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NK900IANWZ9RS00@mta04.eastlink.ca> for
 util-linux@vger.kernel.org; Tue, 24 Feb 2015 22:45:06 -0400 (AST)
Date: Tue, 24 Feb 2015 22:45:05 -0400
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] docs: fstab(5) grammar / English fixes,
 and some other	updates
Message-id: <20150225024505.GS3933@cordes.ca>
References: <1424689834-29236-1-git-send-email-peter@cordes.ca>
 <1424812009.4081464.231923961.72455B01@webmail.messagingengine.com>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary=9Ek0hoCL9XbhcSqy
In-reply-to: <1424812009.4081464.231923961.72455B01@webmail.messagingengine.com>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--9Ek0hoCL9XbhcSqy
Content-Type: multipart/mixed; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

TYVM for the detailed review.  I applied all your .macro
recommendations, and most of the other changes.

I included a revised patch.  (Is email attachment the prefered way?
Or inline, or as a separate message?)

On Tue, Feb 24, 2015 at 10:06:49PM +0100, Benno Schulenberg wrote:
>=20
> On Mon, Feb 23, 2015, at 12:10, Peter Cordes wrote:
> > -spaces.  Lines starting with '#' are comments, blank lines are ignored=
=2E The
> > +spaces.  Lines starting with '#' are comments.  Blank lines are ignore=
d. The
>=20
> When changing a line, please also fix a single space after a period: ".  =
The".

Good call, missed that.

> I would have changed the comma to semicolon, by the way.  :)

 Since you mentioned it, I looked at the rest of the paragraph more
carefully.  I split the description of the formatting into its own
paragraph, for easier skimming.  The other semicolon-separated things
could stand alone as simple declarative sentences, so I did that,
again for easier skimming.


> > +This is a typical example of an [...]
>=20
> Please add a .PP instead of a blank line before this line.  And
> replace "This" with "The following", because when starting
> to read the sentence, it is completely unclear what "This"
> refers to.

 Ok, that works.  I wasn't happy about "This is", but it was better
than several other ideas that didn't sound right for a man page either.


> > +LABEL=3Dt-home2   /home      ext4    defaults,auto_da_alloc      0 2
>=20
> Please add a ".RS 7" before and a ".RE" after it.
> And for clarity maybe doublespace the "0 2".

 Ok, more than one space would make it more like distro-default
fstabs.  At some point I changed my own fstab on this machine to take
less line length.  (I think when I had long LABEL=3D fields from playing
with LVM.)

 And in case anyone's wondering, the t is for the hostname, tesla.  I
like to label my filesystems so I know what host they're from when I
stick the disk in another machine sometime in the far future.  And
it's home2 because during one disk upgrade, I made a new FS with a new
label and copied the data, instead of copying the block device.
(It's usually a good idea to do a file-copy instead of block copy to
reset FS aging any time you have to copy anyway.  And you can use new
mkfs options that weren't around when you made your old FS.)  Sorry,
getting off-topic here.


> > -For ordinary mounts it will hold (a link to) a block special
> > +For ordinary mounts, it will hold (a link to) a block special
>=20
> I don't agree with this comma.  For me it hinders comprehension
> a bit rather than helping.  When speaking the phrase aloud, the
> pause between "mounts" and "it" is negligible, even inaudible.
> A comma makes me think something parenthetic is getting said.
> But... matter of taste.

Speaking aloud, I would actually pause there for longer than the usual
inter-word gap.  I think that's typical.  Without the pause, it sounds
or feels like a run-on jumble of words, for me.  (spoken pauses don't
always imply a comma should go there, though.)

Random google hit that describes the usage rule leading me to use a
comma there:
http://grammar.ccc.commnet.edu/grammar/commas_big.htm  (rule #3)

    Use a comma to set off introductory elements, as in "Running toward
    third base, he suddenly realized how stupid he looked."

Apparently the comma is optional when the introductory clause is
short, but my first impression when reading it was that there SHOULD
be one.

 If other people agree with Benno that it reads more easily for them
without the comma, I'll take it back out.  I might have a tendency to
overuse commas.  There's no harm to meaning either way.


> > +This is the recommended method, as device names are often a coincidence
> > +of hardware detection order, and can change when other disks are added=
 or removed.
> > +(cf.
>
> please also replace "cf." with a clearer "compare" or "see also".

I changed the cf. to a full sentence and re-ordered things.


> > +This field describes the type of the filesystem.  Linux supports many
> > +filesystem types, including ext4, xfs, btrfs, vfat, ntfs, hfsplus,
> > +tmpfs, sysfs, proc, iso9660, udf, nfs, cifs, and many more. [...]
>=20
> Ah, no, you can't say "including", name some, and then add
> "and many more".  It's either "including", name some, and period,
> or replace "including" with a colon, name some, and finish with
> "and many more".  So, it was fine the way it was.

 Oops, good catch.  I think I was worried that someone would install
Linux, read this man page, and not see their favorite FS in the list.
And then uninstall Linux before getting to the "and many more", or
something. :P
=20
 I spent more time editting the list to have good examples of
filesystems.  (Took out ext2, ext3.  Included vfat, ntfs, and hfsplus,
since GNU/Linux has full read-write support for Windows and Mac
filesystems these days.)  I wanted to give examples of filesystems
specialized for various things (like compressed read-only squashfs),
in case the reader wasn't aware of the existence of specialized
filesystems for different use cases.



> > +It is formatted as a comma separated list of options.
> =20
> comma-separated
>=20
> > -Basic file system independent options are:
> > +Basic filesystem independent options are:
>=20
> filesystem-independent

fixed.


> The other changes are good.

 Thanks.

--=20
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

--lEGEL1/lMxI0MVQ2
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-docs-fstab-5-grammar-English-fixes-and-some-other-up.patch"
Content-Transfer-Encoding: quoted-printable

=46rom c5dd774035e0e7899aca6c9a7e109f167c13e5e0 Mon Sep 17 00:00:00 2001
=46rom: Peter Cordes <peter@cordes.ca>
Date: Tue, 24 Feb 2015 22:40:41 -0400
Subject: [PATCH] docs: fstab(5) grammar / English fixes, and some other
 updates

I proofread the whole thing.  I fixed everything that I thought could use
improvement.

various grammar and man page style-guide fixes (commas, word order, etc.).

Reworded a couple things to hopefully make it clear to someone that
didn't already know about fstab.  Re-ordered the intro paragraphs
for easier skimming.  And added an example line.

Expanded on a couple things other things.

Tightened up the wording in some other places to get the point across
faster and in less space.

Thanks to Benno Schulenberg <bensberg@justemail.net>
for several improvements.

Signed-off-by: Peter Cordes <peter@cordes.ca>
---
 sys-utils/fstab.5 | 99 ++++++++++++++++++++++++++++++++-------------------=
----
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index 9287519..2f20fed 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -31,7 +31,7 @@
 .\"
 .\"     @(#)fstab.5	6.5 (Berkeley) 5/10/91
 .\"
-.TH FSTAB 5 "August 2010" "util-linux" "File Formats"
+.TH FSTAB 5 "February 2015" "util-linux" "File Formats"
 .SH NAME
 fstab \- static information about the filesystems
 .SH SYNOPSIS
@@ -39,13 +39,10 @@ fstab \- static information about the filesystems
 .SH DESCRIPTION
 The file
 .B fstab
-contains descriptive information about the various file systems.
+contains descriptive information about the filesystems the system can moun=
t.
 .B fstab
 is only read by programs, and not written; it is the duty of the system
-administrator to properly create and maintain this file.  Each filesystem
-is described on a separate line; fields on each line are separated by tabs=
 or
-spaces.  Lines starting with '#' are comments, blank lines are ignored. The
-order of records in
+administrator to properly create and maintain this file.  The order of rec=
ords in
 .B fstab
 is important because
 .BR fsck (8),
@@ -56,27 +53,46 @@ sequentially iterate through
 .B fstab
 doing their thing.
=20
+Each filesystem is described on a separate line.
+Fields on each line are separated by tabs or spaces.
+Lines starting with '#' are comments.  Blank lines are ignored.
+.PP
+The following is a typical example of an
+.B fstab
+entry:
+.sp
+.RS 7
+LABEL=3Dt-home2   /home      ext4    defaults,auto_da_alloc      0  2
+.RE
+
 .B The first field
 .RI ( fs_spec ).
 .RS
 This field describes the block special device or
 remote filesystem to be mounted.
 .LP
-For ordinary mounts it will hold (a link to) a block special
+For ordinary mounts, it will hold (a link to) a block special
 device node (as created by
 .BR mknod (8))
 for the device to be mounted, like `/dev/cdrom' or `/dev/sdb7'.
-For NFS mounts one will have <host>:<dir>, e.g., `knuth.aeb.nl:/'.
-For procfs, use `proc'.
+For NFS mounts, this field is <host>:<dir>, e.g., `knuth.aeb.nl:/'.
+For filesystems with no storage, any string can be used, and will show up =
in
+.BR df (1)
+output, for example.  Typical usage is `proc' for procfs; `mem', `none',
+or `tmpfs' for tmpfs.  Other special filesystems, like udev and sysfs,
+are typically not listed in
+.BR fstab .
 .LP
-Instead of giving the device explicitly, one may indicate
-the filesystem that is to be mounted by its UUID or
-LABEL (cf.
-.BR e2label (8)
+LABEL=3D<label> or UUID=3D<uuid> may be given instead of a device name.
+This is the recommended method, as device names are often a coincidence
+of hardware detection order, and can change when other disks are added or =
removed.
+For example, `LABEL=3DBoot' or `UUID=3D3e6be9de\%-8139\%-11d1\%-9106\%-a43=
f08d823a6'.
+(Use a filesystem-specific tool like
+.BR e2label (8),
+.BR xfs_admin (8),
 or
-.BR xfs_admin (8)),
-writing LABEL=3D<label> or UUID=3D<uuid>,
-e.g., `LABEL=3DBoot' or `UUID=3D3e6be9de\%-8139\%-11d1\%-9106\%-a43f08d823=
a6'.
+.BR fatlabel (8)
+to set LABELs on filesystems).
=20
 It's also possible to use PARTUUID=3D and PARTLABEL=3D. These partitions i=
dentifiers
 are supported for example for GUID Partition Table (GPT).
@@ -86,7 +102,7 @@ See
 .BR blkid (8)
 or
 .BR lsblk (8)
-for more details about devices identifiers.
+for more details about device identifiers.
=20
 .LP
 Note that
@@ -106,9 +122,10 @@ contains spaces these can be escaped as `\\040'.
 .B The third field
 .RI ( fs_vfstype ).
 .RS
-This field describes the type of the filesystem.  Linux supports lots
-of filesystem types, the most common are ext2, ext3, ext4, xfs, btrfs, vfa=
t,
-sysfs, proc, nfs and cifs. For more details, see
+This field describes the type of the filesystem.  Linux supports many
+filesystem types: ext4, xfs, btrfs, f2fs, vfat, ntfs, hfsplus,
+tmpfs, sysfs, proc, iso9660, udf, squashfs, nfs, cifs, and many more.
+For more details, see
 .BR mount (8).
=20
 An entry
@@ -138,14 +155,19 @@ deprecated).
 .RS
 This field describes the mount options associated with the filesystem.
=20
-It is formatted as a comma separated list of options.  It contains at least
-the type of mount plus any additional options appropriate to the filesystem
-type. For documentation on the available mount options, see
-.BR mount (8).
-For documentation on the available swap options, see
+It is formatted as a comma-separated list of options.
+It contains at least the type of mount
+.RB ( ro
+or
+.BR rw ),
+plus any additional options appropriate to the filesystem
+type (including performance-tuning options).
+For details, see
+.BR mount (8)
+or
 .BR swapon (8).
=20
-Basic file system independent options are:
+Basic filesystem-independent options are:
 .TP
 .B defaults
 use default options: rw, suid, dev, exec, auto, nouser, and async.
@@ -171,31 +193,26 @@ do not report errors for this device if it does not e=
xist.
 .B The fifth field
 .RI ( fs_freq ).
 .RS
-This field is used for these filesystems by the
+This field is used by
 .BR dump (8)
-command to determine which filesystems need to be dumped.  If the fifth
-field is not present, a value of zero is returned and
-.B dump
-will assume that the filesystem does not need to be dumped.
+to determine which filesystems need to be dumped.
+Defaults to zero (don't dump) if not present.
 .RE
=20
 .B The sixth field
 .RI ( fs_passno ).
 .RS
-This field is used by the
+This field is used by
 .BR fsck (8)
-program to determine the order in which filesystem checks are done at
-reboot time.  The root filesystem should be specified with a
+to determine the order in which filesystem checks are done at
+boot time.  The root filesystem should be specified with a
 .I fs_passno
-of 1, and other filesystems should have a
+of 1.  Other filesystems should have a
 .I fs_passno
 of 2.  Filesystems within a drive will be checked sequentially, but
 filesystems on different drives will be checked at the same time to utilize
-parallelism available in the hardware.  If the sixth field is not present
-or zero, a value of zero is returned and
-.B fsck
-will assume that the filesystem does not need to be checked.
-.RE
+parallelism available in the hardware.
+Defaults to zero (don't fsck) if not present.
=20
 .SH NOTES
 The proper way to read records from
@@ -207,7 +224,7 @@ or
=20
 The keyword
 .B ignore
-as filesystem type (3rd field) is not more supported by the pure
+as a filesystem type (3rd field) is no longer supported by the pure
 libmount based mount utility (since util-linux v2.22).
=20
 .SH FILES
--=20
2.3.0


--lEGEL1/lMxI0MVQ2--

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iLwEAQEIAAYFAlTtNzEACgkQBaSaEuRa5FMkzgUAlh4aqAzt8e/LOFBsvyWqIm6C
d+VWrJlDykd5Ri6oooqdHlw/Y1aONJz7XSSi2eQSHnCf/2yp+EVjIOyR4z+Adrfi
nFlT+eVLdLuhcohiX02eMRF0sjUJ9eG7g95hCJqNdqxdwmyGYC0u0h9jnlEwXFrt
JVEsKxiOgwM/FGLTx8/iN4X2bHUeUYCY7o9oKJ5kF+OGNSAjprS0oj/5BjFPVA==
=Ngnc
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
