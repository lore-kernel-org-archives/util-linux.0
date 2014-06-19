Return-Path: anca.emanuel@gmail.com
MIME-Version: 1.0
In-Reply-To: <53A1A9CA.7000108@gmail.com>
References: <20140618134616.GA25885@x2.net.home>
	<53A1A9CA.7000108@gmail.com>
Date: Thu, 19 Jun 2014 04:15:50 +0300
Message-ID: <CAJL_dMtV58XpgJnoaPHG2tOb4u5n6aBCvxhQMfuMVcQ9F2UjTw@mail.gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.25-rc1
From: Anca Emanuel <anca.emanuel@gmail.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

Can you help debian people (on the testing realm) to test this on all
architectures ?

On Wed, Jun 18, 2014 at 6:01 PM, Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
> Karel Zak wrote:
>>
>>
>> The util-linux release v2.25 is available at
>>
>>    ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.25
>>
>> Feedback and bug reports, as always, are welcomed.
>
>
> In an LFS build environment, the configure, make, and make check are all
> clean.  It is especially nice the way you tell us why some tests are not run
> (mostly not root permissions).
>
> In prior releases, the last/ipv6 and last/last tests did not pass in the LFS
> environment, but they now do pass.
>
> It would be nice if we could set the adjtime path in configure.  Right now
> we do:
>
> sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' \
>           $(grep -rl '/etc/adjtime' .)
>
>   -- Bruce
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
