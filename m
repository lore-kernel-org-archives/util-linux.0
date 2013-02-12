Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20130212111248.GG20408@x2.net.home>
References: <kf0ehe$q7h$1@ger.gmane.org>
	<CAG27Bk2dO1ztSAy47=j+nmG+v5YuMCBa0i4eorLWw2sFWRT2Pg@mail.gmail.com>
	<51197D69.6050901@gmail.com>
	<20130212111248.GG20408@x2.net.home>
Date: Tue, 12 Feb 2013 11:23:49 +0000
Message-ID: <CAG27Bk109veDrkVetXg5cRSA0TogpbhJ0PwFArRyf=pqQg0zfQ@mail.gmail.com>
Subject: =?windows-1252?Q?Re=3A_lslocks_=96_=22failed_to_parse_pid=3A_=27WRITE=27=22?=
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 12, 2013 at 11:12 AM, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Feb 12, 2013 at 01:23:21AM +0200, Mantas Mikul=C4=97nas wrote:
>> On 2013-02-12 00:42, Sami Kerola wrote:
>> > Karel, and others, what do you think about adding a mode
>> > to output listing which some might say is not a mode at all?
>>
>> Just tested the patch and it works here, but wouldn't it be better to
>> add a "waiting" flag to the mode display, or something like that?
>> ("WAIT-READ" and "WAIT-WRITE"?)
>>
>>
>>
>> Side note: It seems that fs/locks.c:lock_get_status can output many
>> other variations =E2=80=93 e.g. mandatory locks have a third type called
>> "ACCESS", shown when a program tries to simply read/write a locked file;
>> in this case listing the R/W mode might be more useful than "WAITING".
>> Mandatory locks can apparently say "RW" as well, although I haven't
>> found a way to create a "RW" lock yet.
>
>  Yes, IMHO we have to follow kernel and keep the original string in
>  the MODE column.

Perhaps the columns lslocks displays by default should not be changed.
For the blocked locks adding a small markup to MODE field such as ">"
prefix makes sense to me, as it gives a hint to use there is
information in BLOCKED column.

>> Also, while I haven't yet seen this in practice either, the same
>> fs/locks.c can output lock type "LEASE", which has completely different
>> values for the 3rd field, and cannot be represented by a binary
>> "M[andatory] =3D 0/1" column.
>
>  Good point. This should be fixed. I think that lease locks could be
>  also interpreted as mandatory (so "1" should be used in "M" column).
>
>  But you're right that we need something more to describe lease locks
>  -- probably by another column "PROCMODE" (process mode) and use
>  keywords BREAKING, ACTIVE and BREAKER from kernel.
>
>  Maybe we can use the same column to identify blocked flock/posix
>  processes (by BLOCKED keyword) as I described in my previous email.

I quite like the BLOCKED column, especially when it tells what/who is block=
ing.

Almost off topic.

I noticed another small lslocks annoyance. With narrow window 'lslocks
| cat' is truncating lines. IMHO when writing  to pipe command should
ignore window width.

--=20
   Sami Kerola
   http://www.iki.fi/kerolasa/
