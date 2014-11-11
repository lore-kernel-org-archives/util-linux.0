Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f52.google.com ([209.85.220.52]:57391 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaKKVQt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 11 Nov 2014 16:16:49 -0500
Received: by mail-pa0-f52.google.com with SMTP id fa1so11293352pad.25
        for <util-linux@vger.kernel.org>; Tue, 11 Nov 2014 13:16:49 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20141111021250.GG3652@vapier.wh0rd.info>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
	<1415656195-20458-7-git-send-email-kerolasa@iki.fi>
	<20141111021250.GG3652@vapier.wh0rd.info>
Date: Tue, 11 Nov 2014 21:16:48 +0000
Message-ID: <CAG27Bk0+saBoL=R0n_7CRBiC89J9JC+udoabTMFd1vN_W=e4Eg@mail.gmail.com>
Subject: Re: [PATCH 6/6] tests: mark python libmount tests known to fail with AddressSanitizer
From: Sami Kerola <kerolasa@iki.fi>
To: Sami Kerola <kerolasa@iki.fi>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11 November 2014 02:12, Mike Frysinger <vapier@gentoo.org> wrote:
> On 10 Nov 2014 21:49, Sami Kerola wrote:
>> The tests fail with an error similar to this.
>>
>> Traceback (most recent call last):
>>   File "/home/src/util-linux/libmount/python/test_mount_tab_update.py", line 7, in <module>
>>     import pylibmount as mnt
>> ImportError: /home/src/util-linux/.libs/libuuid.so.1: undefined symbol: __asan_option_detect_stack_use_after_return
>
> if libuuid.so is built with ASAN, it should be linked with it too.  that means
> passing the ASAN flags at link time.  or maybe libtool is filtering them out
> when it goes to link the library ?

Hi Mike,

The documentation

https://code.google.com/p/address-sanitizer/wiki/AsanAsDso

gives a hint

-- snip
=ASAN and LD_PRELOAD=

It is possible to use ASAN in this scenario (e.g. JVM+JNI, Python+SWIG):

* There is third-party executable binary which can not be recompiled
* It loads shared libraries that can be recompiled and we want to test
them with ASAN

A simple solution is to build ASAN-DSO and LD_PRELOAD it into the
process, however the devil is in the detail.

* If the process creates sub-processes, they will also have ASAN-DSO
preloaded, which may be undesirable.
* TODO (stay tuned)
-- snip

Making the python + libuuid should be possible, but I it seems to
require a bit trying to get work. I feel it is acceptable to get most
of the util-linux & travis to work with the asan first, and once the
easy stuff is done one can/should concentrate on making the less
trivial things to work.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
