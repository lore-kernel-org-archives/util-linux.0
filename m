Return-Path: pali.rohar@gmail.com
Date: Sun, 5 Nov 2017 15:56:03 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>,
	util-linux@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
	Curtis Gedak <gedakc@gmail.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux & FAT32 label
Message-ID: <20171105145603.xbvst6slxa4pz34e@pali>
References: <20171012101311.zfvg6edfvszlujom@ws.net.home>
 <20171012204931.tfd2bhmwu5b6rbpz@pali>
 <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
 <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
 <20171105133929.7cscboxymmpkw634@pali>
 <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
 <20171105140745.ze4ttkazeczrqsy7@pali>
 <CAHp75VfeNj16k_nMmLxVJTWLr=gwFUMXiga6FYmbLb3pvWJxaw@mail.gmail.com>
 <20171105143411.aynz5tr3igobuh6e@pali>
 <CAHp75VfZB4ceK-5KL8Zjz9=2kfkKEpZF+mBfGU3ane5ctHLAfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAHp75VfZB4ceK-5KL8Zjz9=2kfkKEpZF+mBfGU3ane5ctHLAfw@mail.gmail.com>
List-ID: <util-linux.vger.kernel.org>

On Sunday 05 November 2017 16:51:49 Andy Shevchenko wrote:
> In comparison lsblk might output partition label and FS label.
> 
> Looking to blkid help
> 
>        -L, --label label
>              Look  up  the device that uses this filesystem label;
> this is equal to --list-one --output device
>              --match-token LABEL=label.
> 
> So, it can be PARTLABEL as well?
> 
> What the difference of LABEL vs. PARTLABEL for FAT?

LABEL - label of the filesystem
PARTLABEL - label of the partition, supported e.g. by GPT scheme (not by MBR)

So nothing which filesystems in libblkid can set or use.

-- 
Pali Rohár
pali.rohar@gmail.com
