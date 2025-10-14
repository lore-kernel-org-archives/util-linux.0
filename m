Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA222259D
	for <util-linux@vger.kernel.org>; Tue, 14 Oct 2025 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436381; cv=none; b=odWYwtdY7frV6sEM7g6JokcpSG8sgtHdKGTkiGysd/Nbc7NeKSOdlyDgE7E6k3/1eUGla179mhDJmeLVWINZKkzeGd+8xJfR8VND4CMrUvTfoA3MctMxNSEr/0xbmO3DDVMpE8GUYvl5iVJXxQE5Y/icvPJqAexlh2Sb8RWORVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436381; c=relaxed/simple;
	bh=f6RCGDnDngsfH4iJBgQ6U+N0ne8DS1HHaWZu/hMH3AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAdGRcySrChbcFXcng8VZcY4mzN3veMN9BE1ja1rlLNiSTZQLOeZJwVPZZp6CrJj2SBWfP0lL1vsPToj8oy9FKJ/fL9QXuatXE5bgZnT5FnjwohjoTHq6y7MWubz2qfwqyliFD9jFLumjkU2g1dh8Xe7utgqIzU4a2cjClZxAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2BYxC+S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2BYxC+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760436377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+CAnYm/NuKbW4dlJf3Nj1+RosY218qK+FanlgxZ9Zc=;
	b=H2BYxC+S14gS2p1ywjcgFBljGEKPoUSZT03+Z0tvOQW0jIxVg0lfXipERGgpUy2G0JcpLY
	+/5TyrrKpO3s0eDkG6amMmeiTli8nF6Lv9QUKHsxuKQSt+M+YZZ4GvBTjqq2MnQLJJjE0p
	Xubqh3t13hQhSyYc6n5zIiJ4mNIep3k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-IGhymoRkNv6mESijMvTfCw-1; Tue,
 14 Oct 2025 06:06:14 -0400
X-MC-Unique: IGhymoRkNv6mESijMvTfCw-1
X-Mimecast-MFC-AGG-ID: IGhymoRkNv6mESijMvTfCw_1760436373
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4EA11800586;
	Tue, 14 Oct 2025 10:06:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.89])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E4331800577;
	Tue, 14 Oct 2025 10:06:10 +0000 (UTC)
Date: Tue, 14 Oct 2025 12:06:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Util-Linux <util-linux@vger.kernel.org>, 
	wguanghao <wuguanghao3@huawei.com>
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
Message-ID: <vzoribxep4c3tc2g2si4c6377tg77q33w6fllpixbnomwav3gl@7cu4iypyezye>
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Oct 10, 2025 at 11:41:08AM +0200, Benno Schulenberg wrote:
> 
> After setting up a loop device with:
> 
>   # ./losetup loop4 some.img
> 
> I wanted to see what happens when trying to "remove" it
> (since the man page says it is "not recommended"):
> 
>   # ./losetup -R loop4
> 
> There is no feedback, but it failed:
> 
>   # echo $?
>   1
> 
> When a command fails, shouldn't it print an error message?

Yes, we need to fix it.

> Then I tried detaching and removing at the same time:
> 
>   # ./losetup -R -d loop4
> 
> No feedback, but it didn't do anything:

The options need to be mutually exclusive.

>   # ./losetup loop4
>   /dev/loop4: [66306]:5939273 (/home/ben/Sources/util-linux/some.img)
> 
> Trying a different order of the options:
> 
>   # ./losetup -d -R loop4
>   losetup: /dev/-R: detach failed: No such file or directory
> 
> Huh?  Why does it try to interpret an option as a loop device name?

-d and -R requires argument.

>   # ./losetup -d loop4 -R
>   /home/ben/Sources/util-linux/.libs/losetup: option requires an argument -- 'R'
>   Try 'losetup --help' for more information.
> 
>   # ./losetup -d loop4 -R loop4
> 
> Oh.  Surprisingly, this last invocation worked.
> 
>   # ls -l /dev/loop? | grep loop4
>   # lsblk -a | grep loop4
> 
> 
> However, the loop4 device is not really gone, because one can attach
> a file to it again:
> 
>   # ./losetup --show loop4 some.img
>   /dev/loop4

This is expected. losetup asks kernel to create the node again.

>   # ./losetup -a
>   /dev/loop4: [66306]:5939273 (/home/ben/Sources/util-linux/some.img)
> 
> When the device is really gone, attaching doesn't work:
> 
>   # rm /dev/loop3
>   # ./losetup loop3 some.img
>   losetup: /dev/loop3: failed to set up loop device: No such file or directory
>   losetup: device node /dev/loop3 (7:3) is lost. You may use mknod(1) to
> recover it.

This is because according to kernel there is the node, but you have
manually removed the /dev/loop3 file. This is mostly udevd playground,
losetup is able to detect "lost node" situation, it's enough I think.
We can improve is losetup man page to explain it.

> In my opinion --remove is not a good name for the option, as it doesn't
> actually remove anything.

It asks kernel to remove the node (and it's processed by udevd I
guess). The ioctl name is LOOP_CTL_REMOVE.

> Also, its meaning is too similar to "detach":
> when the computer asks me to "Remove the USB stick", I detach this stick
> from the USB port.
> 
> What --remove accomplishes is that it prevents the specified loop device
> from getting listed.  So in my opinion a better name for the option would
> be: --unlist.

I think --remove is fine, but it needs to be implemented in more
verbose way and with more respect to the end users.

> But what is the purpose of --unlist?  Why would one want it? 

Well, we provide command line interface to kernel features :-)

> What harm is there in listing empty, fallow loop devices?

Maybe someone needs to optimize devices scanning, size of /sys
etc. The number of loopdevs can be large on some servers.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

