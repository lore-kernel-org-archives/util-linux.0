Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20121121100852.GC2006@x2.net.home>
References: <1352214367.5099275f85792@imp.free.fr>
	<535592290.498944.1352219102253.JavaMail.open-xchange@email.1und1.de>
	<20121121100852.GC2006@x2.net.home>
Date: Wed, 21 Nov 2012 13:46:59 +0000
Message-ID: <CAG27Bk2L7p=pO3LJZTNMaS68vx2vfodG76K=1SicOvEExDQRFw@mail.gmail.com>
Subject: Re: Accessibility of swap files
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux <util-linux@vger.kernel.org>, mp.lists@free.fr
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 21, 2012 at 10:08 AM, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Nov 06, 2012 at 05:25:02PM +0100, Bernhard Voelker wrote:
>> On November 6, 2012 at 4:06 PM mp.lists@free.fr wrote:
>> > As a first idea, it looks, as if such may be implemented, eg. by
>> >      letting swapon [and fstab-based "mounting"] by default not enable a swap
>> > file, if it has non-root access permissions
>>
>> Did you know?
>> The swapon utility issues a warning diagnostic with --verbose:
>>
>>   # ls -l /tmp/swapfile
>>   -rw-r--r-- 1 berny users 134217728 Nov  6 17:03 /tmp/swapfile
>>
>>   # sbin/swapon -v  /tmp/swapfile
>>   swapon /tmp/swapfile
>>   swapon: /tmp/swapfile: insecure permissions 0644, 0600 suggested.
>>   swapon: /tmp/swapfile: insecure file owner 1000, 0 (root) suggested.
>>   swapon: /tmp/swapfile: found swap signature: version 1, page-size 4, same byte
>> order
>>   swapon: /tmp/swapfile: pagesize=4096, swapsize=134217728, devsize=134217728
>
>  this waring is there since year 1999.. so it's really nothing new.

I wonder would be be too noisy to make insecurity warnings enabled by
default,  and add --quiet option to thous who do not want to hear
system complaining about things they know.
