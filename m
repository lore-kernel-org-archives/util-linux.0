Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B72C1A0
	for <util-linux@vger.kernel.org>; Wed, 27 Mar 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525942; cv=none; b=PBCCqZKmLfrnB0abePwItO4m70JGwXYHsLfROVt8792aVdt66n4CmmdwMxp2CVUGReXntx8xrD5gHsr3B/AVbryDPG7gsCi1UgbbfkTHPQXH0KcseJiunsejvHCA4gLM0rISZaMfsVklTzLREjuAdDCwHuP13Lmt+bd5nHjzM4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525942; c=relaxed/simple;
	bh=EoXp3blC34HRMFjRlQWHK7Uwi2VDhDIhrpjMtSFSygo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgICwRDwRHpbaYPvqu/vude6TxJC5PkTgwprc2gxZum2uj/hEUBDDj3abpl9lUr3t5rstCXhXUEfO4AfEMYUoDprnYllSM0C1/4704rrIDcWYYmKqUbcYhAvHgUXjlcrTB6hz0CMoWFTRjZeRf2IgE0UuI516nM/HxGHiEnpV/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+fU6PvG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+fU6PvG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711525940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+421NJvUMCwD2e43hmKRkWFgz5bm7uvJLWA24lcoffA=;
	b=O+fU6PvGU3/D5MRymwZx2hDOPA2fjYUS2uDFSmo1rvzm+28qmgJMvU3GiAABrn7r1U0X8B
	L5xd5ooex1+iis1snxe3fJwWlW9KaaWlLjLGuOenLtatH5yI9tKwNFAcuZO+IPuHcRokTT
	+/vXpZ0vM889SH7o3Cvup5rxpS0efuc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-TEPBXQUzP3KFOBsZQfQHDQ-1; Wed, 27 Mar 2024 03:52:18 -0400
X-MC-Unique: TEPBXQUzP3KFOBsZQfQHDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C752801802;
	Wed, 27 Mar 2024 07:52:18 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F3CC2166B31;
	Wed, 27 Mar 2024 07:52:17 +0000 (UTC)
Date: Wed, 27 Mar 2024 08:52:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Petr Pisar <petr.pisar@atlas.cz>
Subject: Re: Mistakes in messages of util-linux-2.40-rc2
Message-ID: <20240327075211.zjzzs4cezm4dvpwq@ws.net.home>
References: <ZgKxUSbGN-R8Rn-w@album.bayer.uni.cx>
 <257b46c7-dbe9-414e-a707-fc543d1e7849@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <257b46c7-dbe9-414e-a707-fc543d1e7849@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


 Hi Benno and Petr,

On Tue, Mar 26, 2024 at 04:48:09PM +0100, Benno Schulenberg wrote:
> 
> Op 26-03-2024 om 12:28 schreef Petr Pisar:
> > while translating util-linux-2.40-rc2 I notice a few messages which are, in my
> > opinion, incorrect: [ ...]
> 
> A patch for most of these issues is coming up.
> 
> Karel, would there be time for an rc3?  It wouldn't need to delay
> things much: giving translators three or four days to update their
> translations for these small changes should be enough.

I need to release v2.40 today, it's already scheduled due to the end of
embargo for one CVE.

I guess we will have v2.40.1 very soon ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

