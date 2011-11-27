Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56259 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab1K0AfA convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Nov 2011 19:35:00 -0500
Received: by bke11 with SMTP id 11so6303447bke.19
        for <util-linux@vger.kernel.org>; Sat, 26 Nov 2011 16:34:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201111231358.16493.vapier@gentoo.org>
References: <CA+zVqtWW+CknuW7NKyd2AZVsrDwj=J7gg+U2UYEBgbp++vaZgA@mail.gmail.com>
 <201111231358.16493.vapier@gentoo.org>
From: Paul Stone <Paul@Stone.org>
Date: Sat, 26 Nov 2011 16:34:38 -0800
Message-ID: <CA+zVqtWCj=zRaOeesLfaOABHiuBcQMqTZRfJwE84s_G=Z8qAAA@mail.gmail.com>
Subject: Re: how can I compile mount and umount as shared object files?
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks Mike,

The compiled regular executables do seem to work fine.

Any idea why they are compiled as PIEs for CentOS (and presumably Red Hat)?

Best Regards,
Paul Stone


On Wed, Nov 23, 2011 at 10:58 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tuesday 22 November 2011 19:02:26 Paul Stone wrote:
>> [root@xxxx .libs]# file *
>> mount:  setuid ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
>> dynamically linked (uses shared libs), for GNU/Linux 2.6.18, stripped
>> umount: setuid ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
>> dynamically linked (uses shared libs), for GNU/Linux 2.6.18, stripped
>>
>> [root@xxxx .libs]# file /bin/mount /bin/umount
>> /bin/mount:  setuid ELF 64-bit LSB shared object, x86-64, version 1
>> (GNU/Linux), dynamically linked (uses shared libs), for GNU/Linux
>> 2.6.18, stripped
>> /bin/umount: setuid ELF 64-bit LSB shared object, x86-64, version 1
>> (GNU/Linux), dynamically linked (uses shared libs), for GNU/Linux
>> 2.6.18, stripped
>
> looks like your objects in /bin/ are PIEs.  it's not required for these to be
> PIEs, so you can install the locally compiled ones if you want and they should
> work fine.
> -mike
>
