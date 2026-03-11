Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CEF3C870B
	for <util-linux@vger.kernel.org>; Wed, 11 Mar 2026 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232032; cv=none; b=q0zrnEjwc9V+CTbAw9sdX199kUzog/3saZJU8AskzVs6/4oXdzRQrVVUGMZpSS0s9A/oJIECOfnGQ2BGB9+I0q/Hu2yDeJGgrs9zJB+5goQWOWuuRVR4sWMn06ng6XKALiX9NmI7tTNeR46oECSItYhZnxp0ljhR5n+Qdxlzwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232032; c=relaxed/simple;
	bh=bwX76MByHwst6RGQkni6EsU7xWzBUwQJQ4X2ypS/d/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e215jFkxWZOPQUMIqjNJ1fewh4q9I0GDTzLtCQtBttE+XYYcEU9bPEgD+egm8wzflPIop9Dv3OCQ2sSCkvS521EDwtJGMdCCEeqayatcH1syY7m8yKz42iZxDOEp3cnMqLT3nNgsu4pCddsw2rXbHFYIUsrNif6x+AwEa8dcZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7vaU6eP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7vaU6eP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773232030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PdC+W858wmz/kP9m7fUpumTc2TXNGiSzT7eHz//2xNY=;
	b=g7vaU6ePBrxhgfC5Yg7LaKQH8XmdTD0OpAPKEQx3ouPzc8UrwS7UtzXtWqhgNt2UhAHDdY
	4Lw/6m0Y9MriJofCpfUx+6UqAlaiIZjB5CC2fLZSUJwJqdqj0eO+MiXC9+3qxy8/0i3QSQ
	32h22cFBfKkA0dHSMWv31Hj8z9JjLwE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-9fdJpe9gPM2wSSdik3xG3w-1; Wed,
 11 Mar 2026 08:27:09 -0400
X-MC-Unique: 9fdJpe9gPM2wSSdik3xG3w-1
X-Mimecast-MFC-AGG-ID: 9fdJpe9gPM2wSSdik3xG3w_1773232028
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04867195605B;
	Wed, 11 Mar 2026 12:27:08 +0000 (UTC)
Received: from ws (unknown [10.45.224.202])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85968180075B;
	Wed, 11 Mar 2026 12:27:06 +0000 (UTC)
Date: Wed, 11 Mar 2026 13:27:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] lsmem: (man) correct the markup of column names, and
 improve some grammar
Message-ID: <d6fywjkl5vvef3uyshxi477fe6vtnzygb7sjsy5mecs7c546gd@cy73pfohzucq>
References: <20260307114308.7517-1-bensberg@telfort.nl>
 <20260307114308.7517-2-bensberg@telfort.nl>
 <aa6-0Gx7Q8ZzWozj@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6-0Gx7Q8ZzWozj@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Mar 09, 2026 at 01:36:32PM +0100, Sumanth Korikkar wrote:
> How about the following?
> Example STATE, CONFIGURED, MEMMAP-ON-MEMORY states:
> STATE   | CONFIGURED | MEMMAP-ON-MEMORY | Description
> online  | yes        | yes              | Memory block is configured with memmap-on-memory enabled and online.
> online  | yes        | no               | Memory block is configured with memmap-on-memory disabled and online.
> offline | yes        | yes              | Memory block is configured but currently offline.
> offline | no         | yes              | Memory block is deconfigured and was previously configured with memmap-on-memory.
> offline | no         | no               | Memory block is deconfigured and was not previously configured with memmap-on-memory.

I personally prefer structured information like lists or tables and
dislike large text blocks ;-) 

However, in this case, I'm not sure if the description adds anything,
as it repeats what is obvious from STATE, CONFIGURED, MEMMAP-ON-MEMORY
columns.

What I find relevant is "previously configured." Maybe add a sentence
stating that CONFIGURED and MEMMAP-ON-MEMORY for _offline_ blocks show
the previous setup.

Benno, what do you think?

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

