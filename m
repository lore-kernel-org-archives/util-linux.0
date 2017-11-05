Return-Path: andy.shevchenko@gmail.com
MIME-Version: 1.0
In-Reply-To: <20171105133929.7cscboxymmpkw634@pali>
References: <20171004153332.GA6696@pali> <20171011212435.znmtdnsxcd5ectub@pali>
 <20171011214426.wa5endlb3kb4yhbv@pali> <20171012085658.iwrusvy4ay4s7hbb@ws.net.home>
 <20171012092113.2bsb3pzv6un4xahr@pali> <20171012101311.zfvg6edfvszlujom@ws.net.home>
 <20171012204931.tfd2bhmwu5b6rbpz@pali> <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
 <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com> <20171105133929.7cscboxymmpkw634@pali>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 5 Nov 2017 15:56:53 +0200
Message-ID: <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
Subject: Re: Linux & FAT32 label
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Andrius_=C5=A0tikonas?= <andrius@stikonas.eu>,
	Curtis Gedak <gedakc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 5, 2017 at 3:39 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
> On Tuesday 31 October 2017 10:35:48 Andy Shevchenko wrote:
>> On Mon, Oct 16, 2017 at 4:12 AM, Andreas Bombe <aeb@debian.org> wrote:
>> > On Thu, Oct 12, 2017 at 10:49:31PM +0200, Pali Roh=C3=A1r wrote:
>> >> On Thursday 12 October 2017 12:13:11 Karel Zak wrote:

>> > I was worried that there might be some scripts or programs that expect
>>
>> If we really care about such scripts another approach might be to
>> introduce a CLI switch to "spec compatible mode" to each tool and
>> suggest in documentation to use it.
>>
>> There are also variants:
>> - spec compatible
>> - WinXX compatible
>> - DOS compatible
>> - etc
>
> I did tests with MS-DOS and Windows versions (results in previous
> email), and they seems to be compatible how they read label.
>
> Based on results I would suggest to ignore label from the boot sector
> when reading label.

So, for tools which are not doing that to add

 --ignore-boot-sector-label (or alike) [recommended]

right?

We don't actually know how many users (scripts) are relying on current
behaviour.
If there are only few, we may introduce backward compatibility switch

--read-boot-sector-label

> This makes behavior consistent with older MS-DOS
> systems and also all Windows systems. This change would be a problem
> only for users who have label stored only in boot sector. After change
> they would not see label anymore -- exactly same what MS-DOS or Windows
> show them. Seems that mkdosfs stores label to both location, since
> support for label was introduced. So different label would be visible
> only for users who used dosfslabel prior to version 3.0.16.
>
> What do you think?

So, in summary it looks like a documentation needs update (to mark
your research).

--=20
With Best Regards,
Andy Shevchenko
