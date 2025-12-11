Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48028A3EF
	for <util-linux@vger.kernel.org>; Thu, 11 Dec 2025 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765488134; cv=none; b=OlF86GpJZrVWpcLzbjO1C81ln/I1JfNiTKTI9SUTrlBfwahs4pFvIJg/1SuSOIfBAUOokoa3vXZ+NgQRFIktOPCDt34OjTS189kNct72FpuReHrsVPmet5D/ZgqUk5qt1RO/V/ddhk9IkJXMpgQ1ARfmEQHw5L00OyPOuUskzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765488134; c=relaxed/simple;
	bh=ZspFC/1nu29AiBDY+ZMeNjO4PpR+a6kiV/3wh8TywAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O0Xcy6ljjcaAMKL2bCCWxmBhxxzuF4eqZNlX6FNpPFl0AAA2uqhKNV2F6ujJ9Z2xaU5YlFMDllrWGU16XMbxuWn4PS6fey9lubXYr5q4RKvoXzZ0gvfUQdF+boGZiYfu2KcJg72aeBViJZIK6xnmbidO3XFgCJsFmIfBGqoBeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEbzyalk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEbzyalk"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso4015915e9.1
        for <util-linux@vger.kernel.org>; Thu, 11 Dec 2025 13:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765488131; x=1766092931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OqStxZfYyllVwP3LCoaJVpTLLGXSkB4ijyjb3l07dcA=;
        b=EEbzyalkkUO0as2o46hSeep4MvFmlN9N179wo6BN6SFt3uOd7qklsXTjkFgeVVfnJH
         buBvVAciIt2D6i9xsMOKYvEtrAjHlZgabHZ4sT2MUGBU8Zj6GcLOGfgT3P8bqXiGw4RV
         +V20qTunsDZZKN/e98/QhN2nNcmELSs8t3RIkC7uSlcMlY3GH4PexzpG4qJzeyxbow5F
         zCiI1Osbp4uVqXUpRTyqRGhA/xiRQJh3g3+DbO7CzlpBAEUXKtNcqOik4fDUS3fkEDVo
         XZ1Lz4EB7qb/wCPJBB3UM4J4esGMlOhKtoYBIFJv64sGfAbLAQ9Q5A2qNVcPDlG1rSsa
         mm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765488131; x=1766092931;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqStxZfYyllVwP3LCoaJVpTLLGXSkB4ijyjb3l07dcA=;
        b=Ok5cRAkwEriJqNhRbH3HEx3v6PVuA4lqb+P3h0Jg+DtvK55b0QGj4JqnRNPNq2cVN/
         9apViIVLpbohCmgoWhOROzo3KHRZcZAVk6fDVduQZjEmbq3MhjEj0UaQM3OofhOIpf9w
         SJZU+lJTSGQmES1Bn/S/yR15XPJNDTBHuC7mC322StdIMLm+ZcU+ajn35efVpCCe3gkU
         QHX0jA2vkXMLdi5UUI7tqhHiYTFEuUf4LbWmIxjbAP0DB+kDXqauyqxrgCL3P8foVDve
         v+AH7gqmGC4n4qPoVlKWhPxlZs21SpMAhf0hGN+zai+xeuUXo0DeL945SgJZ7RcEE3ug
         cAAw==
X-Forwarded-Encrypted: i=1; AJvYcCVPvu2TwXwWtxi0/vjyxPxyzacJjHapxvUjeTqC2Rb5pvkjlqECglfVgHkFL9mIYUyQj07UP/W5Wjvd@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKPcnwVlFeU8W0xqaFE7xkF+l4G3T5MFEq+uP4z0pDnrseasM
	9NGZVOeG3a9+9SsGq2VWQixxXwkkA5bSbaz6YNI29nbyqKFXMaINaGtd
X-Gm-Gg: AY/fxX4dZjiBmhRmiDg8TUlx61VrbTOzSVzyX9lO6bwzMTvC7Y6c+Sdfaw6564UkUBH
	/HrwEgFmQn8kKK5hKylHWxJXHw02N0LkTXMY84VEH7P1OpX6mlANztJj8ifyQRxO5AeTgcO5Dzu
	NfKhMjox71OoEz9+pMX304B/5jifpdZSqoR0mDA4QSgHXcNzzq8iutw/u5MpdBZvPz7pQeZVNOq
	6fx00FsCawGoqCEHq/0A1Cg8mdgJWnycwyZtWyk14K76IBW6ojxGuy4uyJZjbzfyJRg09PPNOCA
	aquC9xqV0mjyxRX5KGxbSJZv1/xSN7Z4ie5tadMaz7jV26hv5lFsEbJln0/EhT0R/qt9jqpfYJ1
	yW0g1p3JnL3bqQIHCA+OPfeM+kaCbVRAUlO7nCcD9IDDkEXORINeWdLICal9uwlUJXkanztUJv7
	Lb4M0QJcqZt5sURwoASoLnU4VUrVDcUb6L2gz5
X-Google-Smtp-Source: AGHT+IFAHUauzgLLqpZibM4kQq1CLjI7cJxOfsM04FiwgHpujLXZYSTw0iQb5RePMiO4AppUMp3GwA==
X-Received: by 2002:a05:600c:190e:b0:47a:7fd0:9f01 with SMTP id 5b1f17b1804b1-47a8380641fmr83124645e9.16.1765488130484;
        Thu, 11 Dec 2025 13:22:10 -0800 (PST)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f74291sm53756005e9.11.2025.12.11.13.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 13:22:10 -0800 (PST)
Message-ID: <13c13750-6420-40a8-a99c-35b46b9b009a@gmail.com>
Date: Thu, 11 Dec 2025 22:22:09 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Partition incorrectly identified as LUKS
To: Anthony Rossomano <trossoma2@gmail.com>, util-linux@vger.kernel.org
References: <4C27EBF0-B758-4528-903C-9199916EB6F9@gmail.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <4C27EBF0-B758-4528-903C-9199916EB6F9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/25 4:20 PM, Anthony Rossomano wrote:
> LUKS image is stored on XFS partition. When secondary LUKS signature
> winds up at one of the offsets checked by libblkid partition then we
> have the side effects of partition reported with crypto_LUKS fstype,
> no by-label link created by udev, mount requires fstype, etc
> 
> Don’t think that this has been addressed upstream but need to
> confirm.
LUKS2 metadata contains offset, so it is not possible to detect
it on a wrong offset.

If it is detected on partition (secondary LUKS2 header),
it probably means that partition was not properly wiped before reformat.
(wipefs -a should wipe both LUKS2 headers)

Anyway, without the reproducer image it is just guessing.

Milan

