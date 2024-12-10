Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755586324
	for <util-linux@vger.kernel.org>; Tue, 10 Dec 2024 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873313; cv=none; b=c5yh/75xNDTRKKB+gM5ojE4q49vWJyEtNnMHa7XhN8kl3c0gAaQtB0CSBmB9c5HYJvHhnL9LNrPlp7ECi6JOuLNESVJHrSJ7JZY4apeJJvVgv0AzaqttVVvJcs3iyAa30eKY4k48PcWt81f27Kp7powlXdE2PMr7t928fEDw2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873313; c=relaxed/simple;
	bh=16ofHKM3rf97/PfS7lZG0fbPz8IbXZhLZ5rArMqawv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=if2D3jZgawmZNNCCAAFKedRKAA/FPOd/t2IJvu/j4d1l/5BynZGDPv444NJBZk22y9i7etsVg+IvwbWtfSpORRgGK03B8eGo25bzM9L9qysx5LiYwtoGH1+IwupS4MDOQ/BJamT61d9wKlOj25uRqoHOkS/eHJRU+jKGE+qd7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5kezNZt; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5kezNZt"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d900c27af7so36053576d6.2
        for <util-linux@vger.kernel.org>; Tue, 10 Dec 2024 15:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733873310; x=1734478110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jNMIN2rvwZfwSi48azbiSc9K18FfkWBEapcQnJKFCQg=;
        b=Z5kezNZt18haO0/oD0kF6DaCUDi9TB9msjJi+eFeQ3m+3ECTHZlmL+FNh6KeR25ZK1
         UuAeDntabf8E0vOtPUCYrAljHZhoqnlW1YYdLmrW1GcSN1r0gt7qV3xIZkgYQVz1vLcb
         W85CJA1vAVVTJs3W/7Y51MvNgbeMVh19yPPfMwA7Is2CuPOWp9dJ81TvuipgRw6brjds
         OsmT62GKr565xnFP0IPLHtUqyFoJSaKQR25lBExPd52A/MNqycSYOQnBWpVPsdBmYUit
         lnjQduGDzjjFXjzpkVbJLV5zPs8gA4OjhW9oiWqAfzV3rS1znRNgnRIH/v4Cdp92asVS
         Zwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733873310; x=1734478110;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNMIN2rvwZfwSi48azbiSc9K18FfkWBEapcQnJKFCQg=;
        b=COHyl8tGEeLP82KZ3TdccQ/N5/mwJsKH95OJoKwVFWwCV5EuDs3M0WO/xga5RI0Rk3
         pmnaIiaNmCwTsaiJM2an8R20bV0bU/ZlSR3lk0w+WUxzH/zjjEyBytFudwfa3HQ+FOTf
         pZ2a+15lxL+oe5uQPEJxkJwab+HW9AAqB879aTD6SGuMzarxgC2PBj/oR1NKUq/o2OBG
         hHTjNWkW2LV1oRyPm9Hx0O/sPB6JNr2ujnN9Osm8fovwON6vYHy+W0DIAMcxHlKu8VjR
         HLko7OTHZP3qZacFzFtgxi+Py5h0Ckn4FoBWV+eVz17m7IuUMt7D8LJkmwculRoT+0N5
         /cpA==
X-Gm-Message-State: AOJu0YzhogMMKgk2FBhXVM0B+4/2dtFfwMS0zFmgGLoWxDPHgGvabOjr
	pJ+SK94f/HCaQIcvGcOCjzVMCjlL+c8BPRkKTkq0Az6sWLHvoiuB
X-Gm-Gg: ASbGncu4i0Ol3AajKbKOfs8H0+xk1yhqNkKj6wlSP6G6qh4Y6L6BuGE7b47jnLk3+u4
	lgkVHGXMPG3x7BFrLAWlVPGSKQ1NFTkA0BnX5JM+RaNy6aGpw9xyGvuNfHtJHhApXwKW93URnV9
	dWaeM/YNoBY3hjAwbsf7t1xjPB6yLj0SX3YOOuXSwRAqhkIj2FHM2VtWrgSULQ9rT1gUk7A/B23
	Bbz4FRLYGTgsZVBSCyqYYfwmVsjoQy0XkSlWfX7SDq7plwVvx94u1NC
