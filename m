Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3EA157A5A
	for <util-linux@vger.kernel.org>; Mon,  1 Jun 2026 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316819; cv=none; b=OE/CtFZYs+v+fHeR28Cs8Ssg7/Pju6eJa5/ejpXZ/mSNUF1oyyf7TrYU9iv6ajh+TNzdQ42hrp1pjjF395CCcEfYXhLp9iTwFxBmuSfcI+IFfaQ8kGT5Ftof0LIcPQsNGIpCe1ED8jXjtjXFbiJnUSxCCtL3dyVsHnREZuL//8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316819; c=relaxed/simple;
	bh=UUUt2Jibm+DscUw6m4URloTa/hwhopB/DCoKI9cZ8+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRxuJ7QYv3X/nlD9SdTwfyrHEiX3HKbPyQMliIzdhWB58DHxxWtBnrkJrvC30H94HuAspnSmOmpWkpl2YIqlVR2TyOcmveD/McQ0iazZlzK7qoCwqBAEQ/yB95pIMh9pqTBt07XPAWOLB1OmicoSx2ykOblWGM/9w8HDzKrpwoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdnDw8Ws; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdnDw8Ws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780316817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PGjnvcvQYQ25fkSQgx6fryr3ExukFIPG4oQ3zbTzl/s=;
	b=HdnDw8WsmqKzwAvSdCxQRwom6iCxsqcD0vtTs3pGwW8cOGqxkDCYUrxzaGCpsocNJFUAmD
	hEnLFi/ZA21HUy6l/AdRsmfwrzhgBsDwBRoe7zqdaPE+hLwLvNZUXn/tacrl17y8eR+nzx
	8YG5iwtpGXEqfJ3jIs3DsYjpboR+st0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-x0vT1v8cOXaa-USdIvfD2A-1; Mon,
 01 Jun 2026 08:26:53 -0400
X-MC-Unique: x0vT1v8cOXaa-USdIvfD2A-1
X-Mimecast-MFC-AGG-ID: x0vT1v8cOXaa-USdIvfD2A_1780316812
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 835431800451;
	Mon,  1 Jun 2026 12:26:52 +0000 (UTC)
Received: from ws (unknown [10.44.32.253])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0D8419560A2;
	Mon,  1 Jun 2026 12:26:51 +0000 (UTC)
Date: Mon, 1 Jun 2026 14:26:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Max Gautier <mg@max.gautier.name>
Cc: util-linux@vger.kernel.org
Subject: Re: Question: GPT GUID for dm-integrity separate metadata partition
Message-ID: <dekoqnth4brpwuopmhbzudhcw6bpbspog4hbcqyvy65t3nq6rt@ea2k25rl3fpu>
References: <ahyQJUrpRIJY7JfR@framework>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahyQJUrpRIJY7JfR@framework>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, May 31, 2026 at 09:46:45PM +0200, Max Gautier wrote:
> While setting up my system (new RAID array on top of dm-integrity on
> each RAID member), I asked myself what GPT type those separate integrity
> partition should have, to avoid being confused as something else by
> other tooling.
> (for example systemd auto-mount some partition type, so I suppose some
> other tooling could have similar behavior)

For decades, partition type GUIDs have been mostly cosmetic on Linux.
The kernel doesn't use them to decide anything - it probes
filesystem/device content directly. The partition type is just
metadata, "nice to have" for documentation purposes.

The one notable exception is systemd's Discoverable Partitions
Specification, which defines specific GUIDs for root, /usr, /home,
swap, etc. Tools like systemd-gpt-auto-generator use these to
auto-discover and auto-mount partitions.

For your case, "Linux reserved" (8DA63339-0007-60C0-C436-083AC8230908)
seems like a reasonable choice. It's recognized by partitioning tools
(fdisk, gdisk) but is not part of the Discoverable Partitions
Specification, so systemd won't try to auto-discover or auto-mount it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

