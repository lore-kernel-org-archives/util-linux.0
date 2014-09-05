Return-Path: francis.moro@gmail.com
Message-ID: <54097099.4070505@gmail.com>
Date: Fri, 05 Sep 2014 10:13:13 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Weird behaviour with lsblk and freshly created loop device
References: <54049344.4010502@gmail.com> <20140901175609.GA21325@x2.net.home> <54056BD1.1080205@gmail.com> <20140902073020.GB21325@x2.net.home> <5405F446.2040202@gmail.com> <20140905074535.GI21325@x2.net.home>
In-Reply-To: <20140905074535.GI21325@x2.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

On 09/05/2014 09:45 AM, Karel Zak wrote:
> On Tue, Sep 02, 2014 at 06:45:58PM +0200, Francis Moreau wrote:
>>> That's question, now (because it's not hardcoded to lsblk) everyone is
>>> able to control this behavior, all you need is to add 'udevadm settle'
>>> to your use-case. 
>>
>> The question is more why let the user do that ?
> 
>  because we're talking about small, simple command line util, not
>  about complex high-level UI
>  
>> If lsblk reports the partitions, shouldn't it do that only when it's
>> sure to fully have retrieve the partition's metadata ?
> 
>  if you do not have exclusive access to the device then you cannot be
>  sure at all. All is asynchronous...
> 
>> BTW, is the user supposed to know that lsblk relies on udev or is this
>> implementation detail ?
> 
>  This is very generic system feature, for example if you want to mount
>  a device by /dev/disk/by-* symlinks then nowhere is guarantee that
>  mount(8) is not faster than udev+blkid, etc.
> 
>  Yes, we can add "udevadm settle" functionality into all system utils,
>  but it will increase complexity and degrade performance. So from my
>  point of view it seems better to explain the problem in man page,
>  keep lsblk simple and stupid and assume that users who really care
>  will use "udevadm settle".

Also you might want to add a new option for forcing lsblk to wait for udev ?

Thanks for your answers.
