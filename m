Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94E4C9C
	for <util-linux@vger.kernel.org>; Fri,  1 Mar 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317866; cv=none; b=YydmDQcaPan37Uwix+EpSQ2+Nr29mE+MvvgI18Wswyh5t6VtRjZcEdwcL/3YE4bzpQGJmbwpCHkrPXk/CuVr+h5Vdt6ZSlpOCgiEu3rL8eEh5K7Rys5u8ZOajRcdj8cPEfuKUSNYZAxB1qHvdwfRC+4i74DzCMOeKSV+K+l2zy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317866; c=relaxed/simple;
	bh=5cHCJeeRml/MfJN4HDxBV0BvROgcKenS5s6lWwptoSg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HwYrhVUeRemshYF0wGKFfbjdwYccrlnezLNFkQ1gSko0TQILA5BmILbXiShNsCGbWaH0zHVtF0G8/cW5xZjFowDCV5Jg+hXfj0XE43u5hvurdwbkyka7PGvDrjNRWDiDgqD2uZ7NGJavNXzMksDps+Bxsqk0SeMooB7B4gSpOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2/9E69u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2/9E69u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709317863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5cHCJeeRml/MfJN4HDxBV0BvROgcKenS5s6lWwptoSg=;
	b=X2/9E69uWnwu2myiA5WNhalnlTXgnS1mjm88qZ9SV+IZn7FmInMTFcUbsI6/pYs8m1qxkI
	IIjVlhtgYHkBydxd2jNgwgUWYTuugBi1bUZpjkTcSILxyRFuCAjUxG4NvBkvk/KzxA2xol
	7NWH9rHwwCsUlv32KJh1669G6SI8t2Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-u88yNBBONxKbrgCdrAD_hA-1; Fri, 01 Mar 2024 13:30:53 -0500
X-MC-Unique: u88yNBBONxKbrgCdrAD_hA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29b27e71d7aso565873a91.2
        for <util-linux@vger.kernel.org>; Fri, 01 Mar 2024 10:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709317852; x=1709922652;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cHCJeeRml/MfJN4HDxBV0BvROgcKenS5s6lWwptoSg=;
        b=QYHjnOdkYqYSiz7L5Rupk5+UPcBZA3pAJkvp3HFUX4Qg1eLUy68/i4THRivavfICDC
         M3ZGxpxKYPEot4Qv7bytYk617EQfe8S8+FYHofsQ1KrXSWDSSkw7Bga7dLQ0p8kuYlrE
         wJ+28kOWN9aJ8eBWRext386VwhB8GFzmYKc8oKHYzLtqoK5SVHRxnpldxNEf/TmE1DgU
         pCqHEkSGbWfthDc+D3salPc1GH3mfXY5xnUad7uJ/hJI2BiLZB0ZZQerFvQY/v3qyamy
         x6vxZuF2DTY+D4fzifSDX2lw5y0YcBA/9MK8n6vDG2/BeJc0imBkF4614Rum+xgptXGa
         ppAg==
X-Gm-Message-State: AOJu0YxkPnZ1jIfCJeaiiDV/RGN5lNhPgzfJnuvd3jGQ2C/YrLTo3G4X
	e589xnGW4G8eAgRPgyvgK5cKQ3C+f0wdEhOXEeLgPsA4DlyYAcSI6AL1/3nOB3pDBEGc4anDDsz
	JpoVW/YgIc+TtrXIYMYRrIGWBg72CHHDghGmHBheIuIHNHBhI6IQZSWEBOQ1l0bzHCxFCD/ZNhv
	IpjThCgiUtAkTXv7t4lo2bGmA4eldYTHwRC1c2v2hoP+2I
X-Received: by 2002:a17:90a:f3c1:b0:299:464c:c9fc with SMTP id ha1-20020a17090af3c100b00299464cc9fcmr2028207pjb.45.1709317852537;
        Fri, 01 Mar 2024 10:30:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbpKoG2Ons9RvZo8ieW+1gU0QOVtB9TsphEpklzXWXhFMqEzGtymIG1wpBOBtDkBDnRM831EOeu/XQWbnsLZ8=
X-Received: by 2002:a17:90a:f3c1:b0:299:464c:c9fc with SMTP id
 ha1-20020a17090af3c100b00299464cc9fcmr2028194pjb.45.1709317852197; Fri, 01
 Mar 2024 10:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Curtin <ecurtin@redhat.com>
Date: Fri, 1 Mar 2024 18:30:15 +0000
Message-ID: <CAOgh=FwPHHW7fyTZDF422+WLuXps_qNcTUDDQopAHT_dJNZ6Sw@mail.gmail.com>
Subject: Finding a block device quickly with libblkid
To: util-linux@vger.kernel.org, systemd-devel@lists.freedesktop.org
Cc: Eric Chanudet <echanude@redhat.com>, Brian Masney <bmasney@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Guys,

We are looking into optimizing the boot sequence of a device with many
partitions.

On boot in the default systemd implementation, all the block devices
are queried via libblkid and the various symlinks are set up in
/dev/disk/* from the results of those queries. The problem is on a
device with many partitions this can delay the boot by hundreds of
milliseconds, which is not ideal, especially when in many cases all
you really care about is mounting the block device that represents the
rootfs partition. We can sort of guess "/dev/sde38" is the correct
one, but that's not deterministic.

So we started digging and came across blkid_find_dev_with_tag and
blkid_dev_devname, which you can call like this:

blkid_dev_devname(blkid_find_dev_with_tag(cache, "PARTLABEL", "system_a")))

blkid_dev_devname(blkid_find_dev_with_tag(cache, "PARTLABEL", "system_b")))

On first glance this looks useful as you don't have to loop through
all the devices to use.

But this function only seems to work if the data is already cached, so
it's not so useful on boot.

Has anyone any ideas on how we can optimize the identification of a
block device via UUID, LABEL, PARTUUID, PARTLABEL, etc.? Because the
current implementations don't scale well when you have many block
devices.

I suspect we may not be the first to encounter this, so just probing
to see if anyone had ideas on how to solve this in the past.

Is mise le meas/Regards,

Eric Curtin

