Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] tests: fix fdisk/bsd for alpha
Date: Wed, 16 Mar 2016 16:27:10 +0100
Cc: util-linux@vger.kernel.org, Andreas Henriksson <andreas@fatal.se>
References: <1458088844-23523-1-git-send-email-sweet_f_a@gmx.de> <20160316113741.cdm4hrufcoiki5ae@ws.net.home> <20160316131107.4orceajqir34wavj@ws.net.home>
In-Reply-To: <20160316131107.4orceajqir34wavj@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201603161627.10907.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 16 March 2016, Karel Zak wrote:
> On Wed, Mar 16, 2016 at 12:37:41PM +0100, Karel Zak wrote:
> > On Wed, Mar 16, 2016 at 01:40:44AM +0100, Ruediger Meier wrote:
> > > BTW it was a bad idea to use md5sum. In case of failure it
> > > would be much easier to debug hexdump diffs. Now it's nearly
> > > impossible to collect all these exotic hexdumps.
> >
> >  I'll try to prepare a new test with hexdump, PPC[64] LE/BE should
> >  not be a problem. The rest we can gather later.
>
>  Done, the last missing is Aplha (with special fields in the
> label...).

Thanks! I was really to lazy to refactor this one.

>  The original md5 based test is still in the tree to make a way how
> to verify Alpha output. Maybe it's overkill and we can remove the
> test. Not sure.
>
>  Test it, try it, send patches ;)

Hehe, maybe the only alpha machine on this planet is this Debian build 
host:
https://buildd.debian.org/status/package.php?p=util-linux&suite=experimental

We can wait until Adreas updates the package and copy/paste it from the 
log like I've got that md5sum;)


BTW there are only two more test failures left on sparc:

FAILED (fdisk/id)
--- /<<PKGBUILDDIR>>/tests/expected/fdisk/id
+++ /<<PKGBUILDDIR>>/tests/output/fdisk/id
@@ -1,3 +1,5 @@
 Initialize empty image
 Create MBR with ID=0x1
-Disk identifier: 0x00000001
 Create MBR with ID=0x2
-Disk identifier: 0x00000002


FAILED (fdisk/mbr-nondos-mode)
--- /<<PKGBUILDDIR>>/tests/expected/fdisk/mbr-nondos-mode
+++ /<<PKGBUILDDIR>>/tests/output/fdisk/mbr-nondos-mode
@@ -1,189 +1,203 @@
 Initialize empty image
 8f4e33f3dc3e414ff94e5fb6905cba8c mbr-nondos-mode.img
 Create new DOS partition table
-4e23561dcb81678bb1bd678722c7cbb7 mbr-nondos-mode.img
+8f4e33f3dc3e414ff94e5fb6905cba8c mbr-nondos-mode.img


And we could disable setarch's uname26 test because
# glibc requires kernel >= 3.0, thus setarch --uname-2.6 fails
# on platforms without VDSO

cu,
Rudi
