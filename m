Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EA0101DE
	for <util-linux@vger.kernel.org>; Sat, 14 Dec 2024 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734214139; cv=none; b=ArCbP78ONismKCMCxeh+rt2WWaXrEPDYL8g06bBkosTvQhpWVLlsn0W/rDN7XZicnTCsIuqJuk377DjjeOwJ7N0hSo4y9QiLvNGrrOEShqtQxF2hrmuW1soYlN+kju6LWV3UytC70kdKthNmWQHI75BFBG2HZRwhZuqxt2tXUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734214139; c=relaxed/simple;
	bh=ShHFB7MsNwIthrqFseJASiui/y97UrsVS/sKtkUpKik=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fVUKGKYdXSR+gmsbZViJBYW4QhW+/qkBxeRtc14wfKdmK9L1iWt0ZdCxEba4X7vl6WILr03jFy9TqVlzhrwb+s1HkXhCp3ndJR1pzNJgzHU/2Y2zbjdQZehLhe00rVdlbWxUlA7URFreT800TqsUbJB/H8Qm8sv/Kd58KyD6E3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+uFq/Ua; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+uFq/Ua"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5161d5b8650so727891e0c.3
        for <util-linux@vger.kernel.org>; Sat, 14 Dec 2024 14:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734214137; x=1734818937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qAUDq4OgMSKqH84tZoPwjnmbMDau1lPpmqnYj/8tFkM=;
        b=c+uFq/Ua3zlwerAfyincjdcY2xwPssoxy99pv3urZgNGw18+3TSGK2WipBtG7CdfZZ
         ToipCCO384BHe6nKM6hShwTAd0qQMo0GkipeaasMtt+FSIGA3HtNV6Id/SMqCG5UKhg8
         spx1DTuE7BIJBKXXu6XANXoJ2pjMGw2kO3brJE5PfdyPs2veWmemvFZd1Ij1ltyWPh8p
         eUxbHd41Hc9oAd50NCFQKF+BcE1ExMmQ9eGmXFuRrbz3Qdl8i4ROAt25nhCbGy1O24I0
         xSyl4kZNCLPRxw6vkSUaZqL9yiY/DSrJwMGbqajJZWv1sP08sWxpJxrSRaCOrViYK6se
         866A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734214137; x=1734818937;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAUDq4OgMSKqH84tZoPwjnmbMDau1lPpmqnYj/8tFkM=;
        b=qpb/Rl5eOJGoqIQZZ2JJ7jZ4LFRPHJrX9PQBxrEkN4Q0ME86XZnI+Gbq/mc9ep6+wk
         g+8gyZYmDfD3iMUPFb+1kpHW5ieyswDfOuHZBCYpyt1AMkxIh3I67y3IlUj0eiysCQb1
         dpzb3XrBijVoF0qWzLzvv9gJrQHFdy/6ZNuefs/83Wb5p6cCLsRHTaAliyh9KZzCdqGU
         PvdYkd906A4o0liVTFx+3GVMfKPlQ2o3uUettP5sS0NT2/oJ9Iv/GuciJ3mGB+9elPVh
         NGyi4EM9nZc1Fcx2lGIy8SiQwNd7oLqfpyr+uW95oKD94jmziKcNAbhlbhs3BwT2/Q/u
         QWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGIy+dKu7vU2M3Qo4pIXHlgUD7GyathgDaonba5Jv+kEHeZupn/qpe/0Pq6x0zqfp/mr4HMDVyh/n4@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhEZUEx6MwiAQTx90p0pwWS3bx6k16MWH0Z7sDdB0swQF25uZ
	41FJJQcLcQpNpe6tN3KJJRemNXG2lOlQJg4UVKoppsnNXJ7sz21E
X-Gm-Gg: ASbGncsSbGeUCAh5Q7tbpCpHGeqSb4WfZxaaSmzKFj4pXdBF9LgnfvACDW+dFmWQbKK
	r3lDdkrg1TWE717f2z9fi9atgREEbtIJD3A8MS6lPmEwTA7GRsgNM/HJnQrlPjZgpLv0JEOGCJW
	mpLfewKAGN7gyC57dYVzXUDLei49bb6xGRHkzJh8cKaSIeOYhjhQ1MMVSumbQ9g7Y7gpsjtQi7d
	CPWVZ3JVdhPY0E3TIWTPo66wc6zeBx4cBKw850qfwf+LfZmlRkLuBtefuA=
