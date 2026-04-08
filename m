Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA485313520
	for <util-linux@vger.kernel.org>; Wed,  8 Apr 2026 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655141; cv=none; b=VTwBY3iwGo3FLVGSgUNRq9FEI3otOCOU8JAeim6inihBupir1M42E9odRJ5Lo3fZHn5BGu0K/w+kJgBe8MJp0ctWQEcxVvtTO/mN4pMHp+rliIAYl0akpyoGQX2Qgs6l/l0qwPIAP35gCc6wiVQsCkLcyhHsJppBTGYwes9oGl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655141; c=relaxed/simple;
	bh=CHnaSAmaLI+25RRQ2kZp8wVk8h9RdnCBvXOFBjAIbt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAAlKGVQwGiEKLstp0jTGdymOdkvLHarOP1cWQyXTbaJEHAV0VH20pTre4OwcbcHEBjW2rxXgjzMSjmbCjWGgD3lb5KKhi2w9KkjjpasO6OuV9YdOkeS8h2o+ReO2vheSrXarcULi0bkiyZx1O+LC5atYAb1dYomgjf4GiCyHiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXk0w2HN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tfhrX/ZE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXk0w2HN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tfhrX/ZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775655138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7DyGS5sYT6xKKcmZjgfV7ZpfNlUhjMvV/RU19BFVCY=;
	b=NXk0w2HNNeBBsbkYwfwbrGNlGinLDKPog3pQW7/BM+rPh/P+BU1Vet5ytiX9yZHX0N9aC6
	Qxxj1xdTDOG4YOX15DAgh9npF2GryMDQv4s0knbn5Sx2MvTztbv0Cqu+ANC1W7CWVXvkcF
	8YpBxOTWU4dIaV6Eo/NnGB1oFXS4JHs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-uCRy5ygAMAOBYaUZiaJ2og-1; Wed, 08 Apr 2026 09:32:17 -0400
X-MC-Unique: uCRy5ygAMAOBYaUZiaJ2og-1
X-Mimecast-MFC-AGG-ID: uCRy5ygAMAOBYaUZiaJ2og_1775655136
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cfb72377bso4203689f8f.2
        for <util-linux@vger.kernel.org>; Wed, 08 Apr 2026 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775655136; x=1776259936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P7DyGS5sYT6xKKcmZjgfV7ZpfNlUhjMvV/RU19BFVCY=;
        b=tfhrX/ZE9eRlQEGARtoBjPzbzlj6j1uT62u4WHuTLxmkLrIWSvvYUxLdS+Qk7YTjBp
         5Cvfm0CSioL5QGls7ZpY+cVeJPVu99CrGfkkJBO8ivZZg412v8dSMIdqN+8XzzCj1Liu
         CzHoL5b9fbUzRcZBCmz/LNQ9admM0FWaAnprD0AsUubXhHxQnHnCF7U4clAzNXUc/Y42
         R4XfoUnBOsFZuW2xIDvAOkXe2QcV62CKVfgzn+7qAJbSd6f2ZCR7anzykre6F94ldBEN
         YzxZJukaGQuwVcWeTH1QtPch/YFooPnT+poNKtxxjPoarUlojsjiRlPQIm9h//wOKEzJ
         4nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775655136; x=1776259936;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7DyGS5sYT6xKKcmZjgfV7ZpfNlUhjMvV/RU19BFVCY=;
        b=j89+z2iUOL25/NNTraJGbnd37PW2eVwzku4O8P00Xc6Iw5v6Ga/zaa/LomTOKQ4StD
         kl9zNcRjBeRBVilHwQDxQ03H0dhnTDM4FeszL0xIoeoXseutC8olN25qCVIVt0MVJqVw
         JH9fshJS3sRIq2229vlBeb0i5dn5m/YDXG2hLrtSJ7f1BZ4xVBGFmBNEJafipLaOlaSr
         cjAtR3PEyeb9u1CcqgaCYe3ibb1uptK/NkNpsnukceyF4+naEPR46MsGljpR8vshQ7YX
         XuHMVgiO08d/aheEyhMgKnf+hl1dL1GrydLu719Bb1/KTz/9LZ0ydyYYWWWygq/zMOYO
         oQVA==
