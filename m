Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:50980 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbaK3RR6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Nov 2014 12:17:58 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so15148348wid.6
        for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 09:17:57 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1417365287.1296747.196968317.62A1BE41@webmail.messagingengine.com>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
	<1417355862-16935-10-git-send-email-kerolasa@iki.fi>
	<1417365287.1296747.196968317.62A1BE41@webmail.messagingengine.com>
Date: Sun, 30 Nov 2014 17:17:57 +0000
Message-ID: <CAG27Bk2YU9i11dbgieEnsa9tAzP3OS+YTpVjqrw02AAtomP4ww@mail.gmail.com>
Subject: Re: [PATCH 09/10] lscpu: blacklist vmware_bdoor() AddressSanitizer check
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 30 November 2014 at 16:34, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Sun, Nov 30, 2014, at 14:57, Sami Kerola wrote:
>> AddressSanitizer is identifying the __asm__ segment as suspicious.
>
> Hmm...  How come that it doesn't flag the very similar segment in
> static inline void cpuid(...) as suspicious?  Is it the 'inl' command?
> (What does this do anyway?  It isn't an x86 assembly that I can find.)

I don't understand assembly enough to tell why that worked but not this.

>> -static inline
>> +static inline UL_ASAN_BLACKLIST
>>  void vmware_bdoor(uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx)
>
> While here, maybe move the 'void' to the previous line?

I can do that.

Unless more radical approach is considered correct. The vmware_bdoor() came from

commit  b7744730f6e4b5b91c9846f3e7c58aaa7423a167

and the code looks remarkably similar as

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/cpu/vmware.c#n30

The kernel code is setting in vmware_platform() hyper_vendor_id that
lscpu consumes with read_hypervisor_cpuid(). Perhaps the
vmware_bdoor() can be removed.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
