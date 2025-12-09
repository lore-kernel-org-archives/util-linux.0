Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47830C358
	for <util-linux@vger.kernel.org>; Tue,  9 Dec 2025 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765316109; cv=none; b=mwYk/jsaTohesPBt6G9NoJSWbD3rBZUYzNr1ONbaYW6xrKMIHugEaNIvemgHl+R3FGCcfqMwcg7BSooL+7dHFC9XODWojtb/JG+t4XxGjCsukZis6WFM6UuFJReyCQ8kSX6qu0wxe5t50cHjqCLIpFDG/+Y8c6ty01N9Hdvkjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765316109; c=relaxed/simple;
	bh=ddSePYVXi0RYu7ZTkr9oC2YkW7fTnlSaQ1PA1tksC2M=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B9QcEIicUXyxjDJIZ+0x4m+WuE/yKWHRKdXjlCwQ+am1UvBF+0ETInLT7c6U/+Qq4MsPwVP6LklkL9wKi2+cfNHzcgntdaGxRVU65jLOFM8K91DBq1ga9RerB661MHRWSlKSOYBWpSv9evjtRBoFVBiwJtDRZS36gVdFONSveYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYK1uVrv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYK1uVrv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765316106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ye4MhWTZftaEBrhYxO4NmerCeVT2OflnOkv4cXcqm3o=;
	b=hYK1uVrvUgx0gvEz7gU7IxLysJ/DRKwcygAzRJvZJnwYCS3JufcbL+TV6/QX/RsSm970I9
	rhhOwgYPfFMulIjN2UANSc55qMx1pQ+tKi3sD0Zoryd8nXu+7GnhBfqqq7BfVdBfZDmvmz
	dAFdDbWC3Gh7V1IQowcVXrO2OcMpg4Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-oQkgqGrNPNKXSItIVNf34w-1; Tue,
 09 Dec 2025 16:35:04 -0500
X-MC-Unique: oQkgqGrNPNKXSItIVNf34w-1
X-Mimecast-MFC-AGG-ID: oQkgqGrNPNKXSItIVNf34w_1765316104
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0625118001FE
	for <util-linux@vger.kernel.org>; Tue,  9 Dec 2025 21:35:04 +0000 (UTC)
Received: from localhost (unknown [10.22.64.230])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D47CE180045B;
	Tue,  9 Dec 2025 21:35:02 +0000 (UTC)
Date: Wed, 10 Dec 2025 06:35:01 +0900 (JST)
Message-Id: <20251210.063501.976895848370886654.yamato@redhat.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: Re: v2.41.3 planning
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <ajxw7xn6mh3puhs44cmj5mxxe7stxqwqi3vzzzueqa4srn2zgx@iukpxdgp4dkk>
References: <ajxw7xn6mh3puhs44cmj5mxxe7stxqwqi3vzzzueqa4srn2zgx@iukpxdgp4dkk>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

> 
> 
> Hi all,
> 
> I'd like to release the stable update v2.41.3, primarily to provide an
> upstream tarball with the fixed CVE-2025-14104 and to fix compilation
> with gcc-15, along with some other minor fixes.
> 
> Do you see anything in the master branch that we need to include in
> this stable maintenance update?
> 
> For the current state, see the stable/2.41 branch.

I made a pull request about lsfd.
https://github.com/util-linux/util-linux/pull/3896

Masatake YAMATO

>     Karel
>     
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 
> 

