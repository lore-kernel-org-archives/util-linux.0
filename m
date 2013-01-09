Return-Path: linux-btrfs-owner@vger.kernel.org
Date: Wed, 9 Jan 2013 19:10:22 +0100
From: Karel Zak <kzak@redhat.com>
To: kreijack@inwind.it
Cc: util-linux@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Mason <chris.mason@fusionio.com>,
        Chris Murphy <lists@colorremedies.com>
Subject: Re: Btrfs: wipe all the superblock [redhat bugzilla 889888]
Message-ID: <20130109181022.GA1372@x2.net.home>
References: <50E9C267.3050302@inwind.it>
 <20130108164314.GA9177@x2.net.home>
 <50EDAD6C.4050901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50EDAD6C.4050901@gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 09, 2013 at 06:48:28PM +0100, Goffredo Baroncelli wrote:
> Hi Karel,
> 
> > 
> >  You can specify more than one magic strings for the same filesystem,
> >  the .magics = { } is array.
> 
> thanks for you suggestion. However this seems to me not applicable. I
> tried to change the code, and what I got to me seems inconsistently:
> 
> Whit this change
> 
> 1) if I do "wipefs <device>", I got the offset of the first superblock
> (good enough)
> 2) if I do "wipefs -a <device>", I clean-up *all three* superblocks
> (very good)
> 3) if I do "wipefs -o <offset> <device>", I clean-up only the superblock
> located at <offset> (very bad)

 this is expected behavior described in wipefs man page:

Note  that  some  filesystems  or  some partition tables store more
magic strings on the devices. The wipefs lists the first offset where
a magic string has been detected. The device is not  scanned  for
additional magic strings for the same filesystem. It's possible that
after wipefs -o <offset> will be the same filesystem or partition
table visible by another magic string on another offset.

> If the user doesn't know enough btrfs, trying 1) and 3) could think that
> the disk is cleaned-up. Instead the 2nd and the 3rd super-blocks still
> exist.

 well, users (and installers) usually use wipefs -a or wipefs -t <fsname>

> >  see for example libblkid/src/superblocks/reiserfs.c 
> 
> I think that this is a different case: the reiser superblocks are

 it was example how to specify the magic strings in the code

> *alternative*; instead in the btrfs case, *all the three superblocks*
> exist at the same time.

 this is pretty common to have backup superblock (e.g. GPT) or more
 ways how to detect the filesystem (e.g. FAT).

 Please, send me the patch with the magic strings :-)
 
 I really don't want to add dummy filesystems to the library (like you
 did in the first version of the patch) -- it's very bad idea with
 many side effects.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
