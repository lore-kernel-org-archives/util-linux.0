Return-Path: util-linux-owner@vger.kernel.org
Received: from mout0.freenet.de ([195.4.92.90]:55014 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629Ab2JPQa0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Oct 2012 12:30:26 -0400
Message-ID: <507D8B15.5050004@01019freenet.de>
Date: Tue, 16 Oct 2012 18:28:05 +0200
From: Andreas Hartmann <andihartmann@01019freenet.de>
MIME-Version: 1.0
To: =?windows-1252?Q?Luk=E1=9A_Czerner?= <lczerner@redhat.com>
CC: Andreas Hartmann <andihartmann@01019freenet.de>,
        util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: Questions concerning fstrim and online discard.
References: <20121004064736.64caef77@dualc.maya.org> <alpine.LFD.2.00.1210151649540.15261@dhcp-1-104.brq.redhat.com>
In-Reply-To: <alpine.LFD.2.00.1210151649540.15261@dhcp-1-104.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Lukas!

I'm really happy about your detailed comments! Thanks a lot!

On Tue, 16 Oct 2012, Andreas Hartmann wrote: Lukáš Czerner wrote:
> On Thu, 4 Oct 2012, Andreas Hartmann wrote:
> 
>> Date: Thu, 4 Oct 2012 06:47:36 +0200
>> From: Andreas Hartmann <andihartmann@01019freenet.de>
>> To: util-linux@vger.kernel.org
>> Subject: Questions concerning fstrim and online discard.
>> Resent-Date: Mon, 15 Oct 2012 16:10:43 +0200
>> Resent-From: Karel Zak <kzak@redhat.com>
>> Resent-To: Lukas Czerner <lczerner@redhat.com>
>>
>> Hello!
>>
>> Please, may I ask you some questions because I'm a little bit confused
>> about the behaviour of fstrim and online discard (ext4)?
>>
>>
>> I'm using the following configuration / partitioning with a SSD
>> (Controller: SF-2281; Corsair Force GT 240GB):
>>
>> - dm_crypt: cryptsetup luksOpen - version 1.4.1, device-mapper
>>   version 1.02.75
> 
> Hi Andreas,
> 
> I hope that you realize that using discard with dm_crypt is not
> safe.

I know about this problem. My understanding is: trim usually writes 0 to
the free addresses, hence it is possible to see which addresses are used
and which are unused.

The SF-2281 controller seems not to write zero to the addresses, hence
the problem shouldn't be with this controller? Or did I got something wrong?

cat /sys/block/sda/queue/discard_zeroes_data
0

> 
>> - lvm version 2.02.96
>> - ext4, option discard; kernel version 3.4.11
>>
>> All seems to work fine, I can't see any errors in messages or in dmesg
>> according trim / discard.
> 
> The question is what kernel version do you use ?

3.4.11 :-)

> Currnently we will
> ignore all errors coming from the online discard including the
> situation where the device does not support discard.
> 
> This is not exactly ideal, because we should really inform user that
> there was an error.

Yes, this would be really important!

> However we should _NOT_ inform user about every
> discard request failed with EOPNOTSUPP because we can have
> multi-disk devices where some of the devices support discard and
> some of the does not, this is perfectly valid situation and kernel
> should not scream.

Once at the moment the device is mounted would be enough.

> Nevertheless I am going to change things so that we inform use about
> problem (other than EOPNOTSUPP). And maybe warn once a day that
> part, or whole device does not support discard at all - I think that
> this should not hurt.
> 
>>
>> Now, I tested fstrim from util-linux version 2.19, and surprisingly got
>> this unexpected error:
>>
>> fstrim: /: FITRIM ioctl failed: Operation not supported
> 
> Actually kernel version is what matters.
> 
>>
>> Why do I get this error? Online discard always seemed to work fine (= I
>> didn't get any error).
> 
> Those errors probably got silently dropped so you did not know about
> them.

But if fstrim works, online discard will work, too? Or is this
conclusion wrong (ext4)?

[....]

> I hope it helps.

Yes, it really helped a lot!


Kind regards,
Andreas Hartmann
