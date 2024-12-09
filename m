Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134614D717
	for <util-linux@vger.kernel.org>; Mon,  9 Dec 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740366; cv=none; b=PzxHa9PooQ5ODijw6kYp+qkA9OkET3m5IbB5ctepYO4LDe0zDNcL11elQGA9fhNfyFpxp/s75Ke4XGm73v+nVP45EWd31kJz6HRT0WmQBh2/pM7tzucnHn5RgFFlt/x6FyM5Pi8zrWbY2CYe6aACF+KgXzP5WyPqOo3gWKxvUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740366; c=relaxed/simple;
	bh=UMDrB/CKGCZ6LlSSQvZk9pjY0HIkK/X6OpUraR5Y3zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6g1U13pduqmc/KwVxpK4Se10cTTJhQDeVtVNtvHNi/5a2OKjY4IE2qQb5Y16r4o98KznGIDHJc53q8Ml95Rj0GPLvzZ/ioHlPHwv/uUQ+E8VvB1+5v+WR3TODzmpBNui01FtLJ/uMlA0i/YS/AJmWQ8+tGQKkkUpH7ARp1ILhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REKFa+Bv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REKFa+Bv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733740363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kDPZbPKGhNr4Lij5/s02/UbJO1qw4tnvS9tc+NQmlw0=;
	b=REKFa+BvMGazGZqMAB9tV3AtF18vDc1UVrG77FKDBluWlHsa37fel+QaSxImgcEd1aVjBi
	A3lxCSch4gPF7NZfQg3TplMvQ5HB6/dvEC2fJKx85ki35flndFHkyvWdcoZJB/w1k2hrOQ
	BthVzu74CEjzLvM2yomvAvrP43xGVPE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-XnVfD3UMPDa8o7BQe5oIbw-1; Mon,
 09 Dec 2024 05:32:40 -0500
X-MC-Unique: XnVfD3UMPDa8o7BQe5oIbw-1
X-Mimecast-MFC-AGG-ID: XnVfD3UMPDa8o7BQe5oIbw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93ED21956048;
	Mon,  9 Dec 2024 10:32:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22CCF195608A;
	Mon,  9 Dec 2024 10:32:36 +0000 (UTC)
Date: Mon, 9 Dec 2024 11:32:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Zhaoming Luo <zhmingluo@163.com>
Cc: util-linux@vger.kernel.org, bug-hurd@gnu.org
Subject: Re: [PATCH] hwclock: Support GNU Hurd
Message-ID: <kmz3eghhmo6rqlnenuwvcj3aa45elxajfdhwqiht52thxnb4qh@f2z34wslmajb>
References: <20241209025815.7299-1-zhmingluo@163.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209025815.7299-1-zhmingluo@163.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Dec 09, 2024 at 10:58:15AM GMT, Zhaoming Luo wrote:
>  	if (ctl->rtc_dev_name) {
>  		rtc_dev_name = ctl->rtc_dev_name;
> -		rtc_dev_fd = open(rtc_dev_name, O_RDONLY);
> +		rtc_dev_fd = open(rtc_dev_name, O_RDWR);

Why do you need O_RDWR on HURD? Maybe it would be better to add an
#ifdef, as it is unnecessary for Linux.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

