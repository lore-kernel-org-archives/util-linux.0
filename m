Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47197394780
	for <util-linux@vger.kernel.org>; Tue,  3 Mar 2026 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532494; cv=none; b=TTlQTmIMkZYOcRyrXge0aBDl/LWbem6RNbpbffu+4LBqGTLrSQUWCyvWD4HIfceYuTWoXwq+pw5MWhKI0Iogq1ePec/hsPmzsqH89s0QffWcH2YExJmsqQPRZ6dqeDmKXF+wnEUHFtcxSzCRWbv+pbst4ochJJGyG4LaJdULFgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532494; c=relaxed/simple;
	bh=r7tg/ALSEVw+Nmwn9+URKzpvroNGz1hBV9YzwVh3Kxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGh9n3abM/gMLW22WfvJaC8CKza5JVxI8e+M2DK3wLLYbR7Ps4lNEBkG9yZMklE9XHgbrk+tCpzyUF2Z5mkItZdxZIWKuzQnrX+0qjcdWl/3mwWeKoCdFrQLjKmCeRasjxXqnLTHafMutC9qT2r1MylNjNXW61T/LzD3IuG/dHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtXj/cyy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtXj/cyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772532492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3A0/Hkg310x1nVCQg/L1lmIcUWzQ4tIfm1G3RK/Z+jc=;
	b=NtXj/cyy1YieOVcFHhEsrVHKS5EK/BsrIQhPyS6JBqvkWEBDvyCa3/CUX0nhdOopc75Ljz
	93fUxBSeHWHzWMQunhbXaZhCsvAnJ5zNFt1oyy0meZMmzeYSDiikP+1hjlfwdZ46zw2K36
	54V1/gCsQc9D3iuZFV81St//JsLfJus=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-p-bvB6QfP7iqd77-diqGnw-1; Tue,
 03 Mar 2026 05:08:06 -0500
X-MC-Unique: p-bvB6QfP7iqd77-diqGnw-1
X-Mimecast-MFC-AGG-ID: p-bvB6QfP7iqd77-diqGnw_1772532485
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E7AE19560A7;
	Tue,  3 Mar 2026 10:08:05 +0000 (UTC)
Received: from ws (unknown [10.44.32.203])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 225A430001B9;
	Tue,  3 Mar 2026 10:08:03 +0000 (UTC)
Date: Tue, 3 Mar 2026 11:08:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Chris Hofstaedtler <zeha@debian.org>, 
	debian-loongarch@lists.debian.org, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.42-rc1
Message-ID: <pj7nqvgvazvimjhx7r3j7qt7zi2hvziv3bxjwnsaxpy45zjpxc@eimfo2zs6p5t>
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
 <aaP6atFYpVqulTO1@zeha.at>
 <aaVVg4PhVKkdL2C5@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <aaWzysmPNrkPm4p1@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaWzysmPNrkPm4p1@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Mar 02, 2026 at 04:59:06PM +0100, Sumanth Korikkar wrote:
> * When --sysroot is used, do not read /sys/firmware/memory
>   (used on s390). This makes sure lsmem reads only the memory
>   directories inside the given sysroot, so the directory list
>   is correct.

Hi Sumanth,

Thanks for looking into this. I think your patch is a workaround
though. It bypasses sysmemconfig and memmap_on_memory when --sysroot
is used rather than fixing the root cause.

The real problem is that --sysroot prefix was not applied to all sysfs
paths. The sysmemconfig handler was never prefixed, and print_summary()
used raw fopen() to read memmap_on_memory, completely ignoring --sysroot.

I've pushed different solution fix to
https://github.com/util-linux/util-linux/pull/4090 

This way all sysfs reads go through the prefix, and tests produce
consistent results regardless of the host system.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

