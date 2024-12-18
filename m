Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F01B0417
	for <util-linux@vger.kernel.org>; Wed, 18 Dec 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533101; cv=none; b=LCmUNj8b2rhMQG5HU56JjEnWH+F7200c3Ka8EFnwBO5qxE0ay5G2Jg4wTMaM9q5MBTZc8Gk8XGngNmRAwqXSEIn8ZLaThJWRwVwmALJeoIs/o+u/g7WF7N9Rk84LoPA3DMo0MbcI00vbB4JHzkEHmu+UJyhsBB/yXwn/56ecFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533101; c=relaxed/simple;
	bh=KRXuadb4U+wvU04aiFfPz5JuFKiALJ92omAVh0JtEhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8Si1pDEnzZbqlzcmcFN7Z5sOnMUwSVKpgNMtESYS7CtS/vW3NvHfde1fYKF6NqMwM4ss/U9w1kLRmUg3XAzRd4AVzIzi7QDJPW6hflX5pRK5QtL+sG2+UVan2S9DGiaUIuUGBV9siXbzzoKnRD9k4IphHiPNhRM140C1mw43DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejXV8EE7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejXV8EE7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734533099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vn60nRsdeISg5F5xT1auCNjSlK4JTo/5ET489DMXjaE=;
	b=ejXV8EE7xxZA+dlXlpOKnrADqS6Qmzjc2evz5G+vc+Opv7/hYnuFLR8y0fZ8fRWwNuGHTf
	0I77fr9EHh5QdATANJMuqh83j2qh4MQWHkznjKsPIh8b0pbFrx3CofxdEETYgEszbsplX0
	PSlLgPlX9EYprHgqdNyu6kAJqb+TC8c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-GaKwasT9NSq52txUBsufdg-1; Wed,
 18 Dec 2024 09:44:55 -0500
X-MC-Unique: GaKwasT9NSq52txUBsufdg-1
X-Mimecast-MFC-AGG-ID: GaKwasT9NSq52txUBsufdg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80F371955DD1;
	Wed, 18 Dec 2024 14:44:53 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.204])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FEA0196BB69;
	Wed, 18 Dec 2024 14:44:50 +0000 (UTC)
Date: Wed, 18 Dec 2024 15:44:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: Michael Chang <mchang@suse.com>, Glass Su <glass.su@suse.com>, 
	Heming Zhao <heming.zhao@suse.com>, "linux-lvm@lists.linux.dev" <linux-lvm@lists.linux.dev>, 
	grub-devel@gnu.org, util-linux@vger.kernel.org
Subject: Re: is it possible to add a new filter to detect unusable partition
 types
Message-ID: <hdqz3hun3f5ftfwvimlopkmuujimtz5ilovkuajqesy6p4a7jd@7w6nkryhr2y7>
References: <826b5136-7ee1-4664-98d6-a3441883f53e@suse.com>
 <43D73CB9-32E4-405E-93A9-E985C94F4A9E__33327.0934455626$1734427189$gmane$org@suse.com>
 <ec0d03c0-40b0-4719-a020-9bae7a3241ec@gmail.com>
 <yjiu3c3e4aknayawhw7lw52kev6fvp4wm6n6wte4t27hx3fr4u__21682.4523567752$1734439545$gmane$org@cc5bu2ij2ia3>
 <dbc7728b-352b-4982-a171-d8f177388a19@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc7728b-352b-4982-a171-d8f177388a19@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Dec 18, 2024 at 11:12:59AM GMT, Zdenek Kabelac wrote:
> Sorry to say this, but the fact the 'someone' has created 'GUID' for GPT
> with the name 'BIOS boot' doesn't really make anything in the Linux world -
> so far I was not even aware such partition type exists (not using this
> myself).

Yes, partition types are a legacy from the previous century. They have
very limited relevance in today's world. They may make sense for
things like firmwares or Systemd Discoverable Partitions, but in most
cases, it is only the device content that matters. It is important to
note that we have no way of synchronizing device content and device
types. Additionally, for Linux, device types have had no meaning since
the beginning.

> Well protection needs to be from all sides here - otherwise it makes no
> sense.  When the grub sees some signature, it must be telling to a user and
> not just let user to loose his data blindly.

Yes, this behavior should be standard for all mkfs-like and
partitioning tools. The use of --force should be required in order to
perform any potentially risky actions.

> And in the same way blkid should expose installed grub loader - currently
> the partition with installed grub looks 'empty' with blkid....

The issue I see is that boot loaders can coexist with filesystems on
the same device. This can lead to unexpected warnings when attempting
to view the contents of the device using mkfs tools.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

