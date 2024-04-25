Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6BC28F7
	for <util-linux@vger.kernel.org>; Thu, 25 Apr 2024 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037294; cv=none; b=StGGSeSVRxiFaNGEvhw31Ud+zb+FJakzybFrAT4JMUMRFbLDS9SBtu6KgVH7aWquQBkvnE1jRvsXETOQORCY/wMvPNWJaUnkoWFPlLbuNF8MjuRD2fJ613vftqArYRJmUX/OrsoJrA2grQfJOeCY7CWzbMkRCKRq5FKlHBpLSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037294; c=relaxed/simple;
	bh=yDL+CGSMJp0LW9i9wmOY+1NDiTHj7PZHrETE7yH+CfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmRtecq/iFkgk62njUdrhODw6PrnLvN2xIcMfQvG9aJqhmQSyNf88vmFIIj667+6hdsQWJYeIoHGng43VpIVZyYEmT2yTzFjHeitgfJG7M2gu+M5bcI2v0qKNf9HMk1ZToQ4QZ+p9PEm0HTlmXNczIxTt4uudCkYaxch0oe6x9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMuxBSy4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMuxBSy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714037292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpsHw/CxMhUA8x1xMI3KRazRI+6ZPOCPac1i+RL9Y3c=;
	b=BMuxBSy4GsphPKwVST5B1zRw54tRRKNvG+ICohMUzCu90475fNm0pe1oLeUhuW2zcnPkgj
	KH2z6iRLHXTfjUJhippobA+4KI6WKYFqKg7M0xQBCpRXqoxR3rwxmWzExxJgoDfN7vCMw7
	/x/OGAFwTv3Do/EKDl31e6njhubzAh4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-AbqvcBOwO-qkv6UcWhyJDA-1; Thu, 25 Apr 2024 05:28:07 -0400
X-MC-Unique: AbqvcBOwO-qkv6UcWhyJDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7535980591B;
	Thu, 25 Apr 2024 09:28:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D1A8F40C6CB2;
	Thu, 25 Apr 2024 09:28:06 +0000 (UTC)
Date: Thu, 25 Apr 2024 11:28:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: util-linux@vger.kernel.org, Masatake YAMATO <yamato@redhat.com>
Subject: Re: [PATCH v2] flock: add support for using fcntl() with open file
 description locks
Message-ID: <20240425092804.zisbm7xvmydkn7xc@ws.net.home>
References: <20240423120819.571181-1-rasmus.villemoes@prevas.dk>
 <fad6d1c0-00e0-4429-9d33-74b2179c0a83@prevas.dk>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad6d1c0-00e0-4429-9d33-74b2179c0a83@prevas.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Thu, Apr 25, 2024 at 09:36:06AM +0200, Rasmus Villemoes wrote:
> Hm, actually, since the values of F_OFD_ are the same across all
> architectures, and the API is pretty old already, I think it would be
> simpler to just drop the configure time probing and all the HAVE_
> guards, and simply add five lines
> 
> #ifndef F_OFD_GETLK
> #define F_OFD_GETLK     36
> #define F_OFD_SETLK     37
> #define F_OFD_SETLKW    38
> #endif
> 
> after the #include s. After all, whether or not the constants are in the
> headers util-linux is being built against doesn't really say whether the
> kernel it ends up being run on has support or not. Then I'll just
> include a note in the documentation that use of --fcntl only works on
> kernels >= 3.14 (besides, it would be really cumbersome, maybe even
> impossible, to have the man page not mention --fcntl even if flock was
> built without that option in its --help output).

I agree, it is usually better to not affect the --help output and
options parsing (using getopt_long() functions) with #ifdefs.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

