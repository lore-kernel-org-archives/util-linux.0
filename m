Return-Path: linux-kernel-owner@vger.kernel.org
Date: Mon, 16 Oct 2017 00:04:50 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>
Subject: Re: Linux & FAT32 label
Message-ID: <20171015220450.gsuwec2auekkqr52@pali>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171011214426.wa5endlb3kb4yhbv@pali>
 <20171015065901.GD3916@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171015065901.GD3916@xo-6d-61-c0.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 15 October 2017 08:59:01 Pavel Machek wrote:
> Hi!
> 
> > Based on results I would propose following unification:
> > 
> ...
> > 4. Prefer label from the root directory. If there is none entry (means
> >    there is also no erased entry), then read label from root sector.
> > 
> >    --> Reason: Windows XP and mlabel ignores what is written in boot
> >        sector. Windows XP even do not update boot sector, so label
> >        stored in boot sector is incorrect after any change done by
> >        Windows XP.
> > 
> >        But due to compatibility with older dosfslabel, which stores
> >        label only to boot sector, there is need for some fallback. Due
> >        to point 1. the best seems to be to process also erased label in
> >        root directory (marked with leading 0xE5) and fallback to boot
> >        sector only in case label in root directory is missing.
> > 
> > What do you think about it?
> 
> 4. seems dangerous. Assume we have "OLD" in boot sector and "0xe5-EW" in the directory
> entry. The label will change from <none> to "OLD" when the directory entry is reused by
> "FOO.TXT", right? That seems surprising / dangerous.

Hm... that is a good question what happen (I do not know). I think that
current situation when Windows XP show different label as Linux is also
_surprising_.

Do you have a better idea what to do and how to handle this situation?

-- 
Pali Rohár
pali.rohar@gmail.com
