Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA6B2BAEC
	for <util-linux@vger.kernel.org>; Thu, 19 Dec 2024 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734605462; cv=none; b=nE4ATgyggpTZM/W9uNU/YwdNq6DQc6ajTwfZ9o5Rl49zu7bzxFIjJJAzLdkISlXud/vctBEtQHBSUoJgjveNv/7QPzH4cj+RZkysfyz06twDiXWOBfqMlDSHcvUv0YEqbSeMT+1woUxQwErww00GHS66YFSCJaooBX1KBFwzYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734605462; c=relaxed/simple;
	bh=THLHSfvLmAzZv98DbQuLFsP5tjHRDCcEL5ZAekr/Km4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QJj/iktzY0NzhpjKfiO5e6krasxa8qvQLR+FkxmwwHrqAAKDvUS8iR9lbItD56can9CVDnElxz2HO/kOVmYbE4xrpjIxQ60aEQMqt1rqPi44PAWyXcUCL6qtYGbNLl8pw7jeoBR8teimdJnM8v4DzcohAc2KxzImwFfOEYUvOO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU7lMPiY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU7lMPiY"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e2880606so459155f8f.3
        for <util-linux@vger.kernel.org>; Thu, 19 Dec 2024 02:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734605458; x=1735210258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4eISiHfQIQOg96V1Ckb3mY9iucdk8uiqNEjs4RmGpx4=;
        b=FU7lMPiYq+YIRMhiv3NASERr4/7Q1zkb2kumJ23oFCGuBUKTTAh2w7xjwKMfnR7rcK
         OewMAsQNrFQUWqHTN7H8OjOQkZAo/GMletCsj3Z8j6A4M9zbZHzSmKVnvfd6K86vyrrS
         WFh9natlBkBdMw53Tvub7Kl0kjJktln2SK9wV6ZV8xo4W/Sp2imfPJfpV6/aGX/lGwgp
         iUU4dWWLc/7wjpUAk3hoCIe/smw/zVwVn9HIef0VKpptGVx/jwA6dnLP0lWAgm+yk9D2
         M445wYiZj7D/KApTDYZYqw9D7eP6f/mD90eZTjKM5WOcNFpLwgDk2y5CVa+1uUdk+qWX
         TAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734605458; x=1735210258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4eISiHfQIQOg96V1Ckb3mY9iucdk8uiqNEjs4RmGpx4=;
        b=UObKEYuhYfi2uAy1JhIUH7Ud33ft8hEBYIPWIaGRrytW3KfWgCb66P9fNnzsYY5fDN
         NXhsKx8rGO2u1gBd5ItJGQB28i0Bl8tF2Qu3Q3srPy6XigFrVdomiEmBKjOA0dwmH2uj
         rh1GYSsULPi0j5qdaZ/oDRMXaAHhnUkH+JRZcxFFNzHBwxeWmgAy3XBWmw28nyb+PY5p
         BUK0eqW5yAdni85pt1m9nO20uW0n6qmcFO5574EXFS/WLW3evht8A3yTwcqyMnxLXz4e
         CVulfdjyOzFbyWnmoYYg6NYJD9bDUNV+bdcrrlZ7pOwK6uFBddFJl0Q4sz8YOijj9RVS
         UEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+6R6Z/0q7pPkegmCEALpBr9fVdmHBpIr0ldCOLJkO7ohvFQJszdOTszQqSJaNPl4BKt9KKQHJoDK8@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXePJ0pBpfIE6KqN2QB1tHJgNT7bvmhHy1G/IFmA92zrg7OW7
	s8GIOfHUPQBEd93T+1JdQXURQXR/LEVue4RZsVLJ//fXmhHh+0z6
X-Gm-Gg: ASbGncvW5kfmtsGEMIIUHY0uclMg6aIwJ40mz/pV9afUSpVqAmbHSb0LyeyPR7wTbft
	dHT1bBqusOpwOQAH2gQ9virdpOo4xQ6Cp/ZQ2qAvdAw1r71tpXut7em5VQz1Vc0hew5BYnOZavd
	Nsn7imxEck/ZnZVA9THaIn7iDlLvDvVeyWW6+6kSgjxvpeihaUk78xMHzlRI2Bn1ZTKzc+Bodgw
	zwc6cHCYtv9xyJ4XU81NL6BP78hDCQFEMt93gW6OFnoF8sunv7FkAX0anomcxRFrup9P5Zl1fGy
	uESf7AH9z1kUDA==
X-Google-Smtp-Source: AGHT+IFvHJ3lCjc0wxpW+3TIjFto6/aaA1tQFmvUWLw85vFxPO1ZOEnXgQO1nYlOyBbgzO+F3tzXRQ==
X-Received: by 2002:a5d:6d81:0:b0:386:3a8e:64bd with SMTP id ffacd0b85a97d-38a19b05201mr2823273f8f.22.1734605457548;
        Thu, 19 Dec 2024 02:50:57 -0800 (PST)
