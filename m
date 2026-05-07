Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A1376BCD
	for <util-linux@vger.kernel.org>; Thu,  7 May 2026 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143554; cv=none; b=PGzd2dpFNDKPMa+PyUOVpsSTiDUa+WE0e0mFy6cJl0YaQL/yFUNaaMhPAsg/Zhf0SpSoGvUa62Kw2c4NwFETyS8PWI7SqQb0uhM5GSjZGCWLl0Hy34IbSEcUPf4UR+WCQfF1f6kQkA4d4ELv9AFwzfAGkUkLTFnap79VSAglhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143554; c=relaxed/simple;
	bh=jA9h062ggSAGTcW22U42urdHobDVq2Pi568cUCd2tSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM9QHt2C5CqJ3ViBMmJRaJshppdKBv4t6+6wvs0XTpYp+5fa3zqch8nDZ0nvY5n/xfMqFfWiQt5dnqstpkdC9Ym1+IpQQoyvPf5LPNiojDToDLPYXrLYxcAd0W3oOlbiQSBeorJS0ogT6DD1Xap+ATXTUmhU79bHseTBBE0xGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdKCVLnh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdKCVLnh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778143546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1CT5wtUS9x0t6zGOXKiVJSI9M2H21P30Egl73Df712E=;
	b=OdKCVLnhXC2GVmGuE1t3PioeydD1b1A/8B5hdM4KHOekcX7DM2rstrfF57rD2rP1XpV2Fl
	Ywree7DHboFpOvfhWUbo5qb1oiLXD+Mbohyk6eMNgrIT9y2bBy4/vJRomqdglDFTzA2y0U
	ij7SMkB4o7XQFj7MWB8dPxFDXs7malk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-oicLqHY4NrKwnn9rvq0_Tg-1; Thu,
 07 May 2026 04:45:45 -0400
X-MC-Unique: oicLqHY4NrKwnn9rvq0_Tg-1
X-Mimecast-MFC-AGG-ID: oicLqHY4NrKwnn9rvq0_Tg_1778143544
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C092C1800367;
	Thu,  7 May 2026 08:45:43 +0000 (UTC)
Received: from ws (unknown [10.44.34.93])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E85E19560A2;
	Thu,  7 May 2026 08:45:42 +0000 (UTC)
Date: Thu, 7 May 2026 10:45:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Evgeny Kapun <abacabadabacaba@gmail.com>
Cc: util-linux@vger.kernel.org, wanbingjiang@webray.com.cn
Subject: Re: Bug#1132887: script: "script file -c command" stopped working
Message-ID: <gz7k7kxnbqcitn5jqg5dgus76hjiyrwxscab55dlrlhtrxdenm@rroa5scdex65>
References: <88e0b54d-3c86-46ca-ab3f-e116073216d6@gmail.com>
 <adS9qeW8w0bmUukR@per.namespace.at>
 <x7m64hxjjld7rkfjwuta75hzmj3f6en57mpvdfttzdliebdqxn@ym5mhuzim23o>
 <cc9deabe-7529-440d-bb42-67740f47dfc9@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc9deabe-7529-440d-bb42-67740f47dfc9@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Apr 08, 2026 at 04:36:50PM +0300, Evgeny Kapun wrote:
> On 4/7/26 16:26, Karel Zak wrote:
> > I have created bugfix for this, see https://github.com/util-linux/util-linux/pull/4201
> 
> It seems that this fix doesn't handle the case where -- is used as an
> argument to an option. For example, `script -I --` before v2.42 would
> interpret -- as an argument to -I, but the pre-scanning in that PR would
> break it.
> 
> The value can come from a variable, e.g. `script -I "$VAR"` and `script
> --log-in "$VAR"` will usually work, but break if $VAR is --. Similarly,
> `script "-I$VAR"` will usually work, but break if $VAR is the empty
> string. The only approach without special cases seems to be `script
> "--log-in=$VAR"`, but it doesn't seem to be very popular.
 
I have updated the patch to accept "--" as argument for your cases.
https://github.com/util-linux/util-linux/pull/4326

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

