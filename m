Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175D17ADE3
	for <util-linux@vger.kernel.org>; Thu, 15 Aug 2024 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706935; cv=none; b=FM/SPr5X6TX1QV0GYGqkufMXPctsvnDPktAC7+xu7nnuC3zPYJNxFSjQbMPB2xnSDtYCqpNXkHLB/QDVGWzG5E6hW/cvuPffHczepQz90m+Dwibvdiu5XvL5ovoUZXf0tsH8AB16B8YZXtmsw6rUMQH11fSTvAWzh/a1wJfZ7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706935; c=relaxed/simple;
	bh=OnnvkmAwZ/6/N3HrhZB3ko3gIBAIowsV9p5i3gA59mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQ5QhtGPyDfxH8EaoocvAkGNwuBD4o8HFqSz7qlDYF8bvuZIMh8LIVDDEZzGyW7In0+djfTZC9cM4rHLA6WvoSuu1l8e0EMAUVLdYli6ZmnLOWkqLYV7qIVHuYyRv3r5RkFQ+YOy3Mlu/sDvjo+VEVB+2+iYQ97BpJKti41lvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NgnkvHOU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgnkvHOU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723706932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKz0GooUetFMP3cijkiRMD7vyeVCA6S59KWG92IixLE=;
	b=NgnkvHOUK4bGPqC0XkekPW0Sjtf85fR0IMVzFFzUkRT3E8Y/FPWQpL6WmFUHmeAzQGiH2K
	uvxD7G0jTXT3a/us+cTwVvZUfdQN35FTxbChwxGd6zmIbSuHLJN/tt3w+X4DOqFglGQheT
	lO7HDAUIYqhb5MmP/MTCH5LKBWFWJDg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-Hl2RblWLOxCbeStGQ9TuzQ-1; Thu,
 15 Aug 2024 03:28:50 -0400
X-MC-Unique: Hl2RblWLOxCbeStGQ9TuzQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B18351955BF4;
	Thu, 15 Aug 2024 07:28:49 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.142])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF1A019560AA;
	Thu, 15 Aug 2024 07:28:48 +0000 (UTC)
Date: Thu, 15 Aug 2024 09:28:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Jeremy Dilatush <jdilatus@checkpoint.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: util-linux bug: mkfs(8) has -V for -v
Message-ID: <pkdvr572xhrtmindvjsfs5uia3vcxkeszup4d3ifyfdnkml3zb@c74rjg6jjvsy>
References: <28f8d3ca8b3545e5af64e2a7699b4b03@checkpoint.com>
 <0ca8b22dbbde43e0b65857877ec9a624@checkpoint.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ca8b22dbbde43e0b65857877ec9a624@checkpoint.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Aug 08, 2024 at 06:07:26PM GMT, Jeremy Dilatush wrote:
> > The manpage mkfs(8) lists "-V, --verbose" which should be "-v, --verbose" (uncapitalized).
> > Seen on as recent a version as 2.38.1 (on Raspberry Pi OS), also seen on 2.23.2 (on CentOS 7).
> > Not as trivial a fault as it might seem, since "-V" unlike "-v" causes mkfs to do nothing.
> 
> 25% user error on my part: Looks like there are two bugs here and one is already fixed:
> "mkfs -j -t ext4 -V Tempy" gives version on 2.23.2 but verbose on 2.38.1.
> The manpage still probably should have "-v, --verbose".

I believe the current version of the man page is quite clear on this
matter:

   -V, --version
        Print version and exit. (Option -V will display version information only when it is
        the only parameter, otherwise it will work as --verbose.)

and important is also the first line of the man page:

    This mkfs frontend is deprecated in favour of filesystem specific mkfs.<type> utils.


;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

