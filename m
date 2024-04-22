Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD715025E
	for <util-linux@vger.kernel.org>; Mon, 22 Apr 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798397; cv=none; b=FAaPeHlp/XFJGflSZSzIBFm/jIMBoWmQux30rE6it1SwDbvXuZc6wGs3ksF1X4bfnwY12Wdujl3k8cR94MDNhf2N7Q1L+evR0vQT/oi6aoYt4C0rhB2YZcIbmJjMysHH5CvmIekhtWhF3eSSy/yLud4k5PkcSNIX4i/aj9pLBEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798397; c=relaxed/simple;
	bh=y07MqcaKsKr+qpbEDoW1jxlee7Q10o6vWBzj/uG4PTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BznOAWSH4qDvCF2mz1Yg3R845JTYQdFlnSzyeOBaq4WnBmbrZH+nJ6eqzdJAIYDj2PafHAItk/N4XM4AmyVFTn+lS21hYr4lsGMFb4n7GcSO8obKHmoKY8a0LzKirAwsfL4rdbF9m9F7Myo9rRM8j08t2C5l4fJLLyFg1vsmb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=J+qOERYq; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="J+qOERYq"
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 43MF6G6N021810
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 22 Apr 2024 17:06:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1713798379; bh=5T3x2sGcJ0rLhVX/TXc/NzMyZPt9h4RrV824Vf2WBPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J+qOERYqdbfVUWf/uNtGBRqLjd+H1kjVv6AVX6YTGUpHX+/UYrXs7naXnxICt8QZo
	 4n7NMN1gsMpWfRIj/i4Htt8IkboXDd6jvQ06VOujio2GtMJQkIKBKrz6az0wxNfNkc
	 DXe2r/O2O89vKL1dnnfk7M0226snd/VPemXF4L88=
Message-ID: <1d51472a-279b-4a41-884b-1b935ee1dc7c@ans.pl>
Date: Mon, 22 Apr 2024 08:06:15 -0700
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: umount -r broken due to "mountinfo unnecessary"
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <315f1f43-013f-48c9-9016-474dc9d53a04@ans.pl>
 <20240422114314.pu3domts67l7qzvh@ws.net.home>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <20240422114314.pu3domts67l7qzvh@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22.04.2024 at 04:43, Karel Zak wrote:
> On Thu, Apr 18, 2024 at 01:00:56AM -0700, Krzysztof Olędzki wrote:
>> Clearly this is not the right fix, but perhaps something like this would be correct:
>>
>> @@ -275,6 +275,7 @@
>>       || mnt_context_is_lazy(cxt)
>>       || mnt_context_is_nocanonicalize(cxt)
>>       || mnt_context_is_loopdel(cxt)
>> +     || mnt_context_is_rdonly_umount(cxt)
>>       || mnt_safe_stat(tgt, &st) != 0 || !S_ISDIR(st.st_mode)
>>       || has_utab_entry(cxt, tgt))
>>        return 1; /* not found */
>>
>> I wonder if we just missed the mnt_context_is_rdonly_umount case in https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=6a52473ecd877227f6f7da2b95da0b51593ffec1?
> 
> Yes :-)
> 
> Nice debugging work, thanks!

Thanks!

> I will most likely use the bugfix that you have suggested. The
> long-term solution should be to use the new mount API for
> context_umount.c as well, as it allows for reconfiguring the
> mountpoint without having to worry about the source.
> 
>   attr.attr_set = MOUNT_ATTR_RDONLY;
> 
>   fd = open_tree(AT_FDCWD, target, 0);
>   mount_setattr(fd, "", AT_EMPTY_PATH, &attr, sizeof(attr));
>   close(fd);
> 
> However, we need to implement it in a backwardly compatible way for
> cases where there is the new API unsupported.

Right, and it seems it will need to live for many years to come given mount_setattr got added in Linux 5.12 with xfs/ext4/FAT support only and several other filesystems added in 5.15/5.18/5.19.

BTW: we probably did not notice it for that long because Linux kernel has a special handling for root filesystem, where failed umount is internally handled as remount read-only, and it is not very common to have /usr on a separate filesystem.

Thanks,
 Krzysztof

