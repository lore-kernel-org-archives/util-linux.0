Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24847 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab3LSK6W (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 19 Dec 2013 05:58:22 -0500
Date: Thu, 19 Dec 2013 11:58:19 +0100
From: Karel Zak <kzak@redhat.com>
To: Aleksey Midenkov <midenok@gmail.com>
Cc: Mikhail Mukovnikov <m.mukovnikov@gmail.com>, util-linux@vger.kernel.org
Subject: Re: Per-filesystem default mount options
Message-ID: <20131219105819.GB21748@x2.net.home>
References: <CAF8BazAW7xxXpO1-vCBJvfvORBLXnJkDxv=qagoe0ZJe-12aJg@mail.gmail.com>
 <CAF8BazDFWf7-NPwCr7Cg=aV9prKsWNUxJu2neZ3x+8XP1fZPHQ@mail.gmail.com>
 <20131018083452.GB15115@x2.net.home>
 <CAF8BazB4jsWj0_3Ns14o5qDF2wVch9_K5u_ZsJ8GwjMyNZb6Uw@mail.gmail.com>
 <20131023152744.GB21504@x2.net.home>
 <CAF8BazA6Q_qECmMe_n8KxkBmXgH_8H1AYGbW4jO1Q2Y2hphcWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF8BazA6Q_qECmMe_n8KxkBmXgH_8H1AYGbW4jO1Q2Y2hphcWA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 13, 2013 at 04:49:00PM +0400, Aleksey Midenkov wrote:
> On Wed, Oct 23, 2013 at 7:27 PM, Karel Zak <kzak@redhat.com> wrote:
> >  If you really need a generic (on device independent solution), then I
> >  don't see a better way than improve libmount for read something
> >  like /etc/mount/<fsname>.conf. The problem is that such feature will
> >  not be usable for non-libmount applications.
> 
> I guess, it is possible to do it in /etc/fstab. This solution would
> bring us additional advantages (f.ex. better readability of /etc/fstab
> itself). An example draft is available here:
> 
> https://github.com/better-oss/util-linux/issues/1#issuecomment-30503845

OK, I have read the discussion.
 
> What are these non-libmount applications? Do they mount without
> /bin/mount invocation? Why would they do this?

/etc/fstab is de-facto standard, we have libc functions to parse this
file, it's used by many applications (mount, fsck, backup tools, etc.). 
 
The mount(2) syscall is directly called for example by systemd (usually 
for pseudo filesystems), for regular filesystem it uses mount(8), but 
it generates units according to entries in the file (for dependencies
etc.), I guess udisks also uses fstab.

In the discussion at github (it's really bad place for such topics:-)
you have suggested:

 /dev/sda2        /              ext4     defaults,errors=remount-ro  0 1
 *                 *             ext4     noatime,discard,nobarrier,iocharset=utf8
 *                 *             vfat     ro,codepage=866,iocharset=utf8

where '*' entries are default mount options. Right?

Notes:

- we really don't need a way how to specify default mount options for
  filesystems *already specified* in fstab (e.g. /dev/sda2). If there
  is an entry for the filesystem than you have to use it for all
  options -- merge two entries ('*' and sda2) to compose the final
  options is bad way.
  
  I really really don't want to change the current semantic how we
  compose mount options for fstab entries. 


- currently we don't read fstab at all if mount(8) command line contains
  all necessary information -- it means source and target. For example:

      mount /dev/sdb2 /mnt

  will not read fstab for mount options although fstab contains 'sdb2'. 
  This is pretty ugly feature in some cases. In the TODO file we have 
  
      --options-mode={ignore,append,prepend,replace}

  to resolve this problem (it's already supported by libmount, but no
  exported to mount(8) command line).


- at the first glance the '*' entries seems like elegant way how to
  avoid filesystem specific /etc/filesystems/<fstype>.conf files, but I
  have still doubts that add a new extension to the fstab is the right
  way. 
  
  If we really need to resolve this issue, then filesystem specific files
  with default mount options will provide more opportunities:

   * not restricted by fstab syntax
   * possible to add another sections for another tasks [fsck, ...]
   * possible to distribute/modify the files independently on fstab
   * backwardly compatible (you don't have to care about systemd,
     udisk, ...)
   * we already have /etc/nfsmount.conf

Again, the problem is to have a way to specify default mount options
for filesystems which are *nowhere* specified and configured so user
has to specify all the options on mount(8) command line now.

> >  I understand the pain for removable media, but for regular disks you
> >  can use /etc/fstab, right?
> 
> Yes, for regular disks usual /etc/fstab is enough.

Well, on many systems udisks mounts removable media, not sure which
role it plays in your proposal.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
