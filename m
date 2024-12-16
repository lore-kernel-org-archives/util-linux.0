Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97D2010EF
	for <util-linux@vger.kernel.org>; Mon, 16 Dec 2024 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344289; cv=none; b=MMCrrlmP3N8vBArCX9k8JxQ1U4pjnkSwRYaRZLiOvSwcbCINODYPXz1G9iMvKLi3t6arH0tEhGeQKDUfOBNkLNsXt9Ap7FGoQ21RZK2rVESwTn6Q/eGdtnOcqFjQXsvuvIAJ8Rr8ifdDyOq0ic05hlu/zw9t6M+f1Y2PlJ68qOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344289; c=relaxed/simple;
	bh=Bp8awhjIYQJ1jUgicKcRnJyBuVU6dEf9uU69C6/LNYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHXA4mDfdyKTf+jY3O0gQ6WtMUdwu0xRnjPKpHBm8gFHZhb2Dhty7mRcewzawhCNwj6XgsdY4vzcjwRpUQP3aIDNlSjPDiXZKE5lMhsc2JDFUJk7OS4KjY2dhRNWwYgR783GyR9HllFOi+PRNiDLdXbOd9P+jwRuWucmJQh8S1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTglYXLd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTglYXLd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734344286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I21r0SE0xH374+FeB8NH8ts9+WA3PbC5UKYq8CkEfhY=;
	b=DTglYXLdGNWcDJWc8MyGy6EqXPJnWs1YfZvVeNVonnQ4lT2g5L7GZ15dd4wP+Jxq7+2uYu
	GPiLSfZ53gnZAuUXnV8+9W7ftarmc1xX9glwf5+tn26aNI8MEc1N5TvPReHNqGcnDPy9jW
	xE4r+aO87YDvjERote6f+qiUH2Qw+Lc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-hiE1yqxpP6qsqUKCJ3jQ5Q-1; Mon,
 16 Dec 2024 05:18:03 -0500
X-MC-Unique: hiE1yqxpP6qsqUKCJ3jQ5Q-1
X-Mimecast-MFC-AGG-ID: hiE1yqxpP6qsqUKCJ3jQ5Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 544A71956086;
	Mon, 16 Dec 2024 10:18:02 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.204])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 576923000197;
	Mon, 16 Dec 2024 10:18:01 +0000 (UTC)
Date: Mon, 16 Dec 2024 11:17:58 +0100
From: Karel Zak <kzak@redhat.com>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.40.3 plan
Message-ID: <xh2hk7lsr2mdfza6a2s4aeq6gcwbnsfteqnaunckm77zhyjlgf@pybi4g4fqw6f>
References: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
 <tcyqzu65my54wgqt4twjcdtb5vayvoojareuzkfnbx6pev7osa@lhea5femzoia>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tcyqzu65my54wgqt4twjcdtb5vayvoojareuzkfnbx6pev7osa@lhea5femzoia>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

 Hi Chris,

On Tue, Dec 10, 2024 at 04:03:49PM GMT, Chris Hofstaedtler wrote:
> I think it would be nice to add the following three commits from

All three commits were cherry-picked to the stable branch. Thank you
for the suggestion.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

