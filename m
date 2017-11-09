Return-Path: linux-kernel-owner@vger.kernel.org
Date: Thu, 9 Nov 2017 09:59:09 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux & FAT32 label
Message-ID: <20171109085909.b6b5m35qeul3orrx@pali>
References: <20171012101311.zfvg6edfvszlujom@ws.net.home>
 <20171012204931.tfd2bhmwu5b6rbpz@pali>
 <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
 <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
 <20171105133929.7cscboxymmpkw634@pali>
 <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
 <20171105140745.ze4ttkazeczrqsy7@pali>
 <CAHp75VfeNj16k_nMmLxVJTWLr=gwFUMXiga6FYmbLb3pvWJxaw@mail.gmail.com>
 <20171105143411.aynz5tr3igobuh6e@pali>
 <20171106101444.m5kxevutsdxx34kl@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171106101444.m5kxevutsdxx34kl@ws.net.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 06 November 2017 11:14:44 Karel Zak wrote:
> On Sun, Nov 05, 2017 at 03:34:11PM +0100, Pali Rohár wrote:
> > On Sunday 05 November 2017 16:25:54 Andy Shevchenko wrote:
> > > On Sun, Nov 5, 2017 at 4:07 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > On Sunday 05 November 2017 15:56:53 Andy Shevchenko wrote:
> > > >> On Sun, Nov 5, 2017 at 3:39 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > > >> > On Tuesday 31 October 2017 10:35:48 Andy Shevchenko wrote:
> > > >> >> On Mon, Oct 16, 2017 at 4:12 AM, Andreas Bombe <aeb@debian.org> wrote:
> > > >> >> > On Thu, Oct 12, 2017 at 10:49:31PM +0200, Pali Rohár wrote:
> > > >> >> >> On Thursday 12 October 2017 12:13:11 Karel Zak wrote:
> > > >>
> > > >> >> > I was worried that there might be some scripts or programs that expect
> > > >> >>
> > > >> >> If we really care about such scripts another approach might be to
> > > >> >> introduce a CLI switch to "spec compatible mode" to each tool and
> > > >> >> suggest in documentation to use it.
> > > >> >>
> > > >> >> There are also variants:
> > > >> >> - spec compatible
> > > >> >> - WinXX compatible
> > > >> >> - DOS compatible
> > > >> >> - etc
> > > >> >
> > > >> > I did tests with MS-DOS and Windows versions (results in previous
> > > >> > email), and they seems to be compatible how they read label.
> > > >> >
> > > >> > Based on results I would suggest to ignore label from the boot sector
> > > >> > when reading label.
> > > >>
> > > >> So, for tools which are not doing that to add
> > > >>
> > > >>  --ignore-boot-sector-label (or alike) [recommended]
> > > >>
> > > >> right?
> > > >>
> > > >> We don't actually know how many users (scripts) are relying on current
> > > >> behaviour.
> > > >> If there are only few, we may introduce backward compatibility switch
> > > >>
> > > >> --read-boot-sector-label
> 
> The current recommended way how to get filesystem label is to read it
> from udev db. For example this is the way how lsblk reads labels by
> default.
> 
> And udevd and some another tools are linked with libblkid. I don't
> see an elegant way how to support something like "read-boot-sector-label" 
> switch for the library to switch it on the fly.
> 
> Maybe it would be good enough to change the default behavior and add 
> #ifdef to the library to switch to the old behavior. This is elegant
> way how to move the decision to downstream maintainers. They have more
> clue about importance of the FAT32 usage. I can imagine that for example
> for some embedded systems it's more important than for example for
> Fedora desktop. I prefer this solution.
> 
> The another way is to add an option to blkid.conf, but it will make
> filesystems probing more complex and slow (we don't read the file
> during superblocks probing now). I'm sure udev guys will hate me with
> this solution. I'd like to avoid something like this.

What about exporting e.g. BOOT_LABEL field from libblkid for vfat disks?
LABEL (which is shown to user, e.g. in GUI) would be that one from root
directory (same which is used by label on MS-DOS and Windows) and
BOOT_LABEL would be from boot sector. If somebody really needs to know
current label stored in boot sector he would be able to do it via blkid.
Also it would be possible then via blkid to read exact label stored in
root directory and also read what is stored in boot sector. Because
currently it is not possible to know from which location LABEL comes
from.

-- 
Pali Rohár
pali.rohar@gmail.com
