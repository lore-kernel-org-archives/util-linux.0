Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405D3B8D6F
	for <util-linux@vger.kernel.org>; Mon,  8 Dec 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765194454; cv=none; b=l5kdDv3JbygHI5pcMFcU0YbKe/QTP4ZTkEqtHOylH/GMeDc7KtHlV9lh3cjYzFu8U+DIorCSkB7mPg1fnQvgmTsDGo6GJlT5kEVHpBT65PNHqW+3XgvJN9VQtlcpz48Vbfe4vsf0c2JhJabywZCzXnxyqGiqzTpyDWHtllCN5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765194454; c=relaxed/simple;
	bh=cPjCAv+h705LWGeysdsVNGtcKLwFHq/UmtGoZbphSjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDwB0ES/mO3qWb377KaA0yV3sjVXoHJpRuqGBK5ci+ItknDILpDxphR0wLX7TqR0iTNtJUpw6wHFFXZc2xMMY/X476zC2EuXIbSeIrmTcRd8L+n63SJlJWQ2eaoXv24DRf3C9yUKdankIqLpnPg+geZF75ZF/xyV+RP0mzDJjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YokivWQd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YokivWQd"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bd1b0e2c1eeso3443432a12.0
        for <util-linux@vger.kernel.org>; Mon, 08 Dec 2025 03:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765194452; x=1765799252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4okenSK+FWacRX0/UFto8Btvp96AOr1jENqIpaAT3Xo=;
        b=YokivWQd3p62UPHSnJdybDPuyFwLeIqAHoEag+gd4dwvtD7NIqIy0a7CGn6K7lgXzn
         QJCYMg+AU6JPVjRTjqh6CNIC1fPTHfRa42zabMVF8MTbko5kH+RcC7mGmY2l3x6H1brw
         xpDtdRXJGp6cr/HJkPlh5+2fxMIGT+viPeb0QVQmZrfG1RLzkdzxkD5lwX/xem1gAhVg
         //YNxU0dVkjIuCiU/f46+/vvTNr0DKoaw8QXEY7WE44ZPibVJwwg3WWk3FgRAtKwyNLT
         ejs7c813NwHUuiVKUMJm4TP4vwYPUn7V+7J33WqMvc0VQGIUPpmAc4uoCPKFm7yN38Ot
         YwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765194452; x=1765799252;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4okenSK+FWacRX0/UFto8Btvp96AOr1jENqIpaAT3Xo=;
        b=MxPaUIwejJU/pRKCI3Ag2nki6A92ooPtzcnfYlK/E10A4Z04WelXo4L+HD7VwveOxk
         Fdp8X8MJAHxP8PceBEQQTzt33Ikl5opYbODhQDylTM32BXEcCplLWIPFMqwP2q665RQd
         2uXfuvOzE4ELY/0NcQv5Hv8Jo+aEldZw8cwwt7piVs+Aoalu//Dcm42QFCUkUYhX3htA
         XWwGjf2BM0oOBAIAGe/X2l7myAZ8B8Co/uTajFF/pAM1NDHXQX+fvEwUF6P5a1gC0pO7
         u3yEHFF9IJq7pcQB/G1nLJtbUJuZpkc3LYLGO4ujO5v+p7IBYgLZkU8Nk+FclyK/g2+s
         KZAw==
X-Forwarded-Encrypted: i=1; AJvYcCUWSyR2SO/QvGuOetl+cQiDrqanyGhD9phe8OINm1A84HeJ+dzxS+JqUhgJ2p8yOfYSd+CiamSL6vX3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaynb5ryRB8zJEmQ+SHFXmBglp4qmivBAStwIJA5YOGqJdevh7
	/d9n1rclPDmfFD0P9aC+L9LBOdGnyTr1Xe/983cWdYeTB7pdMKrRDnU9bWDRb6C8rAQ=
