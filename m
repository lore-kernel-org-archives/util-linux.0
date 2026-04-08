Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AD377003
	for <util-linux@vger.kernel.org>; Wed,  8 Apr 2026 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648854; cv=none; b=OvU3e4DckqTauIpOxn/ynC+YaiVrupsZeH0Pq0GBRqKcySZ7Wr2kucxONtNQMj7Z77vz1JEnD8ZW1MUWMRVL7dvkycvcCHYVN2SsyDakLz9sf5ZHo3Coe8prxK2lQqcyKaK6FFj0lezQidk+239vsMMW1eiREV3YZWurngOf8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648854; c=relaxed/simple;
	bh=CncD7YSFdmDj9zlQ4LXXsMVoE5DPC+HpQtRHK1LvypY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5WkxvhZk/9rZeLn9WbJznG5E+tWlGy+xFZTUOsQqt23Ux8sXpG10OmTStu9YT/u8mjqxDF5nX3cKMA7j5aa9qaW2UxByFgAF1fX/rlyz8Ip0iLjpbkoJrtN7BiBVcXqikSmkO4slRdoWu4B0Oxz6GHmBGQmjZCx9qNPeb7hYCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZExCxfw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaOEESnN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZExCxfw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaOEESnN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775648851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1I9L04oPOzCslJhnLT8DPLXtmjWOaPIbMuXBSBfwgg=;
	b=bZExCxfwUmjbhHxkAO2b6yVvvzTKiPTjmOZaXczSz1kG2AnHShfDo8KkTUjeXCiS1xBti1
	1Up/bnTEz3vfpry4mDzI82Q6Z8QdpLSObWRAVv/KIlqS1Ii7ggMSufFkti7FFJ6H6IAZqF
	LLtnFWl+CQzt/gCTt82z89FgPddsLvs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-0nOcyLV9M16zlUhbmuqqrQ-1; Wed, 08 Apr 2026 07:47:30 -0400
X-MC-Unique: 0nOcyLV9M16zlUhbmuqqrQ-1
X-Mimecast-MFC-AGG-ID: 0nOcyLV9M16zlUhbmuqqrQ_1775648850
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c2764f83so7954215e9.2
        for <util-linux@vger.kernel.org>; Wed, 08 Apr 2026 04:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775648849; x=1776253649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T1I9L04oPOzCslJhnLT8DPLXtmjWOaPIbMuXBSBfwgg=;
        b=GaOEESnNUAqLXTiIiIeifaxsQkipKNxmbvGZarnqZvMO4PmoI/WUalOdJXthIqRucC
         MZFsv7ab269zPy4L+RLvnBUgyjFBk2LH2x/s+jdC6q+zqZwYpYWzacRS/mhSrdtm2ViH
         QYGVQjqU0nDgbYA/bRCXCiN3TLz+MW6UizfiBLsxUqiY6XUt3NuQ8swJUvcjeRV4zZz+
         4BSPtMCviGCpvm9geSmKPlcxvTwzu8goGkPQ92ozz6+drxp+miJKFbiApNdeJgwKlNvS
         wORCf4ePXkklLLWHtHrwxlZ2+oOBrzugqfBb4tp+KM6ySYjfkf8IITa7+cM4ww2B+Phc
         HThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775648849; x=1776253649;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1I9L04oPOzCslJhnLT8DPLXtmjWOaPIbMuXBSBfwgg=;
        b=f7R3w7Y5f2SiVadbmpRDBjMnRbDHWbXTDvdnsmeFDe9ZS+n8RLjYzn/aHfbVZaoPGp
         u8v7DZGhjc6g5rmaqm1NhcgaN1UTdtq197P9vCLexhWJdhkJJFPe0nEf3mVhYthvI4Yl
         77GVGsURAVx8UNz3jdISDzH+pPhFN//v1+EbsNk+5OlEdUdbhnZUbZW7O5iQ32w5J9id
         D0iTC++Mcu4JFXiIDQDqNaF4GQAjVWW5F6efltRs6dy9Yfl9h0Bo+2kLY/OTpAILDc0C
         Rk3F4dJa4IiFmVT+mSzWExp+idpZtjXvSFtxctM+7kYOo/iadFlb9tQV7MeJqF5T5gnA
         JPVA==
X-Gm-Message-State: AOJu0YxRFVPKCmP/b55I5EWizY2bckEKpBDWqFpxsivZRBM163MBXok3
	IzAwOxk0W2AVZDLz/3RI/R4qfoL0j8lrXblPd2g9yE9WGmHhLvE1ybMkMyK+HXiSb4zifZgatFw
	RwHQq3uInXaSTB1Kde3tysWrZMFIe7cacFnhRWoF1L16uq8sDrtw1WGimjNkN/NT0zgjZgSVb2w
	==
