Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD39364056
	for <util-linux@vger.kernel.org>; Mon,  9 Mar 2026 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053519; cv=none; b=tnCNQzPFny8AcnmnGxh5VggPJf8VauXjABJDVSIK+3atFeQ4fT3IfaFVlXPmgy85YyAKei8SCVUK4QJidqDOTBmuZmeDQcv5iZO4WkwxZNzO/C9HrpJailLG8tg912LwaIpngu7H9IJVRkP7vgImKvJ13tdJGOKUwCiSLrpMuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053519; c=relaxed/simple;
	bh=QgZvbcWWY2fk1D0Tcp1UQ8e29MMAI5/2gQh38xajeo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJ90+BilSRmYwK7l/cfVOjLiXv2Ng8wOn7Kvh5kh6OVw8uiXF5bL83EaUohjNqLMaWekaNWVFKJeLgfNw2h83Si7k+f/tmz6yapJlx7p7oYD0Ww91lZThQiChdIQ2uuMcQ5lm3KmsVPCNa2ZaJKP4XKiTrOkCSyOEWU2QZolfUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjSqq4RJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjSqq4RJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773053517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJvJOFncII2TYXGTBg8hyYtrKBY2reEqsECMjemYDPA=;
	b=HjSqq4RJ1uyqd827XzpM6GaSCzx5OnnyQY69WTFmRJ9Hz3h6TgSRhkuCYxugIGkhCdeKzB
	bCBlnDTYitc5hGSxtnEFQJDiD8Jw4RMydR1BmDKuV1KDwJjWFk8B+PeEVvfZQ/32nyrPFX
	oAJQQUWw678mlRaXENoaEgPsM2GPUTE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-wOeszNVkOVyDqCHL2IhQ5g-1; Mon,
 09 Mar 2026 06:51:54 -0400
X-MC-Unique: wOeszNVkOVyDqCHL2IhQ5g-1
X-Mimecast-MFC-AGG-ID: wOeszNVkOVyDqCHL2IhQ5g_1773053513
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F8DE195609F;
	Mon,  9 Mar 2026 10:51:53 +0000 (UTC)
Received: from ws (unknown [10.44.34.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50F671955E72;
	Mon,  9 Mar 2026 10:51:52 +0000 (UTC)
Date: Mon, 9 Mar 2026 11:51:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Morgan <me@numin.it>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] pam_lastlog2: add -lpam to Makemodule.am
Message-ID: <2eu6jgeo2ir5f7kk7zam7agf42l2fwroh25rtoeoae3jg3q7y7@scrb3wj3u5z6>
References: <CAEUYr6ZH=9akE64zf5FM3u+Sr44oSJctk2gemiadisghEFESbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEUYr6ZH=9akE64zf5FM3u+Sr44oSJctk2gemiadisghEFESbg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Mar 02, 2026 at 11:08:39AM -0800, Morgan wrote:
> pam_lastlog2/src/Makemodule.am | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

