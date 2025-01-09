Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39022F43
	for <util-linux@vger.kernel.org>; Thu,  9 Jan 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451134; cv=none; b=ntj0iq/S8Wt31Elm+tb4LSdk7Zv8m4ZogJarbsDqWCm0Z9sgN9JnaGqSr55ZXkDiaEKbxBRd9k7PMddBhFnUMLDkIOivpls0OqBfiyKccmDW7oKenaZREAds71jyijUOV4WjAOAtWEQgxxw4W7Gkl1AH2yEdkf2T+I51Tn9chfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451134; c=relaxed/simple;
	bh=/PQMH7UvuAugoChaqacDQwKvK472EfTywyyrz8O7dxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3SIdjm5cAsEYzVXNLkS+DGUvvg5ut3OGJ6ZYoRItb125grPmZqFifbWPx2y3a5jBexMCotgMPwbP2WFXl7Wm//aJmVUe6THYfw/Cf+CO6WYoknUSmpaLaVwAt1VKSsA3lmgiwa04K+48cbWumAC6uTotZbwJeAeJojeyzzEnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hm7kg+C9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hm7kg+C9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736451131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8GgwCsdswsrc5C9S2INVzJcRZpqsrIw8FrNsaXFKbk=;
	b=Hm7kg+C9nYadQK8LgJ1r+6U6geTdyaZ63PpVHw5aJAf+GqexgGD2ggqRU76fsnA6+jKf8n
	0JBl1S07uZT3xJYC3f6uyGkOkTtZVZIsv1FlaPQ7Dmgd4/diCeyVaQ2pCtic+SCM06mzfb
	oAKC7uAP4lMgsDIPgBpT85/Yn5wZWnI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-cobpSgc3PZuPD2SzVBj5fg-1; Thu,
 09 Jan 2025 14:32:10 -0500
X-MC-Unique: cobpSgc3PZuPD2SzVBj5fg-1
X-Mimecast-MFC-AGG-ID: cobpSgc3PZuPD2SzVBj5fg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41ED31956050;
	Thu,  9 Jan 2025 19:32:09 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.199])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5861230001BE;
	Thu,  9 Jan 2025 19:32:08 +0000 (UTC)
Date: Thu, 9 Jan 2025 20:32:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.40.3
Message-ID: <xe3qmt5i7m5oxub42qz7vp7ztizvby74rxw4jmuh6bz54yw3na@iul4zrg4d4y2>
References: <xw6eivqjw6nc75sbejmi3nkbfssmakkrwpbjpfqtwwbpqxmb4f@rmyrm5gnizln>
 <wzdbgtxffvujwnv5oeeutbmeodm5chcmelyhwhhx7yt6dym7lh@j5vdmg3rnm3z>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wzdbgtxffvujwnv5oeeutbmeodm5chcmelyhwhhx7yt6dym7lh@j5vdmg3rnm3z>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jan 09, 2025 at 02:21:06PM GMT, Chris Hofstaedtler wrote:
> Hi Karel,
> 
> * Karel Zak <kzak@redhat.com> [250109 13:54]:
> > The util-linux stable maintenance release v2.40.3 is now available at
> >       
> >   http://www.kernel.org/pub/linux/utils/util-linux/v2.40/
> 
> I'm not sure where this comes from, but building the translated
> manpages seems to fail:
> 
> GEN      ro :  fsck.minix.8
> asciidoctor: ERROR: fsck.minix.8.adoc: line 29: dropping cells from incomplete row detected end of table
> 
> I haven't dug deeper yet; if someone has an idea upfront that'd be
> great.

 https://github.com/util-linux/util-linux/pull/3346

However, I forgot to merge it to the stable branch as well.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

