Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B736EAB3
	for <util-linux@vger.kernel.org>; Wed,  4 Mar 2026 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631282; cv=none; b=XET7fqZ7dZEy9RoCR2mMqKBEv5Z8hJDi5MNKXrsW/Jk0w9A2JI7m7onBDPr1NI7YYzPjSCTsxqud6d1z9xTaIvFW2h5HTdIp3MAThtQP33ibE95hzBBR/M98dcnHWR2+jPcmsSWGc/hUmZG+r6LCQyig+w+0C7TTGsIDpVcKRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631282; c=relaxed/simple;
	bh=U37+Jnt78nivVD0p1COHRbkA4W4j4dtj1klVnyeDdeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNoHb+gdPsVxgEP8V8AmsUVJbMQHkpabN1a22WPfDFXHKZCRgG+HP30yO1dEJQoELEfh8uTH8c99hID/ZBPn/28PqP+F+tMYtoxwZOoqhW9qLkczCIX+n2G+PU4LNIEqAEHz6JNgEkQhiSSmH0OPX4dSnFRrdkPojplett5+upU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ETfjlMj/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ETfjlMj/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N3iwNfjquedfYCI5FlNLeZfBZhW0Qs2qKdyy9F0ee5w=; b=ETfjlMj/mRlaF9GbbigiDzIgUW
	rITeu4wpLu0Z0KsxgR8CI7qAYLyMYZP1mIcyh+amrV5UBvxyZVoX7W0AUChc5HTVK4kvEwk6xqSlL
	HdAXSli2rfHNUSuO7HKyLrAhyj4e2blv70pCAgZIcYoUVg7hJX0ZdOfy6LN5nD1QhOuR+xwYPsGhf
	b8yjIdWfNe8VYmEck58JtXTXeGdsdKRQ2C8yjspHgkczKNqrnvfMS15hR0+SXavwLKZPfy47Pde+h
	A2oRBz/EvdKgnMCi2XTQe8kGUewPcarL/83tvBpgjUL3dgbCju4dpfu+SFxnhhubUeblXaz7pLTIZ
	9nERETxQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1vxmMx-00FzVu-Tq; Wed, 04 Mar 2026 13:34:32 +0000
Date: Wed, 4 Mar 2026 14:34:28 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Karel Zak <kzak@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	debian-loongarch@lists.debian.org, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.42-rc1
Message-ID: <aag0u2k9K3gr7XBa@zeha.at>
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
 <aaP6atFYpVqulTO1@zeha.at>
 <aaVVg4PhVKkdL2C5@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <aaWzysmPNrkPm4p1@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <pj7nqvgvazvimjhx7r3j7qt7zi2hvziv3bxjwnsaxpy45zjpxc@eimfo2zs6p5t>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <pj7nqvgvazvimjhx7r3j7qt7zi2hvziv3bxjwnsaxpy45zjpxc@eimfo2zs6p5t>
X-Debian-User: zeha

* Karel Zak <kzak@redhat.com> [260303 11:09]:
>On Mon, Mar 02, 2026 at 04:59:06PM +0100, Sumanth Korikkar wrote:
>> * When --sysroot is used, do not read /sys/firmware/memory
>>   (used on s390). This makes sure lsmem reads only the memory
>>   directories inside the given sysroot, so the directory list
>>   is correct.
>
>Thanks for looking into this. I think your patch is a workaround
>though. It bypasses sysmemconfig and memmap_on_memory when --sysroot
>is used rather than fixing the root cause.
>
>The real problem is that --sysroot prefix was not applied to all sysfs
>paths. The sysmemconfig handler was never prefixed, and print_summary()
>used raw fopen() to read memmap_on_memory, completely ignoring --sysroot.
>
>I've pushed different solution fix to
>https://github.com/util-linux/util-linux/pull/4090

Thanks, I've pulled this into our build and can confirm it fixes the 
issue on loong64.

Best,
Chris

