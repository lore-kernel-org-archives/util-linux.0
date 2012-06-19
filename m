Return-Path: marcosfrm@gmail.com
MIME-Version: 1.0
In-Reply-To: <20120619154314.GA20256@x2.net.home>
References: <CAJZVDJCK3Z_u_2TYrFMdjhjNXAJgW2C9rGnwv4RdEkcca92C7Q@mail.gmail.com>
	<20120619142627.GA14727@x2.net.home>
	<4FE090DC.80304@bernhard-voelker.de>
	<20120619154314.GA20256@x2.net.home>
Date: Tue, 19 Jun 2012 17:48:41 -0300
Message-ID: <CAJZVDJBMY9mDV+e6znsxra5_uEH6r9SxryafEaBeneGuU9YSXQ@mail.gmail.com>
Subject: Re: lsblk "include" option?
From: Marcos Felipe Rasia de Mello <marcosfrm@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

2012/6/19 Karel Zak <kzak@redhat.com>:
> On Tue, Jun 19, 2012 at 04:46:52PM +0200, Bernhard Voelker wrote:
>>
>>
>> On 06/19/2012 04:26 PM, Karel Zak wrote:
>> > On Fri, Jun 15, 2012 at 10:09:16AM -0300, Marcos Felipe Rasia de Mello=
 wrote:
>> >> lsblk has an "exclude" (-e, --exclude) option. I wonder if would be
>> >> possible to add an "include" option to tell it to show *only*
>> >> specified major number devices. Like
>> >>
>> >> lsblk -i 8
>> >
>> > =A0Implemented (--include, -I)
>>
>>
>> > diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
>> > index f635a4a..0bcdbfc 100644
>> > --- a/misc-utils/lsblk.c
>> > +++ b/misc-utils/lsblk.c
>> > @@ -142,7 +142,7 @@ static struct colinfo infos[] =3D {
>> >
>> > =A0struct lsblk {
>> > =A0 =A0 =A0 =A0 struct tt *tt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* o=
utput table */
>> > - =A0 =A0 =A0 unsigned int all_devices:1; =A0 =A0 /* print all devices=
 */
>> > + =A0 =A0 =A0 unsigned int all_devices:1; =A0 =A0 /* print all devices=
, icluding empty */
>>
>> s/icluding/including/
>>
>> > @@ -1116,6 +1159,7 @@ static void __attribute__((__noreturn__)) help(F=
ILE *out)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " -d, --nodeps =A0 =A0 =A0 =A0 don't p=
rint slaves or holders\n"
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " -D, --discard =A0 =A0 =A0 =A0print d=
iscard capabilities\n"
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " -e, --exclude <list> exclude devices=
 by major number (default: RAM disks)\n"
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " -i, --include <list> show only devices=
 with specified major numbers\n"
>>
>> s/-i/-I/
>
> Thanks for review!
>
>> BTW: the <list> does not necessarily have to be comma separated;
>> e.g. a dot also works: "lsblk -I 8.11". The same applies to "-e",
>> of course.
>
> Fixed, this is unexpected feature.
>

Thank you both!


Marcos
