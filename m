Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E383B8D78
	for <util-linux@vger.kernel.org>; Wed,  8 Apr 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655416; cv=none; b=adXpKu5BwhS5385qUBU/JOsyIYgCaJLcWVTOsfe/KNwNxrA3I2l05QNigpC7dET0p+YRFl8PDgevs4Vct+FgzAlk3f/4PWtQQZgfDbeO1hUI3RWl4IfnxYbEFQ58/v71e8uXTl4sxVo0U9Om1Gnyl6VypzcVS+igsa2FHEApM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655416; c=relaxed/simple;
	bh=s90i9uUcuTAE3hKX0UAH9dlUiSmpMpO/fBSGQ07QflU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nyy1CzU7UvSujdEDNBpItj/eEK/3OFyY/j9iWXMry/xZGx5PPzfHmDsfLn7eMunyjt7V3aWly9Kdj+byNWR+ruqKE7eEjrrQ9pRaYtX2mcgo7CDYNIBrMmribb6kwi5ACIKmR38O1uy7JYVYq6f3dEJNb0h8MsIzAebw6EFyj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQEGxvj+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQEGxvj+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso56086785e9.0
        for <util-linux@vger.kernel.org>; Wed, 08 Apr 2026 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775655413; x=1776260213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s90i9uUcuTAE3hKX0UAH9dlUiSmpMpO/fBSGQ07QflU=;
        b=WQEGxvj+46/hLYslHPvyJ7MdEVUI8Suuy0kHLSVvHMqNJMZmJa6GB9PyePDK4UyGkB
         Q2fCevsEy4vtFfOgce0eqybdcwW75SS6y7OfOTA6OixNRcgbtzLH12WJxDEYWy/ahecj
         GNvQaFPYEfysE8OffBmN1f8J7CyKxZKQPx16GaXfyIZvcHenl54cprI1Ch+ZpzZ8GmXS
         YlKlyGxEKdQcyiAHD203Zy3NGmQ4x1O8sPjQOOyM2jhkKZg7NKOXwMsdc/drXCn83Y1p
         RJrnmwRNhHp6fpGu6BDHBUbMJ6rx9F0fAkvmHqClGy+Vq7afAg+E/ks/0xRhEjj1HXXA
         vb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775655413; x=1776260213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s90i9uUcuTAE3hKX0UAH9dlUiSmpMpO/fBSGQ07QflU=;
        b=DGCu77eH8hTdL6Uxa27OcRvh0QT5PG/WDTw74/dIYgln7x1iDrCWsxexrERI+u2wAe
         ftCytal6GN+GcTmTPfDVYZFl4cC9nUcBcIJhCEjKKGUpx58auRTuLDKz5BcxhJgt8JSn
         VhZEqLKRCQPv7dZQJXI0w5Ydjj+FvHASNQ1qrAqQDnsXbXSkrc3L9+ZJ+du0FqSYoO6X
         9oU00k2VWtPP3xWlR6bT/XG+IaR74sTo74poDAT0QZ6IlLw9+ACqMCoQZpAF0vh94m6Y
         bmr7dIzCBJlqssroJXlafhxWN1HIpakMnkv/TXf3NCH18Kl7zrSF6L72lGRmidb4xbHI
         cZoA==
X-Forwarded-Encrypted: i=1; AJvYcCX5fr6W9PHJLmYJqlc0FgGN+vvf7CXMvr2+NXKJo5E2/LKmlzLocuHpYsqWHsk07MoZx91CTdigogz1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6wkN3vedg+n48DDdVUUDvwAkCX8OXBBwZcjkHn9gbRz5GsaDY
	zo+oxxFs9bE4sAcyJX+LY1hH9i4wl5qGwnH1+hU1n5KtOx7E1OxlQbg1LoILyHht
X-Gm-Gg: AeBDievW1lMSkBRTyPHyxsXO6f5hsLYevkQe4xfpjwLyqIOXsdDd23rYR/bbngalYnb
	FV23cDaSS32Ku7UFmn8jA2FWF0WAKRRRkCf5I+5yDuleypI2HddFrTyeNKz++bGMN+7nJk2yX6n
	JIKAHgCXxVRZ/795vbwoTndHBFFyLWzujuhplH+Vo+Rdt2LqF4wXLFpioKlD+vSXbhfhSrGtS9o
	Zjs+6854+vZ50hay7r1dqL8BNLtomMSfY0DBjGDENMj8xBihBLMG5OfPG7wRBFH4DCjv7noFub4
	rOtjFeCmUXfxLkmE6c0u5fMMv/Xw/ZF/mZBWEh7GDZfoB86mMx1pFJbuBcPOT9TkYXr/SNTf+FB
	EvNcdtjWfdBOJthQ+XYNa7mp+ZhuM1yqK0x5Yam6nDrHdShyBUBH8hA50rnJRRG+Lp4KLjAd8df
	ee4HRYmxHu+nOxUlxqojjau+Fr/AP8krpJ2PUDzoJuQ8c=
X-Received: by 2002:a05:600c:628e:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-488997dd822mr271309095e9.21.1775655413175;
        Wed, 08 Apr 2026 06:36:53 -0700 (PDT)
Received: from ?IPV6:2a00:a041:265f:d600::ab41? ([2a00:a041:265f:d600::ab41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488940e075esm527818235e9.9.2026.04.08.06.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 06:36:52 -0700 (PDT)
Message-ID: <cc9deabe-7529-440d-bb42-67740f47dfc9@gmail.com>
Date: Wed, 8 Apr 2026 16:36:50 +0300
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1132887: script: "script file -c command" stopped working
To: Karel Zak <kzak@redhat.com>
Cc: Chris Hofstaedtler <zeha@debian.org>, 1132887@bugs.debian.org,
 util-linux@vger.kernel.org, wanbingjiang@webray.com.cn
References: <88e0b54d-3c86-46ca-ab3f-e116073216d6@gmail.com>
 <adS9qeW8w0bmUukR@per.namespace.at>
 <x7m64hxjjld7rkfjwuta75hzmj3f6en57mpvdfttzdliebdqxn@ym5mhuzim23o>
Content-Language: en-US
From: Evgeny Kapun <abacabadabacaba@gmail.com>
In-Reply-To: <x7m64hxjjld7rkfjwuta75hzmj3f6en57mpvdfttzdliebdqxn@ym5mhuzim23o>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/26 16:26, Karel Zak wrote:
> I have created bugfix for this, see https://github.com/util-linux/util-linux/pull/4201

It seems that this fix doesn't handle the case where -- is used as an
argument to an option. For example, `script -I --` before v2.42 would
interpret -- as an argument to -I, but the pre-scanning in that PR would
break it.

The value can come from a variable, e.g. `script -I "$VAR"` and `script
--log-in "$VAR"` will usually work, but break if $VAR is --. Similarly,
`script "-I$VAR"` will usually work, but break if $VAR is the empty
string. The only approach without special cases seems to be `script
"--log-in=$VAR"`, but it doesn't seem to be very popular.

