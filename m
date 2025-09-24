Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915F27FB25
	for <util-linux@vger.kernel.org>; Wed, 24 Sep 2025 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701212; cv=none; b=SDOdazJ2GRtUMeoezwWOVIVphY3NHeH7XBfY1Ar+qnLfy485T0a/LttkHwfaq22uqS2kstZzmEKrLHkF1jtw0XFBEMtzsYWZxiPdBurg554bSN2eiSZcUcCFS8F3ygMGEXaQ7PV9MM7APzdaTubEOdQMoJqo+ur4kj4nGgR4gog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701212; c=relaxed/simple;
	bh=Hec57hl/qFkrzHQfSCjJH5f7I0dax5dLUVShVWKoP1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm3t+HaaB67QeGklmx6eFOokt4y/4TZELW31W7qRMXNvdElZdY/RL83AaknQo9Vdl7gbaQhe8l7Jp8bnARrJ2uJ2+tTvrGcoXyGsKjzEBSuBGUTaqwvt6xl9wW62wX13EU7CWr13R9F8REYJiz51RasqbqTZgWhv+0YXWzYXLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvtZX7G9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvtZX7G9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758701209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jA7tIHWMsdmGbLM+R9PwC1SQDsJwwnSCaugtxv535Ds=;
	b=AvtZX7G9DOxpRfCEbAfzbDQNh6hRYE17v+bQPdRtqpd+kOg8/PlU3qoxCjrJavjvlgPEav
	NJlPoBTxSgvjC31fgWLdJ/3zbIBvAAbJvXyCRAnn/k+9vfpILrqZeczhRN6AmiRwhfs13L
	QLKQBeD+dZNA0ogLWgjpETYCR4+DV8Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-14PmzPapNLOneIb60W8VDw-1; Wed,
 24 Sep 2025 04:06:47 -0400
X-MC-Unique: 14PmzPapNLOneIb60W8VDw-1
X-Mimecast-MFC-AGG-ID: 14PmzPapNLOneIb60W8VDw_1758701207
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8A8C19560A2;
	Wed, 24 Sep 2025 08:06:46 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 971DE1955F19;
	Wed, 24 Sep 2025 08:06:45 +0000 (UTC)
Date: Wed, 24 Sep 2025 10:06:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: correct an erroneous error message
Message-ID: <ieu3rzvjuokjyyhxz7wamdxlynjxi7hy5cyrfd2vaddhuz4z7n@txg6uqt6mxnx>
References: <20250916134441.51685-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916134441.51685-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Sep 16, 2025 at 03:44:41PM +0200, Benno Schulenberg wrote:
>  misc-utils/blkid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

