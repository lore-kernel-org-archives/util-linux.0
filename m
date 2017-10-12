Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbdJLI5D (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 12 Oct 2017 04:57:03 -0400
Date: Thu, 12 Oct 2017 10:56:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>
Subject: Re: Linux & FAT32 label
Message-ID: <20171012085658.iwrusvy4ay4s7hbb@ws.net.home>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171011214426.wa5endlb3kb4yhbv@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171011214426.wa5endlb3kb4yhbv@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 11, 2017 at 11:44:26PM +0200, Pali Rohár wrote:
> On Wednesday 11 October 2017 23:24:35 Pali Rohár wrote:
> > On Wednesday 04 October 2017 17:33:32 Pali Rohár wrote:
> > > Hi! There is a big inconsistency in Linux tools which read or write
> > > FAT32 label in filesystem images. The most common used are tools:
> > > blkid (from util-linux project), fatlabel (previously known as
> > > dosfslabel; from dosfstools project) and mlabel (from mtools project).
> > > 
> > > FAT32 is itself a big mess from Microsoft hell and even FAT32
> > > implementation in Microsoft Windows systems is not compliant to the
> > > released FAT32 documentation from Microsoft.
> > > 
> > > In past months I observed that Linux FAT32 tools has its own way how
> > > they interpret FAT32 label (known as volume id) and because every GUI
> > > application uses one of those low-level command line tool, it is a big
> > > mess if one application say that FAT32 label is A and another that it is
> > > B. And then Windows XP say, it is C.
> > > 
> > > I would like to open discussion if it would be possible to change
> > > behavior how blkid (from util-linux project) and fatlabel (from
> > > dosfstool project) handle FAT32 label. Ideally to report exactly same
> > > output.

The stuff in blkid is not "how we believe that FAT should be handled",
but "what users expect" :-) There is nothing like FAT standard and
unfortunately on may disks and USB devices is huge number FATS created
by many 3rd-party tools. For me the LABEL is not so important, the most
important is to keep libblkid ability to detect all the crazy FATs.

> Based on results I would propose following unification:
> 
> 1. If there is entry for label in root directory, including erased entry
>    which starts with 0xE5, then do *not* process boot entry.
> 
>    --> Reason: Setting label to empty on Windows XP just marks label in
>        root directory as erased (set first byte to 0xE5) and it does not
>        touch boot sector when label can be always old. Test case is in
>        file fat32_mkdosfs_label1_xp_erase.
> 
>        Same behavior can be seen in mlabel.
> 
> 2. Process 'NO NAME    ' label in root directory as 'NO NAME' name. Not
>    as empty label.
> 
>    --> Reason: 'NO NAME    ' is regular entry in root directory and both
>        Windows XP and mlabel handle it in this way.
> 
> 3. Process 'NO NAME    ' label in boot directory as empty label. Not as
>    label with name 'NO NAME'.

I prefer this solution. The label also means entry in udev DB, symlink
somewhere in /dev, field in lsblk output, etc. I'd like to avoid "NO
NAME" everywhere in the system (especially if you have more than one
device with this "label"). The "NO NAME" dummy label provides zero
value to end users.

>    --> Reason: On Windows XP when formatting empty disk and label is not
>        specified then 'NO NAME    ' is stored to boot directory.
> 
> 4. Prefer label from the root directory. If there is none entry (means
>    there is also no erased entry), then read label from root sector.
> 
>    --> Reason: Windows XP and mlabel ignores what is written in boot
>        sector. Windows XP even do not update boot sector, so label
>        stored in boot sector is incorrect after any change done by
>        Windows XP.
> 
>        But due to compatibility with older dosfslabel, which stores
>        label only to boot sector, there is need for some fallback. Due
>        to point 1. the best seems to be to process also erased label in
>        root directory (marked with leading 0xE5) and fallback to boot
>        sector only in case label in root directory is missing.
> 
> What do you think about it?

The best for me is to keep blkid output backwardly compatible as much
as possible :-)

Note that the current version is v2.31-rc, you use pretty old v2.20 in
your tests.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
