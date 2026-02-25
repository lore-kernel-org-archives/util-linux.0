Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E052FD69F
	for <util-linux@vger.kernel.org>; Wed, 25 Feb 2026 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020785; cv=none; b=RitMbXbnVNthJhbS8CyWV4bqGtb1m+uJ0XkRjlGZw9CcLDsTiZze6WD3stjlP2xXr8bgGyIr43kLrQ5ezg/E3Xxn0xeyQ4iQJCb61H6FM17zKy61gyRQoFpuJkhH/XmllKGF+laePxyP/Y2pKkmhyYyYuhFuomBHDWdPTo9TY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020785; c=relaxed/simple;
	bh=9cWkRhM5IETUe8JgYSiYxfCEGX5Fmi1Ey3PAOl/yzy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYN9uyT2P1TVJkNJlE0NDJVJ1B5l46ciu0oLxrR2yR5LhuiWZBMvHWqSRrsnHuqu8TdFLgagT3Pyh3gBHlrgVch2ypqYSqn0x46q+SXx8CPEJ6GmBSVwZeX9NeT7nwYpRGTzjLMGG1kzUWGDQA9ReQ7Sv/9yxnPmX0NUuRBQObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G78aWnKS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G78aWnKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772020782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WcEJJcxfNxsq8DUxabJLDugSLRrNF3ZRdNl/iqcxG2s=;
	b=G78aWnKS2PBBmzuHhbKNNXZAcH3U1lwd2pqY1fdOI/X+sat790HikFUJ8a0AWEodY/3AUD
	EeUV6enLYzKu3yBL+HgXiQIFldOqyw17fbP0798slEF6bBZLFiM/rypejGjTY8eDmHOlU4
	0MQ2rYCk9XthkklwVFCauyaJXO8NTQE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-nsX_htBfNTqxo1YjUBQTog-1; Wed,
 25 Feb 2026 06:59:39 -0500
X-MC-Unique: nsX_htBfNTqxo1YjUBQTog-1
X-Mimecast-MFC-AGG-ID: nsX_htBfNTqxo1YjUBQTog_1772020778
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64A6418002DE;
	Wed, 25 Feb 2026 11:59:38 +0000 (UTC)
Received: from ws (unknown [10.45.224.186])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75ECF1955F43;
	Wed, 25 Feb 2026 11:59:36 +0000 (UTC)
Date: Wed, 25 Feb 2026 12:59:34 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fdisk: (man) correct the markup + punctuation of two
 option descriptions
Message-ID: <2dn6zjjnaalxlus5j7huwomrdee2bxbrqhka3jxohrgs2gpd44@7nqq32e2e2qq>
References: <20260224152422.52931-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224152422.52931-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Feb 24, 2026 at 04:24:22PM +0100, Benno Schulenberg wrote:
>  disk-utils/fdisk.8.adoc | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

