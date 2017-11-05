Return-Path: andy.shevchenko@gmail.com
MIME-Version: 1.0
In-Reply-To: <20171105140745.ze4ttkazeczrqsy7@pali>
References: <20171011212435.znmtdnsxcd5ectub@pali> <20171011214426.wa5endlb3kb4yhbv@pali>
 <20171012085658.iwrusvy4ay4s7hbb@ws.net.home> <20171012092113.2bsb3pzv6un4xahr@pali>
 <20171012101311.zfvg6edfvszlujom@ws.net.home> <20171012204931.tfd2bhmwu5b6rbpz@pali>
 <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box> <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
 <20171105133929.7cscboxymmpkw634@pali> <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
 <20171105140745.ze4ttkazeczrqsy7@pali>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 5 Nov 2017 16:25:54 +0200
Message-ID: <CAHp75VfeNj16k_nMmLxVJTWLr=gwFUMXiga6FYmbLb3pvWJxaw@mail.gmail.com>
Subject: Re: Linux & FAT32 label
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Andrius_=C5=A0tikonas?= <andrius@stikonas.eu>,
	Curtis Gedak <gedakc@gmail.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 5, 2017 at 4:07 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
> On Sunday 05 November 2017 15:56:53 Andy Shevchenko wrote:
>> On Sun, Nov 5, 2017 at 3:39 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
>> > On Tuesday 31 October 2017 10:35:48 Andy Shevchenko wrote:
>> >> On Mon, Oct 16, 2017 at 4:12 AM, Andreas Bombe <aeb@debian.org> wrote=
:
>> >> > On Thu, Oct 12, 2017 at 10:49:31PM +0200, Pali Roh=C3=A1r wrote:
>> >> >> On Thursday 12 October 2017 12:13:11 Karel Zak wrote:
>>
>> >> > I was worried that there might be some scripts or programs that exp=
ect
>> >>
>> >> If we really care about such scripts another approach might be to
>> >> introduce a CLI switch to "spec compatible mode" to each tool and
>> >> suggest in documentation to use it.
>> >>
>> >> There are also variants:
>> >> - spec compatible
>> >> - WinXX compatible
>> >> - DOS compatible
>> >> - etc
>> >
>> > I did tests with MS-DOS and Windows versions (results in previous
>> > email), and they seems to be compatible how they read label.
>> >
>> > Based on results I would suggest to ignore label from the boot sector
>> > when reading label.
>>
>> So, for tools which are not doing that to add
>>
>>  --ignore-boot-sector-label (or alike) [recommended]
>>
>> right?
>>
>> We don't actually know how many users (scripts) are relying on current
>> behaviour.
>> If there are only few, we may introduce backward compatibility switch
>>
>> --read-boot-sector-label
>
> Current behavior of the last blkid and fatlabel tools is: Try to read
> label from the root directory. If it does not exist, then fallback to
> label stored in boot sector. And when fatlabel is changing label it
> updates both locations.
>
> So tools which already uses fatlabel for get & set operations should not
> be affected as setting new label makes boot and root in sync.
>
> New proposed behavior is: Try to read label from the root directory. If
> not exist, then treat disk as without label.
>
> As in current behavior there is no way via fatlabel to read "just only
> label from boot sector", I think that problems for current scripts is
> minimal.
>
> What about making this new behavior in fatlabel as default with new
> switch --fallback-to-boot-sector (switch to current behavior) or
> --read-only-boot-sector (ignores label in root directory) for people who
> are interested in label stored in boot sector?

Dunno how others will react, but I think what you are proposing makes sense=
.

> And what to do with blkid? That cannot have any switch :-( and can have
> only one behavior.

Btw, I don't see such tool in Debian unstable. Do you mean libblkid ?
lsblk OTOH has switches.

>> > This makes behavior consistent with older MS-DOS
>> > systems and also all Windows systems. This change would be a problem
>> > only for users who have label stored only in boot sector. After change
>> > they would not see label anymore -- exactly same what MS-DOS or Window=
s
>> > show them. Seems that mkdosfs stores label to both location, since
>> > support for label was introduced. So different label would be visible
>> > only for users who used dosfslabel prior to version 3.0.16.
>> >
>> > What do you think?
>>
>> So, in summary it looks like a documentation needs update (to mark
>> your research).
>
> Which documentation do you mean?

At least dosfstools (to mark that versions prior 3.0.16 better to avoid).

And any where new switch would have been added and / or default
behaviour would have been changed.

--=20
With Best Regards,
Andy Shevchenko
