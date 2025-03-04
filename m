Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CE4165F1A
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2025 03:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741060221; cv=none; b=tX70NsFKDhlAThJgLfTV03TCh8pwqQH2a0Y/Agfk+7dhfJwGkGpcczS0kR6U4zLrPFBBhdh3ZZ0ufLsvCcffUNW30bXMmmuN4dKJoCMNAfV3ksDKf6VOyG8GYl2iYJERQ8XbjdQ5VyUYrERvcRJvac41W/mXgal9/XAl5QcMCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741060221; c=relaxed/simple;
	bh=AuJbx4SF9VWu+EYiZ7v7+pCa+gyJueJSNFAqG8z6sio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smX43tSOopxBeeD3RmzMO4R0nXcu/OxXkg199xS/28sAVdZPXcJOofmPY62oYdkAx3TTF14xz6pQeAGabsP4tcoq4cSK4nw230ukmyT8CmQbpeQNEg3K451UPNHfCDnOX8ReLIpvq8dZHLy4CUcq0LY7NdKnX1B9vgHkEUHjy5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PJKkh2ML; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PJKkh2ML"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2234e4b079cso93401025ad.1
        for <util-linux@vger.kernel.org>; Mon, 03 Mar 2025 19:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741060219; x=1741665019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IdxAdcfLaO1fw0a2oHcLYE8W54dTwHr/cIdQHtG2kHI=;
        b=PJKkh2MLkuepF0CfGg56T5uBL98FV6euCbhd+56C/4PSSl5emdhjBJ9Kw+evXS37xA
         QJMazjZty8ifevQBAC0AAXaoZGxwIq3zeb8EQFl69dZvSbkpuS16AzkAFG6V6/o6hPSB
         28VZTyn3oAYcAbiJWpLudhtcH1uRA6NZxmMnNA8x+R+oYimL6fVGYLOAXS6h4g7diwYZ
         GbOfdHiMOxCk+CDwOAT7PuPBXlptAtIQ7uM6/0jPYFGG9zqn6MzU61wqYINdKe/uxPZS
         Wno+ZretbGm6DxuCJVUWlAuxmusHfLXpw3fzW5csBnPgu3A+uxsZzFCL6t5Nojjrb2kJ
         lzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741060219; x=1741665019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdxAdcfLaO1fw0a2oHcLYE8W54dTwHr/cIdQHtG2kHI=;
        b=DFtiK52dmtINeKYNLSvLa7OR5hK7jyxGLczv8//DT2Z5UUcSSLKRvgJnMvFA6btkWa
         UsPe53uC8agRACa44OcIhWAYCrTW1NIKZvirC9vOjg/vMqEg3YL7iV1WPvBHgI8E+Bwn
         K9cAUq15Eju1qvNXQ/0YyyzZ13adupqM1+uH3jby3cwEKrwfl3zUiPCvAJvpcltwIs4F
         54D20J2ncoSlK1/mddDOsMJxbBVk73TOZm8feLGx/W1Vttxm3NLvDmFHeamatKKQI5h8
         ecjUdlhgn2tnIVoQNoTwPAqpuBye0kVHXxXLqC5R4a2ZfRqvD/iNCJ+EwtPmU/TUjLzj
         CfPg==
X-Forwarded-Encrypted: i=1; AJvYcCVIsX6//eK58O3F07Tt/ROFPKHfhiyRXNWrUhjWt39HlxRsn8PiE+vHSVj2+XlxjooO18rCmxGXGkB/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3oLq8bixpDJV5FFBywX/KnFPkr2WO4O+EqxuRjaCFNXMKUPm
	YUmFHwXFsT+HyZN77qhlYpWoXne5CnnVGo0llX2RnSV+cVD0Qk5pa3bIn9Vw770=
