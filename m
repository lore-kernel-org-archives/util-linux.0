Return-Path: linux-kernel-owner@vger.kernel.org
Date: Thu, 12 Oct 2017 22:49:31 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>
Cc: util-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>
Subject: Re: Linux & FAT32 label
Message-ID: <20171012204931.tfd2bhmwu5b6rbpz@pali>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171011214426.wa5endlb3kb4yhbv@pali>
 <20171012085658.iwrusvy4ay4s7hbb@ws.net.home>
 <20171012092113.2bsb3pzv6un4xahr@pali>
 <20171012101311.zfvg6edfvszlujom@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171012101311.zfvg6edfvszlujom@ws.net.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 12 October 2017 12:13:11 Karel Zak wrote:
> On Thu, Oct 12, 2017 at 11:21:13AM +0200, Pali Rohár wrote:
> > > The best for me is to keep blkid output backwardly compatible as much
> > > as possible :-)
> > 
> > Backward compatibility is a good reason. But what with situation when
> > interoperability with other systems (e.g. Windows) does not work as
> > expected?
> 
> Then... I'm ready to do the changes to keep interoperability with the
> rest of the universe. It's the same situation as with UDF, you know...

Apparently situation is not same as with UDF. For UDF we have
specification and basically all known UDF implementation by me were
compatible how to treat label except blkid (which read different think).

For FAT32 we have 3 different linux implementations (blkid, fatlabel,
mlabel) and every one is slightly different in reading label (see
results sent in previous emails).

What is first needed to know if implementations are willing to change to
be more or less same. And then decide what we want to change.

Andreas, as fatlabel maintainer, what do you think about it?

If you want, I can prepare patches for blkid and fatlabel to mimic
behavior written in proposed solution. But I think it does not make
sense to change just one Linux tool...

-- 
Pali Rohár
pali.rohar@gmail.com
