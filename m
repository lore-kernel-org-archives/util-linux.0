Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932764AbdCaKy0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 31 Mar 2017 06:54:26 -0400
Date: Fri, 31 Mar 2017 12:54:20 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: find device of a known mountpoint
Message-ID: <20170331105420.k7dgpllvk5ojxpvf@ws.net.home>
References: <5f3534af-06b5-9c76-f5e3-9c1d489e570c@gmx.de>
 <20170331091925.mpwmxxk4da4lsegr@ws.net.home>
 <cabd1dc9-8eff-8000-ed3b-39c0463ae376@gmx.de>
 <de1756bf-3e8f-f2db-60ae-179067ff35f4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <de1756bf-3e8f-f2db-60ae-179067ff35f4@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 31, 2017 at 12:41:22PM +0200, Rüdiger Meier wrote:
> On 03/31/2017 12:03 PM, Rüdiger Meier wrote:
> > 
> > 
> > On 03/31/2017 11:19 AM, Karel Zak wrote:
> > > On Fri, Mar 31, 2017 at 11:00:24AM +0200, Rüdiger Meier wrote:
> > > > $ truncate -s100M /tmp/img
> > > > $ losetup /dev/loop0  /tmp/img
> > > > $ mkfs.ext2  /dev/loop0
> > > > 
> > > > $ mkdir /tmp/mnt
> > > > $ ln -s /tmp  /tmp/xyz/symlink
> > > > 
> > > > $ mount /dev/loop0 /tmp/xyz/symlink/mnt
> > > > $ mount | grep loop
> > > > /dev/loop0 on /tmp/mnt type ext2 ...
> > > > 
> > > > 
> > > > I need a command which outputs "/dev/loop0" when
> > > > "/tmp/xyz/symlink/mnt" is
> > > > given.
> > > 
> > >   $ findmnt -no SOURCE /tmp/xyz/symlink/mnt
> > >   /dev/loop0
> > 
> > Thank's. Now I remember that you have told me that already one day. :)
> 
> BTW is there also a way to get "findmnt -n -o SOURCE" working if the
> argument is not a mount point but a regular file on another mount
> point? (In opposite of my initial question.)

$ findmnt --target /home/kzak/.bash_profile 
TARGET SOURCE    FSTYPE OPTIONS
/home  /dev/sda3 ext4   rw,relatime,data=ordered

Note that it's probably better to use (for the previous example) the
option --mountpoint if you want to be sure that the path is
interpreted as mountpoint and never as a regular file.

> I don't like that all these questions here are answered using "df".
> http://unix.stackexchange.com/questions/90252/how-to-get-mount-point-of-filesystem-containing-given-file
> 
> http://unix.stackexchange.com/questions/128471/determine-what-device-a-directory-is-located-on

 Well... :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
