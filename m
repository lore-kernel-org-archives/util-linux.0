Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3803C00
	for <util-linux@vger.kernel.org>; Tue,  8 Apr 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118703; cv=none; b=VhWdz/Ie4x88/1TLmu+fY8qSHqrFHO9oozZSADeBsBlqSmTK3yOHepfVnMmNSrsBNuh2ZpkOsMQ+4D/Lzejl4M2/fafWXHXdPFHFRvYlINCM7JNAKq8CJEIJyXxnA1+j5fZEUF4X6pInpy61cLynPv0xAPUbXHs4zrLw+jBk4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118703; c=relaxed/simple;
	bh=f7b+0+SarDKClyqOuguEpK89Hx1qQjsK2uLia+hyosQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqMFBVjZJYXSlIo0FoLTeaVmNYnnYoRkhEHuIdsihZu93db2YQ2aX2gVT8WqchdHblFvaxmJLIoEahSYWNI+5hIeYRUpeExTGK2DjveCMY2AkbaA+fsNk2yeYPceWQQ6E1LJazB4BiKqU69nwgCtB3wY3J15NZKJU3xnN7Uvdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGBWWCwt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGBWWCwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744118700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dWCgjAs5Gk/g4wB6hWPr2ISMsfS7beVJ0ME6wuz2vPo=;
	b=NGBWWCwtOuzzQiZCcbC+dg5vYhbP1fAtBS7yi4Hy+g31IXswBZ3d7IO6H4vRGkSua8pu2e
	5zum+tYxmezOaz8B1vR6Bold+jZMyMRFuMgxXdK5H16STwNRd/Wl6P2GuAxq5iLuiJbgqK
	aZwZV0L5+vc92GAUHukltaCQBIai+dA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-VBif5CyXP_aUgsf2L6l5AA-1; Tue,
 08 Apr 2025 09:24:56 -0400
X-MC-Unique: VBif5CyXP_aUgsf2L6l5AA-1
X-Mimecast-MFC-AGG-ID: VBif5CyXP_aUgsf2L6l5AA_1744118694
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 209931956050;
	Tue,  8 Apr 2025 13:24:54 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6CDB19560AD;
	Tue,  8 Apr 2025 13:24:52 +0000 (UTC)
Date: Tue, 8 Apr 2025 15:24:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: util-linux@vger.kernel.org, Benno Schulenberg <bensberg@telfort.nl>
Subject: Re: [PATCH 1/8] setarch: (man) remove a synopsis line that
 mistakenly mentions `arch`
Message-ID: <fopavmvceex4og3lyqp4fqhecfjkptlmdrutpnn2yn5lq5lks3@yv4hshv75yfw>
References: <20250407151503.23394-1-bensberg@telfort.nl>
 <mbag4aqfzuvn5q44cpbtem6ei7ai6jr2lz2pyzxrytsom4i3vq@7ak5vpzjgy7o>
 <th24qbvmvco3w4oqwcfnxnacwrfcgpqs2qfp7whmam5gjm6wwn@fnajesleg2u4>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <th24qbvmvco3w4oqwcfnxnacwrfcgpqs2qfp7whmam5gjm6wwn@fnajesleg2u4>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Apr 08, 2025 at 02:35:08PM +0200, Chris Hofstaedtler wrote:
> Hi,
> 
> * Karel Zak <kzak@redhat.com> [250408 12:36]:
> > On Mon, Apr 07, 2025 at 05:14:32PM +0200, Benno Schulenberg wrote:
> > > -*arch* [options] [_program_ [_argument_...]]
> > 
> > This is not a bug. We use symlinks for setarch to support specific
> > architectures. It would be beneficial to describe this in the man
> > page in better way...
> > 
> > $ find /usr/bin -type l -lname 'setarch'
> > /usr/bin/i386
> > /usr/bin/linux64
> > /usr/bin/uname26
> > /usr/bin/x86_64
> > /usr/bin/linux32
> 
> There's a very old Debian bug (#530011) asking for the setarch man page to
> list all its aliases. Actually it started out asking what "arch" meant in
> there.
> 
> Maybe the man page really could list all known aliases?

It's architecture-specific, so the set of symlinks will vary between
PPC, x86, and others. I'm unsure whether we should generate the man
page. Probably the best approach is to include lists for all
architectures and their aliases to provide a complete overview.

Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

