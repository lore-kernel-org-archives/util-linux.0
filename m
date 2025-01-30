Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122515C0
	for <util-linux@vger.kernel.org>; Thu, 30 Jan 2025 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738230584; cv=none; b=aTSRaFM5LcMZPBRYh1bjKq2lMbAn9PdQJuK5bQW7lb8H4RKN8twNZXuGdSI47NoQgarkpfaXHjxBHaJBv6+Fu4NKdYfi+kvgvQf92ZqK1gMrdIMALMxb8dMyJSmoP25lhb4UjQhy78VTO74fjkwjZFm305aLZz5Ipy3SOiGupYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738230584; c=relaxed/simple;
	bh=8ojBg1K2PUzOfOU+UtN1cxQm/8WHY/CocfoLscqwdPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edr38FjChQOKtoZi9JS5pX6RfTx1XrsKY/fOdD9GEJT6ae/cazk9uJc516EpX+q1vDxOPo+67qbcyn943Rm8xmfbvCd1PQ3QR+MJQ/wUbzWFo6owyOkbW/jF2RyuG82O34W1ikD1kfItklOnlHUFY7k94D2Alx97OlOlngfBlTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSBXFzIc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSBXFzIc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738230582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u18MZQbNcox40Y/RU/ipxiq35O2ltw456S9/mbS0Gpc=;
	b=DSBXFzIc1UgXwGucGBnb8NhfRZ44fwAWIyXe310IyxYrILILU2EVpjXLVD/hE4L7l2q3TY
	W4DZY85do234d4h9QkBiJVGYIZBfhgs1cVhAa2ofVXZlklB16LIwsSkmRmxcjIyckY/haW
	tqA1OirB+qweQE5+dRa1OWQiXGB9MRo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-p0_dbswyO4yUEXQWYnb0hA-1; Thu,
 30 Jan 2025 04:49:40 -0500
X-MC-Unique: p0_dbswyO4yUEXQWYnb0hA-1
X-Mimecast-MFC-AGG-ID: p0_dbswyO4yUEXQWYnb0hA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FEF71801F1C;
	Thu, 30 Jan 2025 09:49:39 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.106])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05ABB19560A3;
	Thu, 30 Jan 2025 09:49:37 +0000 (UTC)
Date: Thu, 30 Jan 2025 10:49:34 +0100
From: Karel Zak <kzak@redhat.com>
To: Gao Xiang <xiang@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH V2] blkid: allow up to 64k erofs block sizes
Message-ID: <mbd332bqlcr5nxydwwlvgdk4z3pzdoe2dk34k5nuzshawey57s@l6wbunh7aib2>
References: <71d43b45-9d53-48a1-8751-7080e50937e9@redhat.com>
 <e0eb2d1f-48fd-4d2b-b087-20a87b396218@redhat.com>
 <Z5UBH6G7Af9QyqZx@debian>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5UBH6G7Af9QyqZx@debian>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Jan 25, 2025 at 11:19:59PM GMT, Gao Xiang wrote:
> On Fri, Jan 24, 2025 at 08:37:12AM -0600, Eric Sandeen wrote:
> > Today, mkfs.erofs defaults to page size for block size, but blkid
> > does not recognize this. Increase the limit to 64k.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> Reviewed-by: Gao Xiang <xiang@kernel.org>

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

