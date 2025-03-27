Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA220E326
	for <util-linux@vger.kernel.org>; Thu, 27 Mar 2025 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743070558; cv=none; b=sp5wAlJsTkISlvN6yhF/oGdcO9psqEFMoScBNAew7t2AugEH8EV6PlfQ8rhKe79hK8RUsKTlCEhGopiy2gTt8avlUUHpTPnLIoGg1sFmJCwTVO9TaOpw1SKn5WZ9Ki7apVc8gDO4b7Zs8ZM7fGhUMFEqqJRYQ05Z5G8iJ6DA8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743070558; c=relaxed/simple;
	bh=XeUHS0CaO02w2+MnTV5QxIjZF+VjxRgJShh+7iBBuR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2IUPQnEwauv4V6SxwspFDjrUhJWbS9MFdxNrn1kQ4tbscFt8Ha9cK1OkZOK870GIQasw/9iX+/oZWVgv3vIVGnhPX3LbY3EEmEGDkd3JQg7a9hJ2K8d0RAbJp/ksDTYH4nyuCuqfCy/On5rBfSrJOwb4V24idGGezgsWaYZJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXs36t1i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXs36t1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743070555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUjDX9qNuC2nMHBpa4n7roAxPd56K57qdAjuVI0fU+I=;
	b=WXs36t1iVcnvUp03pah848Yy3TGwI4Ik5h7pLzL7yyAhx4INvRarqPjKom9piWi322IeG+
	K+gt8hsJ45Gwdub+lFmnbFoVV/YY/dJvdkLk9hMEtyJzpH0bjrwhYJyk8ytSA8h631TF87
	Sng0AR4C+kz3GNvERoDgz8bQ27YxTdE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-whsxLGNoMM-ULceF9WBNSA-1; Thu,
 27 Mar 2025 06:15:51 -0400
X-MC-Unique: whsxLGNoMM-ULceF9WBNSA-1
X-Mimecast-MFC-AGG-ID: whsxLGNoMM-ULceF9WBNSA_1743070550
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C817D196D2D8;
	Thu, 27 Mar 2025 10:15:50 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1483180B487;
	Thu, 27 Mar 2025 10:15:49 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:15:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH util-linux] fallocate: add FALLOC_FL_WRITE_ZEROES support
Message-ID: <j7o7bftkbz4fg7rt6s76q5qumie3lncauloft77k2nvnlyzd7a@pecviw4axn5w>
References: <20250318073218.3513262-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318073218.3513262-1-yi.zhang@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Mar 18, 2025 at 03:32:18PM +0800, Zhang Yi wrote:
>  sys-utils/fallocate.1.adoc | 11 +++++++++--
>  sys-utils/fallocate.c      | 20 ++++++++++++++++----
>  2 files changed, 25 insertions(+), 6 deletions(-)

The patch will be merged later if it passes CI tests. Thanks!
https://github.com/util-linux/util-linux/pull/3489

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

