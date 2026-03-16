Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116238F248
	for <util-linux@vger.kernel.org>; Mon, 16 Mar 2026 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658692; cv=none; b=gQS2+UqFezedUW1NjcAxe51Idkrq/7zeJ1+4y8/uMV1Absf7N3+nvFO0SOW6iwTxo3L2/KKTTZruYjRjAKxjAKC3/zkN78aZDTswvmGgaM2SVFMFUQumc0lx2v4P3h69wt+FTCShxljBL+OlE76jQ5fe8xM+jG1Koj0QeoItTeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658692; c=relaxed/simple;
	bh=4ZlTHskxRZw6edZA7CumfZTPxcRdp7WcDoibm1rl2Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV5pV5WeRnhyAbxKlmqvwvJucrh5Ij/HVd6HlQeajWhDRV2LpRK0HiS9WeuMhfGLjnzT2XLBn77rx2L6QsfH/b7unj+toJzw2CRNnBeEyi5Prsq/yvVuyfuXevRmScC4HdRjvaJTxcc2X3J/oMKlpvnfrYbR4xnb0wIaAIb2Dmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWY28DCf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWY28DCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773658689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdPVQdvOteKPtu4zGnAxGQ3y7M67mHTYlbtVhyfxQsI=;
	b=jWY28DCfkGyNXfeC9REwH4itvq3SSkGiXXnFiK+OMDw/4PjmK+45x8f/IHGo/6pd5WR98N
	ZNm+V7k6P/NfZINIpmVAbVKOL2IhCGhtDRDwsuqJh+ZayX0AR3diE3FXeVidO23c33/BSa
	24aGhYbGmBG2Tol6WRz0jvxeXPlp4A4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-TzgtcsT2PtapfVNuDnJ3RA-1; Mon,
 16 Mar 2026 06:58:08 -0400
X-MC-Unique: TzgtcsT2PtapfVNuDnJ3RA-1
X-Mimecast-MFC-AGG-ID: TzgtcsT2PtapfVNuDnJ3RA_1773658687
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8639919560AE;
	Mon, 16 Mar 2026 10:58:06 +0000 (UTC)
Received: from ws (unknown [10.45.227.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37BCB1955F19;
	Mon, 16 Mar 2026 10:58:04 +0000 (UTC)
Date: Mon, 16 Mar 2026 11:58:01 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: Re: [PATCH 2/2] lsmem: (man) correct the markup of column names, and
 improve some grammar
Message-ID: <wujarepqrdbbw2qzmhiyck5xhxael5kamahzago6ij7ln2c5nu@wsfbc7hip55w>
References: <20260307114308.7517-1-bensberg@telfort.nl>
 <20260307114308.7517-2-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307114308.7517-2-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Mar 07, 2026 at 12:43:08PM +0100, Benno Schulenberg wrote:
>  sys-utils/lsmem.1.adoc | 65 +++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 36 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

