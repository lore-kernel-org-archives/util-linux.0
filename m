Return-Path: dsd.olpc@gmail.com
MIME-Version: 1.0
Sender: dsd.olpc@gmail.com
In-Reply-To: <CAGq3pz4smg1pJisnEpnFKKAcNMFyBjDVSSWrLA79O8JK+=AFQQ@mail.gmail.com>
References: <20110709132046.90A119D401C@zog.reactivated.net>
	<20110711121836.GJ5214@nb.net.home>
	<CAGq3pz4smg1pJisnEpnFKKAcNMFyBjDVSSWrLA79O8JK+=AFQQ@mail.gmail.com>
Date: Mon, 11 Jul 2011 14:14:09 +0100
Message-ID: <CAGq3pz5hJrpcSdwnJwGRGtC3Ap=vDzm3r0PSbYdK=33S4t2HBg@mail.gmail.com>
Subject: Re: [PATCH] evstate: new utility for querying evdev key/switch/event state
From: Daniel Drake <dsd@laptop.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, pgf@laptop.org, dmitry.torokhov@gmail.com,
        Kay Sievers <kay.sievers@vrfy.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

+CC linux-input

On 11 July 2011 14:12, Daniel Drake <dsd@laptop.org> wrote:
> On 11 July 2011 13:18, Karel Zak <kzak@redhat.com> wrote:>
>>> http://article.gmane.org/gmane.linux.drivers.platform.x86.devel/1089
>>
>> Wow, so you have already implemented a patch that exports the state
>> in *human readable format* by sysfs. This patch was NACKed.
>>
>> Now it's expected that everyone in userspace will use ioctl() (with
>> root permissions?) and translate any crazy bit array to something
>> human readable. Right? Really?
>
> Dmitry, what are your thoughts on this?
>
> To clarify, there are 4 different switches that we need to read the state of.
>
> 1. XO-1.5 lid switch, exposed via ACPI via normal acpi-button driver
> 2. XO-1.5 ebook switch, exposed via drivers/platform/x86/xo15-ebook.c
> 3. XO-1 lid switch, exposed via arch/x86/platform/olpc/olpc-xo1-sci.c
> (linux-next)
> 4. XO-1 ebook switch, exposed via
> arch/x86/platform/olpc/olpc-xo1-sci.c (linux-next)
>
> We'd like to do this from shell code, as root.

add 2 more to that list as well in the near future: we are currently
writing drivers for the lid and ebook switches on the ARM-based
XO-1.75 laptop currently in prototype stages.

Daniel
