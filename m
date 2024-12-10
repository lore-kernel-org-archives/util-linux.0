Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74CE2153FE
	for <util-linux@vger.kernel.org>; Tue, 10 Dec 2024 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829401; cv=none; b=Fqy3tsARCyT9CNp6jAtTuMDiVR7HrJPFkDVNbig03hQ8h0WNmVROCJbjoQQRzq7DQXFZhiuc8NpvckVFc+seI45Cfb/zwl1Idnqy5C4UVpRePDjifiUoudFK3M6jeZCvweiiH+9BopEIX44BrneSb7vo6KtmDszRJpt6fU/xrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829401; c=relaxed/simple;
	bh=/+QCI6m3FZGGalwod0SkgA6+CnIx5uHI9xBxA/eQHeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To+JSE5KaER5Qfi+pt9HwJUIJ1Y4ARbegTmNeKtN4FP4I1LlRc2Z+YFvkt22FbcKJO0F7EyzWK4KkFgs8GbA1P2YoRTzwLeWW15+6k5JL4soZvzSGi1WP1wrxt30kk+lLNUrNSFjCxiTmzoGac0BkO3JvgjzcRZL36ATE1Bovp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xq34N3CG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq34N3CG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733829398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXWQ90pgVEfWbzwIhsAAZXiUAGqmMvlm83G+97Q5AoI=;
	b=Xq34N3CG7aKjfPrJ/ieuirCK2XOhOpq5/VBZMjSoGyhHEXSevTiLk7YUMRrFlyVQpDz0tu
	rxq1b/+4I9igsso5sw6mMweVbfKlgOwTaez8PowVzXYcojI/+Yl4e7Tcn99m97x6zUtJ5k
	urvYFn52MGbH/G10MSZqLcfaUMMZUA4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-i7aknaxFN7ipSN2o4qXRKA-1; Tue,
 10 Dec 2024 06:16:37 -0500
X-MC-Unique: i7aknaxFN7ipSN2o4qXRKA-1
X-Mimecast-MFC-AGG-ID: i7aknaxFN7ipSN2o4qXRKA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38394195608B;
	Tue, 10 Dec 2024 11:16:36 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A465195605A;
	Tue, 10 Dec 2024 11:16:34 +0000 (UTC)
Date: Tue, 10 Dec 2024 12:16:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Ensuring that mount(8) will always interpret a filesystem
 correctly
Message-ID: <y7tl6b7pviy7ubstwprmw57ubquf777orkp56h45r7ab3xjfek@t3qjqzehfwnp>
References: <6f939e2c-7d86-4b3d-885b-2c171c944079@gmail.com>
 <zxqdvuyhtmas5apcnop7kleh2b24sboscyaosgkyqqfz4nlsdf@rmgdzivamwdw>
 <114fa16d-5908-4300-96a0-23203c7470af@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <114fa16d-5908-4300-96a0-23203c7470af@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Dec 10, 2024 at 12:11:49AM GMT, Demi Marie Obenour wrote:
> On 12/9/24 5:26 AM, Karel Zak wrote:
> > 
> >  Hi Demi,
> > 
> > On Sat, Dec 07, 2024 at 08:45:32PM GMT, Demi Marie Obenour wrote:
> >> Is there a guarantee that if all data before the filesystem superblock is
> >> zero, and that the filesystem never writes to this region, libblkid (and
> >> thus, presumably, mount(8)) will always mount the filesystem with the
> >> correct filesystem type, even if e.g. someone writes a file containing
> >> a superblock of a different filesystem and the filesystem happens to put
> >> it where that superblock is valid?
> > 
> > the libblkid library offers multiple modes, with "safe mode" being the
> > default for detecting filesystems. In this mode, the library checks
> > for any additional valid superblocks on the device. There are
> > exceptions for certain filesystems on CD/DVD media (such as udf and
> > iso), but for regular filesystems, sharing the same device is not
> > allowed.
> > 
> > There is also an option to specify that a superblock is only valid if
> > no other area is using it (using blkid_probe_set_wiper() and
> > blkid_probe_use_wiper()). However, this is only used for LVM and
> > bcache.
> > 
> > The library does not require that there are zeros before the
> > superblock, as not all mkfs-like programs zero out all areas.
> > 
> > In recent years, there have been no reports of collisions. In the
> > entire history of the library, the only collisions I can recall are
> > with swap areas and luks, and occasionally with poorly detected FAT
> > filesystems (due to the messy design of FAT).
> 
> Was https://github.com/util-linux/util-linux/issues/1305 a
> collision between ZFS and ext4?

Yes, but in this case, ZFS was incorrectly detected. As you can see
from the bug report, blkid ended with an "ambiguous result" error.

> > I believe the situation would be the same even without the
> > Discoverable Partition Specification. The kernel always divides the
> > whole disk into partitions, and libblkid/mount utilizes these
> > partitions. Therefore, the filesystems are automatically separated by
> > the partition table.
> 
> /etc/fstab provides an explicit filesystem type.  The Discoverable
> Partition Specification doesn't.

You can use the "auto" file system type in fstab. It is also common
for people to not use the "-t <type>" option on the mount(8) command
line.

However, if you are paranoid, then specifying the file system type in
fstab and avoiding Discoverable Partitions is a good choice.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

