Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F472DF150
	for <util-linux@vger.kernel.org>; Mon,  3 Nov 2025 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174357; cv=none; b=XxDgRuNhO8AFJS9wYvMhnL5pMgtqVCPguyN+CpjNpZDqyOVCvCY1MB5nfdJcrAgTQi9NoQ6ZURKVPP+u/A8HrQIzze/z0vUJnCUZlSZAtSe3oD5m27pbT+sR63mBDqpWcMNGncB35yPRrDcm7bOLTvXJEuPzHqxhJCtWZH0lU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174357; c=relaxed/simple;
	bh=/zTiDAU6nZPWk6f21g0OwImwfEjtCbl1L30/Z2BTcp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKvVLGFZGgVd7RXfGo70B0mkrNyXdnV6iitxuqu8TucWCcPFMKWCOOQbno/FrUKh+kNxvMsxlfvlLYqj/3gQronnc6gPcjdpEZ2h7Z9M9PMNpcBWLTRkelUKXUpRGOQt09lEW4wxuxwsuiTTNfQDut5iZqgdzm8e7ZKSEt14tyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NR6mFGfd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR6mFGfd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762174354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GeUxyhfmd0A/maA+LJ4+92BO44fIH2r8tK/WSwzFfFY=;
	b=NR6mFGfdphQFK4EuYUu5hCojILjssL8yw/Dg3e1f6Mc9fDfqf82YlZOEDGuPo8Gxz7vkyT
	2VolZeOxgjLyE24j1DB2TSmW2wKXr9TGyvXoOIpNf1tCjSQjO9u/4CEie58NUT/tsJ5Cie
	qiKb6qjtEUzEv38/54si3kX9MFnQAls=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-7Dubxn5HPq-UqykgjT9ihw-1; Mon,
 03 Nov 2025 07:52:30 -0500
X-MC-Unique: 7Dubxn5HPq-UqykgjT9ihw-1
X-Mimecast-MFC-AGG-ID: 7Dubxn5HPq-UqykgjT9ihw_1762174349
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5ABD61955E85;
	Mon,  3 Nov 2025 12:52:29 +0000 (UTC)
Received: from ws.localdomain (unknown [10.45.242.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10AAE19560A2;
	Mon,  3 Nov 2025 12:52:27 +0000 (UTC)
Date: Mon, 3 Nov 2025 13:52:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Munehisa Kamata <kamatam@amazon.com>
Cc: util-linux@vger.kernel.org, adanaila@amazon.com
Subject: Re: [PATCH] wdctl: remove -d option leftover
Message-ID: <uz3xz6ntnj25plqptzsmlg7vxbyewxesekwhe72tupqyqkn7oe@tp2tteyjwp6p>
References: <20251028195417.3569126-1-kamatam@amazon.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028195417.3569126-1-kamatam@amazon.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Oct 28, 2025 at 12:54:17PM -0700, Munehisa Kamata wrote:
>  sys-utils/wdctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Good catch. Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

