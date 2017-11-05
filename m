Return-Path: andy.shevchenko@gmail.com
MIME-Version: 1.0
In-Reply-To: <20171105143411.aynz5tr3igobuh6e@pali>
References: <20171012085658.iwrusvy4ay4s7hbb@ws.net.home> <20171012092113.2bsb3pzv6un4xahr@pali>
 <20171012101311.zfvg6edfvszlujom@ws.net.home> <20171012204931.tfd2bhmwu5b6rbpz@pali>
 <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box> <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
 <20171105133929.7cscboxymmpkw634@pali> <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
 <20171105140745.ze4ttkazeczrqsy7@pali> <CAHp75VfeNj16k_nMmLxVJTWLr=gwFUMXiga6FYmbLb3pvWJxaw@mail.gmail.com>
 <20171105143411.aynz5tr3igobuh6e@pali>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 5 Nov 2017 16:51:49 +0200
Message-ID: <CAHp75VfZB4ceK-5KL8Zjz9=2kfkKEpZF+mBfGU3ane5ctHLAfw@mail.gmail.com>
Subject: Re: Linux & FAT32 label
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Andrius_=C5=A0tikonas?= <andrius@stikonas.eu>,
	Curtis Gedak <gedakc@gmail.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 5, 2017 at 4:34 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
> On Sunday 05 November 2017 16:25:54 Andy Shevchenko wrote:
>> On Sun, Nov 5, 2017 at 4:07 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
>> > On Sunday 05 November 2017 15:56:53 Andy Shevchenko wrote:
>> >> On Sun, Nov 5, 2017 at 3:39 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
>> >> > On Tuesday 31 October 2017 10:35:48 Andy Shevchenko wrote:

>> >> > I did tests with MS-DOS and Windows versions (results in previous
>> >> > email), and they seems to be compatible how they read label.
>> >> >
>> >> > Based on results I would suggest to ignore label from the boot sect=
or
>> >> > when reading label.
>> >>
>> >> So, for tools which are not doing that to add
>> >>
>> >>  --ignore-boot-sector-label (or alike) [recommended]
>> >>
>> >> right?
>> >>
>> >> We don't actually know how many users (scripts) are relying on curren=
t
>> >> behaviour.
>> >> If there are only few, we may introduce backward compatibility switch
>> >>
>> >> --read-boot-sector-label

>> > And what to do with blkid? That cannot have any switch :-( and can hav=
e
>> > only one behavior.
>>
>> Btw, I don't see such tool in Debian unstable. Do you mean libblkid ?
>> lsblk OTOH has switches.
>
> https://packages.debian.org/search?suite=3Dsid&arch=3Dany&mode=3Dpath&sea=
rchon=3Dcontents&keywords=3Dblkid
>
> In Debian unstable, that tool is in binary package util-linux.

Found, it required me to be root or use full path.

In comparison lsblk might output partition label and FS label.

Looking to blkid help

       -L, --label label
             Look  up  the device that uses this filesystem label;
this is equal to --list-one --output device
             --match-token LABEL=3Dlabel.

So, it can be PARTLABEL as well?

What the difference of LABEL vs. PARTLABEL for FAT?

> But you are right that implementation is in library libblkid and there
> is no interface between blkid binary and libblkid for passing such
> compatibility switches.
>
> Also more application would use directly libblkid library and not blkid
> binary...

Among other blkid manual has:

...lsblk(8) is also easy to use in scripts.  blkid is mostly designed
for system services and to test libblkid functionality.

which makes me think that we could just change it's behaviour to be sane.

OTOH libblkid is a root of such behaviour.

> And I would say that Karel (as maintainer of the util-linux upstream
> project) does not want to see such switch in blkid just for FAT
> partitions.

For me sane (default) behaviour in this case is to follow what windoze
/ dos does in most (default) cases.

--=20
With Best Regards,
Andy Shevchenko
