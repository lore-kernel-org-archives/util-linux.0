Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81434227BB6
	for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648515; cv=none; b=d1RcotcUUa+sXMQCQhCCpR6kyvn2QGBPGG7wwsj8szIKzTp26zJSv1Y3S3YjMAHAcDBdHnV7hS0Bjls4Huhg2C8oQYjQ0A2aozK+2dmJrjDb9McBMa/uIOnX4zmjhpuSk8jzkGsD64VVSDm7cp+KyD4X0tBA572N77MZvHrdNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648515; c=relaxed/simple;
	bh=ybec3FBIdXiNPBIjIG2KkaRhrfm8dYF2yeQ9k7GK2Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux9bw8AzBEf/VKA+w3iGDqt2mXV5FHb+PquttnUPjLSEz9d64dr5FPkn8492GdwYpcJJgikDsKCDgeXI5AVIytyNy4Ef23FCknJsPJCkFY2JHhAX44oUcM6ZZvL7OMHOi/ZejwHqzXtqmY2pnZfPCq3cZ2d3T5m1A9P2rAbdIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwaDktnj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwaDktnj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740648512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4RFesEfqj5+FSLql/AWLf6diIvWkihAEzUOnE/SI+s=;
	b=dwaDktnjIFFnBe/ysJoG+mrPn9AUJc7AX+6nR+oXeNUsWj7kGl4frXPn3ttH581nIs8+g2
	B5gKhF4YoRmeeFRrmuG1xWaq8oxBna0t46mM6/3AzeQEbG1SeLIbPIRsxv35AHjivDQ0Ym
	w3AMSGm05sWeZj+IZ911awKGQtaHUhM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-HCuGE_gPPNW897Y_vrvq0w-1; Thu,
 27 Feb 2025 04:28:27 -0500
X-MC-Unique: HCuGE_gPPNW897Y_vrvq0w-1
X-Mimecast-MFC-AGG-ID: HCuGE_gPPNW897Y_vrvq0w_1740648506
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ABCE1944D01;
	Thu, 27 Feb 2025 09:28:26 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ADFC19560AE;
	Thu, 27 Feb 2025 09:28:24 +0000 (UTC)
Date: Thu, 27 Feb 2025 10:28:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>, 
	util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] irqtop: add max iteration support
Message-ID: <pr4fky3knju6kxdk7tkdffc6qcxrintim4y42aoj4rcfrn2wk4@2no665wcutja>
References: <20250227044916.89925-1-joe.jin@oracle.com>
 <20250227044916.89925-3-joe.jin@oracle.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227044916.89925-3-joe.jin@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Feb 26, 2025 at 08:49:15PM GMT, Joe Jin wrote:
>  	enum irqtop_cpustat_mode cpustat_mode;
> +	int64_t	number;

Can we find a better name for the variable and the option?

  --nloops 
  --repeat

or so ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

