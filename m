Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f178.google.com ([209.85.220.178]:54757 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdJaIfu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 31 Oct 2017 04:35:50 -0400
MIME-Version: 1.0
In-Reply-To: <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
References: <20171004153332.GA6696@pali> <20171011212435.znmtdnsxcd5ectub@pali>
 <20171011214426.wa5endlb3kb4yhbv@pali> <20171012085658.iwrusvy4ay4s7hbb@ws.net.home>
 <20171012092113.2bsb3pzv6un4xahr@pali> <20171012101311.zfvg6edfvszlujom@ws.net.home>
 <20171012204931.tfd2bhmwu5b6rbpz@pali> <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 31 Oct 2017 10:35:48 +0200
Message-ID: <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
Subject: Re: Linux & FAT32 label
To: Andreas Bombe <aeb@debian.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Andrius_=C5=A0tikonas?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 16, 2017 at 4:12 AM, Andreas Bombe <aeb@debian.org> wrote:
> On Thu, Oct 12, 2017 at 10:49:31PM +0200, Pali Roh=C3=A1r wrote:
>> On Thursday 12 October 2017 12:13:11 Karel Zak wrote:
>> > On Thu, Oct 12, 2017 at 11:21:13AM +0200, Pali Roh=C3=A1r wrote:
>> > > > The best for me is to keep blkid output backwardly compatible as m=
uch
>> > > > as possible :-)
>> > >
>> > > Backward compatibility is a good reason. But what with situation whe=
n
>> > > interoperability with other systems (e.g. Windows) does not work as
>> > > expected?
>> >
>> > Then... I'm ready to do the changes to keep interoperability with the
>> > rest of the universe. It's the same situation as with UDF, you know...
>>
>> Apparently situation is not same as with UDF. For UDF we have
>> specification and basically all known UDF implementation by me were
>> compatible how to treat label except blkid (which read different think).
>>
>> For FAT32 we have 3 different linux implementations (blkid, fatlabel,
>> mlabel) and every one is slightly different in reading label (see
>> results sent in previous emails).
>>
>> What is first needed to know if implementations are willing to change to
>> be more or less same. And then decide what we want to change.
>>
>> Andreas, as fatlabel maintainer, what do you think about it?
>>
>> If you want, I can prepare patches for blkid and fatlabel to mimic
>> behavior written in proposed solution. But I think it does not make
>> sense to change just one Linux tool...
>
> I was worried that there might be some scripts or programs that expect

If we really care about such scripts another approach might be to
introduce a CLI switch to "spec compatible mode" to each tool and
suggest in documentation to use it.

There are also variants:
- spec compatible
- WinXX compatible
- DOS compatible
- etc

--=20
With Best Regards,
Andy Shevchenko
