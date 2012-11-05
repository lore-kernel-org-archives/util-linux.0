Return-Path: toshi.kani@hp.com
Message-ID: <1352142965.19172.106.camel@misato.fc.hp.com>
Subject: Re: [PATCH RESEND] lscpu: Fix issue found on CPU hot-remove
From: Toshi Kani <toshi.kani@hp.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, heiko.carstens@de.ibm.com, kerolasa@iki.fi
Date: Mon, 05 Nov 2012 12:16:05 -0700
In-Reply-To: <20121105185614.GF3799@x2.net.home>
References: <1352135015-13946-1-git-send-email-toshi.kani@hp.com>
	 <20121105185614.GF3799@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Mon, 2012-11-05 at 19:56 +0100, Karel Zak wrote:
> On Mon, Nov 05, 2012 at 10:03:35AM -0700, Toshi Kani wrote:
> > read_basicinfo() relies on sysfs cpu directories
> > "/sys/devices/system/cpu/cpu%d" with assumption that cpu
> > logical number %d is always sequentially assigned for all
> 
> Ah, sorry I have moved the mail to my mail archive without response...
> thanks for resend.
> 
> It seems correct, I'll apply the patch tomorrow.

Great!  Thanks Karel!
-Toshi


> 
>     Karel
> 
> 
