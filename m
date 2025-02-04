Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC4207A18
	for <util-linux@vger.kernel.org>; Tue,  4 Feb 2025 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660141; cv=none; b=GePzSdaTZfVzRCnUzn8p8MO+j2B2UU4Ie2J35vT4P+rCs5DQ9yM1Je5SdepTKiV1WsWqBe/lT/asI9VGVEBENTB0y1mxi1xpnmFS4zdXNlptmwx9UEUfCun3L+KTi5gk8NwSY99t4oI6ks8UhGApOn5QWd3yhnea+scKFFPi8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660141; c=relaxed/simple;
	bh=4DIil6xhWQDIN1mDMueGhTiJ1SYNqK1xPVbFXOhKkls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D96R2ckehLOSs/J+to84EOV7e7zw8msWPESn7+q7/haPibCeq77819Z9ussInlKwXgGFLGx73eRQY/afpzNUEzBif13YGb7JjENVvH13NljTT9EOPyKlKYgjlZK+OOBwKt22Nu9zYzJcOHSgDgOsv2rfEryou/AvxX5YId0c7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D99fKwGC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D99fKwGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738660139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sSWdEvVXO7qedZd33yezRvcMFx0qsre+LVkCiTfHn7w=;
	b=D99fKwGCsy6iLj/8fKbqnIPlujAz7KmehmRlxuOIT/8xabdDKrwt87Lg0Lhetb5ed4o0GA
	1Qg6iH9xMB+FjCX0X7mGNAWY3xIxaoiESqJ0Q2+NKQReWyY0s+auzd4mTR4u/+GFZB1pOd
	2CTmAzbrSTmHUkE1jUlq9o8mYW1OBvo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-sf-vdurxMs2po60wel22Vg-1; Tue,
 04 Feb 2025 04:08:55 -0500
X-MC-Unique: sf-vdurxMs2po60wel22Vg-1
X-Mimecast-MFC-AGG-ID: sf-vdurxMs2po60wel22Vg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42ADC1801F21;
	Tue,  4 Feb 2025 09:08:54 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6DAD30001BE;
	Tue,  4 Feb 2025 09:08:52 +0000 (UTC)
Date: Tue, 4 Feb 2025 10:08:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: util-linux@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH] lscpu: skip frequencies of 0 MHz when getting minmhz
Message-ID: <5lsyoejmvn7fgwx7k7t67xwn5pnxqpfbkjdf3s25fb3dntc7bu@qzeg56ej4zvy>
References: <20250131032532.17492-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131032532.17492-1-ricardo.neri-calderon@linux.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jan 30, 2025 at 07:25:32PM GMT, Ricardo Neri wrote:
>  sys-utils/lscpu-topology.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

