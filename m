Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412721767E
	for <util-linux@vger.kernel.org>; Mon,  9 Dec 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742006; cv=none; b=LmP/7hYbweG1p9GpzeXJOATK4sd1/QtxU7TqH6G42aHX/wh3Nt5UtOKcoMeFRdigk+47wq9QAAdWsvtfUPIxJyDn4jIrnOcPlZA2569EX/HsXv5nJrwnjPy+CP8BFkGcsOVsNlRipvxNeMQ99Q1GFJGdhObvPS7DUkMZXHQCitM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742006; c=relaxed/simple;
	bh=eYU3rdvZ7Qxr2XDbsChtfAMz37Zssb6cxBwkBuAlwyg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAvDYqjphYuXXdc0RjKaNwzc/m+Lc6LriZXGD7DCYJYY53YyTaeLa8Dty2vOziKfNy9V6shyL1T6c4hHPznyJs2DcTHsqiDLfn27mGOpc1Kb34AVWyER1IsY0Ttc6AnCeJ1XImpYDrL6b4ANuv8A847NA32uxDx1FdjPhkkC3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIz4Wem9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIz4Wem9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733742003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaW9C1XMEEzuDKfJxjQ9qXAhrHABjp4iQ+NJRsCkKc4=;
	b=UIz4Wem90fw7f+6hdxQiUBnY7nTnkXszB6qopupmydsmJMdDo/Z18p+HNFGCmRs+DkURUZ
	0poTKGXf1le/5yJf9ITJely0Y8yycgfq29S0wjbKM+fb2fmLKcpDpiPqWfCPvDy7/p1V7S
	kxzwV6w2MdsihCZkqEtjlS025UYpq6w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-KKoAGa4FMy2oAaGhtIRPnw-1; Mon,
 09 Dec 2024 05:59:59 -0500
X-MC-Unique: KKoAGa4FMy2oAaGhtIRPnw-1
X-Mimecast-MFC-AGG-ID: KKoAGa4FMy2oAaGhtIRPnw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A70A19560BC;
	Mon,  9 Dec 2024 10:59:58 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F8E3195605A;
	Mon,  9 Dec 2024 10:59:57 +0000 (UTC)
Date: Mon, 9 Dec 2024 11:59:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Zhaoming Luo <zhmingluo@163.com>, util-linux@vger.kernel.org, 
	bug-hurd@gnu.org
Subject: Re: [PATCH] hwclock: Support GNU Hurd
Message-ID: <frqkhqzh2lsm5d42xhror4ipqaqpspe3z4tbackwzx7jpt3afy@xjtr4ml2pomg>
References: <20241209025815.7299-1-zhmingluo@163.com>
 <kmz3eghhmo6rqlnenuwvcj3aa45elxajfdhwqiht52thxnb4qh@f2z34wslmajb>
 <Z1bIJjzgosmfF4xL@begin>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1bIJjzgosmfF4xL@begin>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Dec 09, 2024 at 11:36:22AM GMT, Samuel Thibault wrote:
> Karel Zak, le lun. 09 déc. 2024 11:32:33 +0100, a ecrit:
> > On Mon, Dec 09, 2024 at 10:58:15AM GMT, Zhaoming Luo wrote:
> > >  	if (ctl->rtc_dev_name) {
> > >  		rtc_dev_name = ctl->rtc_dev_name;
> > > -		rtc_dev_fd = open(rtc_dev_name, O_RDONLY);
> > > +		rtc_dev_fd = open(rtc_dev_name, O_RDWR);
> > 
> > Why do you need O_RDWR on HURD?
> 
> For setting the time, it makes sense to request WR?
> 
> > Maybe it would be better to add an
> > #ifdef, as it is unnecessary for Linux.
> 
> I have to say I'm surprised that Linux doesn't require it for setting
> the time.

It requires CAP_SYS_TIME. I assume that in this case, the RTC file
descriptor is simply a handler used to communicate with the RTC
driver. There are also more RTC_* set/get ioctls available, such as
alarm and interrupts.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

