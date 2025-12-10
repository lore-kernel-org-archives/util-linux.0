Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FEF2F83A7
	for <util-linux@vger.kernel.org>; Wed, 10 Dec 2025 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765359668; cv=none; b=ZRAgeyCNNlatP0PRqTdMoGmiPHBLGtwwTN78jvyHiqydL4VLhTKmfF12g+xZeVPUV6B6U2h70jsR122ix949kQSIQaGTbVop6FMZt8noWYsbegwZcSwmpypoVi/vXS7RHEwsAAiuWCBRP2Rq0CMrYO2jwj7rMVVOCBNeEwjqOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765359668; c=relaxed/simple;
	bh=livn3thVuffDxTu5XS5X8XI9C9cAt6ZXDZ2fJKlQkgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhmxczsxQr6A/YpdAJtK1RRoi2qKkeDym3h70pA/3L/bA22LbyziVNUd1MsIwde82bdatvcgrTNWcaEpPekEwhs3vc9K74Pp2RfMPEFVBwyN9vrqmc9u3pnN8GLZgyrz8M0em67700J6AIgvd1zw07Uc7LHXKuT5tXhHKKC2XBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBWgP1di; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBWgP1di"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765359661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bRr8MgpYoJ+u39tNm0Va7intAqOe/CkMcsWPYJU/hMQ=;
	b=eBWgP1diYMp8Zg4QsSX1E0rDQ+jC44bvFPtwx+sOfRoDTqyuRvegw69ireWA4kvWp+TK6e
	UOzf9yqp0ohsqZ1K23H3Zt4oSp8Mlt4Q4IPhBQT4IWs8ngvzuJAjiA20Aage/d+qODAMhu
	RefngFM2W5H/wbJrxyhyHpNo0j8zusw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-0d13fQ5ZNBGiwzoDcaebSw-1; Wed,
 10 Dec 2025 04:40:59 -0500
X-MC-Unique: 0d13fQ5ZNBGiwzoDcaebSw-1
X-Mimecast-MFC-AGG-ID: 0d13fQ5ZNBGiwzoDcaebSw_1765359658
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A40AF195608F
	for <util-linux@vger.kernel.org>; Wed, 10 Dec 2025 09:40:58 +0000 (UTC)
Received: from ws (unknown [10.45.242.26])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7466180044F;
	Wed, 10 Dec 2025 09:40:57 +0000 (UTC)
Date: Wed, 10 Dec 2025 10:40:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.41.3 planning
Message-ID: <inqgvwhb7vqesvikg2mle2fh6b5u3qi5et3jqqthwjolxjnsrt@fwwn2ckpmlxo>
References: <ajxw7xn6mh3puhs44cmj5mxxe7stxqwqi3vzzzueqa4srn2zgx@iukpxdgp4dkk>
 <20251210.063501.976895848370886654.yamato@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210.063501.976895848370886654.yamato@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Dec 10, 2025 at 06:35:01AM +0900, Masatake YAMATO wrote:
> I made a pull request about lsfd.
> https://github.com/util-linux/util-linux/pull/3896

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

