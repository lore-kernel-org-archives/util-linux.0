Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63F18CC0B
	for <util-linux@vger.kernel.org>; Wed, 18 Dec 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516785; cv=none; b=dNgHd761njYOHjPjFRuNysX6I7G568UOK8vlz7/kY/JlUuLstQ6T2HwTUXwk7A5m70vmOiydBCkyIWxjYleKirAUyM+0+nEGvLJShvzhv9/SJEfU6IObpomuY0kfVoe2ExqwPGU/ec2fxbFCA03kqv89f3HDMMJF11c/03qjNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516785; c=relaxed/simple;
	bh=XcJHhDJoWHMwTg2Z2D2evuIPF5B+luZUnVa6cTHbvn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbFZk1LhWZbq932hA+NISey2nj1oJxLg5W4aI435RCyZSf/fPgSn9juATS5d9vvDWtdal85uaeFhvglaAYyZPqC/TWVTX7JO6NgLmiiPTui013DCSewuE6BYcHOLtA7N26P3vegZwRl/FldRXdNZOWagph2Lw/iOeivNUVIKub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njWepVxO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njWepVxO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso3485565e9.0
        for <util-linux@vger.kernel.org>; Wed, 18 Dec 2024 02:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734516781; x=1735121581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgrtqXBin1iT6QaRljR5QkgSdE3ZFkLvNO0/qisTma8=;
        b=njWepVxOKhCdMXA3uP/gu8yhzPrn74NnhRqr5PrZkd9U+wecqzcQWcBcMI3+LcLCP8
         i1tprHA2kBuqYMlEctWkQqgU3h9dJr/aXdkpSD7jrZTAItLK8bUUN0T1SRbFwd6YfJTU
         OPt8Z+l3ZhxlkayJfgdYfi+DgGYiYIECatYsx9Q5oU84XsLztjzbqjiCNlWiwvQmZA8s
         ceA4lJh/1A4PdGt/DRyezvgjALn6LLC74T/fnVB0mNln+NFpmban+chchZGIaTR4Df9p
         enW8MJFTBoFaofQMRiyBJiFsTxnVoT8uaaldShza3eEzFwNGB1Vk6LHxetBe5gOOnXf2
         Q49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734516781; x=1735121581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgrtqXBin1iT6QaRljR5QkgSdE3ZFkLvNO0/qisTma8=;
        b=UBdbsdM4hd8MG5rnYXx+IRaI1nCYzlDnZMVqdZkCq0Mh2ytoirSx/3Ol7CrFqWT4G2
         i43KoahHfnyPWZzIqeu04EsbxjAmFlNObO8xdUgTbB7U4aSWudfBsJM1cioJUFKL/Zxu
         wwcEO6G3Unjd8hhsneouiGKXePv/wlYUelUy0shqoJCrV1lCB5Ujc2MHbA9FdnM2t7Ka
         9ipqrF0P/SStmvNYoJ8W1/7OzOga9EyCRaotjkDstfEGzD7LyjUBRQ1nGAD9/Ep4U2MG
         n7pL1tGaH5kEWdNh0WFWHo0m3AF2Zg3AwNAFb/YUyxeE0xFpFgO03/XiJJOANL7vbBXe
         0Qxg==
X-Forwarded-Encrypted: i=1; AJvYcCV7RwZ7+1oZ5iViekloACmvZP2E8+8zI4SAktbBmcFZhvUrvTkNDcpOsAlAXZ5rodozz2H6PRuNxmTm@vger.kernel.org
X-Gm-Message-State: AOJu0YwOV41P80kpYYg9a8WGeZ94NL2EPrPC+wSMmW2W3QhM9/B1KXNL
	lpMtLo5PtbbNtoSc1KFXi0bW1a10KnORCcd6X8gNMBV+L8KN7H8C
X-Gm-Gg: ASbGncs246oFISdbuDVkkop9ZnP0Yri43CEQprAmiZeUeBDAqYCeqPV7YN706YNmbK0
	HK39pm6fdkpVnDqky8S18dRKOQGYT3qDUM1OiaSxRCBd0+31sO9dPrWbW6KZ6FOmcmB9qrsaF1H
	OWXX9s+mFCYxxrOBgBW3ONncDPKr0+vRhVzv50VjERB+SyvsPR/US7meZyXMeHDFk5Hnt9XYWi/
	j+dkDc1jzmMj9OG+1i0b4eJVdHJxSKQxFfmX1b3riIsfySuPvM/+LAgRBISxYs2U1YUBS2/t/C6
	IfmaOZoB75mSpSZW/rm26EI4xZwM3YBqGV8=
X-Google-Smtp-Source: AGHT+IGXXMkXd57gXVc9n8sSX0uU0Nvp1CRk7tizXOXcewE2vqXBKoAVzbggRbGBkWeD6m2GW0uMeg==
X-Received: by 2002:a05:600c:1d19:b0:434:fb8b:deee with SMTP id 5b1f17b1804b1-436553f2d16mr17004065e9.16.1734516781240;
        Wed, 18 Dec 2024 02:13:01 -0800 (PST)
