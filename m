Return-Path: pali.rohar@gmail.com
Date: Thu, 23 Nov 2017 10:01:40 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
	Curtis Gedak <gedakc@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux & FAT32 label
Message-ID: <20171123090140.dojgfgnvxbqckvq4@pali>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171105130608.5oww3b2fnnrwe7ok@pali>
 <20171109212131.uxraxzwpvrlyfyys@pali>
 <20171119124440.ffxx64zjmwedmtdp@pali>
 <20171120111256.zqvmpzdcf6ncyi5m@ws.net.home>
 <20171122085203.oyvtmbp4hpxnee5e@pali>
 <20171122110352.lzzb7lwfx3cajij3@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171122110352.lzzb7lwfx3cajij3@ws.net.home>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 22 November 2017 12:03:52 Karel Zak wrote:
> On Wed, Nov 22, 2017 at 09:52:03AM +0100, Pali Rohár wrote:
> > I can prepare patches for blkid (util-linux), but I do not like idea to
> > have different algorithm how is read label in fatlabel and blkid. Both
> > tools are used by different GUI programs and it is a bad if one GUI
> > program on linux (e.g. GParted) tells you that label is A and another
> > (e.g. KDE Partition Manager) that label is B. So I rather wait for final
> > decision.
> 
> Maybe it's time to update all the GUI stuff to read LABELs and UUIDs
> (and another attributes) from udev db.

This is just one side of coin. Another is that these GUI applications
needs to set/change labels, UUIDs, ... What udev/blkid does not support.

-- 
Pali Rohár
pali.rohar@gmail.com
