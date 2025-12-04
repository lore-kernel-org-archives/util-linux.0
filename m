Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927422B584
	for <util-linux@vger.kernel.org>; Thu,  4 Dec 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857222; cv=none; b=cQMkT2PEib8N4euDlHLgO3YPfRzCvIUnDWLFuXz6vtksa86iyVeiG99f4j//fzygrLlzdbDL6ttaqGH6CsEQCL2xZftayulg6ipqBRnxW652igD2CMIuCvywD0bizB02sJpU0gkLAfH8EjgrU+ql7xLxVsYIIu9qTk6N4XMIvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857222; c=relaxed/simple;
	bh=vTILdcFT/yTD4zLO5VehboBXL1ed+guhIsTxcMiinv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/hRE32RPEKuwdX0dWBS8ZfKipM7GYLBXZAI9dwSt27T6MB4bRRRlTfe5R5CL/X5msUzNRWKCcIl4W4Uu0RupMZJrFYWvbj93cUTBPZZzp+1ewdY6H1HYxPr3IxkJ08Ro4dZM1RGDhy+NNRTbe3q44Sl4oqIz/wTU+Vu+6a/RgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aMGQW/7L; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMGQW/7L"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso1442728b3a.1
        for <util-linux@vger.kernel.org>; Thu, 04 Dec 2025 06:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764857219; x=1765462019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=43t/Czy5k/x+GFzhf1OSgUonwXfO1dTYBh2ATpkwGxI=;
        b=aMGQW/7LRhMcN9YAxQfTOpbUo4YSxNJNrj9lMOVfgM92W8WbUyh/MZUIbX7utSrMI5
         CCI5MdBI8ds04+wWVe2x/dsGIGFWkC8MZBZheT5T49G7+pl8CKR6hoJxGFASOxjXSzed
         w7WqwvVOWl5YYgf6iBv2VJ5Ekzkv/T8WEWKfRK1YPqQcJg8YWf2k3DRwML+oWSyRWZTA
         I0eRg4HU6gBJFUt4+hOP2qJBKexx5qIq6D2c/21HRX1LdYRTULJWCKfque0Fy0l4tfMe
         lf9ixqcssUlI0fu3sm4OJ+wxJl9UlmemQggRHAo4Do3q7vhIQUi/8dQYpsFmfZUkNNQT
         mbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764857219; x=1765462019;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43t/Czy5k/x+GFzhf1OSgUonwXfO1dTYBh2ATpkwGxI=;
        b=q90P78Xz/lyinNUA7MkzP4TeID0TrgpK2MisaWUEI7hcYWxzlsScCl/m+KWEe1aHjO
         8xFhUVzu2JsGIjKuQdqF9IwLxOLw6B3XB8RdPkkD2M5Kd4cC7gBkB0aLsKyUwV+KPk8M
         ke/2o+DIKzwqH6Ntv2XrK8WkJSBinlHbLKkpRIosCZ6JDXL9vmI29PO4si5btQ4wqKbr
         I5Y1bJVCnfBZrqJ8r9w2jS6Uf++rGjJDuJfQcKPQNekg0w32yd2r3skcnwLzg3E6yweM
         DP23UjAbLNBximaQD9f3ui+0fNQmih3iIgBbO+QC8o90WETQNJDdQTpM8oi0Gqp1QOOJ
         zfOA==
X-Gm-Message-State: AOJu0YwSSrn5gAzK3sLnRH9koPsGlqZg8ZaWhPVwglROfGzx/mzdD4Sg
	UIh1G/vPGS0X+bkZ/Cp/DvKSSJ2zDx1ulXvqaZMVDWzPtbfh5CwwKwZNKcJg5GByPpU=
X-Gm-Gg: ASbGncvfb5bId4ELA4zpI6GCmGJyRhFqYJSnp0BcF3xvoLxBfkJxVk6sO7uMnANI8lU
	ZQIoQYUkohM7SlY7AucojLJho6CRoDSugle6Mh9FDz4uq4Pi1VMEQWrQkrvCzoxLeP/uupUn/3G
	prON9Sbblj2OMPboXgrB3WkKFdWfDRyKPf2VRpG0kKC5Op4iajC8/aIckchb9lXhG39/PP53auf
	2jzjl4R+BDOic/ARniETrNtGB/dW4Z+1G+H4cX2AexvNSZWJESInzOiStPahCb2ukKE7LQ7Bjan
	1EsRr+W09mbv5Kyb24jordfobd5xUcSLoTJ0X3Tu1eEc3d94tY8bUmiHhELNv8BOk5//5kV7nof
	CaXM3UORqjCRW2Vy7AiGeDGrVnkVvHY2f2B/c429CSyFDF+XFdX6mgOi8wPQi2d2QYh7WIKWq+J
	PYFOR4K0FZpGUXEONyQubfYt71BTRz7FVlAMMNz4iz/k2xjv2Jo9t7bZXTegL6+5QG7h/vKIbE7
	Wyb6/s+7yBOdIAAtR1n0w==
