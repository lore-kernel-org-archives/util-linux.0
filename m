Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E4B2AF03
	for <util-linux@vger.kernel.org>; Mon, 16 Dec 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346039; cv=none; b=mk2vSt006RMRtVHHoL34SIQfAdxgKWK7I/sUNvpEqIo8iJMi7FybI8yC399ZFnd3BukhJWupcfB86QB2nrG4TD9tnm+NZifzEA5q+Wv7Lns1NkMC6xI6gJQ8tYl71tK7BS9YNaf8hdSJIFfUJqxePjZvVl+3J93JMOuLLku+1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346039; c=relaxed/simple;
	bh=c8q06i8je4pxorK8Uwn4+ymzOngcktYnMNv0yrNz2eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8gZC1jLv++jV33rE2oikrUAj+jL6YJ+dzGnhYaN2Wm1R7JmNkzctOCC6aZmdKQlJ/jFGwhoRmeo8zp64iL/hqlwigfXIwusdUwlhgp5T+Kd6y+Ka6K0at7y9VTCQbmtz6BcM5Q1MajtuJqZIIJ4u88BSmhozNGtHDX8FITap4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cv4dzoCJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cv4dzoCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734346035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwT00lbXnV1BN8q+W7dwvFsKt2SygRMOpHFfA2G0o4w=;
	b=Cv4dzoCJA2Yz3JaBO66jo0H9q8+Un1LRULtrw3Bq+mDROJjsu13uKqLNp5mRht7vv7UFDi
	yWq18S0agKz7AZh6I8uP+Vm+jPaEoM0lnH3E1FOwXF3mBKSVBwj7BGm/yHs3IEyFohmDyb
	amMQ9+JFpRWohDuDtLxOEm1bFbd0rBE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-RZC5BoOmOBW7LDCgcL6ykA-1; Mon,
 16 Dec 2024 05:47:12 -0500
X-MC-Unique: RZC5BoOmOBW7LDCgcL6ykA-1
X-Mimecast-MFC-AGG-ID: RZC5BoOmOBW7LDCgcL6ykA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F23119560A3;
	Mon, 16 Dec 2024 10:47:10 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.204])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D602F1956052;
	Mon, 16 Dec 2024 10:47:08 +0000 (UTC)
Date: Mon, 16 Dec 2024 11:47:05 +0100
From: Karel Zak <kzak@redhat.com>
To: LiviaMedeiros <9@cirno.name>
Cc: util-linux@vger.kernel.org, LiviaMedeiros <livia@cirno.name>
Subject: Re: [PATCH] tests: add skips when IPv6 is not supported
Message-ID: <domr6v35llfidwvpp2owtsdbnkqlvcyua45cc5qtsbvf2fstoi@jzwgrbhbpufn>
References: <2097ed76-2ed6-40da-9912-01774316370f@cirno.name>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2097ed76-2ed6-40da-9912-01774316370f@cirno.name>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Dec 13, 2024 at 08:38:27PM GMT, LiviaMedeiros wrote:
>  tests/functions.sh        | 6 ++++++
>  tests/ts/lsfd/mkfds-tcp6  | 1 +
>  tests/ts/lsfd/mkfds-udp6  | 1 +
>  tests/ts/lsfd/option-inet | 1 +
>  4 files changed, 9 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

