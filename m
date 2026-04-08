Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9C3D5666
	for <util-linux@vger.kernel.org>; Wed,  8 Apr 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661066; cv=none; b=ITj6cywGCIND6DFWodyO/Hvz2oub7MWj/u5ktp4rgOxIpv4ZdYnJkAerWTaRYDVAwOZyEehXqSlhyxcVvWyK3kV6fwpZPEKXHvjSrjPw2HE6hJDvX/uiaUiKrjaCJ21mJfflAk2RxriGg4fDsYblDkGgHTJWmKfyGuf3Tp7GZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661066; c=relaxed/simple;
	bh=G1GOuECHaJMRzzaWwpBY9lov4Sy/TLyRMK/KCrMHsyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W417VJWwmoj+UwVi8YRHYUVRULQ0QZmwDhE4mU6vsNwDbec7I1mzM8Q7nXav230WnMCUsnsqnV24SmGFZzt5oGyAglJXHVzYuT3fvlQ1xq9X6eh0o/xkFFk8aiBLvMicAnFHjhJHfRNhAv8Z9tWEj8HwJsPqD+e7Ag+tfhLtNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dypro0qv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYKKN7iM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dypro0qv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYKKN7iM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775661064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43G81qLpF3tIYkLZ5t8AchGHuokm7DKdtDAy55LzHxc=;
	b=Dypro0qvsR2HoiwF2MpCxGeYc18a2bMJ6XzORAUKZtWejHwhkHMRtf54qRdY1hS3A4pDnu
	9wO+5LRO2r6I+nhHwzZwshkxsaT3qCBNszPMhwKAr2pARx8iwliImouQcC4Gr5O6898eRY
	GF9LpnJgvWGoeBuDid7a0pNzHJLNc9Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-LPAuXTqTNwKzRn-qI3M1hA-1; Wed, 08 Apr 2026 11:11:02 -0400
X-MC-Unique: LPAuXTqTNwKzRn-qI3M1hA-1
X-Mimecast-MFC-AGG-ID: LPAuXTqTNwKzRn-qI3M1hA_1775661061
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4362197d1easo5476704f8f.2
        for <util-linux@vger.kernel.org>; Wed, 08 Apr 2026 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775661061; x=1776265861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=43G81qLpF3tIYkLZ5t8AchGHuokm7DKdtDAy55LzHxc=;
        b=cYKKN7iM4Vd0YrF1yxuulDX6V2DWDK+XPk3dzpWZecQAfbTjkfttVR9rrnYZC1S44M
         EAs6L1CuU82qzVqGoGA2x2kdeqDjrrZBIq3KVTTqSl1uQKZe+Rr81E7w8XwL/VHlHcUB
         +et80d44y1tjR5ZPj8WuEGNYbQhZ0iJnQ6lJZr1A33gZ9rlrdQQcRCr77ikal6c+Ix89
         ZCqytSAXjw7Qh3GBlbL3gNw628MKCQw//IY1h2NCG0rZKnV4SynQ8niMjrztj5zIVWS1
         Zp3sx9OqEjpiAxYpMthVI6spHENCpuLXu4gPW7DM9SUjn9abw5/COk6jdMuxBjc/qcDw
         p9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661061; x=1776265861;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43G81qLpF3tIYkLZ5t8AchGHuokm7DKdtDAy55LzHxc=;
        b=B09eemkRrxyt8D0D5jV4f4AYccD6EIv0k3fV0ttD3jT357N2Cd3pvDUWwBTKCXzJiC
         tj960o1dMcu8Dxw2zbvnmKxppwsTr97n2RBa2H5xs61YxlNJUALlF1iVmN1Ry45sGy8C
         SG6NYR2fLZoK4eOSc0BfMAOAzIZpfoTyxHcJHvK82v1Vz91RyqEqDauRwZkAxbcBuTcX
         oIDhQkCE9NJlNEwZXUNf8UQEfc9YZqfIvroe0UPAOVLpfniMAql8F4d6IDzhZuiU/hzk
         vEzvLCYihfXroOikrkk799JTcOh3YUkg0+toH9//J7LnDaIXlnN0yfx0e+psq9A+x7ig
         +3qw==
X-Forwarded-Encrypted: i=1; AJvYcCVKqWGr4H8GH8i33GBH39Y/9XP48RjPlplLOEHaQzjlSFmPTP9o5nLu3XEj0wT4JoDxdk2DFcZofHxy@vger.kernel.org
X-Gm-Message-State: AOJu0YwsgKfkDeIfjAHCakZDvjM+ndTnBahcpsagCYEt4sHwF+fCO2TL
	1xSI0d9QLAx1qPFwZD5V2MY/PA3/ivXJ50OYIIs9BHKDidbsM+cw8SLNQckuUxkjhnVuAb/aba0
	E6DYQZNm5BXhesi6XUO2r8JJWXf4IK1Mk+nvqiw1+0CSa6/4dVq6gwG+l+xdkm+c=
