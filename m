Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321C42902C
	for <util-linux@vger.kernel.org>; Mon, 24 Aug 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579009; cv=none; b=uvrWjQJ3m1PO8B7zBFVrg6sQEr0SqBLUXnRQ9aXJyWCgrupzJx1/WRmT7OE5NimJC1amh4Mclj3g6qSKY9y+SX60UmDve3putpZr58VQvMDGZ6eCNwnsAftbAgSH9I+nGFPK+7Jxk7LmQ7KCsSGa5FeR/2ZL/3bFH6wFefeV/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579009; c=relaxed/simple;
	bh=6dMzbfjIc6Dz0AJj6CpDVJzPT9uMtf1nVOQcXmhDyV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEOARyz/g5EqSLI0g/62cKo4WAMC6ePYNzAvJd83UdobLCRtx4df0prmWB2UaU6tTztFTXzVbCj6lzft99lF0a1pNBpJaP+1d0qUJsCceaAgx+oa8eppNubufd7QbtWsv3DrSE9eyXAQsk3AA3U6/MPFhZXbamGhDXtHV4rIJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jB6MoZwp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jB6MoZwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787579004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDPLhfbiOqLmT7EeOgNcjdDOVGGFz2FxkIQGWuM5G3A=;
	b=jB6MoZwplDsS0NFpev3GYmDe/qzFibWs4t0d3zE2qRrMF5nKCWxoCjZ+eIN+aM3YV9CpOH
	VXlfXe2UZGYajxEFej9PxYn8INJqhYCmsKCrG/peXwiWmFlIGVvxDqDT6+1UXWLksk5fyD
	VqA479vYfn5GHaiL7v1sv15+iOp00PM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-Q_lDu38NO6CLI5ZPI-1pIw-1; Mon,
 24 Aug 2026 09:43:18 -0400
X-MC-Unique: Q_lDu38NO6CLI5ZPI-1pIw-1
X-Mimecast-MFC-AGG-ID: Q_lDu38NO6CLI5ZPI-1pIw_1787578996
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 761EA196C434;
	Mon, 24 Aug 2026 13:43:05 +0000 (UTC)
Received: from ws (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDD4B30003B0;
	Mon, 24 Aug 2026 13:43:03 +0000 (UTC)
Date: Mon, 24 Aug 2026 15:43:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Lokanadha M R <lokanadha.r@oss.qualcomm.com>
Cc: util-linux@vger.kernel.org, ganapatrao.kulkarni@oss.qualcomm.com, 
	trilok.soni@oss.qualcomm.com, ashok.raj@oss.qualcomm.com, rajendra.nayak@oss.qualcomm.com
Subject: Re: [PATCH] lscpu: prefer model over revision for the Model field
Message-ID: <g5ofi2kmlimr4nhnlhutzqzppyxhctbxos5qrbo4zrueljluvx@tz7c3yk6t5t4>
References: <20260820060801.2094422-1-lokanadha.r@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820060801.2094422-1-lokanadha.r@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Aug 20, 2026 at 11:38:01AM +0530, Lokanadha M R wrote:
> Current logic prefers ct->revision over ct->model whenever
> revision is set. This is not appropriate for any
> architecture that populates both fields, because the CPU
> model (part number) is the meaningful identifier for the
> "Model:" line, not the revision.
> 
> Make ct->model take precedence and use ct->revision only as
> a fallback.

Thanks for the patch. The change makes sense for ARM where the model
(part number) is the meaningful identifier.

However, on PowerPC the "model" field in /proc/cpuinfo contains
the machine/server model (e.g., "IBM,8233-E8B", "Power Macintosh")
rather than the CPU model, while "revision" contains the useful PVR
info (e.g., "2.1 (pvr 003f 0201)"). So simply flipping the
preference would break lscpu output for PowerPC users.

I've applied your patch with a preparatory commit that skips the
"model" field on PowerPC when "revision" contains "pvr", so
the revision is still used as fallback on that platform.

I have created PR https://github.com/util-linux/util-linux/pull/4577
to test all the changes on GitHub CI.

Thanks,
Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

