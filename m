Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8CD2165FD
	for <util-linux@vger.kernel.org>; Mon,  9 Dec 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741031; cv=none; b=QN/+Sa3q/hw3+QRdYGYEvztNI4vmjfoPwp4U0QlzjrJstycmdHSmZtm4RpuJZ6hbY57P/yDP3laWG2OKdiPMbP5YwWH/R1l+ieAhpvqM5A+w03+SyY5A6Ai8XRlVAxYyORrvTUPzBkhIyxc8xf1qdZyXyYXK3+sNdbmMSeC7eiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741031; c=relaxed/simple;
	bh=9KIK1IiJWfvMum97Wtm/1lrqgKe3TGGEEd+xmFv9Bfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uul7Htc8l6WwTZd44+9Vc+cXnsKXHpZg/st/sAUCm7PHMKzWQwbfpgxY2pqAdOPewohFtttX4eZpSP4t4ody5rAdzyVf2qevFluYFhh31czcO5xTGHS05t67M4p43nTeGVRY2tL2l5FAOZC6RXVkzHGR4nR1KyY9XoF5cyUr7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwGASzgU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwGASzgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733741028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/ZoufmkRx4E6w19AthOG5sZ51ykHUMpk0hd0X82Ou0=;
	b=MwGASzgUWYwoZwtGGbnF1a6OCcmYYv3ppKt+QPXR3TmY3CowON6/1CWTjusBw8rm2cxO4m
	zEauv8FR7ekZLXkAudz0CLBfqlEfKJLe2FDItalwMqRn1Yt+qwF6DUZSwKPvwzCtRVV4wU
	EesgSTj85ruDn3HOvfASI7HOhNfASaM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-JzVCb4DYMiigAIFrczb_yQ-1; Mon,
 09 Dec 2024 05:43:44 -0500
X-MC-Unique: JzVCb4DYMiigAIFrczb_yQ-1
X-Mimecast-MFC-AGG-ID: JzVCb4DYMiigAIFrczb_yQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B78381956046;
	Mon,  9 Dec 2024 10:43:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72C2E195608A;
	Mon,  9 Dec 2024 10:43:41 +0000 (UTC)
Date: Mon, 9 Dec 2024 11:43:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Zhaoming Luo <zhmingluo@163.com>
Cc: util-linux@vger.kernel.org, samuel.thibault@gnu.org
Subject: Re: [RFC PATCH] hwclock: Remove ioperm declare as it causes nested
 extern declare warning
Message-ID: <rdetjzmv4xfjkk52qtewa3h7qttx6dmthxvqvkqvxnnzvnyxxo@tmr6xzo75ht5>
References: <20241209021154.255340-1-zhmingluo@163.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209021154.255340-1-zhmingluo@163.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Dec 09, 2024 at 10:11:54AM GMT, Zhaoming Luo wrote:
>  sys-utils/hwclock-cmos.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