X-Forwarded-Encrypted: i=1; AJvYcCXdERGiRuqfSmXw0He8sOhvDdAza+aSzXP+ogxLQ5JO+MB3vUfviVaG1upYgE45P/y+vQEJ6Oh6/Rqm@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQnkNGemagmtcHChvAYQYwfIyifp5IznX7/kGqgPqVb3606uQ
	s0+pNl9fPXlITVGmISsm+3YICozEmNp9j236wKBJPBgv2lHsUjQDYDJdsB7dDJF3jqqciCBnpx2
	6kcrwVAjBmgipOfZNiaT2QgTyr8sjKFvebqJ0wF2Q68Qd9gtkkXCMPcrUpy2wYNk=
X-Gm-Gg: AeBDieug8ly7mpOHrY6tHcSIr66YEtWimZAovnxp8Yt4fWtopb01tpP/SXRh8cbfU3t
	7Uosq3cugQmh4chFBF1ZWwpx8kp952lCxwwNTlgCoMhrp2EiuyonYu+veoZpppgurLTe8B/z1yd
	aKMoLeEKW4HSElIZYrliCqCf7tb6CqjTpOEKAYEOlbP+UDtpV0kFPnvuf9QHfu29poaH/33UqDu
	IvuD1hqBxsIjo/xr1EfsS3hxj2cz2GM9HKCn8SgtKqmrATeOk183RAMgniyK2GKayTpIduxohy4
	dhpX82HIVg5ThjH8AwV1otm8YwbLS5Maot18CytmENB7m7oOcESn+WfvzU6et5GuqKCjph6Paln
	an2Jf10WxT+8q1EqkvJP4B5kWD5A+2iRbdwaapz8CVA5o
X-Received: by 2002:a05:6000:240b:b0:43c:f40f:6c92 with SMTP id ffacd0b85a97d-43d29276ad3mr28678567f8f.8.1775655136110;
        Wed, 08 Apr 2026 06:32:16 -0700 (PDT)
X-Received: by 2002:a05:6000:240b:b0:43c:f40f:6c92 with SMTP id ffacd0b85a97d-43d29276ad3mr28678488f8f.8.1775655135550;
        Wed, 08 Apr 2026 06:32:15 -0700 (PDT)
Received: from [10.43.17.48] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm55175695f8f.35.2026.04.08.06.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 06:32:15 -0700 (PDT)
Message-ID: <94e57a5d-2f49-4e16-8328-5cf30b41d7ff@redhat.com>
Date: Wed, 8 Apr 2026 15:32:14 +0200
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
Content-Language: en-US, cs
From: Zdenek Kabelac <zkabelac@redhat.com>
Organization: RedHat
In-Reply-To: <adZMp4mazAAc9iFZ@nidhogg.toxiclabs.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dne 08. 04. 26 v 15:19 Carlos Maiolino napsal(a):
> On Wed, Apr 08, 2026 at 01:47:27PM +0200, Zdenek Kabelac wrote:
>> Dne 08. 04. 26 v 12:35 cem@kernel.org napsal(a):
>>> From: Carlos Maiolino <cem@kernel.org>
>>>
> So, although I agree with you that Stratis is using libblkid incorrectly,
> I still think this patch is wrong, as it changes the library's behavior
> to fix a problem in LVM (if there is where the race was), and not some
> inherent library problem. If, no user can use libblkid to query into a
> private device, then the above lib call sequence wasn't supposed to work
> either, and perhaps then, blkid_probe_set_device() should actually fail
> in a private device.
> 
> Again, I just looked into the libblkid low-level implementation today,
> but it doesn't seem to be the library's job to be responsible for a race
> between open() and ioctl(DM_DEVICE_REMOVE).
> 

Hi

The main missed concept here is  -  this is not breaking any API.

The concept of private DM device is to be a device that is not being touched 
by libblkid.  So this was a pure bug in the libblkid code when there was a 
code path skipping check (and actually doing this check after opening private 
device).

And actually IMHO there is a bigger issue -  xfs tools are actually relying 
too much on content of udev DB - this DB is by design unreliable - so it's 
likely good for some quick checking - but i.e. in lvm2 - we always do a real 
disk read -  udevDB is only advisory.


Regards

Zdenek

