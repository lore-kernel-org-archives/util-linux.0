Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE9168BE
	for <util-linux@vger.kernel.org>; Tue, 10 Dec 2024 05:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733807515; cv=none; b=YKWbcmUmGH0F2AvCq2J6VJKs5zp6cv3KwpYt+gill9bw2c46og1mqCiMt4dmUdiEDGUDdVVAvUVuP70k/7tDQ93pQMFzkMhsRJwQZu75nKZtTqcjvNjabfHohSUmsaF6ke/9ArcncCf7cE5IOCs/7AoGFv2u+8msJOY88+vtuiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733807515; c=relaxed/simple;
	bh=hxqV7QW/ur7NEsRLyHGDjr/k/GZWaQYZWGJY5vKodAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNwvINhU+a6YxUyv679Xl0ESj/pXhkH9hRya6epE/m16JbbHYE3l5FMpv8DxRMc4UZsPnZlWClwsnpVKXqehYK4aBu4lk4RjoH1z1sE2zVi7frOKtc/P59hHGRcUE6R0ScrCcIhSMZDLosIMgEkeGYkFjKDHDvK5djotKIuPHHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhVzvxOa; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhVzvxOa"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6d63ab374so95286785a.3
        for <util-linux@vger.kernel.org>; Mon, 09 Dec 2024 21:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733807512; x=1734412312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8/zz8OLCZFugXlchKE9LjkBi0JN6pR371n/l5EaFtYw=;
        b=jhVzvxOaWuJbv5dMqG9gDFh+Zv9p4JHRLmK/W7iQ7A2qSQgWshwMkeAkUZ9oxGhQRH
         yYUKKk9agDJT7YMs6lNO0Q98GsTU8sZTw1OjW85ARUQbduXaGVubzU/r6twDLVvJHFdM
         1CpUnAlD7r6krgWcz7e1ScuhTciacG3i4U3MBIBKy+mpQxyBiglqucxJhq1yQmM1uauz
         wMsuFxFi2DOH5bhvlNbZf8FNMY+7e/0vERtnpMyyiG7og7SbAQdZb0Ten3r42bFMOXmp
         8bsV88x3eXJ0/YFpwdgfRI5uoGYZgaHV39gCIBwqTirBp4lx05fPfREZSHAdl70EsSd/
         Tkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733807512; x=1734412312;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/zz8OLCZFugXlchKE9LjkBi0JN6pR371n/l5EaFtYw=;
        b=J0gAp1rpAPvJ2j/JRJ6/D0wNV5qCX4MEWuzYldDGqxwIiPquh6xE/PZ/sDCtBbYXO9
         QxRpwLrLLIEFy8qt5u3sHz7OscQCH+NMPOccB2+uj3dr6B/ydABcGd1D9NOBkepTU6QI
         xxdskaJj5NzU6fRDUWmwdIjJiE9d555U5HA9hayEWB0be8TsoScbPcUgQDKcLw8HdRUx
         2OeBt2or3xdszV1UdEpVobGvAFlCEOQSaxwA7sfiwIo4zXtsh9I4shVRP85jhOMOGIIx
         6u4zTaXHLYyQudNhLYWQrOZ/gd28io6QTOXDX8m6mDq0QVHoDZhHl6YfgHMdE87FKoWj
         Jtnw==
X-Gm-Message-State: AOJu0Yw//JI6j9o/WKTbNtnmXRzKIH0gVlNfdLanX0q3r1NMoF4xBLOk
	HlAXt6jxTEzSD7XXXCqMTrZtVqHCva8xaHOrLLdcm3Dw44gBMtv6
X-Gm-Gg: ASbGncvXBvcfD/0sXg+Hrq6Onz/z0+cLInunVY4FXpFY5daCqCDYDoRGPLIO6RjYroq
	7pHHGjZB9Whsn7FeAOP0WalfK94Bj99oL/dfvGnSkpfLLC9xuuhu6KkGezObhCANIBUn65YVNh/
	QV8KSfimgXMBcuKSgStS/Bb5Wbr7YD1w46YXJjc1Orz9JJSgY6Dx0Q/qx01vzadPjvKbY2OAHbf
	xRERyCHTh3b/dhxbIvrxi/s8sO0XbWW0nOh43EyUL3rX1Sbka0febeO
