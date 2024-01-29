Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1B6157028
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561791; cv=none; b=AzWNPLgc5wnqrICWuhuXA1UwS8QxWXKiR640YeMhMDDEWgS6uUsZgiFFjMopjvxciijYqCI5rYCwo5ghAPxj2deXfWnmS4V17oHyiJTPGR76uCeoIoj7UwY4t8JgzlKS8BmAINcOHoWxOPsO62BkNVdIxL2jKyGpTBkUgCkeQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561791; c=relaxed/simple;
	bh=7MYegh4aCIMcj95BsR6yA1kAuJlDOfayKGtqhpJeBkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOvxMACvyd1Xf5gUedIBcO/CdHliiOlcrW98Oy3FZ8kDn3Nogtb4dhTKrRDw+C8iNL9vyIE2YDLrR5avqGu1jwq4uM7AQKPmHLyeFWIRHKl/68uAlE4ZJ1RWZqUMT3Urm+bIG16qWd5f1F9nmlP8+IEDOrTyKtHXIyIQfj4dCJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBp/5ZBq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBp/5ZBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706561788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iPIqrOcmvvCRKuCxPD5ZhBOcFS4Ec92YG6b4GDnlsJY=;
	b=JBp/5ZBqt8Wc4SqR+lFjnLmrzy1CFRJoeRvErR6APNDFvhl1Dx6ff/ZzPJJsH+mnFsZd84
	IrmxLLiDWNfu4CU2z9F4IPdRXHbGfg6r3zw2W5vKo1icWf20E9IkpTCzQyJ9ItmdOCW64P
	DDjZtytOYGE2Q+VkcyYtbW9Mtp3V5vY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-tMIeGDiSNZ64QyBXuZPwuA-1; Mon, 29 Jan 2024 15:56:26 -0500
X-MC-Unique: tMIeGDiSNZ64QyBXuZPwuA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A9468350E6;
	Mon, 29 Jan 2024 20:56:26 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D0A46492BC6;
	Mon, 29 Jan 2024 20:56:25 +0000 (UTC)
Date: Mon, 29 Jan 2024 21:56:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: Thorsten Glaser <tg@debian.org>, util-linux@vger.kernel.org
Subject: Re: fdisk corrupts data on USB stick
Message-ID: <20240129205623.sgvkhcyyepbsjzh3@ws.net.home>
References: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org>
 <478ec62d-5485-42c3-b492-6ccfa9bf62c8@t-8ch.de>
 <Pine.BSM.4.64L.2401292023270.19873@herc.mirbsd.org>
 <5b8f9459-cc95-4c08-b68c-39abb2ff9f68@t-8ch.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b8f9459-cc95-4c08-b68c-39abb2ff9f68@t-8ch.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Mon, Jan 29, 2024 at 09:44:21PM +0100, Thomas Weißschuh wrote:
> On 2024-01-29 20:27:13+0000, Thorsten Glaser wrote:
> > Thomas Weißschuh dixit:
> > 
> > >    The device contains 'iso9660' signature and it will be removed by a
> > >    write command. See fdisk(8) man page and --wipe option for more
> > >    details.
> > 
> > >I guess your version does the same, but maybe is not printing the
> > >warning.
> > 
> > Hm, maybe it does, maybe it doesn’t, but even so, why should it?
> 
> In the message you may or may not have seen there is a reference to the
> `--wipe` option that describes the reasoning and possibilities.

There is also --protect-boot and --wipe-partitions, that may help in
some cases.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

