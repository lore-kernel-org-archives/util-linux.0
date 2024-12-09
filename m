Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF702165E2
	for <util-linux@vger.kernel.org>; Mon,  9 Dec 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740008; cv=none; b=QgMe4OkO7SSbf9ZGly5N8jKdXK9CqD5efiMN+BZ8V3DCSQoaYMChFUrf/hi0ukQRBPTdZjaduFoNjKV/atPEg1LibxDGncApCjLBuVagncZDVz+jILSJtGBrVcXJaHflgnSTAAPPApkiPyjevM0/vimnhqVq3KH2m+BdseTjiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740008; c=relaxed/simple;
	bh=IW5+XxdBcDYxStxf0ANHz2/aaziQ1TEOwa/5ipNf9iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYuE4lR68PXlN7OfV+CSSz2sJoMIZWbnY1rjhcvaOOKKDq7zuILmmT2PZxZ1ce/JDBJZyOJC4aRI/TtZesS/EaWBKvm34eaHARGBKdRN8D/6uChaksoxyEUnFrcphD0Bf312hRVnBYPQ95zMkO7aV3vxEhf+wm65skgUTEPd59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1/Kcjub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1/Kcjub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733740005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TaFPPqDG35qNxK2ycfSlzgVAsV/rQWmLGzAi4qRKnNk=;
	b=K1/Kcjub/m479c+Nwx4/ZkY34/ylgWFSjfT5uxmMlBvqvqefxPcZnfiPEi5NKACgzS7cg1
	ezym2xoJb6Q3PFrUd71ZnpqNoZD3DdB4pHFuOUeezAWx48TrA3shDPW3B5PPSVWfQAAADN
	FpoSOzyZr5m7jFDZNDiZdIb8+A/A2lw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-FCylwaapMuuUXfaAVfOEYQ-1; Mon,
 09 Dec 2024 05:26:42 -0500
X-MC-Unique: FCylwaapMuuUXfaAVfOEYQ-1
X-Mimecast-MFC-AGG-ID: FCylwaapMuuUXfaAVfOEYQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4120E19560A2;
	Mon,  9 Dec 2024 10:26:41 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 437EC1956095;
	Mon,  9 Dec 2024 10:26:40 +0000 (UTC)
Date: Mon, 9 Dec 2024 11:26:36 +0100
From: Karel Zak <kzak@redhat.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Ensuring that mount(8) will always interpret a filesystem
 correctly
Message-ID: <zxqdvuyhtmas5apcnop7kleh2b24sboscyaosgkyqqfz4nlsdf@rmgdzivamwdw>
References: <6f939e2c-7d86-4b3d-885b-2c171c944079@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f939e2c-7d86-4b3d-885b-2c171c944079@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


 Hi Demi,

On Sat, Dec 07, 2024 at 08:45:32PM GMT, Demi Marie Obenour wrote:
> Is there a guarantee that if all data before the filesystem superblock is
> zero, and that the filesystem never writes to this region, libblkid (and
> thus, presumably, mount(8)) will always mount the filesystem with the
> correct filesystem type, even if e.g. someone writes a file containing
> a superblock of a different filesystem and the filesystem happens to put
> it where that superblock is valid?

the libblkid library offers multiple modes, with "safe mode" being the
default for detecting filesystems. In this mode, the library checks
for any additional valid superblocks on the device. There are
exceptions for certain filesystems on CD/DVD media (such as udf and
iso), but for regular filesystems, sharing the same device is not
allowed.

There is also an option to specify that a superblock is only valid if
no other area is using it (using blkid_probe_set_wiper() and
blkid_probe_use_wiper()). However, this is only used for LVM and
bcache.

The library does not require that there are zeros before the
superblock, as not all mkfs-like programs zero out all areas.

In recent years, there have been no reports of collisions. In the
entire history of the library, the only collisions I can recall are
with swap areas and luks, and occasionally with poorly detected FAT
filesystems (due to the messy design of FAT).

> The motivation for this message is that systemd-gpt-generator generates
> mountpoints based on Discoverable Partition Specification GUIDs.  These
> indicate the mountpoint of the partition but not the filesystem type.

Filesystem auto-detection is a common feature. The situation is
similar to having an "auto" fstype in fstab. The systemd-gpt-generator
simply identifies the partition as "/usr" (or any other mountpoint)
and the rest is usual scenario.

> If a correctly-produced filesystem image will always continue to be
> recognized as the correct type, this is fine.  Otherwise, an unlucky
> combination of writes to the filesystem and filesystem allocation decisions
> could cause the filesystem to start being mounted as the wrong type, which
> would be very bad.  According to https://github.com/util-linux/util-linux/issues/1305,
> libblkid can indeed probe for subsequent superblocks after the first one it
> finds.

I believe the situation would be the same even without the
Discoverable Partition Specification. The kernel always divides the
whole disk into partitions, and libblkid/mount utilizes these
partitions. Therefore, the filesystems are automatically separated by
the partition table.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