X-Google-Smtp-Source: AGHT+IGoOxVmY5dTL+jbLWjVGs4zAEbo93XxrFqS1bDjzT8giMP2ElJ7/QQLfxKoah+DzH3YXA6jXQ==
X-Received: by 2002:a05:6214:501c:b0:6d8:b594:c590 with SMTP id 6a1803df08f44-6d8e70d5ca6mr189760456d6.6.1733807512289;
        Mon, 09 Dec 2024 21:11:52 -0800 (PST)
Received: from [10.138.7.94] ([163.5.171.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da66db88sm56103416d6.7.2024.12.09.21.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 21:11:51 -0800 (PST)
Message-ID: <114fa16d-5908-4300-96a0-23203c7470af@gmail.com>
Date: Tue, 10 Dec 2024 00:11:49 -0500
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
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <zxqdvuyhtmas5apcnop7kleh2b24sboscyaosgkyqqfz4nlsdf@rmgdzivamwdw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 5:26 AM, Karel Zak wrote:
> 
>  Hi Demi,
> 
> On Sat, Dec 07, 2024 at 08:45:32PM GMT, Demi Marie Obenour wrote:
>> Is there a guarantee that if all data before the filesystem superblock is
>> zero, and that the filesystem never writes to this region, libblkid (and
>> thus, presumably, mount(8)) will always mount the filesystem with the
>> correct filesystem type, even if e.g. someone writes a file containing
>> a superblock of a different filesystem and the filesystem happens to put
>> it where that superblock is valid?
> 
> the libblkid library offers multiple modes, with "safe mode" being the
> default for detecting filesystems. In this mode, the library checks
> for any additional valid superblocks on the device. There are
> exceptions for certain filesystems on CD/DVD media (such as udf and
> iso), but for regular filesystems, sharing the same device is not
> allowed.
> 
> There is also an option to specify that a superblock is only valid if
> no other area is using it (using blkid_probe_set_wiper() and
> blkid_probe_use_wiper()). However, this is only used for LVM and
> bcache.
> 
> The library does not require that there are zeros before the
> superblock, as not all mkfs-like programs zero out all areas.
> 
> In recent years, there have been no reports of collisions. In the
> entire history of the library, the only collisions I can recall are
> with swap areas and luks, and occasionally with poorly detected FAT
> filesystems (due to the messy design of FAT).

Was https://github.com/util-linux/util-linux/issues/1305 a
collision between ZFS and ext4?

>> The motivation for this message is that systemd-gpt-generator generates
>> mountpoints based on Discoverable Partition Specification GUIDs.  These
>> indicate the mountpoint of the partition but not the filesystem type.
> 
> Filesystem auto-detection is a common feature. The situation is
> similar to having an "auto" fstype in fstab. The systemd-gpt-generator
> simply identifies the partition as "/usr" (or any other mountpoint)
> and the rest is usual scenario.> 
>> If a correctly-produced filesystem image will always continue to be
>> recognized as the correct type, this is fine.  Otherwise, an unlucky
>> combination of writes to the filesystem and filesystem allocation decisions
>> could cause the filesystem to start being mounted as the wrong type, which
>> would be very bad.  According to https://github.com/util-linux/util-linux/issues/1305,
>> libblkid can indeed probe for subsequent superblocks after the first one it
>> finds.
> 
> I believe the situation would be the same even without the
> Discoverable Partition Specification. The kernel always divides the
> whole disk into partitions, and libblkid/mount utilizes these
> partitions. Therefore, the filesystems are automatically separated by
> the partition table.

/etc/fstab provides an explicit filesystem type.  The Discoverable
Partition Specification doesn't.
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
