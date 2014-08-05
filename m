Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20140804121518.GC6923@x2.net.home>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
	<1407075463-19586-6-git-send-email-kerolasa@iki.fi>
	<20140804121518.GC6923@x2.net.home>
Date: Wed, 6 Aug 2014 00:03:52 +0100
Message-ID: <CAG27Bk3k96DQ+wHis5QkC0GDvH5Q-z=UY_jG0eB=K1Ghk2VeAw@mail.gmail.com>
Subject: Re: [PATCH 6/7] zramctl: fix mount point printout
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 4 August 2014 13:15, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Aug 03, 2014 at 03:17:42PM +0100, Sami Kerola wrote:
>> See sample belo how a device mount point was printed without and with
>> full <device> path.  This change adds the mount point markup to the short
>> device name printout.
>>
>> $ zramctl zram3
>> NAME  ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
>> zram3 lz4             1M   4K   62B    4K       1
>
>  This is bug, it would be better improve zram_set_devname() to make it
>  more robust and always convert the path to the full path. I don't think
>  that any variability makes it more easy to use.

The following make device path to be always absolute.

https://github.com/kerolasa/lelux-utiliteetit/commit/5a093e4d11091c48580531fa88d1c64b564b57d3

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