X-Gm-Gg: AeBDieteHqAbUxkoqay9Xyflyl1XfOd08KtvfuBYDfBMsFarrxM3H05tTstJO0P5KnP
	bdw8L47oiP+h68czV/tY5ZfN/G8bdMYBo632k0a6oVQZkV63gWV+E4d4qQeXu1J8qjFzSa3pmwt
	8OAt2nlzEpDH+lzCHOXMPouQtDB2sxQF5SG0YR2fxt40SJT1F2PxtX0J80EiSRIio4mRzUhd6yH
	F5FQQE2C9EeinQyczkkfulgX3riQQccgCLeJgrYWZhdd+WsYqEOusS+wqNwlFZLPvd9nZieE6d1
	1BfvHqyCjGnLZBC7+YoquRfV95n0snajkuWChgwYBTH4x9uEGWPVm3g9vznPyuj7uPe3SjXbGYq
	/OKNgi+n8rnWkYg4ewfGmALAAGsgSQqGeoAV50Dj/jPYe
X-Received: by 2002:a05:600c:8710:b0:485:5ba3:37d8 with SMTP id 5b1f17b1804b1-488996b0589mr344301555e9.5.1775661061344;
        Wed, 08 Apr 2026 08:11:01 -0700 (PDT)
X-Received: by 2002:a05:600c:8710:b0:485:5ba3:37d8 with SMTP id 5b1f17b1804b1-488996b0589mr344300725e9.5.1775661060713;
        Wed, 08 Apr 2026 08:11:00 -0700 (PDT)
Received: from [10.43.17.48] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5d85493sm25043395e9.17.2026.04.08.08.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:11:00 -0700 (PDT)
Message-ID: <19c4251f-d63d-453d-a51a-9eaed7d6029e@redhat.com>
Date: Wed, 8 Apr 2026 17:10:59 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Fix API breakage in libblkid
To: Carlos Maiolino <cem@kernel.org>
Cc: kzak@redhat.com, util-linux@vger.kernel.org, amulhern@redhat.com
References: <20260408103538.134308-1-cem@kernel.org>
 <bdb82d3c-f7b9-4d38-9a6e-8ed921c33ab9@redhat.com>
 <adZMp4mazAAc9iFZ@nidhogg.toxiclabs.cc>
 <94e57a5d-2f49-4e16-8328-5cf30b41d7ff@redhat.com>
 <adZnDrqOXWtV9nUB@nidhogg.toxiclabs.cc>
Content-Language: en-US, cs
From: Zdenek Kabelac <zkabelac@redhat.com>
Organization: RedHat
In-Reply-To: <adZnDrqOXWtV9nUB@nidhogg.toxiclabs.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dne 08. 04. 26 v 16:49 Carlos Maiolino napsal(a):
> On Wed, Apr 08, 2026 at 03:32:14PM +0200, Zdenek Kabelac wrote:
>> Dne 08. 04. 26 v 15:19 Carlos Maiolino napsal(a):
>>> On Wed, Apr 08, 2026 at 01:47:27PM +0200, Zdenek Kabelac wrote:
>>>> Dne 08. 04. 26 v 12:35 cem@kernel.org napsal(a):
>>>>> From: Carlos Maiolino <cem@kernel.org>
>>>>>
>>> So, although I agree with you that Stratis is using libblkid incorrectly,
>>> I still think this patch is wrong, as it changes the library's behavior
>>> to fix a problem in LVM (if there is where the race was), and not some
>>> inherent library problem. If, no user can use libblkid to query into a
>>> private device, then the above lib call sequence wasn't supposed to work
>>> either, and perhaps then, blkid_probe_set_device() should actually fail
>>> in a private device.
>>>
>>> Again, I just looked into the libblkid low-level implementation today,
>>> but it doesn't seem to be the library's job to be responsible for a race
>>> between open() and ioctl(DM_DEVICE_REMOVE).
>>>
>>
>> Hi
>>
>> The main missed concept here is  -  this is not breaking any API.
> 
> I disagree... Same lib call, same device, works before your patch, does
> not after... You may call it a bug that shouldn't be relied on, but
> that's for sure an API breakage.
> 


Well - DM with private suffix is private  - that's the API  and defined long 
time in history - to avoid any interaction with private device and libblkid.

The fact here was a bug for a long while that such device could have been 
still explored by some libblkid calls does not make it a legit API.

Stratis has 2 easy solutions/fixes:

a) dropping  'private' check for their device in util-linux.

b) use non-private UUID for a device that should be managed by user-space tools.

For lvm2/dm - it's clear we never want libblkid to access internal raid legs 
or other types of private DM devs.

Also it should be noted - Stratis should not have been using 'internal' logic 
without fully understanding concept of 'private' device in the 1st. place....

So eventually as a 'middle' ground solution we may possibly have new:

    sysfs_devno_is_dm_really_private()

that would be called in my patch in this function that would be a replica of 
sysfs_devno_is_dm_private() just with LVM suffix check.
But still this kind of defeats the original 'intention' of this check and 
makes the code harder to follow.

So I'd still prefer a fix on Stratis to correct notation of the private device.

Regads

Zdenek

