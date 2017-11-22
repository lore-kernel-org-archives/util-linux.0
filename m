Return-Path: linux-kernel-owner@vger.kernel.org
Date: Wed, 22 Nov 2017 12:03:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux & FAT32 label
Message-ID: <20171122110352.lzzb7lwfx3cajij3@ws.net.home>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171105130608.5oww3b2fnnrwe7ok@pali>
 <20171109212131.uxraxzwpvrlyfyys@pali>
 <20171119124440.ffxx64zjmwedmtdp@pali>
 <20171120111256.zqvmpzdcf6ncyi5m@ws.net.home>
 <20171122085203.oyvtmbp4hpxnee5e@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171122085203.oyvtmbp4hpxnee5e@pali>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 22, 2017 at 09:52:03AM +0100, Pali Rohár wrote:
> I can prepare patches for blkid (util-linux), but I do not like idea to
> have different algorithm how is read label in fatlabel and blkid. Both
> tools are used by different GUI programs and it is a bad if one GUI
> program on linux (e.g. GParted) tells you that label is A and another
> (e.g. KDE Partition Manager) that label is B. So I rather wait for final
> decision.

Maybe it's time to update all the GUI stuff to read LABELs and UUIDs
(and another attributes) from udev db.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