Received: from ?IPV6:2a03:a900:1000:7e9:403e:7c8b:351b:f333? ([2a03:a900:1000:7e9:403e:7c8b:351b:f333])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm15371375e9.11.2024.12.18.02.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 02:13:00 -0800 (PST)
Message-ID: <dbc7728b-352b-4982-a171-d8f177388a19@gmail.com>
Date: Wed, 18 Dec 2024 11:12:59 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: is it possible to add a new filter to detect unusable partition
 types
To: Michael Chang <mchang@suse.com>
Cc: Glass Su <glass.su@suse.com>, Heming Zhao <heming.zhao@suse.com>,
 "linux-lvm@lists.linux.dev" <linux-lvm@lists.linux.dev>, grub-devel@gnu.org,
 util-linux@vger.kernel.org
References: <826b5136-7ee1-4664-98d6-a3441883f53e@suse.com>
 <43D73CB9-32E4-405E-93A9-E985C94F4A9E__33327.0934455626$1734427189$gmane$org@suse.com>
 <ec0d03c0-40b0-4719-a020-9bae7a3241ec@gmail.com>
 <yjiu3c3e4aknayawhw7lw52kev6fvp4wm6n6wte4t27hx3fr4u__21682.4523567752$1734439545$gmane$org@cc5bu2ij2ia3>
Content-Language: en-US, cs
From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
In-Reply-To: <yjiu3c3e4aknayawhw7lw52kev6fvp4wm6n6wte4t27hx3fr4u__21682.4523567752$1734439545$gmane$org@cc5bu2ij2ia3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dne 17. 12. 24 v 13:45 Michael Chang napsal(a):
> On Tue, Dec 17, 2024 at 11:21:26AM +0100, Zdenek Kabelac wrote:
>> Dne 17. 12. 24 v 10:13 Glass Su napsal(a):
>>>
>>>> On Dec 17, 2024, at 16:34, Heming Zhao <heming.zhao@suse.com> wrote:
>>>>
>>>> Hi LVM2 maintainers,
>>>>
>>>> One of SUSE's customers encountered an issue with LVM2. The user created several partitions, one of which was marked as "BIOS boot" (4) instead of "LINUX LVM" (8E). Subsequently, the user ran pvcreate/vgcreate/lvcreate on this partition. During a system update, grub2-install installed GRUB2 in the "BIOS boot" partition, resulting in LVM2 metadata corruption.
>>>>
>>>> The root cause of this issue is that grub2-install targets the "BIOS boot" partition when this lvm2 device is specified for installation. If the user had initially marked the partition as "LINUX LVM", grub2-install would not have chosen this partition.
>>>>
>>>> On the other hand, it would be beneficial if LVM2 could implement a new filter or a filter function to detect and exclude the "BIOS boot" partition from being considered a valid target for LVM2 device creation. This could involve issuing a warning or error message to alert the user of the potential conflict. This may also help user to notice the issue more easily.
>>
>> Hi
>>
>> lvm2 is using  blkid to detect 'present' signature on a block device - and
>> normally prompt to confirm wiping such signature.
>>
>> We may possibly add similar logic for 'partition signatures'.
>>
>> However there is still the plain fact that lvm2  with  --force  or even just
>> '--yes' option is assumed to simply proceed  and clean&clear such
>> conflicting signatures and simply makes the block device to be a PV.
>>
>> All that said IMHO primary bug here is within  'grub2-install'  which simply
>> should not be blindingly overwriting  block device which is in use - this
>> should be fixed ASAP as there is the biggest risk of data loss, although I
>> guess everyone is using  'grub2-install --force'  - as without this option
>> (even in my personal experience) is typically refusing to do any work....
> 
> IMHO, the BIOS Boot partition is dedicated to grub boot code and cannot
> be shared with other software. Any attempt other than grub writing to

Hi

Sorry to say this, but the fact the 'someone' has created 'GUID' for GPT with 
the name 'BIOS boot' doesn't really make anything in the Linux world - so far 
I was not even aware such partition type exists (not using this myself).

It's never even been submitted to lvm2 as something to be understood by tool 
till this thread.

There are over 220 types shown by 'cfdisk' just for GPT and there is a 
completely different set for DOS partition types...

So how should we know which type is lvm2 allowed to 'use' freely ?

Should we now store somewhere those 'hundreds' GUID where there is something 
with Linux in its name ?

I don't think this is a practical thing to do in lvm2 nor in many other 
userland tools that are doing something with block devices.

There should likely be something in blkid telling other Linux tools  'don't 
touch this device unless you are XYZ' eventually you use some --force override 
option.


> For LVM root with legacy BIOS boot, having a BIOS Boot partition is
> mandatory, otherwise grub won't have usable space to embed the boot code
> in the GPT partition layout, and you won't be able to boot or access a
> functional system in the first place. That said, the BIOS Boot partition
> is in use by grub before it is mistakenly used to create a PV and extend
> the LVM root onto it. It is unlikely that GRUB is overwriting it. In
> such cases, it's more likely the other way around.

Well protection needs to be from all sides here - otherwise it makes no sense. 
  When the grub sees some signature, it must be telling to a user and not just 
let user to loose his data blindly.

And in the same way blkid should expose installed grub loader - currently the 
partition with installed grub looks 'empty' with blkid....


Regards

Zdenek
