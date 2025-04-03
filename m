Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649518DB10
	for <util-linux@vger.kernel.org>; Thu,  3 Apr 2025 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682114; cv=none; b=n1oOWzZ/0eG/jUda56L3nwBEiyeDbHfKUTtLq/Hcm5xvFGPfg6ClnjKkHtUZiFIIjVGNhr6eMPmwgtAFwIzdZaueqs6z8kkxmy3gmsZYXXKc9kfkfCOuvvox5rhYz+Bb0J2dwJecpcj77547HlVerWUMSBYfOFHqL1PpoQNXYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682114; c=relaxed/simple;
	bh=ZYim6E3HNgcCwFRIeKoeozbL5tcsVIcrURclYn3iATA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm7xirynI4+37rBbHL4TnrlYYnMZzxoHGywyxQmxCaEr3Shu1iva+uthfrSEjYuYdAa92HMH8H8b6Ncntm5BPpd4/dIAw9KtoiNvZXQZ544kjbEG1jHpiiTW6uLzEDgTrWNKNj37RAL1eo/O2Rr/MfHIsKRiOUqTpOFUdg38OJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoVJhkiO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoVJhkiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743682107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PejjcMIh0Locol3I9qlXGFdYW3eq/C+CH8YINHIj+xs=;
	b=AoVJhkiOOuniPWPdd8lN7rrTpO5T2e+quoSdwN/oycJ4trJT9aYcRsh2yRUeAeR4d51AIX
	cBadThuGbJ8aK4R2vWgkt51wX+uPCoBYcRLlqFVZD9VGW/9ONp/5OYZknlE6T+f6tbvYLT
	WeuoTiSLUrJSdCxYGJ7kSNmPYDZcTZs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-_7TbQZvcPYiel0J-pSChgw-1; Thu,
 03 Apr 2025 08:08:23 -0400
X-MC-Unique: _7TbQZvcPYiel0J-pSChgw-1
X-Mimecast-MFC-AGG-ID: _7TbQZvcPYiel0J-pSChgw_1743682102
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DFF219560BC;
	Thu,  3 Apr 2025 12:08:22 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAB02180B487;
	Thu,  3 Apr 2025 12:08:20 +0000 (UTC)
Date: Thu, 3 Apr 2025 14:08:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Phil Auld <pauld@redhat.com>, 
	Thijs Raymakers <thijs@raymakers.nl>
Subject: Re: [PATCH 09/10] coresched: reduce excessive whitespace and
 verbosity in usage text
Message-ID: <cyuypoxkyx5barxpx2rsowbp2fsrb5op5ws3y67x4wqlhkcdmo@7ndwtvyxhqy3>
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-9-bensberg@telfort.nl>
 <cztqfu3prb4v2urpxrujq5wqqdclnxwsny4h5ejbml7d7kll2n@yj3dgreqhtrl>
 <2c111844-b6fa-42cc-8333-eec4d7bb4a49@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c111844-b6fa-42cc-8333-eec4d7bb4a49@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Apr 03, 2025 at 11:55:12AM +0200, Benno Schulenberg wrote:
> 
> Op 03-04-2025 om 10:11 schreef Karel Zak:
> > On Mon, Mar 31, 2025 at 11:44:42AM +0200, Benno Schulenberg wrote:
> > > -	fputsln(_("Manage core scheduling cookies for tasks."), stdout);
> > > +	fputsln(_("Manage core-scheduling cookies for tasks."), stdout);
> 
> > > -	fputsln(_(" get                      retrieve the core scheduling cookie of a PID"),
> > > +	fputsln(_(" get      retrieve the core-scheduling cookie of a PID"), stdout);
> 
> 
> > There is a comment from Thijs that kernel docs does not use hyphen, it
> > means "core scheduling" rather than "core-scheduling". Maybe it would
> > be better to follow kernel.
> 
> When speaking of the scheduling itself, it is indeed "core scheduling",
> but when using this compound word as an adjective, then it is much
> clearer to hyphenate it, to avoid the impression that it is talking
> about a _core_, deep, central scheduling cookie.

OK, merged :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

