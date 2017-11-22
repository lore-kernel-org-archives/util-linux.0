Return-Path: pali.rohar@gmail.com
Date: Wed, 22 Nov 2017 09:52:03 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
	Curtis Gedak <gedakc@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux & FAT32 label
Message-ID: <20171122085203.oyvtmbp4hpxnee5e@pali>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171105130608.5oww3b2fnnrwe7ok@pali>
 <20171109212131.uxraxzwpvrlyfyys@pali>
 <20171119124440.ffxx64zjmwedmtdp@pali>
 <20171120111256.zqvmpzdcf6ncyi5m@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171120111256.zqvmpzdcf6ncyi5m@ws.net.home>
List-ID: <util-linux.vger.kernel.org>

On Monday 20 November 2017 12:12:56 Karel Zak wrote:
> On Sun, Nov 19, 2017 at 01:44:40PM +0100, Pali Rohár wrote:
> > On Thursday 09 November 2017 22:21:31 Pali Rohár wrote:
> > > So from all tests and discussion I would propose new unification:
> > > 
> > > 1. Read label only from the root directory. If label in root directory
> > >    is missing then disk would be treated as without label. Label from
> > >    boot sector would not be read.
> > > 
> > >    --> Reason: Windows XP and mlabel ignores what is written in boot
> > >        sector. Windows XP even do not update boot sector, so label
> > >        stored in boot sector is incorrect after any change done by
> > >        Windows XP.
> > > 
> > >        This logic is used by all tested MS-DOS and Windows versions,
> > >        plus also by mtools on Linux.
> > > 
> > > 2. Write label to to both location, boot sector and root directory.
> > > 
> > >    --> Reason: MS-DOS 6.22, MS-DOS 7.10, Windows 98 and also mtools on
> > >        Linux do this. This is also what is written in FAT specification.
> > > 
> > >        It also provides backward compatibility with old dosfslabel
> > >        versions which read label only from boot sector.
> > > 
> > > 2. Process 'NO NAME    ' label in root directory as 'NO NAME' name. Not
> > >    as empty label.
> > > 
> > >    --> Reason: 'NO NAME    ' is regular entry in root directory and both
> > >        Windows XP and mlabel handle it in this way.
> > > 
> > > 3. Process 'NO NAME    ' label in boot directory as empty label. Not as
> > >    label with name 'NO NAME'.
> > > 
> > >    --> Reason: On Windows XP when formatting empty disk and label is not
> > >        specified then 'NO NAME    ' is stored to boot sector.
> > > 
> > >        Also in FAT specification is written that empty label is stored
> > >        as 'NO NAME    '.
> > > 
> > > With this change we would get compatibility with MS-DOS, Windows (both
> > > DOS-based and NT-based) and also with Linux mtools, modulo problems DOS
> > > code page.
> > > 
> > > There are just two negatives:
> > > 
> > > 1) Labels set by old dosfslabel versions (which stored them only to boot
> > >    sector) would not be visible. But they are already not visible on
> > >    MS-DOS or Windows machines, and also via mlabel (from mtools).
> > > 
> > > 2) Behavior of blkid and fatlabel would be changed as both tools have
> > >    different as proposed above, and based on tests they also differ each
> > >    from other.
> > > 
> > > Andreas, Karel, what do you think about it?
> > 
> > Also for other people, do any have comments on my proposed solution?
> 
> Go ahead and send patch :-) (also with LABEL_FATBOOT=)

Ok, but what with fatlabel (from dosfstools)?
Andreas, any comments on this solution?

I can prepare patches for blkid (util-linux), but I do not like idea to
have different algorithm how is read label in fatlabel and blkid. Both
tools are used by different GUI programs and it is a bad if one GUI
program on linux (e.g. GParted) tells you that label is A and another
(e.g. KDE Partition Manager) that label is B. So I rather wait for final
decision.

-- 
Pali Rohár
pali.rohar@gmail.com
