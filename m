Return-Path: andihartmann@01019freenet.de
Message-ID: <507EEAB0.7060900@01019freenet.de>
Date: Wed, 17 Oct 2012 19:28:16 +0200
From: Andreas Hartmann <andihartmann@01019freenet.de>
MIME-Version: 1.0
To: =?windows-1252?Q?Luk=E1=9A_Czerner?= <lczerner@redhat.com>
CC: Andreas Hartmann <andihartmann@01019freenet.de>,
        util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: Questions concerning fstrim and online discard.
References: <20121004064736.64caef77@dualc.maya.org> <alpine.LFD.2.00.1210151649540.15261@dhcp-1-104.brq.redhat.com> <507D8B15.5050004@01019freenet.de> <alpine.LFD.2.00.1210162056290.18184@localhost>
In-Reply-To: <alpine.LFD.2.00.1210162056290.18184@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

Lukáš Czerner wrote:
> On Tue, 16 Oct 2012, Andreas Hartmann wrote:
> 
>> Date: Tue, 16 Oct 2012 18:28:05 +0200
>> From: Andreas Hartmann <andihartmann@01019freenet.de>
[...]
>>> Hi Andreas,
>>>
>>> I hope that you realize that using discard with dm_crypt is not
>>> safe.
>>
>> I know about this problem. My understanding is: trim usually writes 0 to
>> the free addresses, hence it is possible to see which addresses are used
>> and which are unused.
> 
> This is not exactly right. TRIM does not write anything to the
> device, but you can read zeroes (or some other values, see bellow) when
> reading previously trimmed blocks. The reason being that when when
> it's tirmmed firmware does not actually need to read data from the flash.
> 
>>
>> The SF-2281 controller seems not to write zero to the addresses, hence
>> the problem shouldn't be with this controller? Or did I got something wrong?
>>
>> cat /sys/block/sda/queue/discard_zeroes_data
>> 0
> 
> That's just one case. IIRC the device can return zeores after trim (which
> will be advertised through sysfs interface), some other deterministic data
> or pseudorandom data. The device would not be able to always return what
> has been there before simply because those blocks might have already been
> reused in wear levelling process, so it has to be substituted. And when it
> comes to cryptography, all those options are bad.

I read a few articles about encryption with SSD. With linux / dm-crypt /
cryptseup luks, plausible deniability isn't given at all because of the
architecture of cryptsetup luks and the not completely crypted disk.

Are there any known successfully carried out attacks (= partition /
filesystem was decryptable by the attacker) on crypted partitions on
SSDs which would have been not successful without TRIM enabled or is it
(as of today :-)) more of theory?



Thanks,
kind regards,
Andreas Hartmann