X-Google-Smtp-Source: AGHT+IG/KMx+gp9PrFzMpzmCURhrHZB8Ty+N3ZVaFjCwhsJdnri2GqdJr6FygkneC2IhHkNkErU02w==
X-Received: by 2002:a05:7022:6625:b0:11d:c049:2fa3 with SMTP id a92af1059eb24-11df649f9a9mr2433226c88.30.1764857217245;
        Thu, 04 Dec 2025 06:06:57 -0800 (PST)
Received: from ?IPV6:2804:1b3:a7c0:404c:e9c6:12f9:b8e7:7b6f? ([2804:1b3:a7c0:404c:e9c6:12f9:b8e7:7b6f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76edd4fsm6895416c88.8.2025.12.04.06.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 06:06:56 -0800 (PST)
Message-ID: <5272b875-bec8-4b28-84e8-05606db83120@linaro.org>
Date: Thu, 4 Dec 2025 11:06:53 -0300
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Call prctl(2) with long integers, specify 5 arguments,
 and avoid casts
To: Alejandro Colomar <alx@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas@t-8ch.de>, "H.J. Lu" <hjl.tools@gmail.com>
Cc: util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>,
 libc-alpha@sourceware.org
References: <20240601093150.16912-1-alx@kernel.org>
 <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
 <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/06/24 09:23, Alejandro Colomar wrote:
> Hi Thomas,
> 
> On Sat, Jun 01, 2024 at 01:05:02PM GMT, Thomas Weißschuh wrote:
>> On 2024-06-01 11:31:56+0000, Alejandro Colomar wrote:
>>> Since libc's prctl(2) wrapper is a variadic function, arguments must
>>> have the right width.  Otherwise, the behavior is undefined.
>>
>> Ack.
>>
>>> Also, the 5 arguments must be specified always, or the behavior is also
>>> undefined.  libc reads 5 values and passes them all to the kernel, so if
>>> one is uninitialized, the kernel will receive garbagge, which could
>>> result in EINVAL (most likely), or worse, a different action.
>>
>> This seems surprising.
>>
>> The kernel should only check the arguments it documents and not more.
> 
> Hmmm, some prctl(2) calls don't document a need for passing 0 (probably
> for legacy compatibility; you're right.  Only newer prctl(2)s check
> those args.
> 
> And see for example these kernel commit:
> 
> 	commit e9d1b4f3c60997fe197bf0243cb4a41a44387a88
> 	Author: Dave Hansen <dave.hansen@linux.intel.com>
> 	Date:   Thu Jan 8 14:30:22 2015 -0800
> 
> 	    x86, mpx: Strictly enforce empty prctl() args
> 	    
> 	    Description from Michael Kerrisk.  He suggested an identical patch
> 	    to one I had already coded up and tested.
> 	    
> 	    commit fe3d197f8431 "x86, mpx: On-demand kernel allocation of bounds
> 	    tables" added two new prctl() operations, PR_MPX_ENABLE_MANAGEMENT and
> 	    PR_MPX_DISABLE_MANAGEMENT.  However, no checks were included to ensure
> 	    that unused arguments are zero, as is done in many existing prctl()s
> 	    and as should be done for all new prctl()s. This patch adds the
> 	    required checks.
> 	    
> 	    Suggested-by: Andy Lutomirski <luto@amacapital.net>
> 	    Suggested-by: Michael Kerrisk <mtk.manpages@gmail.com>
> 	    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> 	    Cc: Dave Hansen <dave@sr71.net>
> 	    Link: http://lkml.kernel.org/r/20150108223022.7F56FD13@viggo.jf.intel.com
> 	    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> 	diff --git a/kernel/sys.c b/kernel/sys.c
> 	index a8c9f5a7dda6..ea9c88109894 100644
> 	--- a/kernel/sys.c
> 	+++ b/kernel/sys.c
> 	@@ -2210,9 +2210,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> 			up_write(&me->mm->mmap_sem);
> 			break;
> 		case PR_MPX_ENABLE_MANAGEMENT:
> 	+               if (arg2 || arg3 || arg4 || arg5)
> 	+                       return -EINVAL;
> 			error = MPX_ENABLE_MANAGEMENT(me);
> 			break;
> 		case PR_MPX_DISABLE_MANAGEMENT:
> 	+               if (arg2 || arg3 || arg4 || arg5)
> 	+                       return -EINVAL;
> 			error = MPX_DISABLE_MANAGEMENT(me);
> 			break;
> 		default:
> 
> And this one too:
> 
> 	commit 3e91ec89f527b9870fe42dcbdb74fd389d123a95
> 	Author: Catalin Marinas <catalin.marinas@arm.com>
> 	Date:   Thu Aug 15 16:44:00 2019 +0100
> 
> 	    arm64: Tighten the PR_{SET, GET}_TAGGED_ADDR_CTRL prctl() unused arguments
> 	    
> 	    Require that arg{3,4,5} of the PR_{SET,GET}_TAGGED_ADDR_CTRL prctl and
> 	    arg2 of the PR_GET_TAGGED_ADDR_CTRL prctl() are zero rather than ignored
> 	    for future extensions.
> 	    
> 	    Acked-by: Andrey Konovalov <andreyknvl@google.com>
> 	    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 	    Signed-off-by: Will Deacon <will@kernel.org>
> 
> 	diff --git a/kernel/sys.c b/kernel/sys.c
> 	index c6c4d5358bd3..ec48396b4943 100644
> 	--- a/kernel/sys.c
> 	+++ b/kernel/sys.c
> 	@@ -2499,9 +2499,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> 			error = PAC_RESET_KEYS(me, arg2);
> 			break;
> 		case PR_SET_TAGGED_ADDR_CTRL:
> 	+               if (arg3 || arg4 || arg5)
> 	+                       return -EINVAL;
> 			error = SET_TAGGED_ADDR_CTRL(arg2);
> 			break;
> 		case PR_GET_TAGGED_ADDR_CTRL:
> 	+               if (arg2 || arg3 || arg4 || arg5)
> 	+                       return -EINVAL;
> 			error = GET_TAGGED_ADDR_CTRL();
> 			break;
> 		default:
> 
> In the few calls that util-linux makes without specifying all 5 args,
> the kernel seems to not do the checks (in some old prctl(2)s they didn't
> have that check, and nobody seems to have cared enough to add it), so
> it's more like we're lucky (or unlucky, depending on how you see it).
> 
>> glibc itself doesn't even specify all five arguments in its own calls to
>> prctl().
> 
> glibc itself is wrong.  I'm even surprised that the PR_* macros from the
> kernel UAPI for arg2 work without specifying the L suffix on them, but
> it's probably just luck.
> 
> <https://lore.kernel.org/linux-api/20240528114750.106187-1-alx@kernel.org/T/#u>
> 
>> If all five arguments are really required then prctl() wouldn't need to
>> be variadic.
> 
> Indeed.  I guess that's for historic reasons, rather than actual
> necessity; but I don't know for sure.
> 
>> How is random non-zero data less valid than a essentially random zero?
>> And if the kernel actually validates this, how has it ever worked before?
> 
> They only added validation for (all) new prctl(2) calls, plus maybe some
> old ones, but not all.  In the ones used in util-linux that don't
> specify zero, I've checked now that the kernel doesn't validate.
> 
> However, a call such as
> 
> 	prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)
> 
> (this call exists in util-linux)
> actually means
> 
> 	prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, random, random)
> 
> and it supposedly has been working so far.  Those random bits are
> probably 0 most of the time, for some reason.  And the kernel does check
> this one:
> 
> 	$ sed -n /PR_SET_NO_NEW_PRIVS/,+2p <kernel/sys.c
> 		case PR_SET_NO_NEW_PRIVS:
> 			if (arg2 != 1 || arg3 || arg4 || arg5)
> 				return -EINVAL;
> 
>> Other popular software like systemd or opendjk also don't specify unused arguments.
> 
> I've also checked that the ones that systemd uses without specifying all
> 5 args, they are not checked by the kernel.
> 
>> So it doesn't really seem "broken".
>> If the patch is more about "being on the safe side", then this should be
>> spelled out.
> 
> Still, libc reads those values (on x32) which results in Undefined
> Behavior inside glibc.  Which is a bad thing.  Not broken, because the
> compiler has little information to exploit that UB, but not a good thing
> either.
> 
> 	$ grepc __prctl .
> 	./include/sys/prctl.h:extern int __prctl (int __option, ...);
> 	./sysdeps/unix/sysv/linux/x86_64/x32/prctl.c:int
> 	__prctl (int option, ...)
> 	{
> 	  va_list arg;
> 	  va_start (arg, option);
> 	  unsigned long int arg2 = va_arg (arg, unsigned long int);
> 	  unsigned long int arg3 = va_arg (arg, unsigned long int);
> 	  unsigned long int arg4 = va_arg (arg, unsigned long int);
> 	  unsigned long int arg5 = va_arg (arg, unsigned long int);
> 	  va_end (arg);
> 	  return INLINE_SYSCALL_CALL (prctl, option, arg2, arg3, arg4, arg5);
> 	}
> 
> It's arguably less broken than the missing 'L', though.

The x32 and or1k (which also uses similar implementation) does seems broken
without checking the 'option' argument to see which arg we can va_arg.

The problem is adding this logic on libc will add some forward-compatibility
that we try to avoid (newer kernel prctl additions might now work correctly).

I am not sure why we haven't switch x32 back to the assembly wrappers
with 6a04404521ac4119ae36827eeb288ea84eee7cf6 fix (BZ#29770).  H.J, can
use remove the x32 C version (and also or1k as well)?

> 
>> (Plus the cases where documented, required arguments are missing)
> 
> None of the cases where we omit the arguments are checked by the kernel.
> 
> 
> Have a lovely day!
> Alex
> 