X-Gm-Gg: AeBDietTv13ijYaxt04DQc9iwkz61Gt1Y5YUc8ih/tMCVEe8Z50g44kd8epTVts4tKV
	rDpMYOTjZycZa/864JGt1AaG6CbbX1oK/rbJJNamcLNv0YcZhK6BDHekmvdywfp30HH2noH2EwU
	6cSqXhy73bGzXl9xgKIuccl23iJ88Pna0R80PnYWla5FYNx17+4Zy7ncFsjgu2SF0+5oU5/9fhH
	cknTCA/cvPdmV9r950xUBokqquKp+3iPXXjHW1KtzGOA06uNA07CNXv6aUXzuz3L4ChfzZ7c2Nu
	hmQk1jRrweRVpAEHswP0zGxAhvDMTMX5QIb7YIO5DftkBiE12y+ikIoAWsMfvZO1/uEa1MzO2UC
	C/rqAdqqDSpqZPbAqtwq7ZpHcItUP2rUZM253hJwViG77
X-Received: by 2002:a05:600c:1e24:b0:488:c078:bfda with SMTP id 5b1f17b1804b1-488c078f73fmr75022365e9.26.1775648849292;
        Wed, 08 Apr 2026 04:47:29 -0700 (PDT)
X-Received: by 2002:a05:600c:1e24:b0:488:c078:bfda with SMTP id 5b1f17b1804b1-488c078f73fmr75022085e9.26.1775648848815;
        Wed, 08 Apr 2026 04:47:28 -0700 (PDT)
Received: from [10.43.17.48] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d28a5sm53456497f8f.20.2026.04.08.04.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 04:47:28 -0700 (PDT)
Message-ID: <bdb82d3c-f7b9-4d38-9a6e-8ed921c33ab9@redhat.com>
Date: Wed, 8 Apr 2026 13:47:27 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Fix API breakage in libblkid
To: cem@kernel.org, kzak@redhat.com
Cc: util-linux@vger.kernel.org, amulhern@redhat.com
References: <20260408103538.134308-1-cem@kernel.org>
Content-Language: en-US, cs
From: Zdenek Kabelac <zkabelac@redhat.com>
Organization: RedHat
In-Reply-To: <20260408103538.134308-1-cem@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dne 08. 04. 26 v 12:35 cem@kernel.org napsal(a):
> From: Carlos Maiolino <cem@kernel.org>
> 
> Patch d05a84b22e54 ("libblkid: check for private DM device before open")
> broke blkid_new_probe_from_filename() API.
> 
> Before the patch users were able, via the low-level API, to open and
> create blkid probes via the device's filename even from private
> device-mapper devices.
> 

Hi

So I'm not sure how it happened that Stratis kind of 'reuses'  libdm private 
logic we have embedded into util-linux - but something wrong is likely 
happening on Stratis side here.

For  libdm  & util-linux - there is basic principle - when udev should be 
scanning  a 'DM' device that is supposed to be private - in our case it's
uuid with  "LVM-"  prefix and "-anysuffix:  - such device is supposed to be 
NOT touched by any udev rule logic - it's private - so nothing should be 
'randomly' opening a device at unpredictable moments..

Somehow it seems Stratis selected to use similar notion (at least when I look 
there in  sysfs_devno_is_dm_private()  - there is check for uuid:
"stratis-1-private"


> This change broke Stratis project and xfsprogs.
> xfsprogs uses blkid_new_probe_from_filename() to gather topology
> information from the device, and the above mentioned change now prevents

If the private is not meant to be private -  just drop:

	} else if (strncmp(id, "stratis-1-private", 17) == 0) {
		rc = 1;
	}

from sysfs_devno_is_dm_private()

> it to be done on device-mapper private devices, as Stratis does by
> attempting to initialize a XFS filesystem on it.
> 
> > I don't think the last statement here is correct.
> blkid_probe_set_device() marks the probe as BLKID_FL_NOSCAN_DEV, but it
> does not error out, so, for low-level API calls, we simply ended up
> with a probe with BLKID_FL_NOSCAN_DEV set. But the call succeeded and we
> ended up with a probe to use and query device's information.

Please don't try to break original LVM logic which was the main reason why 
sysfs_devno_is_dm_private() even exists in the first place.

> As far as I understood it, the patch aimed to close a possible race
> window when issuing a DM_DEVICE_REMOVE ioctl() to the same device being
> probed by blkid_new_probe_from_filename().
>

Yes - but there is higher logic behind - private  'device' is private and 
should not be randomly opened by any tool.

> As for xfsprogs, I have a patch which 'fixes' it replacing
> blkid_new_probe_from_filename() by blkid_probe_set_device(), but this is
> just taping over the root cause, which is the API breakage.

I think main problem is that Stratis  mangled  'private' meaning in some way.

So let's fix Stratis instead of breaking correct logic in util-linux made for 
lvm2.

Regards

Zdenek

