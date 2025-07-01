Received: from cloudsdale.the-delta.net.eu.org (cloudsdale.the-delta.net.eu.org [138.201.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35EF27B50F
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.117.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385843; cv=none; b=kxgyyWaIaxWr6lRAR2fR+gbdjAknvyKIYwM2N4YN6hhaRPBu6LrW21zeVFdLCvjwE3r1mYcFom+oYZQwHkmP4hBXHc6r/UJPmQXHHCZbQ6C9p3Qfr6QQKQ9yhrfZRxinhudri5IDMIawjgFgMt4j/ldsjIO/IaMxuKmbz4zdjI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385843; c=relaxed/simple;
	bh=p3reSW6yDus/jdHeltwFsdkL2AC27dKUTnQjOeRLa7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmf8/Bm1aTBGqaoBXC5wt/eSpzVyxqpHM/aWccBTFoiyQfLQeoOoU7m2EUg/PpAvDY7MjrK8zOfhmXfb2Y5faOJ3hOc6QW2Lu78eCN/ZfSHf+OcmGYF96x42FBXZUVnHV6gEdHryYKwb4ON1X4fHMZgle39Z8tkXg/AwlIRq7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me; spf=pass smtp.mailfrom=hacktivis.me; arc=none smtp.client-ip=138.201.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktivis.me
Received: 
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTP id 77921262;
	Tue, 1 Jul 2025 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=hacktivis.me; h=date
	:from:to:cc:message-id:references:mime-version:content-type
	:in-reply-to; s=20241213_132553; bh=p3reSW6yDus/jdHeltwFsdkL2AC2
	7dKUTnQjOeRLa7o=; b=B0NPaZSyAFmbPIVrohXDFQbg9CnKvfKUSW7igZJt/Wzs
	1yZtdfIxN8HKvS9VKCUvTMpXm2oYH7P6YJRrpZQjUw6thWF3HN+mtN9PbpZ9wgc5
	4c23jhCMFPxhPBNoQW2sAh0bebTppk+spilAJH4rAw6ltYgi3yZa9CGo550PMAQD
	5Q4LuRZqp1E9KwxZmm2PWvZ70SlxsLNOSgj8o+lqQNt91BNfWW653z4gdI/Q7HgX
	GaUv2cITFn/f71gWDIckWp6zrhoSGS5MPG3Sc6XVP+oj7k2BzfgAZnykLiucD2Uc
	z8CQl0/aJydoDGkgazna0WqRV5Uoy9aWtzUHh7uME0NnA9ZuteNo5HmqXUNUNWAc
	FWooQc6/cS1JZL8d72316BVFWMlQppR9CZUWO0+DUt89pmfJLCa09Btcgs/8QA/z
	C9ssanCisPoWjSMwOmzTbLC45+HXMAlzi0lz78EHD6q8/PgYb8cVak2//FrHWsfa
	cOq6EzUQXyDEA52v8sDePme0Z5/wQrgePAgGMEztPMdsg5zl2TfsRiXaSmuNlBVL
	pjeUK2PxO/UYNYGYqoqQmDrTjjealy55HHd1FZDY1vPNvL+f0d2qQi9FiUT2g9ue
	Lk1KifMWPyCey6cszU2EW0EKeZwfIhyt3gRR5cTWx/YmS6ZeNgo9rJlhtRAXnf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=hacktivis.me; h=date:from:to
	:cc:message-id:references:mime-version:content-type:in-reply-to;
	 q=dns; s=20241213_132553; b=Hf9OdEB43vvtoUHRU0a/5sKUiwj6+OxxVcJ
	dhXJeso//URTyANhA5oJVpm1YXY7TLwrUQ+uR9JY9FU6OOTxyn9eTRvvHjAlFKUz
	b11gSYQSSMyaQ6TlOzxNa7ou5/es7KH9xyEo/UZI/0HkWJUA+wDwcL0JWGWN49w6
	uMXjawRt6/19BuGNNOHVDBQCxRQF+5yjhChGFiHx+Vvru5s1YH/H/+MeNPfQoakC
	6bfEnYrmPaW0uaoGMn7CIeuKhL3vx1lnlRmQABWKPgQKLDpYinTEmnd/ysiNAHfP
	JVKDnGuAw2AFdQyey5+N00j6GlrZ/wWAvRt50xjxy+cC3u4BkrFMDA0N9Ne6fLkF
	QYwVrxEG1JwFOJiNUNf1MUYqEX9xWyzQt8880Ugw8C91vuC0xEL7p/OHvelcJ+3X
	G0R2ckWkx1JiJs2c9e9d3gXpN8/3CoaXf6httlg9IX4Hon5VEMaP9YAuqDzx++yT
	9vum/Q1IlNoTpb9hKqq2sesqZxMivlUgMovpyrqIMGAAvdH4sPnwAQkokQ37JGEN
	DuxuEdws/RGByZzsn3MxSLwbx+ZCWQ1+42/zP+6hRPQVW7PvogqybckGwspiMTFm
	jlTmJmcMtfCvpJhf/tlX2EDs6JCmn9gTqL+40BbmcmI5d522B9V/lWVQliluDRbV
	NkmfXCj8=
Received: from localhost (cloudsdale.the-delta.net.eu.org [local])
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTPA id 81946b7e;
	Tue, 1 Jul 2025 16:03:51 +0000 (UTC)
Date: Tue, 1 Jul 2025 18:03:51 +0200
From: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
Subject: Re: [PATCH] rename: change "expression" to "original"
Message-ID: <aGQG5zND2hha9gyx@cloudsdale.the-delta.net.eu.org>
References: <20250621232642.17613-2-contact@hacktivis.me>
 <00bb2e9d-cf47-489c-a881-81ab2edc2fe3@telfort.nl>
 <fkvvnjmv7r4uchsmr3qjr23omaw4iixuphblmko3uiczdwimzb@q4gxzqfmx4ix>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fkvvnjmv7r4uchsmr3qjr23omaw4iixuphblmko3uiczdwimzb@q4gxzqfmx4ix>

[2025-06-30 14:08:01+0200] Karel Zak:
>On Sun, Jun 22, 2025 at 05:51:39PM +0200, Benno Schulenberg wrote:
>>
>> Op 22-06-2025 om 01:26 schreef Haelwenn (lanodan) Monnier:
>> >   == SYNOPSIS
>> > -*rename* [options] _expression replacement file_...
>> > +*rename* [options] _original replacement file_...
>
>Yes, the current situation ("expression") is unreadable.
>
>> >   == DESCRIPTION
>> > -*rename* will rename the specified files by replacing the first occurrence of _expression_ in their name by _replacement_.
>> > +*rename* will rename the specified files by replacing the first occurrence of the _original_ substring in their name by _replacement_.
>>
>> Instead of using the word "original" (where I would first think: original
>> what?), why not use "substring"?  It describes what the thing actually is,
>> and fits better in the rest of the existing wording.
>
>It seems that in documentation for replace-like functions, it's common
>to use "substring", sometimes the function itself uses "substring" in its name
>(e.g., awk gsub()).
>
>Haelwenn, do you want to update the patch?
>
>    Karel

Yeah, sent a V2, wanted to wait a bit in case there were additional feedback

Best regards
