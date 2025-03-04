Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B66165F1A
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2025 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741060147; cv=none; b=bygThqltS3LpfOSEzyAt/1jZm5oMzpllrUKKaLcsW24aUxA3BTfZBrZuDYa6R9INC4qVIvPCHxWlH+8BtNek21FbodvfEyznLqbZYIMBbckIhDkEyGn+ikaIQYgJEjwwVRm/fVYVzQ/v+L+Ccif06Z/66zIF+kYO3+UJGH6okbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741060147; c=relaxed/simple;
	bh=kPhmxc+hvFIBfyMmMU3kCejnhuBviXWQ6r8fk73Ok/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPmhq7OFQNfERaBLkGWxccV7ZFf6ZmI46xpb2DI7mva2Q2l8qINgMHSiKy14RoIURFLoxEGs72R3n8R40oC8JAWKaZDJy/tv/AN7C1gjRuLsdem+V12XxTN8djYFY/hXqrjklbg192se36RMjkCQWph6aDRXvW/D0EM3is/o/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h0HX1jKL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h0HX1jKL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2237cf6a45dso45932715ad.2
        for <util-linux@vger.kernel.org>; Mon, 03 Mar 2025 19:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741060144; x=1741664944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=urd72V0b2c4EEzzCCgHkA41aJ/GlZVoSdf/lvQgHne4=;
        b=h0HX1jKL3iTFotnxB8QD0O3GvJG/NhhRQRykccI4iIZpNLQAUtRXxeO+SZBSV3m8xp
         UJnxr/++UeS4jJ11/lK68ZLT6JuMXZHYJv5AYt3dBUW7Usd8Q9/eQeK1bXlKWd6icWXd
         pHSafvh7VyrpmKEVYhx+fFyR0QnXJV0foqa6jmdHdzKjl2LCQMsc4pMTfzlRRP6twSh0
         Wds5AdEDc4VHcgEEO1COjbEuFVxaIKgKQX4OdDAQI184M1xXx+PPDakiPFPTH0S/YE4F
         XsWLp6OZBj4nCZGkkZR98ck+QckEk1Pbq3F5jEM95h4StMHiiGo/uve4NMmv/nGkvge2
         PfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741060144; x=1741664944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urd72V0b2c4EEzzCCgHkA41aJ/GlZVoSdf/lvQgHne4=;
        b=U1czSQUraRJPRModSSC7Btex+D4o2yb3x00UgMjm6jfy6ZFQLeL4R36Rzx+EzVfXcS
         6ZYs3lzSTw/wjEQLzwTPz+FlZ9ZiU8lFpNUuYziHgp1i68KPgp/eQp/c+X747Vo3jGLF
         uEYigv6jbqqFCRvZZ2/GqeY4V9DHq2rDsKvzcjxAGyB0/mizfDi4Cc4/B9onDZJo9njQ
         PTxWq7fsrMAu7SdZ04v4Ecft6HYGsgjaH7ox2FMvv5zV7iVdRnh5ObZHL/vLJbOTYpvN
         OXeUmK3NiCiAqUzYymnSc/xxJaiQmNYYI/WsNk2jEwYO65qaGBK0wU7Ybqn2HNOMdZDv
         odqQ==
X-Gm-Message-State: AOJu0YxIOtfm5BK5k43NU2qFHXn5JdhIIU1LKMB0Bg3MbRgjeiyuHQTt
	p6yfO5DTGhgpRMdclJzi/SAuJsMUXUVUAAdQJ/1c4SJ/+hvdjq72eyS+7SS5jAk=
X-Gm-Gg: ASbGncsCtrLhIo2/nBmSsLu5HOJka4FpRVTv2UflaiEkoekw7yJVSXSASQ00GwoaTFK
	/P+whXDOcE50gMpOItlQ7vWrNlihzD+4B+6kYYpbVOVegWq2yW3ousb6jOKp2p3/eD4/ztQ0Z4R
	/fBEswfSzJ5eP87pw8pZLcjoDReirp+8eF3pwUgQtHc/yElzinjTdJNWWOEFsh1zW9+kefVuyXa
	wMrZByjXfRKzmqnb4Hkw7To1AMUH6gAHVdSG/wviyoWJOUCgnW/2+3Iu63j75uptU7IUsOKELJB
	YlRUBSqJJXBdK5vi0zfIzb5+m9cQzX0ighYQgWsKL2CndDCRyQ==
X-Google-Smtp-Source: AGHT+IFL5q2gDpbEY3F88vSCgkt1hw/vQBNFHpQWZmaY5ZHjzhXuoD2fJj5QdzzAPitgzOh1q7MP5w==
X-Received: by 2002:a05:6a20:244b:b0:1ee:e96a:d9ed with SMTP id adf61e73a8af0-1f2f4c9a52fmr27570431637.7.1741060144523;
        Mon, 03 Mar 2025 19:49:04 -0800 (PST)
Received: from [10.3.43.196] ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe51057sm10105557b3a.69.2025.03.03.19.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 19:49:04 -0800 (PST)
Message-ID: <935663c9-8193-45f9-90cd-eab974884bb2@bytedance.com>
Date: Tue, 4 Mar 2025 11:49:01 +0800
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH V2 2/4] irqtop: add max iteration support
To: Joe Jin <joe.jin@oracle.com>, Karel Zak <kzak@redhat.com>,
 Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
References: <20250228161334.82987-1-joe.jin@oracle.com>
 <20250228161334.82987-3-joe.jin@oracle.com>
 <db814aa0-e91b-4a37-81fb-4c849c4a6c0d@bytedance.com>
 <5c7df987-2c12-4716-ad7a-f553e6c01a1f@oracle.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <5c7df987-2c12-4716-ad7a-f553e6c01a1f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>
>> If ctl->iter is initialized as int64_max, then we have codes like:
>>
>> if (--ctl->iter == 0) {
>>      ctl->request_exit = 1;
>> }
> 
> Yes they are exactly same.
> As Karel has queued for CI test, maybe keep current code?
> 
> Thanks,
> Joe

Fine.
