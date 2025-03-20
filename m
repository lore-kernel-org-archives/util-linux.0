Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26E1C5D7E
	for <util-linux@vger.kernel.org>; Thu, 20 Mar 2025 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478187; cv=none; b=Ma0n/Fg4fYksxdYfCXKxeLem39OVbVOp4lqZxz83AwcEF1jnGXI+zKhOz9oNc7j1ZoWK9E3jk8ZmsG/mfjnu0M/h6WZKJgxDwtsbEuSTGaNekRFLNbxHCCp53cP+wvdd+BG9yc6jjULJDRSO5hvinP/UsBPHY8ZzK02G/31Dku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478187; c=relaxed/simple;
	bh=PUcLXT+hil/l8uA2iNtEQDIzhZ+4TAD1NVhfGlEqpv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfmGKFC6kQFCmr5VaGN74C0NnTNp6p6fhld2gKfx/+Mu1G+qTeC17Ixka5Zf4GuBhwaK3lZ1aPoY4wPUVhF4DFwmXCVSvkzFUsMN0qqw7sUtnr9wD/djUynpWEwgw80YqqqWNMhjccDRJr4rVKPFmzqfOdZtaWQXsyQg4cvDZ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/4OKgNZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/4OKgNZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742478184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wNEOZL2CUmocSrW8pX2PhdC1oFjQwuwzH8KhiJ5SNo=;
	b=a/4OKgNZXCNKcqdZeG9lLhOcAEO0AoMRkpBNszCiy/RDZ1+f7uvAfcc0PQfFZCXP5Kg1SJ
	txY7dLIQtxVQf+Afxn7HhfgGbQKKLI6p5PRqIvu9dyvP40jQo5tB8/ON17ANS/cA6U80vw
	NNi9fNK0aaof+WhdhHj1xiR1eiV4khg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-BerHaaqENZqCL4tK4w8pZw-1; Thu,
 20 Mar 2025 09:43:02 -0400
X-MC-Unique: BerHaaqENZqCL4tK4w8pZw-1
X-Mimecast-MFC-AGG-ID: BerHaaqENZqCL4tK4w8pZw_1742478182
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C65C9196D2CD;
	Thu, 20 Mar 2025 13:43:01 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.181])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3AF318001F6;
	Thu, 20 Mar 2025 13:43:00 +0000 (UTC)
Date: Thu, 20 Mar 2025 14:42:57 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: on small terminals, irqtop shows "(null)" at startup
Message-ID: <wz2wsk3nmgctdtcdelnrei7x72r7k3cjv4pcju2vpl6yt4j42b@ypw6ceya5n5e>
References: <477ecae6-0ce6-4463-9c38-8181910fa9c3@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <477ecae6-0ce6-4463-9c38-8181910fa9c3@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Mar 20, 2025 at 10:57:50AM +0100, Benno Schulenberg wrote:
> 
> To reproduce, run `xterm -geometry 80x12 &`, and in that xterm
> run `irqtop`.  See that the table of IRQs is empty at first,
> apart from the string "(null)" -- like this:
> 
>    IRQ   TOTAL   DELTA NAME
> (null)

I cannot reproduce this issue. My system:

 $ uname -r
 6.12.11-200.fc41.x86_64

 $ rpm -qf /usr/bin/xterm
 xterm-397-1.fc41.x86_64

> After three seconds a list of IRQs appears.

Please try the current Git. I made small changes to improve the debug
output and to avoid "(null)." However, I'm still not sure why you do
not see the data. 

>    ./irqtop -c disable  2>TRAIL

I do not see anything wrong in the log. The library gets data and
calculates the output as expected.

> on an `xterm -geometry 80x12`, where I've pressed q as soon as
> the table did appear after three full seconds.

Yes, there is a 3-second delay between reloads (use, for example, "-d
0.5" to change it). I'm not sure why you don't see the data the first
time.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

