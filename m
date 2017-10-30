Return-Path: linux-kernel-owner@vger.kernel.org
Date: Mon, 30 Oct 2017 16:35:22 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>, Andreas Bombe <aeb@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: Changing FAT label of mounted file system
Message-ID: <20171030153522.gaf22di5r5c4hjfo@pali>
References: <201709051614.58774@pali>
 <87a8295fbl.fsf@devron>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87a8295fbl.fsf@devron>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 06 September 2017 00:35:10 OGAWA Hirofumi wrote:
> Pali Rohár <pali.rohar@gmail.com> writes:
> 
> > Hello!
> 
> Hi,
> 
> > On most file system it is possible to change its label at anytime, when 
> > mounted or unmounted. But FAT is such special file system on which is 
> > label stored in two location, plus one is in directory structure (which 
> > cannot be modified when file system is mounted).
> >
> > I would like to ask what about providing FAT specific IOCTL for vfat 
> > kernel driver which would allow to change volume label?
> 
> I have no objection to add this ioctl though, there is really needs of
> apps?

Lets ask other people, maintainers of the GUI & command line tools which
are already used by lot of users.

Andrius, Curtis and Andreas, what do you think?

> For example, ext4's volume name is sb->s_volume_name, right? And no
> ioctl to change it, so I guess the app does read-modify-write
> superblock. If so, there is theoretical race with umount and super block
> update of ext4 (yes, although updating superblock is rare timing).  So
> ext4 is unsafe actually to rewrite volume_name on the mounted fs.

You are right. But IIRC in the worst case label of ext4 would not be
changed (overwritten by the old label when kernel ext4 driver changes
superblock).

> Well, anyway, if there is the patch to add ioctl, again, I have no
> objection.
> 
> Thanks.

-- 
Pali Rohár
pali.rohar@gmail.com
