Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C81DBB35
	for <util-linux@vger.kernel.org>; Tue, 17 Dec 2024 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430891; cv=none; b=Da+y15KMrTaOUvGMq886oYkTwvzlEEucIY5zXEv/mdEuNuml7FJpySUjRTPDsMCX3O2Hv6Lzs2palzj6d2lmgV08nTgsu2cto4Aa1QFkMYGRoHlivhD3HtTgNjTNP4tgz5IDTG30PcJHyUYesNkfoHTvrnt3+w03ug9tnIltf5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430891; c=relaxed/simple;
	bh=4AQp6Vg+AXvM0u6WOXxJK8S0+wcswVaIsGy0lMPR0MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIJFeFXt/pLOPhAmH949hltJLr2Dq5HQiZ8lOVxLCqRYfJIKnO2lyyNMllEt5ESUwZ/o9aZJUlfwuiFtJ2XMoyLAr1GInfmnxJa92bhBUmEH/OSHr/v6temI46nTdjsMO92WEYmSQBdwfOy5Z/XXJpzddLf9p9B5/nb3ljKkIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY+qkDzT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY+qkDzT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436249df846so35513765e9.3
        for <util-linux@vger.kernel.org>; Tue, 17 Dec 2024 02:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734430888; x=1735035688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBIlBfb4EFSVfIGl1b/hj6kFg7hYVxGCzH0y0auCe7w=;
        b=gY+qkDzT5nKyEMXrXeaAMViKQ6xWChIdLRakENTa5v4uzp0Jr8R2lRNyONO2ttC4j6
         ryI8zLni/+R7V1NVCz3NGKBjhm3TmWgdY1KIzpGTKWrFFDzDgfBP+OL/kKHmpm87SijB
         QnH7Fhrl+FTlXe2xgyKbWgyt+9hy5XgfC7KeMrvbcXomAHjeFLStcum0inkX2oxrWh/z
         TDPfhfX4gpSn7BnYMZrNrEMjJ83USooZ3kgmK5m0hTXHyr0XN/xOHBCknHRGNVHZjyNG
         ZQP3pGUW9OG5PvTtfZKr+L2MmeuUq30nKHpFEpnj0QoIUSBaRxp/RYT+ZqkRdr9MDWQI
         AcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734430888; x=1735035688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBIlBfb4EFSVfIGl1b/hj6kFg7hYVxGCzH0y0auCe7w=;
        b=JtPjmTR9l9CxpRdGLx6POVLZqEH8Q7UJMLPAnzp0ylmEWU5CDnkDAlymPfxm0Dx1QX
         zZiIHxOBWm2w+xZ6IYx00BuNRana/vC5ZWr0XxLYwSciQ0nTOeQ3N7SHO4O2C6/ibGKP
         R4evNw5N3v3Wm9mHvL38BMNFwj3JpYmBScv72LOKICXDFtTBztLQg3KvFqsxTQGYLHgV
         VIpQ4nAn8KNG767lfuNLqNvIXdIQXKDkdY/13kObi4oRnOy7KjJAWTqJb2M6HHHtm9/B
         s64rO/wTJdxVRGyI1/0pE1B15bAglmqvRQF6ekGQpKbVDmmc/7L/cTiN7c6se9s7cPTe
         nO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPhhs/qu5iHDnawm/TyFmQmI4iPlu9lKwF3uzED7u4Lqf/WCYHbyc1cnKKw2g26heIAH/iLFLjH2+e@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZDquo3hJDbdrVy48YWIANjfAvoJqAAhiCy4MijQxZ3UbewG6
	1l20YeGFvqh8Td2PF3fWN0W/IVumZ0mA04M+81tY3j56O+ykg1c/oOkn/r17AJY=
