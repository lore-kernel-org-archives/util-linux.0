Return-Path: linux-kernel-owner@vger.kernel.org
Date: Mon, 16 Oct 2017 03:12:37 +0200
From: Andreas Bombe <aeb@debian.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrius =?iso-8859-15?Q?=A6tikonas?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>
Subject: Re: Linux & FAT32 label
Message-ID: <20171016011237.ropo5l6cpewrymd6@amos.fritz.box>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171011214426.wa5endlb3kb4yhbv@pali>
 <20171015065901.GD3916@xo-6d-61-c0.localdomain>
 <20171015220450.gsuwec2auekkqr52@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171015220450.gsuwec2auekkqr52@pali>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 16, 2017 at 12:04:50AM +0200, Pali Rohár wrote:
> On Sunday 15 October 2017 08:59:01 Pavel Machek wrote:
> > Hi!
> > 
> > > Based on results I would propose following unification:
> > > 
> > ...
> > > 4. Prefer label from the root directory. If there is none entry (means
> > >    there is also no erased entry), then read label from root sector.
> > > 
> > >    --> Reason: Windows XP and mlabel ignores what is written in boot
> > >        sector. Windows XP even do not update boot sector, so label
> > >        stored in boot sector is incorrect after any change done by
> > >        Windows XP.
> > > 
> > >        But due to compatibility with older dosfslabel, which stores
> > >        label only to boot sector, there is need for some fallback. Due
> > >        to point 1. the best seems to be to process also erased label in
> > >        root directory (marked with leading 0xE5) and fallback to boot
> > >        sector only in case label in root directory is missing.
> > > 
> > > What do you think about it?
> > 
> > 4. seems dangerous. Assume we have "OLD" in boot sector and "0xe5-EW" in the directory
> > entry. The label will change from <none> to "OLD" when the directory entry is reused by
> > "FOO.TXT", right? That seems surprising / dangerous.
> 
> Hm... that is a good question what happen (I do not know). I think that
> current situation when Windows XP show different label as Linux is also
> _surprising_.
> 
> Do you have a better idea what to do and how to handle this situation?

I have been saying this, a deleted directory entry has no valid contents
and its existence should not be considered meaningful. A Windows
formatted FAT filesystem without label will have no root directory label
entry and if an existing label is deleted, that deleted entry can be
overwritten at any time.

"Ignoring the presence of boot sector labels" is the only thing I see
for practical Windows compatibility.
