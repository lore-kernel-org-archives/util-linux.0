Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E81B87C9
	for <util-linux@vger.kernel.org>; Tue, 26 Aug 2025 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200619; cv=none; b=DBEhaij97j5aPQ3FwA9HmH/5XqIMsnfyaa+GJ89OyCjJjSTOi4HdAH+TDSOmvFbiWFuirxaGjvf1AGY8b86YUvea+EWczDSEFiHmbb3WrQeyWRup+AqZgd6LZI02LBLUj+8TWOAaIdUJJiBq57rjhYoZto7elrqx3//z+llzPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200619; c=relaxed/simple;
	bh=7wrMmp3cj/ydzuXrL07+xPhgO7vkFxp5JFC2bvD4c+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icL69/osxs6Xnt7AmR7RE1V8T9/CfjYhKA/h1gew00s9n58C6yXjlXAHVUIYzoKsI3bkWZUcvbCKmJh1kMK2B/+EwSvInZWSH/GeP2Palg881mOJZ3TQEpYNx8eAgyqxManAgN/1oMmkyaJ8AHih+HCEe9m+/EyVeWhw5PDWyXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jao35Fxr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jao35Fxr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756200616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4pcxbnccwTyQpVmVJab8v0MHqdZzPOPpBRSPbsAu0w=;
	b=Jao35FxrR7Ws1monhPmBnUzOsTcNjDzg2owr33MHOrX7XnR+79fyicaTH71s/QnF3vigQs
	qA0WFXTAMhoTK6DQrAoqpGhj7hsRapicrNVrgOPbbBY3vJ/uMzcKKlQKfpZD2MBtkjYCNX
	6OMM/Ic8nuA00oMNmCCTnu3n7VyTQDA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-9H6dnaxGNvO504m5p6K91A-1; Tue,
 26 Aug 2025 05:30:13 -0400
X-MC-Unique: 9H6dnaxGNvO504m5p6K91A-1
X-Mimecast-MFC-AGG-ID: 9H6dnaxGNvO504m5p6K91A_1756200612
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BC2219560AB;
	Tue, 26 Aug 2025 09:30:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.108])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD3CF1800447;
	Tue, 26 Aug 2025 09:30:10 +0000 (UTC)
Date: Tue, 26 Aug 2025 11:30:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: util-linux@vger.kernel.org, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH] chmem: Remove commit - chmem print warnings about
 failures always
Message-ID: <gabpcqgd73xdbqe7jbvmeumdezpoy3h6ibu4zuxpbhwvlen3ts@ahugft52fm3l>
References: <20250822151353.508175-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822151353.508175-1-sumanthk@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Aug 22, 2025 at 05:13:53PM +0200, Sumanth Korikkar wrote:
>  sys-utils/chmem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

