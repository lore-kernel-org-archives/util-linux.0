Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEA7D412
	for <util-linux@vger.kernel.org>; Wed, 10 Jul 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607983; cv=none; b=cEHsyf0NAPjAb8hPDXPkEmGo7KwpszoW013IoCrA/ElBWuiswpn3/5NSz0t/tmmiJvU8SxTExEZL4Y7Yt0Qs2QVkZyvWk/EbX4ya/R7PLXUZQepi44PpbsAeIBIUPtUR8HFAjFcLRiHBJab7ACCqQ8X7g1fLhpVk13dHeSYjOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607983; c=relaxed/simple;
	bh=jWy2Z5hY7X7kHmfQMvD3lawI90HWFxfwyAHZ97ojtR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4w41tUJiZi2oYxi8evzgBhvbdUEs9FLEqMJjNGJwmZFyJZq7sjgctHMqe9F9NjrJNE8efwYTnBzecIhqJGkKFAOUX0d5/jLYR3R6oD9d7jhFQiq0IkgNGfd/rwSMaRoy9Q8VaNA5SfH7Pg9XLpGqAPJ+teZNnXTe6fw6xe2Fw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dG7Xx2z4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dG7Xx2z4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720607981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZqtx9T7PltUumv4FHKp6WQ5wri+GN5n2GOBC9i3bhg=;
	b=dG7Xx2z4O3/ust2g3jsYcPgyFgRWnGVeDjrXcmBurUUep5ZNtu+wGTvHdDVdJ2U/lae5mO
	rSH7heAohpE9mqwByw0X7xJWVFZh4N9vwg+tAcN5Ft0yFiuw+9VmvJy21tPn+DVnWC8tIO
	aAK2CuS4tseskW8Eh850bBfZywbK9vo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-EZS919fvObaWdQVacYzWOg-1; Wed,
 10 Jul 2024 06:39:38 -0400
X-MC-Unique: EZS919fvObaWdQVacYzWOg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDA7A196CDF5;
	Wed, 10 Jul 2024 10:39:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B07A61955F40;
	Wed, 10 Jul 2024 10:39:36 +0000 (UTC)
Date: Wed, 10 Jul 2024 12:39:33 +0200
From: Karel Zak <kzak@redhat.com>
To: lukaro <lists@lrose.de>
Cc: util-linux@vger.kernel.org
Subject: Re: lsblk: mount point in btrfs raid
Message-ID: <a5dbjm6jeaz66hm6vqb7cg77sm74zq2ci5jbhaejnsg3wtin3w@tkdrki22f4f6>
References: <48C84F1A-9A8A-4E02-8E32-B171461DC0CC@lrose.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48C84F1A-9A8A-4E02-8E32-B171461DC0CC@lrose.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Jul 06, 2024 at 04:17:30AM GMT, lukaro wrote:
> Hi everyone,
> 
> in lsblk, I'm used to seeing the mount point for all devices in an mdadm raid, like so:
> 
> sdb                8:16   0  16.4T  0 disk
> └─sdb1             8:17   0  16.4T  0 part
>   └─md127          9:127  0  32.8T  0 raid5 /store/RAID_A
> sdc                8:32   0  16.4T  0 disk
> └─sdc1             8:33   0  16.4T  0 part
>   └─md127          9:127  0  32.8T  0 raid5 /store/RAID_A
> sdd                8:48   0  16.4T  0 disk
> └─sdd1             8:49   0  16.4T  0 part
>   └─md127          9:127  0  32.8T  0 raid5 /store/RAID_A
> 
> However, with btrfs raid, the mount point is only shown for the first device:
> 
> sdf              8:80   1  7,3T  0 disk
> ├─sdf1           8:81   1  7,3T  0 part
> │ └─video_4b0  254:4    0  7,2T  0 crypt /mnt/video
> └─sdf2           8:82   1   28G  0 part
> sdg              8:96   1  7,3T  0 disk
> ├─sdg1           8:97   1  7,3T  0 part
> │ └─video_5f2  254:5    0  7,2T  0 crypt
> └─sdg2           8:98   1   28G  0 part
> sdh              8:112  1  7,3T  0 disk
> ├─sdh1           8:113  1  7,3T  0 part
> │ └─video_666  254:6    0  7,2T  0 crypt
> └─sdh2           8:114  1   28G  0 part
> sdi              8:128  1  7,3T  0 disk
> ├─sdi1           8:129  1  7,3T  0 part
> │ └─video_9b1  254:7    0  7,2T  0 crypt
> └─sdi2           8:130  1   28G  0 part
> 
> Where in the sysfs does lsblk obtain the mount point information?
>
> Is it possible that the btrfs module is lacking this information? I
> would like to understand why lsblk is lacking this information for
> btrfs.

The list of mount points can be found in /proc/self/mountinfo. When
searching for a mount point, lsblk uses the device number (major and
minor) or the device path.

The /proc/self/mountinfo contains a list of unique mount nodes. This
means that the Virtual File System (VFS) of Linux does not have
knowledge of how the filesystems internally implement the RAID.

The mdadm RAID maps all the disks to one virtual device, which is
visible to the system as a normal block device. However, for btrfs,
there is no such thing and all operations are handled internally
within the filesystem. 

It would probably be possible to add additional support for btrfs to
lsblk in order to request more details from the filesystem, but this
feature has not been implemented.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