X-Google-Smtp-Source: AGHT+IEvsYULh7YXKOhatYWtEKMiyfSjjQohp5WefHVWJkB99b5BuSszYmxYF9lZR7ESf/+4Kd7QGw==
X-Received: by 2002:ad4:5c4d:0:b0:6d4:2806:1765 with SMTP id 6a1803df08f44-6d934be3d36mr18614336d6.34.1733873310259;
        Tue, 10 Dec 2024 15:28:30 -0800 (PST)
Received: from [10.138.7.94] ([163.5.171.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dac1434esm64550106d6.124.2024.12.10.15.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 15:28:29 -0800 (PST)
Message-ID: <155cef10-48b4-42f0-bacf-b9e1d7394206@gmail.com>
Date: Tue, 10 Dec 2024 18:28:28 -0500
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ensuring that mount(8) will always interpret a filesystem
 correctly
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <6f939e2c-7d86-4b3d-885b-2c171c944079@gmail.com>
 <zxqdvuyhtmas5apcnop7kleh2b24sboscyaosgkyqqfz4nlsdf@rmgdzivamwdw>
 <114fa16d-5908-4300-96a0-23203c7470af@gmail.com>
 <y7tl6b7pviy7ubstwprmw57ubquf777orkp56h45r7ab3xjfek@t3qjqzehfwnp>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <y7tl6b7pviy7ubstwprmw57ubquf777orkp56h45r7ab3xjfek@t3qjqzehfwnp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/10/24 6:16 AM, Karel Zak wrote:
> On Tue, Dec 10, 2024 at 12:11:49AM GMT, Demi Marie Obenour wrote:
>> On 12/9/24 5:26 AM, Karel Zak wrote:
>>>
>>>  Hi Demi,
>>>
>>> On Sat, Dec 07, 2024 at 08:45:32PM GMT, Demi Marie Obenour wrote:
>>>> Is there a guarantee that if all data before the filesystem superblock is
>>>> zero, and that the filesystem never writes to this region, libblkid (and
>>>> thus, presumably, mount(8)) will always mount the filesystem with the
>>>> correct filesystem type, even if e.g. someone writes a file containing
>>>> a superblock of a different filesystem and the filesystem happens to put
>>>> it where that superblock is valid?
>>>
>>> the libblkid library offers multiple modes, with "safe mode" being the
>>> default for detecting filesystems. In this mode, the library checks
>>> for any additional valid superblocks on the device. There are
>>> exceptions for certain filesystems on CD/DVD media (such as udf and
>>> iso), but for regular filesystems, sharing the same device is not
>>> allowed.
>>>
>>> There is also an option to specify that a superblock is only valid if
>>> no other area is using it (using blkid_probe_set_wiper() and
>>> blkid_probe_use_wiper()). However, this is only used for LVM and
>>> bcache.
>>>
>>> The library does not require that there are zeros before the
>>> superblock, as not all mkfs-like programs zero out all areas.
>>>
>>> In recent years, there have been no reports of collisions. In the
>>> entire history of the library, the only collisions I can recall are
>>> with swap areas and luks, and occasionally with poorly detected FAT
>>> filesystems (due to the messy design of FAT).
>>
>> Was https://github.com/util-linux/util-linux/issues/1305 a
>> collision between ZFS and ext4?
> 
> Yes, but in this case, ZFS was incorrectly detected. As you can see
> from the bug report, blkid ended with an "ambiguous result" error.

Should blkid instead stop at the first valid superblock when probing
filesystems for mounting?

>>> I believe the situation would be the same even without the
>>> Discoverable Partition Specification. The kernel always divides the
>>> whole disk into partitions, and libblkid/mount utilizes these
>>> partitions. Therefore, the filesystems are automatically separated by
>>> the partition table.
>>
>> /etc/fstab provides an explicit filesystem type.  The Discoverable
>> Partition Specification doesn't.
> 
> You can use the "auto" file system type in fstab. It is also common
> for people to not use the "-t <type>" option on the mount(8) command
> line.
> 
> However, if you are paranoid, then specifying the file system type in
> fstab and avoiding Discoverable Partitions is a good choice.

Does that mean that Discoverable Partitions are a bad idea for any
filesystem that is not read-only?  Can you explain “if you are
paranoid”?
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
