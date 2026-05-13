Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A693362149
	for <util-linux@vger.kernel.org>; Wed, 13 May 2026 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671022; cv=none; b=Oqbq71y64Lj4nKBFkrnSrJi7YcTM6qZ0LRQ2VLnm7nkxGatCkZ6uSC0sAyHWqe28m+3OOzkM4w/BOc1E+wtzJ993+Li1WzBbzd1GkK0e9mJ/DGLR5Al//9t/PaT0oTCiF0r9WqqHCAbrf4WNqVtGae3s3C4FJrI3k5ESM3rakxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671022; c=relaxed/simple;
	bh=wagihjThA7UoEdB3wWfcjh+0IltJA0/WWn8xmYzH4k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MA8+Lkn7Ag1H+2B72GKJWJqGZYG8d+0WzWYUNErx46obuARu65rJxvk40u+/coHKqtwjM0jAOgvrrxaSSWrO2BmVR5sAeNNWVyxEFOejdylEnWLhVstcd/yOXIDcnmbTV/+7lLyHwPRgeX6MaFka6VylZgwANmlaWunv7mGG+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0gF+OjD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0gF+OjD"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d734223e4so4105943f8f.0
        for <util-linux@vger.kernel.org>; Wed, 13 May 2026 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778671020; x=1779275820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPqt3m5rQ+MhQpvUeBLvuFzoX8zCFQTKfd2RCovPWxo=;
        b=P0gF+OjDcn/59jgntbe123Fzzcu9tRXKthAxFQdu+2TLO9C1Aeu4DyI+eaC21XX+qx
         RQLabBArj0EWnjUnfNhGtorDPvckUSJ899XnDodXo/x9NTg0itHdOIiRohsuWnL/ucII
         5jwDKdMIBMeyIn+uwnGSk1tZW+Cl/gO0ze7Kw348mcAOgfVsREy4JdfAXMaxQiA9N8bu
         SdlojN5d2KmG+VNSNI139tMaddNTkCHm70x3Lx/RYWtmQdmpbJE3Ag+yZodSVfzGwdEp
         i1Dizzk+cyyS8cvdAI2rpDLX7IpLjh+idhsjF683X4yhccOCCD03SZrjmnoCP0n7iAf7
         gmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778671020; x=1779275820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPqt3m5rQ+MhQpvUeBLvuFzoX8zCFQTKfd2RCovPWxo=;
        b=NS7aq0JmdSawTEb9V+7tu5U9qT7/Q9E7Vd6vmRTY94DcWAGxKhremd2Bf4a0ISpXQm
         5IYwjUCEeO6GQm2nOx7VITFC5s8eZvC55+8FvZ7kPc8dUj0qCiiwDOKxg3D22xw8elPp
         VaaGJ44HqeA3l2Mqd01zZ7tYxlS6Dr2m9uGLLzm1UVqaHA0z2ntcfnejrBU16tDOSGoj
         hqKwNO2/N5HkOQq8EWd/nbelO5x7QQ/NdRRF3UDQ25/PmqFX0WKr2lMcX87nASa65dWZ
         A9YJm3yVxf99O3Tp0Yr8MmTAK0/n+35VSbUkRKeckdtZWBnrTzXJYmuZWek74GKJRnTr
         tPtA==
X-Gm-Message-State: AOJu0YyA5LrlHFJ07f4ctcW5AOhfKyRiExJA9m6zL8A4oyL4ZAy4reAs
	LnlEKlogty53hzzEPwcET1Te4hl09wolvcxHLep7Sobt59/UfdqbOcM1
X-Gm-Gg: Acq92OHvqT5wV0HSFBA2g2yOwlLj9dSPngGYSqaN9q1reYcP7W4ZbpBPJj8resx4BM4
	ZKlPRT5Ki07qvUxXdpAYIiWCnlkdfxE4jVSk908qkpvcMFl+0SKm+xvhzNUO3kbHOL/5Rs63Miu
	1ndaTYJct9BcM2zobtl/MH89zbwBMujfduAOtSVKRxFDgW5YNcr3FKYSIenFvwO7m9AMd8eOAre
	VNUQDuiF/7NpN8QS9hGGcGccuuqJLWvIhnrNRSoye/r8YbkJomlWkd3iCrSbb8AiStxdNGOObdI
	yieNS2/yWycTg+4UJ7udneGAerFusUjFBDWJRqRDuhVbxki9v0P4cyN2xtBFLDJUKcXqbmnnrDD
	nY0kRzNW3V4M+eyGVW+CivnN+4LI3c46KKg5rIOtNHhIUdJpPbxGNylCE1CtH7idVnaJuYyDZvt
	5/g0CCoybyaaOqni3xvGhnhNGc6j2JkwkoHFejvCDK
X-Received: by 2002:a05:6000:40c7:b0:43d:7874:5d3b with SMTP id ffacd0b85a97d-45c44a52809mr4878021f8f.9.1778671019948;
        Wed, 13 May 2026 04:16:59 -0700 (PDT)
Received: from [192.168.1.109] ([88.230.46.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6a64sm41372264f8f.6.2026.05.13.04.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 04:16:59 -0700 (PDT)
Message-ID: <daf42ca7-1bdf-449b-91f5-3fd06f4182f1@gmail.com>
Date: Wed, 13 May 2026 14:16:55 +0300
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chrt: Add support for SCHED_FLAG_DL_OVERRUN
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, bensberg@telfort.nl, vineethr@linux.ibm.com
References: <20260513100100.31857-1-frn1furkan10@gmail.com>
 <vokmtg7drod6gzs5wdltod32yx5absvzf7spdne5wdu7gnv6x4@ujrijopovjn5>
Content-Language: en-US
From: =?UTF-8?B?RnVya2FuIMOHYWzEscWfa2Fu?= <frn1furkan10@gmail.com>
In-Reply-To: <vokmtg7drod6gzs5wdltod32yx5absvzf7spdne5wdu7gnv6x4@ujrijopovjn5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Karel,

On 5/13/26 13:56, Karel Zak wrote:
> On Wed, May 13, 2026 at 01:01:00PM +0300, Furkan Caliskan wrote:
>> When set on a SCHED_DEADLINE task, the kernel sends SIGXCPU to the
>> task if it exceeds its runtime budget within a period. Without this
>> flag the task is silently throttled until the next period. Useful
>> for real-time applications that need to detect when they are not
>> meeting their timing requirements.
> 
> I have added this to the TODO list:
> https://github.com/util-linux/util-linux/issues/4339 ;-)
> 
> It seems you (1frn10) already use GitHub. Creating a pull request
> there will speed up testing, reviews, and CI.
> 
>     Karel
> 

Thanks for the feedback. I have opened a pull request here:
https://github.com/util-linux/util-linux/pull/4347

--
Furkan Caliskan
