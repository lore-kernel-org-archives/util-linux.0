Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1291CBA17
	for <util-linux@vger.kernel.org>; Thu, 21 Nov 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186796; cv=none; b=LUQKVptY40y+JvQBfQ4lpV3CkLnC7003zyqZigGHwDiCdLYJHTEYnNLbtpLzRh1VOU7NH4sfoFOstMlnFOCuKQlrUQj0XS6nWuTZmr7GOFqMGaKIWeZL/o4IDMIaGHGc6TKM2xVxjM2FqTa9uK165cXmx9/Yi8iTNB4AifjW5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186796; c=relaxed/simple;
	bh=dOrKPY0PD/oXJxaOYsdRt2iOI92ZwWfoI8WOmTkc6aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4m1FKdIY4m1+dCQA8Xv8MIA7H5YWAJR/cQS7ZpkCVRl1leRgbBFgPZ94Ej3+RiUPobqQZt0wpQallBQci7Ic9P/us/DRWcb0iDe6qG/DIAAXlsHMW6pLm5xO5bmKvBuQ2Swxt7ZlYJdbzQJK6dGyrD70DJ4Mm7YFOviefU4vtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlO/VJqs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlO/VJqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732186792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iigy+BNSmq/4Xo8k6LQt049NzKrzc3kRvu5uEVXIkiU=;
	b=NlO/VJqsI+WOScrlL3ZYT90jaL/ywHk3Lse5rZfHnRuW36DMWYp+0T9/+QZ5XsgD3OoDmk
	p9nCNWsYxdwiPhSKtAHx28K+IcaN72fGqNUFI1oVe2bXS6R0IeBdYp2QxoLxafvc1MC9JC
	FcvLhA7aQD3sLJVLOOndf3RLMaa3Lq4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-oiUNklNOMba4nZ7MBbDnWw-1; Thu,
 21 Nov 2024 05:59:48 -0500
X-MC-Unique: oiUNklNOMba4nZ7MBbDnWw-1
X-Mimecast-MFC-AGG-ID: oiUNklNOMba4nZ7MBbDnWw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC88519541A0;
	Thu, 21 Nov 2024 10:59:47 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.223])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E08BC30000DF;
	Thu, 21 Nov 2024 10:59:46 +0000 (UTC)
Date: Thu, 21 Nov 2024 11:59:43 +0100
From: Karel Zak <kzak@redhat.com>
To: anchal agarwal <mail.anchalagarwal@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: lsblk vs blkid to fetch UUID
Message-ID: <vlnxxhoys6tuljowm446u2v5a2jrvdes7f5fhbycvgpodbcow3@qlfyib3nqzcb>
References: <CAGppiHZvn-vgiQczdTyG+F3-jwzSAMB=Kwf+jFa7UWmF_68-wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGppiHZvn-vgiQczdTyG+F3-jwzSAMB=Kwf+jFa7UWmF_68-wQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 19, 2024 at 12:15:02PM GMT, anchal agarwal wrote:
> Hi,
> I have a use case which involves imaging of a system using custom
> scripts. Imaging involves installing an operating system and
> formatting all the disks and setting up a File System.
> At times I would like to enable LUKS on certain disk partitions, so I
> format the partition using cryptsetup to setup luks format.
> However, I had been seeing issues with fetching UUID post luksFormat
> using lsblk.  I have seen the same issue with blkid but its
> occurrences are exponentially less.
> I want to use lsblk because its faster but seems like blkid is more
> reliable here.
> From what I understood from the code, blkid opens a FD for the device
> and reads directly from super block; however, going through the code
> of lsblk.c I see lsblk_device_get_properties() gets it from various
> methods.
> 
> I am slightly confused as at that point in time the device database is
> not set up so is lsblk fetching the UUID the same way as blkid does
> using libblkid? Any information on this will be helpful.
> Please correct me if my understanding is incorrect.

blkid (libblkid) is the primary and usually only way to read UUID from
not yet mounted filesystems. It reads it directly from block devices,
so the caller needs root permission to open the block device.

The usual setup is to call blkid from udevd when a new device or a
write change on a device is detected. Udevd gathers this information
and keeps it in the udev DB. This DB should be used as the source for
other system tools because it is (or should be) up to date and does
not require root permissions.

lsblk primarily reads information from the udev DB. If it is not
available, then it tries to read it directly from the device, which is
useless for non-root users.

If you get incomplete information from lsblk, it is usually because
the udevd prober is not done. The typical case when this happens is:

    mkfs.foo /dev/sda1
    lsblk /dev/sda1

In this case, lsblk reads data at a time when udevd is still running.

All you need to do is call "udevadm settle" before calling lsblk.

  mkfs.foo /dev/sda1
  udevadm settle
  lsblk /dev/sda1

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

