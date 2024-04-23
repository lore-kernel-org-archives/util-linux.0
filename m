Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555D320E
	for <util-linux@vger.kernel.org>; Tue, 23 Apr 2024 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861248; cv=none; b=K0z6Bzq3TNCu+Il2sSvmcuFEH/z1Y/XgtoEMfCDwOeAeYbPCm7Lq6d035INvfF8o41MH0oTndEsidfUfs8rFsaJZsdGxIf5lMN5+WEFuTSeFvAlNDoun9jMhQdCy6KL9HEStst1oQWK8XT62/7e1xlhcmt5KvLbXOq/Q2jYJDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861248; c=relaxed/simple;
	bh=erBcbMhjsd0buiPyL2bEgJVatMO2UvtuHhQk2TZASs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPXKoc4PGzJjWbt6zs9k9Au3g+WEF5UhSQ3uJO6QZX202Z4vsbPouukC3Jn9PFJEhho/u2YwrbboYV5jQAxswr8zz3P3LPTAaiDajUUXbwPD19v/63Vv5SufDIvVm6kF3k8BnVQP8SXzGtcgHmq5biObPPMrddvcM+JMQpPF4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNsP/TVx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNsP/TVx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713861245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qYZkZSAD3CbEiEBlgpcXlAVL5Z/jQ+I8P7pEa0EQ2GE=;
	b=NNsP/TVxANCwP8S/ui7oOoH0hFVa3fjW+gmZfKbDfT1S6FiD1Mi4MJylS5uUHDwoF2Sgxn
	wHVE1RtCcu4GmqrBe91tISfUPkSUc9pvBs1eEikg62CwNfGYXCEncDHVrwl39Zr0J3E29h
	/AKGPHMPZXv9TWvMEXsatYSmmUhlMf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-MbBTqehtPoqcgI90fThcmw-1; Tue, 23 Apr 2024 04:34:01 -0400
X-MC-Unique: MbBTqehtPoqcgI90fThcmw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EDE1834FB9;
	Tue, 23 Apr 2024 08:34:01 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AAFF43543A;
	Tue, 23 Apr 2024 08:34:00 +0000 (UTC)
Date: Tue, 23 Apr 2024 10:33:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: util-linux@vger.kernel.org
Subject: Re: umount -r broken due to "mountinfo unnecessary"
Message-ID: <20240423083358.2k532xl557meewws@ws.net.home>
References: <315f1f43-013f-48c9-9016-474dc9d53a04@ans.pl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <315f1f43-013f-48c9-9016-474dc9d53a04@ans.pl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Thu, Apr 18, 2024 at 01:00:56AM -0700, Krzysztof Olędzki wrote:
> I noticed that "umount -r" does not work on my system for filesystems other than root:

Fixed: https://github.com/util-linux/util-linux/pull/2989

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

