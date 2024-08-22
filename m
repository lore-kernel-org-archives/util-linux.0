Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CED1A2C10
	for <util-linux@vger.kernel.org>; Thu, 22 Aug 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326261; cv=none; b=dzhbTWGSR/6lcdjaDkxHoGtY6hlJQfbmZrxDlNGlRwIPTrq2k/K7TJtnc56kkLevtKE5GV8ICAYB8VE7PSKTPZ+ULxLDzjIXFTVlHNG+zG9wFHlNB/QLOF0ARsmSunVAZkpAENRYgd3rDD3lZ+80HEZbf+evBH55g8rWqJfCwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326261; c=relaxed/simple;
	bh=v1ZCg328XnbgIwwS8Ipm/qhWLFsddBpowVaOkvOiO2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqxhALQC57nqxTXCQ6BbhYxG1TQztIIYXfOID5dglDcWA9m9GtXRLp/bNuLUNwMIohgO9nDduEy6OkmHV0naeMOUpB1JElS8KDakFXuK8fHcRVHwFwS/hm6YckZnZoJI9YGDu9hC/N8CnAooonjQh/AsRHsNNLTA7Ln1GZ9zxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jV8lAWO3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jV8lAWO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724326259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08KqUy3olkOmq8eG2KOrIut8IOF3IWLOq1RzEVML+w4=;
	b=jV8lAWO3GQlLEPh2TC+QS7FEeFLJn7WNYBdRNLheg1VyucjKwR+zbyTBycRls+RAAgsuHI
	oJBVebzuXEEl1+Xl0FHfms4SpvW/CtG0tQDu/QG9uIvQ0kA3xp7l0KehZX9YnL1B/wgCA8
	fBum5TfaSk/WkbjRjwk0mA0+FRYeOl0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-fNL7V_yIOXao_whFyn-APA-1; Thu,
 22 Aug 2024 07:30:55 -0400
X-MC-Unique: fNL7V_yIOXao_whFyn-APA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A7C61955D4F;
	Thu, 22 Aug 2024 11:30:54 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.104])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E851B1955DD8;
	Thu, 22 Aug 2024 11:30:52 +0000 (UTC)
Date: Thu, 22 Aug 2024 13:30:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: qcai@redhat.com, util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: optimize query virt pci device
Message-ID: <papgvdtxmskvqsaytst5zw5onbf37kyn4dbez7kx7vjl6knbt4@wibthc277ev2>
References: <20240821084954.21566-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821084954.21566-1-kanie@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Aug 21, 2024 at 04:49:54PM GMT, Guixin Liu wrote:
>  sys-utils/lscpu-virt.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)

Thanks, the patch looks good. I'll merge it later after it passes CI:
https://github.com/util-linux/util-linux/pull/3177.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