X-Gm-Gg: ASbGnctpCYtQjbnQVfrHDDx4YVTlwyaV0zKansMb8BtmGgzCxNxv7JC5+eYic0b2mYM
	PXcVMtSlj62zC/e6zajNqCc26KSGaROpOZcJJ3YYr2mMsDJlygTs9+La5Cxbks0cI35aHBPlfMp
	ZKWyxfmirmFmrNUVT0ikmbbOiZaNKC2DBvvkbbV1/xK1bBuCVpki8uCS7B+pTktkEkQUABw/cWy
	jCfvfD5YjK1rmm8qAuB1Gp6aAzrK1+UwFsqyjBCUc5MUxrN5NIsZnPq4Y/ZlHz3CuK68lg71kMj
	uijRWVBrj5BzllX+1IqtpzX9Vocp/pK11AVb4ZII4xewOeqvcY4x4U0dsPR3oaRcXm5BS04rzgi
	1oK/9EPt/wZOY7LpSa3mv4GHAeThM5Gh39eN6iCX3fLzWtkzXRRcRdqWpJhHus9vDNesbMC5dUH
	+FyQ37aIqdg5uoovp4fPy96mJFiL/2gKr7Bxg0ip6gjW6ZpwfhheKSC9hUk6m70lnwbojoWzmDr
	IY58uwpLg24gNxQOibCbRXljajfVQ==
X-Google-Smtp-Source: AGHT+IFqkVqpZ/3wUbXMcYBwAvtynpg6O3QgQjLZgGFjoo/GGV28fVTeo/KLT+Wh7e9v+jgbw/nMhw==
X-Received: by 2002:a05:693c:2506:b0:2ab:ca55:89b7 with SMTP id 5a478bee46e88-2abca55989dmr2781449eec.42.1765194451659;
        Mon, 08 Dec 2025 03:47:31 -0800 (PST)
Received: from ?IPV6:2804:1b3:a7c0:da21:d7a:68ef:9b64:722f? ([2804:1b3:a7c0:da21:d7a:68ef:9b64:722f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba87d7b9dsm46282169eec.4.2025.12.08.03.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 03:47:31 -0800 (PST)
Message-ID: <ad7ac28b-fa81-48a1-b3f5-e2ab21f83c51@linaro.org>
Date: Mon, 8 Dec 2025 08:47:27 -0300
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x32: Implement prctl in assembly
To: Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas@t-8ch.de>, util-linux@vger.kernel.org, Xi Ruoyao
 <xry111@xry111.site>, GNU C Library <libc-alpha@sourceware.org>
References: <20240601093150.16912-1-alx@kernel.org>
 <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
 <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
 <5272b875-bec8-4b28-84e8-05606db83120@linaro.org>
 <CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
 <lhuh5u2aat0.fsf@oldenburg.str.redhat.com>
 <CAMe9rOqMGabug88Qm7p22Qk+oMOk9YdbAQeyb77rL3ot4HS1UA@mail.gmail.com>
 <lhuzf7tl7fz.fsf@oldenburg.str.redhat.com>
 <CAMe9rOq6mx_ZQs_z2QazC2pbvJZDZzD7kLCo=_o9eTj3cUh8nA@mail.gmail.com>
 <lhuqzt5l4pk.fsf@oldenburg.str.redhat.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <lhuqzt5l4pk.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 08/12/25 06:09, Florian Weimer wrote:
> * H. J. Lu:
> 
>> On Mon, Dec 8, 2025 at 4:11 PM Florian Weimer <fweimer@redhat.com> wrote:
>>>
>>> * H. J. Lu:
>>>> Here is the v2 patch to implement prctl in assembly for x32.
>>>>
>>>> Since the variadic prctl function takes at most 5 integer arguments which
>>>> are passed in the same integer registers on x32 as the function with 5
>>>> integer arguments, we can use assembly for prctl.  Since upper 32-bits in
>>>> the last 4 arguments of prctl must be cleared to match the x32 prctl
>>>> syscall interface where the last 4 arguments are unsigned 64 bit longs,
>>>> implement prctl in assembly to clear upper 32-bits in the last 4 arguments
>>>> and add a test to verify it.
>>>
>>> What's the advantage of the assembler implementation over the C
>>> implementation?  I'm missing the context for this change.
>>>
>>
>> It is inspired by
>>
>> commit 6a04404521ac4119ae36827eeb288ea84eee7cf6
>> Author: Florian Weimer <fweimer@redhat.com>
>> Date:   Sat Feb 17 09:17:04 2024 +0100
>>
>>     Linux: Switch back to assembly syscall wrapper for prctl (bug 29770)
> 
> The justification for that does not apply to x32, though, because prctl
> doesn't take floating point arguments.  I don't have a strong opinion,
> the C and assembler versions are of similar complexity.

The main justification is UB to va_args *all* the arguments without taking
in the consideration which option is passed.  If x32 requires additional
argument handling to clear the upper 32-bits, there is no advantage of
using the assembly wrapper.
