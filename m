Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86C3D0C8
	for <util-linux@vger.kernel.org>; Mon,  4 Mar 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557892; cv=none; b=QLs52CJ6xDVBg7FwYm5oFTN2onOUha0NZvcFqVSO3GfZYyerDbLMchQrJ0vQ2q+zGZSc6jsUKIWDNgaRBqvS8mkj6aEHJYLphqHZctR7n6UqEjsyEMnAYxISqlKSOOVFEFek+mPu9UYxxlo/hhweuo+pV396BHqmiCy2eTTMDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557892; c=relaxed/simple;
	bh=S7pFZPgqJiDiCpUfH6CT0wlxAyByn3BthroAELqn+L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQyd5HMmxHlkXjUOUM+Y6OyH/D1wyyXEmkKJCKqVDlTfQYcwTQNoNGniLIiF8CNrJVfJ8nO+Z5ImpzP69SNbNXZT2QWt8Us2cWjyB+p4zx3Ic9zbP1lAuQDKHK0VDaCUeMFT/GzDbKGkvmXdn9w4P2SDSptoHypI67nHBuY/oM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9/Ths/w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9/Ths/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709557889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTJp4ZeDN2HvpKtGtxmSkgrBjBUQtDoYuv4RVgPJhqQ=;
	b=U9/Ths/wIlCebyx4cNuneAb7KEPXVlz8XHsyKEjrSSlVBY5kAHHya4zQ8R4wjmzU3U49oZ
	3qjSXHJ9IXEjzJOyw+7lx3JZN+hYWk8ZQQ3jBGiyIl2cWtynLoOHyqSNJBPUiQS0+dZMh2
	U2jhmVuNRD+E+d+stIOvAR06i/8MQGU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240--aNiKVt5PiKY8b-EPOrn8w-1; Mon, 04 Mar 2024 08:11:28 -0500
X-MC-Unique: -aNiKVt5PiKY8b-EPOrn8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B265F185A78A;
	Mon,  4 Mar 2024 13:11:27 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DF0B140C6EBA;
	Mon,  4 Mar 2024 13:11:26 +0000 (UTC)
Date: Mon, 4 Mar 2024 14:11:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Eric Curtin <ecurtin@redhat.com>
Cc: util-linux@vger.kernel.org, systemd-devel@lists.freedesktop.org,
	Eric Chanudet <echanude@redhat.com>,
	Brian Masney <bmasney@redhat.com>
Subject: Re: Finding a block device quickly with libblkid
Message-ID: <20240304131124.4hc53fxojj5zdnfy@ws.net.home>
References: <CAOgh=FwPHHW7fyTZDF422+WLuXps_qNcTUDDQopAHT_dJNZ6Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgh=FwPHHW7fyTZDF422+WLuXps_qNcTUDDQopAHT_dJNZ6Sw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Fri, Mar 01, 2024 at 06:30:15PM +0000, Eric Curtin wrote:
> We are looking into optimizing the boot sequence of a device with many
> partitions.

Nice topic :-)

> On boot in the default systemd implementation, all the block devices
> are queried via libblkid and the various symlinks are set up in
> /dev/disk/* from the results of those queries. The problem is on a
> device with many partitions this can delay the boot by hundreds of
> milliseconds, which is not ideal, especially when in many cases all
> you really care about is mounting the block device that represents the
> rootfs partition.

It's a little bit more complex. It's not just about rootfs. The reason
why udevd scans all the devices is to create a udev database and fill
it with data usable for running the system. For example, when you type
'lsblk --fs', it reads the data from the database (findmnt, mount,
etc.), which is also used by udev rules and for dependency evaluations
in systemd, etc. This is the reason why the system gathers all the
data about a new device when it's detected.

If you want to avoid all of this, you need to customize udev rules
where you can filter out what and how to scan.

> We can sort of guess "/dev/sde38" is the correct
> one, but that's not deterministic.
> 
> So we started digging and came across blkid_find_dev_with_tag and
> blkid_dev_devname, which you can call like this:
> 
> blkid_dev_devname(blkid_find_dev_with_tag(cache, "PARTLABEL", "system_a")))
> 
> blkid_dev_devname(blkid_find_dev_with_tag(cache, "PARTLABEL", "system_b")))

You're on the right track. PARTLABEL and PARTUUID are stored in the
partition table, so it's unnecessary to scan partitions for their
content (filesystems).

> On first glance this looks useful as you don't have to loop through
> all the devices to use.
> 
> But this function only seems to work if the data is already cached, so
> it's not so useful on boot.

Yes, using blkid_dev_devname() is not advisable. It's part of the old
high-level libblkid API from the pre-udev era.

If you truly need to read data from the device, then utilizing the
low-level probing API is recommended. This can be done from the
command line with 'blkid -p', but you'll need to disable scanning for
all unwanted data (using '--usage no*'). For instance:

    blkid -o udev -p --usages nofilesystem,raid,crypto,others /dev/sda1

This command will only return ID_PART_ENTRY_* data from the partition
table.

You can use the LIBBLKID_DEBUG=all environment variable to see
the library's operations.

The question arises whether using blkid is the ideal solution if you
only require PARTLABELs and PARTUUIDs. For example, sfdisk could be a
more efficient approach:

    sfdisk -l /dev/sda -o+NAME,UUID

However, a potential issue is that sfdisk only provides the guessed
partition names (paths); the name used by the kernel might be different.

> Has anyone any ideas on how we can optimize the identification of a
> block device via UUID, LABEL, PARTUUID, PARTLABEL, etc.? Because the
> current implementations don't scale well when you have many block
> devices.

It depends on your goal. You can heavily customize your system to
speed up boot (all the necessary tools are available for this
purpose). However, the problem I see is the issue of portability and
the maintenance overhead.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

