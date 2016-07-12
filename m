Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34897 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbcGLUD2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 12 Jul 2016 16:03:28 -0400
Received: by mail-oi0-f67.google.com with SMTP id w143so2420310oiw.2
        for <util-linux@vger.kernel.org>; Tue, 12 Jul 2016 13:03:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201607121623.04891.sweet_f_a@gmx.de>
References: <20160710200242.2706-1-kerolasa@iki.fi> <3421b4a5-023c-304b-3768-fa6f219d6300@gmx.com>
 <CAG27Bk2oLozR-Va_vcnNS9faDZKi5Q1tC+y2F6Ws9Ye7fGu_tw@mail.gmail.com> <201607121623.04891.sweet_f_a@gmx.de>
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 12 Jul 2016 21:03:12 +0100
Message-ID: <CAG27Bk3po26Bsb=E0A1UXDrTrkwPH1pEvqEKXFZ_n4PVOcxt8A@mail.gmail.com>
Subject: Re: [PATCH] hwclock: remove UTC-0 localization hack
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: J William Piggott <elseifthen@gmx.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12 July 2016 at 15:23, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> On Tuesday 12 July 2016, Sami Kerola wrote:
>> On 11 July 2016 at 21:23, J William Piggott <elseifthen@gmx.com>
> wrote:
>> > We use mktime(3) for portability.
>> >
>> > http://www.gnu.org/software/libc/manual/html_mono/libc.html#index-t
>> >imegm
>> >
>> > Portability note: mktime is essentially universally available.
>> > timegm is rather rare. For the most portable conversion from a UTC
>> > broken-down time to a simple time, set the TZ environment variable
>> > to UTC, call mktime, then set TZ back.
>>
>> I don't think hwclock(8) is portable. It has ioctl(2) calls, and
>> such.
>
> But there are non-gnu libc's for Linux.

Fair point, but can you name one that does not have timegm().

https://github.com/cloudius-systems/musl/blob/master/src/time/timegm.c
https://github.com/ensc/dietlibc/blob/master/libugly/timegm.c
http://www.uclibc-ng.org/browser/uclibc-ng/libc/misc/time/timegm.c?order=name

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
