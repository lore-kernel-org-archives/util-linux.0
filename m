Return-Path: pali.rohar@gmail.com
Date: Sun, 5 Nov 2017 14:39:29 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>,
	util-linux@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
	Curtis Gedak <gedakc@gmail.com>
Subject: Re: Linux & FAT32 label
Message-ID: <20171105133929.7cscboxymmpkw634@pali>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171011214426.wa5endlb3kb4yhbv@pali>
 <20171012085658.iwrusvy4ay4s7hbb@ws.net.home>
 <20171012092113.2bsb3pzv6un4xahr@pali>
 <20171012101311.zfvg6edfvszlujom@ws.net.home>
 <20171012204931.tfd2bhmwu5b6rbpz@pali>
 <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
 <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
List-ID: <util-linux.vger.kernel.org>

On Tuesday 31 October 2017 10:35:48 Andy Shevchenko wrote:
> On Mon, Oct 16, 2017 at 4:12 AM, Andreas Bombe <aeb@debian.org> wrote:
> > On Thu, Oct 12, 2017 at 10:49:31PM +0200, Pali Rohár wrote:
> >> On Thursday 12 October 2017 12:13:11 Karel Zak wrote:
> >> > On Thu, Oct 12, 2017 at 11:21:13AM +0200, Pali Rohár wrote:
> >> > > > The best for me is to keep blkid output backwardly compatible as much
> >> > > > as possible :-)
> >> > >
> >> > > Backward compatibility is a good reason. But what with situation when
> >> > > interoperability with other systems (e.g. Windows) does not work as
> >> > > expected?
> >> >
> >> > Then... I'm ready to do the changes to keep interoperability with the
> >> > rest of the universe. It's the same situation as with UDF, you know...
> >>
> >> Apparently situation is not same as with UDF. For UDF we have
> >> specification and basically all known UDF implementation by me were
> >> compatible how to treat label except blkid (which read different think).
> >>
> >> For FAT32 we have 3 different linux implementations (blkid, fatlabel,
> >> mlabel) and every one is slightly different in reading label (see
> >> results sent in previous emails).
> >>
> >> What is first needed to know if implementations are willing to change to
> >> be more or less same. And then decide what we want to change.
> >>
> >> Andreas, as fatlabel maintainer, what do you think about it?
> >>
> >> If you want, I can prepare patches for blkid and fatlabel to mimic
> >> behavior written in proposed solution. But I think it does not make
> >> sense to change just one Linux tool...
> >
> > I was worried that there might be some scripts or programs that expect
> 
> If we really care about such scripts another approach might be to
> introduce a CLI switch to "spec compatible mode" to each tool and
> suggest in documentation to use it.
> 
> There are also variants:
> - spec compatible
> - WinXX compatible
> - DOS compatible
> - etc

I did tests with MS-DOS and Windows versions (results in previous
email), and they seems to be compatible how they read label.

Based on results I would suggest to ignore label from the boot sector
when reading label. This makes behavior consistent with older MS-DOS
systems and also all Windows systems. This change would be a problem
only for users who have label stored only in boot sector. After change
they would not see label anymore -- exactly same what MS-DOS or Windows
show them. Seems that mkdosfs stores label to both location, since
support for label was introduced. So different label would be visible
only for users who used dosfslabel prior to version 3.0.16.

What do you think?

-- 
Pali Rohár
pali.rohar@gmail.com