Received: from [10.43.17.62] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b207sm48069605e9.32.2024.12.19.02.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 02:50:56 -0800 (PST)
Message-ID: <7793f5eb-57d3-4325-b3fe-27cf4ec6cf1e@gmail.com>
Date: Thu, 19 Dec 2024 11:50:55 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: is it possible to add a new filter to detect unusable partition
 types
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Karel Zak <kzak@redhat.com>, Glass Su <glass.su@suse.com>,
 Heming Zhao <heming.zhao@suse.com>,
 "linux-lvm@lists.linux.dev" <linux-lvm@lists.linux.dev>, grub-devel@gnu.org,
 util-linux@vger.kernel.org
References: <826b5136-7ee1-4664-98d6-a3441883f53e@suse.com>
 <43D73CB9-32E4-405E-93A9-E985C94F4A9E__33327.0934455626$1734427189$gmane$org@suse.com>
 <ec0d03c0-40b0-4719-a020-9bae7a3241ec@gmail.com>
 <yjiu3c3e4aknayawhw7lw52kev6fvp4wm6n6wte4t27hx3fr4u__21682.4523567752$1734439545$gmane$org@cc5bu2ij2ia3>
 <dbc7728b-352b-4982-a171-d8f177388a19@gmail.com>
 <hdqz3hun3f5ftfwvimlopkmuujimtz5ilovkuajqesy6p4a7jd@7w6nkryhr2y7>
 <860960db-bb66-453c-a392-1495690bb2ff@t-8ch.de>
 <jcqrtifxjk2adtngyykvyoffh6ab3twulqra4ugq7satddqob7__49168.7655843393$1734583719$gmane$org@rngyhl7nuyhk>
Content-Language: en-US, cs
From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
In-Reply-To: <jcqrtifxjk2adtngyykvyoffh6ab3twulqra4ugq7satddqob7__49168.7655843393$1734583719$gmane$org@rngyhl7nuyhk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dne 19. 12. 24 v 5:48 Michael Chang napsal(a):
> On Wed, Dec 18, 2024 at 06:05:54PM +0100, Thomas Weißschuh wrote:
>> On 2024-12-18 15:44:45+0100, Karel Zak wrote:
>>> On Wed, Dec 18, 2024 at 11:12:59AM GMT, Zdenek Kabelac wrote:
>>
>> [..]
>>
>>>> And in the same way blkid should expose installed grub loader - currently
>>>> the partition with installed grub looks 'empty' with blkid....
>>>
>>> The issue I see is that boot loaders can coexist with filesystems on
>>> the same device. This can lead to unexpected warnings when attempting
>>> to view the contents of the device using mkfs tools.
>>
>> Isn't this specifically about the grub second stage on GPT systems
>> inside a dedicated partition?
> 
> Yes, GPT has no unallocated space similar to the MBR gap in the MSDOS
> partition table that can be repurposed for grub second stage, therefore
> a dedicated partition has to be defined and allocated. A similar scheme
> is also used in PowerPC, where a dedicated firmware PReP boot partition
> must be allocated for the boot code.

Hi

Yep - it's obvious grub needs to have a space to store its data.
In fact if a device would be 'just & only' a PV, such a PV actually has 
prepared empty space to be consumed by grub - (see  'pvcreate 
--bootloaderareasize)  - which probably never reached its audience - so when 
the user is using PV lvm2 he should not need a special dedicated partition 
(theoretically).

But all that is said here is that choosing some 'random' GUID GPT partition 
type really doesn't change anything in Linux - all tools in Linux are scanning 
content of device - checking for  'partition type' is highly unusual and 
pretty much undefined.

So the focus should go to blkid being able to report that device is occupied 
by some content.

> 
>> There should be no valid coexistence with a filesystem.
>>
>> So having a probe in blkid looks reasonable to me.

Speaking of this - there was use in old ages (and I believe it's still support 
by lvm2) the usage of a PV & MBR at the same time (it's also the reason why 
the PV header is storing it's LABELONE on 2nd. sector (512b)

This has also caused some troubles in past to properly identify device content.

Also blkid already can identify multiple signatures on the same device so it's 
just about the priority which one will be then shown by 'udev' as primary.
lvm2 also checks and clears all signatures one-by-one...

>>
>> Not that it helps in the specific case mentioned above, where everybody
>> is using --force anyways.
> 
> That's the reason I think adding such a check in grub-install doesn't
> help at all. After adding the check, I believe the tools managing the
> bootloader installation will start to use wipefs or enforce --force to
> grub-install to make sure no leftover can get in the way. In that sense,
> it seems like unnecessary breaking change to the toolings.

I guess we may not move forward with this logic...
(aka it's ok change lvm2 to not wipe, but it's fine grub will overwrite anything)

lvm2 is for long time trying to advocate against using '--force' regularly.
In some cases we've introduced even 2nd. --force required to be entered if the 
compatibility usage would be broken otherwise.

Thus the proper logic should be that some 'operations' that currently do need 
--force  - may have it's own dedicated option - i.e. in my case  grub usually 
doesn't really like to store it's data on the partition in use - so maybe 
there can be an option just for this aka --in-use-is-ok y|n

Similarly lvm2 has  'pvcreate --zero y'  to clear device content 
unconditionally - so there is no need to use --force for such case - although 
it takes time to teach other tools to use options the right way....

Regard

Zdenek

