Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36094 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945959AbWLVHws (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 02:52:48 -0500
Date: Fri, 22 Dec 2006 08:52:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Bryan Henderson <bryanh@giraffe-data.com>
Cc: ethanol@armory.com, ams@gnu.org, P@draigbrady.com, acahalan@gmail.com,
        util-linux-ng@vger.kernel.org
Subject: Re: splitting util-linux (was: kill)
Message-ID: <20061222075240.GR5971@petra.dvoda.cz>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com> <20061220085706.GH5971@petra.dvoda.cz> <45890A78.1030105@draigBrady.com> <20061220104547.GJ5971@petra.dvoda.cz> <20061220214503.0BB4744007@Psilocybe.Update.UU.SE> <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com> <20061221215312.GP5971@petra.dvoda.cz> <42767.bryanh@giraffe-data.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42767.bryanh@giraffe-data.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 22, 2006 at 06:44:21AM +0000, Bryan Henderson wrote:
> > That's not 100% true. You need upstream and downstream maintainer for
> > every package. You need an infrastructure (scm, mailing list, ...)
> > for every package. Maybe it seems like something simple (10 clicks at
> > sf.net), but my experience is completely different. Maintainig is
> > really boring work and after few months nobody wants to do it... 
> > 
> > Number of well maintained packages is not so big. Believe me, people
> > who work on Linux distributions fight with unmaintained projects every
> > day.
> 
> If you're willing to do all that work for all of the components of
> util-linux, or alternatively if most of the components simply don't
> require any maintenance, then the labor-distributing advantage of
> splitting isn't there.  And you've obviously determined that you can

 Yes.

> distribute one big package more easily than lots of little ones
> (myself, I've found the opposite -- I split things up into independent
> parts so that I can release in smaller doses).

 Frankly, maybe 90% of utils in util-linux needn't any real development or
 fixing. These utils are stable for really long time.

 My experience (last two years) is that almost all bug reports are
 about the mount/losetup, login, fdisk and man pages. Also the
 problematic part of the package is NFS code -- but it will be removed
 to nfs-utils (already done in FC6/RHEL5).

 For example list of patches from Fedora Core 6:

        floppy-0.12-locale.patch
        util-linux-2.11y-chsh-103004.patch
        util-linux-2.11y-fdisksegv-103954.patch
        util-linux-2.11y-multibyte.patch
        util-linux-2.11y-procpartitions-37436.patch
        util-linux-2.11y-skipraid2.patch
        util-linux-2.12a-126572-fdiskman.patch
        util-linux-2.12a-16415-rdevman.patch
        util-linux-2.12a-ipcs-84243-86285.patch
        util-linux-2.12a-mountbylabel-dm.patch
        util-linux-2.12a-mount-man-cifs.patch
        util-linux-2.12a-pamsession.patch
        util-linux-2.12a-pamstart.patch
        util-linux-2.12a-partlimit.patch
        util-linux-2.12j-113790-hotkeys.patch
        util-linux-2.12j-managed.patch
        util-linux-2.12j-pamconsole.patch
        util-linux-2.12p-cal-wide.patch
        util-linux-2.12p-col-EILSEQ.patch
        util-linux-2.12p-execl.patch
        util-linux-2.12p-fdformat-ide.patch
        util-linux-2.12p-floppy-generic.patch
        util-linux-2.12p-fstab-man.patch
        util-linux-2.12p-ipcs-typo.patch
        util-linux-2.12p-login-lastlog.patch
        util-linux-2.12p-look-separator.patch
        util-linux-2.12p-lvm2dupes-76467.patch
        util-linux-2.12p-mount-ocfs2.patch
        util-linux-2.12p-mtab-lock.patch
        util-linux-2.12p-swaponsymlink-57300.patch
        util-linux-2.12p-vipw-perm.patch
        util-linux-2.13-arch.patch
        util-linux-2.13-audit-hwclock.patch
        util-linux-2.13-audit-login.patch
        util-linux-2.13-cal-wide.patch
        util-linux-2.13-cramfs-maxentries.patch
        util-linux-2.13-cramfs-zerofiles.patch
        util-linux-2.13-ctrlaltdel-man.patch
        util-linux-2.13-ctty3.patch
        util-linux-2.13-fdisk-b-4096.patch
        util-linux-2.13-fdisk-gpt.patch
        util-linux-2.13-fdisk-isfull.patch
        util-linux-2.13-fdisk-sectors.patch
        util-linux-2.13-hexdump-gcc.patch
        util-linux-2.13-ipcs-shmax.patch
        util-linux-2.13-login-hang.patch
        util-linux-2.13-login-ipv6.patch
        util-linux-2.13-login-pam-acct.patch
        util-linux-2.13-login-timeval.patch
        util-linux-2.13-losetup-all.patch
        util-linux-2.13-losetup-deprecated.patch
        util-linux-2.13-losetup-rdonly.patch
        util-linux-2.13-mkswap-mounted.patch
        util-linux-2.13-mkswap-selinux.patch
        util-linux-2.13-more-CLOEXEC.patch
        util-linux-2.13-moretc.patch
        util-linux-2.13-mount-comment.patch
        util-linux-2.13-mount-context.patch
        util-linux-2.13-mount-man-bugs.patch
        util-linux-2.13-mount-man-nfs4.patch
        util-linux-2.13-mount-man-nfs.patch
        util-linux-2.13-mount-move.patch
        util-linux-2.13-mount-nonfs.patch
        util-linux-2.13-mount-sloppy.patch
        util-linux-2.13-mount-subtree.patch
        util-linux-2.13-mount-twiceloop.patch
        util-linux-2.13-mount-uhelper.patch
        util-linux-2.13-mount-uuid.patch
        util-linux-2.13-namei-logic.patch
        util-linux-2.13-rmparts.patch
        util-linux-2.13-schedutils-man.patch
        util-linux-2.13-schedutils-SCHED_BATCH.patch
        util-linux-2.13-swapon-suspend.patch
        util-linux-2.13-swap-page.patch
        util-linux-2.13-umount-sysfs.patch


 [Not all will be ever merged with upstream of course, there're RH
 specific patches too]
 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
