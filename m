Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C085C62
	for <util-linux@vger.kernel.org>; Tue,  5 Mar 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648171; cv=none; b=q4zo7kxFRGYCbQn7TWztmvz/6XyiMlCLPcYhx9SAj+YlM9AQUFjDkSfymdIHFuXRTxZ3FzAlE9VB7F0IDquN6y39lONPspm7z0PJRdzgrycgr9M5c8qrl/EYxFYhwxt9tZnuPQcp8NRhW2IVV3Vb+t4mjGl5CAtdk0n6o6AEbiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648171; c=relaxed/simple;
	bh=Id0jHNgwKBj+2MKXE/xec6wqp1TahOr30CXaqUMCIFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXbndakQRj/Ty/h3HjCB8PUNmxEELgZUuOpU7XFWoBufeVZrb8x0KGgF3bLPZgaS2R0Bbe72VINNiQJeZRAG6Jn+TijZDk1Ld0HkdzVoYmJ6QlJqO043KoajpYIGcDmGLCv4CCbia9ylr0MZfxHXGGvPZbna5iXtH1/YkvVwHI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exGSKvfq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exGSKvfq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412e783c94fso13409055e9.1
        for <util-linux@vger.kernel.org>; Tue, 05 Mar 2024 06:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709648167; x=1710252967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KzS2EnTgw+IwZH1NLDbGVvnlL7zrQcj5TIrlzpV+svk=;
        b=exGSKvfq1treW5svWPw9fd7fqvHWmxz6TJ8ZSffvXtl5CHbYjNOy72/0ysEhXQ2l2R
         4VsRmCHtWp0A8qQLw/6/xnwjai9wPscQC9nRdL3L1GiA0A1wC0QYKeP2AxIy3hTf2vcx
         AAwH3bO9GKTdIvmJ4JWtP6GKpK5HnOVOosk/9LfR7PTFA1ZQX/KgrEwLroALcXLRPUmP
         FDt1WFqB8wrdUluoU6cBNJ0WgpL96kSGJ9MEvRR63qr65t2BBzu8r9Pp8j9Djpq2ekJh
         faV+DMgbn1AGlnosYuetsrlusJnR3/gLk1RmiXT0WaRrBvKOru0EBc1yvfYTRySNRVqy
         rQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709648167; x=1710252967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzS2EnTgw+IwZH1NLDbGVvnlL7zrQcj5TIrlzpV+svk=;
        b=dKkFdwwhRWx16Y+Ch6f07scsjDNyotOhQABbTuTJkMDf/e07sRaDVhT1I2faoL89iF
         QzKmNO00T5rCXBPvfvEQnD2Ne7QWWRzhYso+qVoUXl11MsO6bhugOU5dqqcqo31I4U8e
         Mi7PLHiERjRVLeq4Se1U3V80IsLmL6Gw7vTP2YNiyi1W7rlL8AMG/sffbRke7UzZLa+2
         BjUfSXI1Xp0/nBnhtbbchSWWjTdsmzOfh6rAUBov2JWzAty39X8yq89Jooz44SpPM38g
         gYJAS2BvbBIUVnv+C5D7vXMWHNlD8nn83tqDP755698zg5myuVejKUCojTV7/Xx4zsmU
         0leg==
X-Forwarded-Encrypted: i=1; AJvYcCXuYoS6zFYEEXn7SbaSc7YO8UewdpO635XhS/pPjnoR/aERzQds0gsKPLxlCd/PXOwHNWQ1b1R0VS5YSzWf1VgGi47tdPC+fXAsfA==
X-Gm-Message-State: AOJu0YyEVrVtS6eYh1Set+yeQBxyQeNe4JYPTSmsSVc6fNKnATHFJFnq
	BBcCBN9M8vxcMkFC87p0hqqDE1BLltr/ZLfKSC1F9ujUv9Z3MwA9hD6DVlkC
X-Google-Smtp-Source: AGHT+IE1WGVaMzGYGbqSPRvc0w/Dm/JNeswI/pvz2G9qioKhz9rUZiUtP4GGKMdcLFpaYqRAhlyb+g==
X-Received: by 2002:a05:600c:a50:b0:412:de0d:6a47 with SMTP id c16-20020a05600c0a5000b00412de0d6a47mr5212161wmq.18.1709648166650;
        Tue, 05 Mar 2024 06:16:06 -0800 (PST)
Received: from [192.168.1.56] (86-40-129-3-dynamic.agg2.lod.rsl-rtd.eircom.net. [86.40.129.3])
        by smtp.googlemail.com with ESMTPSA id e18-20020adfef12000000b0033cf5094fcesm15047724wro.36.2024.03.05.06.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 06:16:06 -0800 (PST)
Sender: =?UTF-8?Q?P=C3=A1draig_Brady?= <pixelbeat@gmail.com>
Message-ID: <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
Date: Tue, 5 Mar 2024 14:16:05 +0000
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
Content-Language: en-US
To: Paul Eggert <eggert@cs.ucla.edu>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: 69532@debbugs.gnu.org, Petr Malat <oss@malat.biz>,
 Rob Landley <rob@landley.net>, util-linux <util-linux@vger.kernel.org>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
From: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>
In-Reply-To: <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/03/2024 04:10, Paul Eggert wrote:
> On 3/4/24 16:43, Dominique Martinet wrote:
>> Adding Rob to the loop because this impacts compatibility with
>> toybox/maybe busybox implementations
> 
> Busybox does not use RENAME_EXCHANGE, so this isn't a Busybox issue.
> 
> Toybox mv added -x to its development version yesterday:
> 
> https://github.com/landley/toybox/commit/a2419ad52d489bf1a84a9f3aa73afb351642c765
> 
> so there's little prior art there, and there's still plenty of time to
> fix its problems before exposing it to the world.
> 
> 
>> I also see --swap mostly used by scripts and this actually feels a bit
>> dangerous to me -- I'd *always* use this with -T.
> 
> Yes, it's a problem.
> 
> By "see --swap mostly used by scripts" I assume you mean scripts that
> haven't been written yet, assuming that nobody had -x until yesterday....
> 
> 
>> (by the way, what's this "rename" command you speak of?
> 
> https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/
> 
> Now that I've looked into it further, util-linux already has an "exch"
> command that does exactly what you want. This is the command that toybox
> should implement rather than try to simulate it with "mv -x" (which
> causes all sorts of problems).
> 
> That is, toybox should revert yesterday's change to "mv", and should
> implement "exch" instead.

I think having the functionality in mv(1) is better than in rename(1),
but since exch(1) is already released that's probably
the best place for this functionality now.

A separate exch command may be overkill for just this,
but perhaps related functionality might be added to that command in future.
For e.g. some of the discussed functionality for a "replace" command
might reside there.

So I think I'll remove the as yet unreleased mv --swap from coreutils, given that
util-linux is as widely available as coreutils on GNU/Linux platforms.

cheers,
Pádraig