X-Gm-Gg: ASbGncuas56qwjX+TLxIgcov05K14Y6i3BVTj43mzScOYBXDF+nPP0UhwCNx2vIaW3m
	89+93Wx5mJ5erfbxt6lowHNAnGR0jVpBL+fAnkZtBb4j5TyDZSR0V/oO5vHroIArI8qKm0rVvQz
	Gu1obhGLMISP7CtTXe3wL0AeM+JBWYQaLU3pX0qAWxnPBJs+hG2T4qbsF3ecLCQVbjgEIQyBGQ/
	rpNaLlqrL16Dn1si/B0aWZOSOr+GFlOuGi3MqBhE0wRkTJUxwgze25ysbVB1yzKiknt5ZgGqchR
	7m6R2znvjUV19A==
X-Google-Smtp-Source: AGHT+IH9CftQqkJrpJh5Jo4Q3meQJz56Dslt97zvVxG6Ps41w313C/cTfNJXPEj1UrFhnnxZd9VZww==
X-Received: by 2002:a05:600c:3b9c:b0:42c:c401:6d8b with SMTP id 5b1f17b1804b1-4362aa2deaemr135600015e9.7.1734430888093;
        Tue, 17 Dec 2024 02:21:28 -0800 (PST)
Received: from [10.43.17.62] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362b64a5sm114620265e9.29.2024.12.17.02.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 02:21:27 -0800 (PST)
Message-ID: <ec0d03c0-40b0-4719-a020-9bae7a3241ec@gmail.com>
Date: Tue, 17 Dec 2024 11:21:26 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: is it possible to add a new filter to detect unusable partition
 types
To: Glass Su <glass.su@suse.com>, Heming Zhao <heming.zhao@suse.com>
Cc: "linux-lvm@lists.linux.dev" <linux-lvm@lists.linux.dev>, mchang@suse.com,
 grub-devel@gnu.org, util-linux@vger.kernel.org
References: <826b5136-7ee1-4664-98d6-a3441883f53e@suse.com>
 <43D73CB9-32E4-405E-93A9-E985C94F4A9E__33327.0934455626$1734427189$gmane$org@suse.com>
Content-Language: en-US, cs
From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
In-Reply-To: <43D73CB9-32E4-405E-93A9-E985C94F4A9E__33327.0934455626$1734427189$gmane$org@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dne 17. 12. 24 v 10:13 Glass Su napsal(a):
> 
>> On Dec 17, 2024, at 16:34, Heming Zhao <heming.zhao@suse.com> wrote:
>>
>> Hi LVM2 maintainers,
>>
>> One of SUSE's customers encountered an issue with LVM2. The user created several partitions, one of which was marked as "BIOS boot" (4) instead of "LINUX LVM" (8E). Subsequently, the user ran pvcreate/vgcreate/lvcreate on this partition. During a system update, grub2-install installed GRUB2 in the "BIOS boot" partition, resulting in LVM2 metadata corruption.
>>
>> The root cause of this issue is that grub2-install targets the "BIOS boot" partition when this lvm2 device is specified for installation. If the user had initially marked the partition as "LINUX LVM", grub2-install would not have chosen this partition.
>>
>> On the other hand, it would be beneficial if LVM2 could implement a new filter or a filter function to detect and exclude the "BIOS boot" partition from being considered a valid target for LVM2 device creation. This could involve issuing a warning or error message to alert the user of the potential conflict. This may also help user to notice the issue more easily.

Hi

lvm2 is using  blkid to detect 'present' signature on a block device - and 
normally prompt to confirm wiping such signature.

We may possibly add similar logic for 'partition signatures'.

However there is still the plain fact that lvm2  with  --force  or even just 
'--yes' option is assumed to simply proceed  and clean&clear such conflicting 
signatures and simply makes the block device to be a PV.

All that said IMHO primary bug here is within  'grub2-install'  which simply 
should not be blindingly overwriting  block device which is in use - this 
should be fixed ASAP as there is the biggest risk of data loss, although I 
guess everyone is using  'grub2-install --force'  - as without this option 
(even in my personal experience) is typically refusing to do any work....

And same applies to most UI tools I've seen that use lvm2 - all seem to be 
pushing  '--force & --yes' with each it emitted lvm2 command...

Regards

Zdenek