X-Google-Smtp-Source: AGHT+IFa9AlTE4d2Bl3GP88yUcIsfK48C9tPacllFe3v3prjKDtuNCsk5L7scEFrXDKSajyddeJm0Q==
X-Received: by 2002:a05:6122:547:b0:50c:4707:df0 with SMTP id 71dfb90a1353d-518ca24f6femr7322413e0c.5.1734214136706;
        Sat, 14 Dec 2024 14:08:56 -0800 (PST)
Received: from [10.138.7.94] ([163.5.171.73])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-519eb72b537sm273385e0c.52.2024.12.14.14.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 14:08:56 -0800 (PST)
Message-ID: <d1ad846b-def1-403d-be62-aac78e06fdc3@gmail.com>
Date: Sat, 14 Dec 2024 17:08:54 -0500
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Ensuring that mount(8) will always interpret a filesystem
 correctly
To: Theodore Ts'o <tytso@mit.edu>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <6f939e2c-7d86-4b3d-885b-2c171c944079@gmail.com>
 <zxqdvuyhtmas5apcnop7kleh2b24sboscyaosgkyqqfz4nlsdf@rmgdzivamwdw>
 <114fa16d-5908-4300-96a0-23203c7470af@gmail.com>
 <y7tl6b7pviy7ubstwprmw57ubquf777orkp56h45r7ab3xjfek@t3qjqzehfwnp>
 <155cef10-48b4-42f0-bacf-b9e1d7394206@gmail.com>
 <20241211133808.GB1912640@mit.edu>
Content-Language: en-US
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20241211133808.GB1912640@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/11/24 8:38 AM, Theodore Ts'o wrote:
> On Tue, Dec 10, 2024 at 06:28:28PM -0500, Demi Marie Obenour wrote:
>>>> Was https://github.com/util-linux/util-linux/issues/1305 a
>>>> collision between ZFS and ext4?
>>>
>>> Yes, but in this case, ZFS was incorrectly detected. As you can see
>>> from the bug report, blkid ended with an "ambiguous result" error.
> 
> mke2fs (mkfs.ext4) does attempt to zero the typical locations where
> conflicting superblocks might be found.  The ext4 metadata is located
> at the beginning of the file system, except for the first 1k, which we
> leave zero out on all platforms except for Sparc (the exact reason is
> lost in the midsts of time, since it pre-exists git, but as I recall
> Sparc had something critical that would cause its BIOS to lose its
> marbles if we zeroed it out), and we also zero out the very end of the
> disk where the MD superblock is located.
> 
> It sounds like ZFS is putting its superblock someplace random that
> mke2fs ext4 doesn't know about.  If someone wants to do the research
> to let me know what needs to be zeroed out to zap the ZFS superblock,
> please feel to file a bug against e2fsck (or better yet, send me a
> patch :-P ) and I'll be happy to add support for it.

I’m not too worried about this, and instead am of the opinion that it
needs to be fixed on the blkid side (by ignoring the ZFS superblock).

>>>> /etc/fstab provides an explicit filesystem type.  The Discoverable
>>>> Partition Specification doesn't.
> 
> From what I can tell, the Discoverable Partition Table specification,
> at least as defined here[1] only supports explicit file system types
> supplied by the GPT partition table.
> 
> [1] https://uapi-group.org/specifications/specs/discoverable_partitions_specification/

It’s the other way around: the GPT only provides the mountpoint,
never the type.  That’s why I filed an issue [1] asking for
per-filesystem-type UUIDs.

[1]: https://github.com/uapi-group/specifications/issues/132

> My personal preference is this *is* the best way to do things; the
> main reason why we have blkid is because of the disaster which is the
> MSDOS FAT partition table, where there was only a single byte used for
> the partition type, that (a) was largely ignored by other x86
> operating systems, and (b) wasn't under our control, so we couldn't
> define a new partition type each time we introduced a new Linux file
> system.
> 
> In general, having explicit file system types, whether it is in
> /etc/fstab, or in the GPT partition table, is the better way to go.
> Using blkid is ideally the fallback when the best possible way doesn't
> work, since it will ultimately always be a "best efforts" sort of
> thing.

Thanks for confirming what I expected.
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
