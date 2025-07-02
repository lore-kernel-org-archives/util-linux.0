Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE030AAAC
	for <util-linux@vger.kernel.org>; Wed,  2 Jul 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467983; cv=none; b=NblGuReLnDiHbGbP06OQK9D1+SPox1dabW/DLcLgeSmm2hY2Wbg9H0cNV7lCToKEWnJmP3mSspzAE9YSDLdEddsZBWJCcOSzr8WvF0GzMh6AB5OnN2vs+1fTHI9tvxFtm+6PTw2tbQ4clRzkR1UODvR3jW2kPRn3U5e6yg7IX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467983; c=relaxed/simple;
	bh=ELM40rB6Y3ZU0OduyVU5NIiV43iwM8iM8m7cCwn9Av4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOAUj8GPd9LheJkpJShddYGl28MFiBBNSF5Xjly3/Y2iRC6lLmgSF0C++dL+83MOS8eiTmZMhCQq1rMbar5oq8HUGI0fojyDRU1SPgN4UFH2y0LfO17oR278HX1U2DNiuHH1tJ+D6YWiJhZbZwz4T8/fOHsyWApKd8XRqNGgQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+CUklcz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+CUklcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751467981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOto4LJWmL8y8QwrFd68dk1/933wxvDJdKz3L1jJLOo=;
	b=O+CUklczLcYPL+WuqAmxezOB5s2r3fJVo/yCSor9tUIzVjl25rQV8/V01mHycYNplWud3H
	qhKf+UeoAmPXwCCv7YVqjVgAIoEkKi1r1LkoplT/vN/UBfvt1SuHad6O7dPZE1urGcJcZs
	WUnsvkSotSqHP9hPea3XvNPqmaGgky4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-cTu7n8yYMJWtUhdhPwgdZA-1; Wed,
 02 Jul 2025 10:52:58 -0400
X-MC-Unique: cTu7n8yYMJWtUhdhPwgdZA-1
X-Mimecast-MFC-AGG-ID: cTu7n8yYMJWtUhdhPwgdZA_1751467977
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F90619560B9;
	Wed,  2 Jul 2025 14:52:57 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C94D518003FC;
	Wed,  2 Jul 2025 14:52:55 +0000 (UTC)
Date: Wed, 2 Jul 2025 16:52:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] chrt: simplify the other check for too few arguments
Message-ID: <kvz4xvunx2bhkm5likrd63s63ckfqgtozhkbafj6vwjlyhfccb@bxxlbpjipchy>
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-3-bensberg@telfort.nl>
 <4e545c8f-8e74-462f-8416-3c1cbde81b2e@linux.ibm.com>
 <a80cdbf2-0c4d-40dc-8ae6-9ccbd900bc1b@telfort.nl>
 <4xnz2hducqdq7o2nvysrm5pvll7k52sprsycok6ouf5epqua6d@5yicext46xu5>
 <bc67a8ab-2a8b-4339-88e7-02fe71779491@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc67a8ab-2a8b-4339-88e7-02fe71779491@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Jul 02, 2025 at 03:39:53PM +0200, Benno Schulenberg wrote:
> As far as I can tell, all the util-linux tools understand --help.
> So, for util-linux tools, it is rather redundant to tell the user
> this.

I mean when users use it on the command line and mix tools from different  
projects and sources. 

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

