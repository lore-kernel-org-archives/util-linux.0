Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3213DBB6
	for <util-linux@vger.kernel.org>; Wed, 24 Apr 2024 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952369; cv=none; b=kFhxETwtZZHrL8G2Egrp3x7gs7MnLS67OPJwsT9GKFi/4nAB8kHnthrbDV5EHz0GwiN1Xc0UXBOOIoDdGdUdNWHOpRHD2dGgNIjx1EXXzn68BhQnuHXRmtKLJaEGblT/ormELpVeJuPFK2mrrvG6hBl+VNdNRe7Q5wSRqrrWtfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952369; c=relaxed/simple;
	bh=ushO/ugw6rq/OLlvakg+SPvRY8jQlhOuKUaTNDXwC4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6uyb71N/DQ2znY+Y6NMGZaa3C/oAKiFqgTwiOfXhTkqoFtiSV/5xC88ZxjbZCulX0whuNBLW6bSBi+XIFD56AaEQfZfh2fOb6umN54TGkznme6kDaV7SNGQbeKNVMqKDB1vbQonbzIVxw2QjdPtdfOMVo5zXYXLtd0y8RWYwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVqUHqNK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVqUHqNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713952366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iu6FOCc0vCSiH9fJ4QbVIUEjNs+WRD59ReL+7Si7Jnw=;
	b=OVqUHqNK06AuTo+Q4UE6UrZ9l/ag8+La2u5YxPli76q27JEGBmdOiQZmo43FhXz8zwXwJ/
	YcZpmwm7X2FjCVA4bqTlvLT4Q8+7gCWa25RTwOl0LjD4KTYkb/PSKQWSwF5xAqXmSZpBq2
	hB0wwBD8uBt6xq9eEtpcu0tRaevDZb0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-OlkKSaz3P42H6HHP0jY8Ig-1; Wed, 24 Apr 2024 05:52:43 -0400
X-MC-Unique: OlkKSaz3P42H6HHP0jY8Ig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F97280B935;
	Wed, 24 Apr 2024 09:52:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A50240C6CC0;
	Wed, 24 Apr 2024 09:52:42 +0000 (UTC)
Date: Wed, 24 Apr 2024 11:52:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Prasanna Paithankar <paithankarprasanna@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [RFC] ipcs for POSIX IPC
Message-ID: <20240424095240.l2fzrswgtvaqpv2o@ws.net.home>
References: <CAOfrUuZ8fL3kz=p2Pwh5JN6Nm9UvE4NPtcikNFCL8LC7r5FW0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOfrUuZ8fL3kz=p2Pwh5JN6Nm9UvE4NPtcikNFCL8LC7r5FW0g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Wed, Apr 24, 2024 at 04:10:48AM +0530, Prasanna Paithankar wrote:
> The 'ipcs' (and 'ipcrm') command provides information on (or removes
> some) System V IPC resources. I'd like to know why no similar utility
> for POSIX IPC has existed for a long time. I would like to know if
> such a tool exists in case I missed it. If not, I will provide patches
> to ipcs and ipcrm (or should I separate the functionality into a new
> utility).

I would suggest improving 'lsipc' instead of using the old 'ipcs'.

The question is where to find information about POSIX IPC. For System
V, there is /proc/sysvipc, but there is no equivalent for POSIX (or I
am not aware of it). It seems that the only way to gather this
information is by scanning all processes' memory maps for /dev/shm.
This could be achieved by using lsfd.

    Karel

> 
> Yours sincerely
> Prasanna Paithankar
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

