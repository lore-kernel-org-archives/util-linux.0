Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5155280332
	for <util-linux@vger.kernel.org>; Wed, 18 Jun 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238763; cv=none; b=VN1npILBCDE6gb8JYvZc2unuLgaRqj+6gW448dK8eYNNtw9l4+g7Fs7z4k3Edg/ENqIIIj3pAW4I8d3WzN1AgEGhQsqhzdDx5ZSYFMyUzplFUwCHbdHOFCZm4b2CWiKVv0gZfK2Zd3tDf5L5gYbWG4A33hg96VTaxZq3SnnNOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238763; c=relaxed/simple;
	bh=wKxrNoGsiOBAZNp7naLjLxzzcY6IdrQD6VTFrf9z1CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc1Yk6heB1955/SqFpVy5d/rCAyTIIh6lPgPsMkJbMKhWTd3aXu+tj7wDNxm7eTZ7x1EDmN7u+wo7KUFpO5CUoUplVc6OmrtcoVSivAe4tBS0FCyq0OJkBKeBFvhdMmf3dPJ2bPl5+Z4wGIHzxpQRdo7WpwA87Eg1Tzoohxf0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMQxD/nR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMQxD/nR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750238760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RbxxOv7Qs8Xu1YyNN6gkQ2gmmzzCqT7JKEu6lT+bRMI=;
	b=CMQxD/nR/IS/vUPGwqGeisjgLwAtYJg9gUNgSuwFpwqq80sUpv0c7z9boYPDEGYul7DFOw
	Um0A9EBPB/JWCeWE8eemRKZuNTxs8uB0x76hzEFAISGgeVHNeF7wpq2QghRjlQct2NjHvt
	rR3+L1oDbjIQDTrkKpvIvEGiTX59Jg8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-zyWOvVBbOHWsiC-IHgXSug-1; Wed,
 18 Jun 2025 05:25:56 -0400
X-MC-Unique: zyWOvVBbOHWsiC-IHgXSug-1
X-Mimecast-MFC-AGG-ID: zyWOvVBbOHWsiC-IHgXSug_1750238756
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B72D41956088;
	Wed, 18 Jun 2025 09:25:55 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.26])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D3341956094;
	Wed, 18 Jun 2025 09:25:54 +0000 (UTC)
Date: Wed, 18 Jun 2025 11:25:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	util-linux@vger.kernel.org
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
Message-ID: <7qx4y3d3fnfjt2bfbqs4vfat7qb2imerqoalzgeiv25ejeypzk@5mp6rya3s2v2>
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
 <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
 <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jun 18, 2025 at 11:18:18AM +0200, Karel Zak wrote:
> On Wed, Jun 18, 2025 at 10:18:29AM +0200, Benno Schulenberg wrote:
> > 
> > Op 17-06-2025 om 20:24 schreef Madadi Vineeth Reddy:
> > > Currently, chrt requires a priority argument even for scheduling
> > > policies like SCHED_OTHER and SCHED_BATCH, which ignore it.
> > > 
> > > This change relaxes that requirement. Now, priority is only expected
> > > for SCHED_FIFO and SCHED_RR. For other policies, a default value of 0
> > > is set internally and no argument is required on the command line.
> > 
> > Doesn't this alter the "show-the-current-policy-and-priority" behavior
> > when no priority is given?  Currently `./chrt --help` says (trimmed):
>  
> Very good point. The priority policy (--{other,...}) should be
> required to ensure that the user wants to alter the setting rather
> than print the current situation. Madadi, what do you think?

Ah, I now read Benno's note more carefully. The code just silently ignores  
policy when priority is not specified.

$ chrt --fifo --pid $$  
pid 994013's current scheduling policy: SCHED_OTHER  
pid 994013's current scheduling priority: 0

This is ugly. The question is how important it is to support this for  
backward compatibility. I'd assume that users use "chrt --pid $$" to get  
the current setting.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

