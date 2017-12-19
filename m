Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ot0-f177.google.com ([74.125.82.177]:35925 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdLSV0B (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 Dec 2017 16:26:01 -0500
Received: by mail-ot0-f177.google.com with SMTP id d5so17986067oti.3
        for <util-linux@vger.kernel.org>; Tue, 19 Dec 2017 13:26:00 -0800 (PST)
Subject: Re: Regression test failure
To: Ruediger Meier <ruediger.meier@ga-group.nl>,
        Util-Linux <util-linux@vger.kernel.org>
References: <5A39782D.1030608@gmail.com>
 <201712192211.32500.ruediger.meier@ga-group.nl>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <5A3983E7.1000100@gmail.com>
Date: Tue, 19 Dec 2017 15:25:59 -0600
MIME-Version: 1.0
In-Reply-To: <201712192211.32500.ruediger.meier@ga-group.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The filesystem is ext4,  kernel 4.14.6,  x86_64.

   -- Bruce


Ruediger Meier wrote:
> On Tuesday 19 December 2017 at 21:35, you wrote:
>> In version 2.31.1, I had one failure:
>>
>> fincore: count file contents in core   ... FAILED (fincore/count)
>
> Which filesystem are you using for the build directory? And which
> kernel version, architecture?
>
> AFAIR this test is somehow fragile. Maybe we should whitelist this test
> only for a set of known filesystems with default block sizes etc..
>
> cu,
> Rudi
>
>>
>>     1 tests of 200 FAILED
>>
>> $ cat ./tests/diff/fincore/count
>> --- /sources/util-linux-2.31.1/tests/expected/fincore/count.4096
>> 2017-09-18 09:48:03.676890826 +0000
>> +++ /sources/util-linux-2.31.1/tests/output/fincore/count
>> 2017-12-19 20:18:24.410460239 +0000
>> @@ -13,7 +13,7 @@
>>    return value: 0
>>        0  8192 i_TWO_PAGES_directio_
>>    return value: 0
>> -    1  8192 i_TWO_PAGES_mixed_directio_incore_
>> +    2  8192 i_TWO_PAGES_mixed_directio_incore_
>>    return value: 0
>>        1  8192 i_TWO_PAGES_mixed_incore_directio_
>>    return value: 0
>> @@ -42,7 +42,7 @@
>>        0      4096 i_JUST_PAGESIZE_directio_
>>        2      8192 i_TWO_PAGES_incore_
>>        0      8192 i_TWO_PAGES_directio_
>> -    1      8192 i_TWO_PAGES_mixed_directio_incore_
>> +    2      8192 i_TWO_PAGES_mixed_directio_incore_
>>        1      8192 i_TWO_PAGES_mixed_incore_directio_
>>        2 134213632 i_WINDOW_SIZE_incore-sparse-incore_
>>        0 134213632 i_WINDOW_SIZE_directio-sparse-directio_
>>
>> -----------------------
>> The system is a fresh LFS build (systemd version):
>>
>> ./configure ADJTIME_PATH=/var/lib/hwclock/adjtime   \
>>               --docdir=/usr/share/doc/util-linux-2.31 \
>>               --disable-chfn-chsh  \
>>               --disable-login      \
>>               --disable-nologin    \
>>               --disable-su         \
>>               --disable-setpriv    \
>>               --disable-runuser    \
>>               --disable-pylibmount \
>>               --disable-static     \
>>               --without-python
>>
>> make
>>
>> chown -Rv nobody .
>> su nobody -s /bin/bash -c "PATH=$PATH make -k check"
>>
>>     -- Bruce
>> --
>> To unsubscribe from this list: send the line "unsubscribe util-linux"
>> in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