X-Gm-Gg: ASbGncuvGTyDemeac9M5MsFlcijF4fYO8OqHFjVzxn0EOaAQP9K46DHk489sAIquhSa
	3MfLIRMFmWho2XWVrcomS2RCl7OyG9555HyGlR/Sh2mFpJ/JTQEetxnKNd5g7dTbxP/Rj7Xxm6B
	9UgVlFiXJ4G9VlmeUktKvJxNZC/mnPYt1HFY9LiiyvhhxkuBHeGVAjxVwr34UwQAO7ckwPr+uSO
	EHydcpCL1vHR6HUiSF0Yh6aNt5JoSLfVpWSkqiwoktljJNFqsIr5UFea6pg5o7vElU+MthyRHPE
	zCngGYdiXHbCaWf1X5cHrtNO9YFlTPb4w/fko+luQ+oyZQiEr7k=
X-Google-Smtp-Source: AGHT+IH+ftU4Sr+K5sei205/+dTKIgJPREK5/p8aBAT3yGnJmIL+ekAIKio8eTmlMtGLqz5p6/mmtQ==
X-Received: by 2002:a17:902:d2d0:b0:21f:6cb2:e949 with SMTP id d9443c01a7336-22369244fb0mr195301815ad.52.1741060219325;
        Mon, 03 Mar 2025 19:50:19 -0800 (PST)
Received: from [10.3.43.196] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825baa37sm11998738a91.13.2025.03.03.19.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 19:50:19 -0800 (PST)
Message-ID: <3783dd8e-3895-4377-b1ff-39d25e66cf04@bytedance.com>
Date: Tue, 4 Mar 2025 11:50:15 +0800
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH V2 0/4] irqtop,lsirq: Miscellaneous enhancements
To: Joe Jin <joe.jin@oracle.com>, Karel Zak <kzak@redhat.com>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20250228161334.82987-1-joe.jin@oracle.com>
 <ycaevmuxkamyr6m2um4kqxhx5xh7jtcr2xoeadfz2v6cmcmrrf@lgpkcja4h7rk>
 <d0410820-4713-4823-8a99-023223bc17d6@oracle.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <d0410820-4713-4823-8a99-023223bc17d6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This series looks good to me!

Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>

On 3/4/25 09:38, Joe Jin wrote:
> On 3/3/25 02:16, Karel Zak wrote:
>> On Fri, Feb 28, 2025 at 08:13:30AM GMT, Joe Jin wrote:
>>> This patchset add below new options for irqtop:
>>>   '-b|--batch' : Batch mode
>>>   '-n|--iter'  : Specifies the maximum number of iterations
>>>   '-J|--json'  : Json ouput format
>>>
>>> Add below for lsirq:
>>>   '-i|--input' : Read data from file
>>>
>>> v2:
>>>    - Removed macro irqtop_batch_mode.
>>>    - Replaced macro irqtop_printf() to inline function
>>>    - Changed option '--number' to '--iter'
>>>    - Replace strdup() to xstrdup()
>>>    - Added json output format for irqtop.
>>>    - Remove irqtop input file support.
>>>
>>> Joe Jin (4):
>>>    irqtop: add batch mode support
>>>    irqtop: add max iteration support
>>>    irqtop: support json output format
>>>    lsirq: add support for reading data from given file
>>>
>>>   bash-completion/irqtop  |  12 +++-
>>>   bash-completion/lsirq   |   4 ++
>>>   sys-utils/irq-common.c  |  19 +++---
>>>   sys-utils/irq-common.h  |   3 +-
>>>   sys-utils/irqtop.1.adoc |   9 +++
>>>   sys-utils/irqtop.c      | 124 +++++++++++++++++++++++++++++++---------
>>>   sys-utils/lsirq.1.adoc  |   3 +
>>>   sys-utils/lsirq.c       |  24 ++++++--
>>>   8 files changed, 155 insertions(+), 43 deletions(-)
>> Thanks for the update. I have created a PR
>> (https://github.com/util-linux/util-linux/pull/3435) to test it with
>> CI tests.
> 
> Thanks so much!
> 
> 
>>      Karel
>>
> 

