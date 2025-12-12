Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFEF7262D
	for <util-linux@vger.kernel.org>; Fri, 12 Dec 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765524949; cv=none; b=k+8RTkYYfjUTwMsgZc8I0oKpK2UG6lr5O88EVxAgvZ0B/NAoPSZK/zHWJtOQSlNNwtbIzK4I7TI3qW1Gzq6uo74atGnr03ApGes5A5JyvTNPupsGCqfhD7NOKa3oWUu0MFeFUOQWqOcN2N/mEblo/UhDeRuv6gQ116lxFmR1v1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765524949; c=relaxed/simple;
	bh=LoXy8kd3v7bxYObBhN/pQiG06v7j8CS0oiPtVdaUEbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecyIbkZYJiw6DrWPwzMS+V+k0SKgHTIxgOmQPXWgK2JVUMcIKxqPro/okd7HcXCxs+NYEfovzFXLUxRoUvP86GAryPt7WB+J+dh3/ZSQZLoD5b948tLAIr7cUyXmKD617CdmS941BCEXYfz0njz8D8qSKe7MMNzpbJqL897Ieig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJfG8e/O; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJfG8e/O"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso3744085e9.0
        for <util-linux@vger.kernel.org>; Thu, 11 Dec 2025 23:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765524946; x=1766129746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LoXy8kd3v7bxYObBhN/pQiG06v7j8CS0oiPtVdaUEbg=;
        b=YJfG8e/OWEdDhr+4k/hTQKb3GO+Bm/DS9o05V2pn7/+1UiewCidWsYafzi5OVI8ps7
         DEVte4ae4kQfiZvjkv0cItsafhRg867Geiq18sIAuQEubyHpII19GYnZ00og8rsuZFhu
         sZrG4B71BT60pXnZ81wXV116loWuGBIvZfOzm4JSFKHflM42RnkwSK468hE8RZjwOJG5
         nLonUmhAmtpMcL8l/unWNwAzs0F3W+4DrtVZjWpFhysBPDyi4oVJzfWya49dl5soKS5m
         PU00OxV7g9W0D9it18Oxa1js4fT769qxsXHLDpie8/P+AihkDHjF56vaNyGohcrmPw+a
         KbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765524946; x=1766129746;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoXy8kd3v7bxYObBhN/pQiG06v7j8CS0oiPtVdaUEbg=;
        b=ndrlDINm+FIKDvmt29z52kHKWNZO4FDwbgduXPEzFEJtkolIyyZgNmPgyGeauQxeDR
         nu9b4er4tn8pllm/lSjaKLB9eaSZ3GgHatbVbVInpK6I1iRFGm65z9mYyFpFLgi/FoT9
         6kmpC5NNOTJ8E9GwsE7xDS9RLnXqQFtby44BdmugwiOqB7mqUX1kdZtnU+MvuhuWbctt
         BQ4xk9/i8RejrojhAKiEqT6PFpA6znikqLpAU+JCiV5K501T829TLJi1LRAYR0vp/kHs
         1DLH6oQVVRoqhyrGibcR6TOtLZgK018QkOCcHjJOIYdN4WIC1tpthezxZgbsf8KJjatu
         IM4g==
X-Gm-Message-State: AOJu0YxJv0rQs8freXtG/GXHkv7BmwU+eY4x7q9clgPQiCSoqgdQZ96Z
	h0+fAHcf/2Jz5IGV1JYKRkvFMXhCNpaYdnSfMNlhRbOBIQLqGuJLDmiC
X-Gm-Gg: AY/fxX5yCiOnzzqvl/AcPlDZgdQZzZfVS14iB3yD2qtFOK3l5tL2UJM23mBZ4KRBwra
	5S07QF8GW0KxjVY/9N5y349ey1K1n3xAhIr3qiPqBg8sMAtdKWcAHnGCMJXUUpwClv0QdMplVyu
	fWqUZhkXH8YMgTAvlzK4liTMLQ7yKBah7hXRqmio9NySA2YF0qu+Pg0j2lo5gdPa9RrHYKFOZhj
	uJEAis698LJoiYg5+QwGiGcnN6Z7B3oSWfkrCBOzSj4U+dO/fV72UdC+P0R+y5pZ+LGFpf/zBl1
	oWrZxEnbUFzYzmaeJUotqc28JWmIFhrLaM3zXrXDBsZzCApfEGfFgcZxKWDee72NPXgaXvmM1x7
	lce9rMy6XxuX8s8+UDWZXncOqZ9D6X4cDB+/PuuS4XnUxYFnCi17KKvBbBvQStspHnXels6oMhF
	S4SScor6BHpM6iCi6wkU/BvOEXgZasP6CnCLnmgLenu/9BFyc=
X-Google-Smtp-Source: AGHT+IGCM8+4KwlXLVKfxgjK7+z8K4Gwb00CRVlH/3hRFAyB3e9HyGh+hO1Wk2LA8NkgYG4RTzJMuw==
X-Received: by 2002:a05:6000:4305:b0:429:c6ba:d94c with SMTP id ffacd0b85a97d-42fab242a9bmr5426692f8f.10.1765524945821;
        Thu, 11 Dec 2025 23:35:45 -0800 (PST)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a67800sm10597454f8f.4.2025.12.11.23.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 23:35:45 -0800 (PST)
Message-ID: <7cae1d2b-3da8-483e-abaa-6a629fb9e725@gmail.com>
Date: Fri, 12 Dec 2025 08:35:44 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Partition incorrectly identified as LUKS
To: Anthony Rossomano <trossoma2@gmail.com>
Cc: util-linux@vger.kernel.org
References: <13c13750-6420-40a8-a99c-35b46b9b009a@gmail.com>
 <A4CF73A8-06D0-47DD-81CD-0B852DDA0F11@gmail.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <A4CF73A8-06D0-47DD-81CD-0B852DDA0F11@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/25 12:24 AM, Anthony Rossomano wrote:
> Make sure we’re on the same page. This partition is properly wiped
> and formatted as XFS. There are LUKS encrypted squashfs image files
> stored in the partition. These images are updated periodically. The
> issue occurs when secondary LUKS signature in one of the image files
> winds up at offset on disk checked by libblkid.

This just cannot happen until there is a bug in libblkid
(which should check offset) or something different happens.
The offset checking patch was added later, perhaps your distro did not backport the patch.

LUKS1 must be on offset 0.

LUKS2 is designed exactly to prevent this to happen by checking
header offset in on expected location form device start.

If upstream util-linux misdetects LUKS, then please send a testing image somewhere.

Thanks,
Milan

