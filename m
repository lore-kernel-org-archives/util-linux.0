Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ED528312B
	for <util-linux@vger.kernel.org>; Thu, 21 Aug 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761847; cv=none; b=Ksfm0rBb9c9md4ptKuXwLQMyEhyhsYuG8Q+0957zYp1dD/zV6VyPhrYEc8/bfYhmH+1ZkbF5HVQQ5d44VBlLLcXJYuRAocf6aOUbLkvdzOebw8KtThomCzRhrZk/UnVEAqfc6t+Dt2iWVk9j54fHFZdU64VsBAups1QVTsu45Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761847; c=relaxed/simple;
	bh=2bz1IftFmh3NB9KhFSnBps7YxeFq2lEgL+6CNIuLFhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubOy1ETevtmMnjrYNqPMkgf3yipgwOgDOQoqluMgUT9jIkaoCtqBFvc4BLgTtXW3VrRGlXV/pIq9fl8FFg+wwnPQW8imSXAEKR3uDNe7An71O+zAqx/dujd62JTABOXP4GUaiuy6EM13b9t/wIWV072R3jpYcYXvFzJ46mo/B4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgNd2Prd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgNd2Prd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755761844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArfKjDFvZqMekgkqxw/YMSHNHi+h+KAcGjzu9GenH0U=;
	b=TgNd2Prd9lNXJAOiETpxZzgOP62IzzN7O1JKip0ldAXrj2nA/8bFCSKsODJrgqzr/UliU4
	EzUsxDbxRhx/OBJTgjVS7if5H7LFVus7N40Ej7Q01y+gSbqfSJFrCDQ7ZiqvALwm4jRIFm
	nbJR01i4Y1bXWiDm0jwqBu+AqHZNz7A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-TMm7cspsMcqDqJ89v1FBXg-1; Thu,
 21 Aug 2025 03:37:20 -0400
X-MC-Unique: TMm7cspsMcqDqJ89v1FBXg-1
X-Mimecast-MFC-AGG-ID: TMm7cspsMcqDqJ89v1FBXg_1755761839
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45137185CE9A;
	Thu, 21 Aug 2025 07:37:14 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.108])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C2991955F24;
	Thu, 21 Aug 2025 07:37:13 +0000 (UTC)
Date: Thu, 21 Aug 2025 09:37:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Markup fixes for lastlog man pages
Message-ID: <m7uv7vhauxs27oxgi6fofkoeducdhu7moexliksx3zsqiroson@33s7552oxqo3>
References: <CAHi0vA9RfPW7zduvkQufPdvwfPB9wdhg21fzZ0tve3W5TK2DTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi0vA9RfPW7zduvkQufPdvwfPB9wdhg21fzZ0tve3W5TK2DTw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Aug 14, 2025 at 07:11:02PM +0200, Mario Blättermann wrote:
> while pre-translating the man pages of the upcoming version, I found
> some things worth to fix – to get working links in the SEE ALSO
> section, and a clickable author's mail address. See the attachment.

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

