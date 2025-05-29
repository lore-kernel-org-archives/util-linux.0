Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C41EB2F
	for <util-linux@vger.kernel.org>; Thu, 29 May 2025 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748519141; cv=none; b=HCYYZnUokWwbCAAjtUsQACMx1s4Z2+ka2hzNi0l9/GFL+PPVKsHYcJZYF4nI4wUF1YdOIyG9iftyNVHpjaPZl9/I6JoAjBux3hsKipflkYKEPZ3u2i6k3X9qRskUdSE+lXmJY6p9j+4ouNVblWi5l8O7VjPWpurf79Ek2+9pwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748519141; c=relaxed/simple;
	bh=bdGEXjVaN+UbAjUEt8u0qRVDZ8f+TXk5SNjdArX66mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usSQDZG2N03sfb/SuZYKRUB9cD+Wxs0ey/Y418W2FQg5IQkctDXww4DM7EN+g3OW6/Chz6lTlCIzGghpuujc8w7S4YPBimsct4bMCCWGPMvx+i2Pd7Rm6w0RtSAAvvHpmo9s5koNVe95R7Ye/KRCFB88YDFKoYBTJeNSj3nUHBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhbF+BXT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhbF+BXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748519138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNJjm7OEwrl+gFyL1AlS1cTwmSfq9tZ2/qaNdW++Nqw=;
	b=LhbF+BXTBR0cD+6D2mIoMI51J1khi67w6Kd/Z394aiEHRmAJYCljnbbu6qWeQZQGpwXiqv
	7FQZqnhCPO/NQOqA4M/gJ17tT68h9DpudiBDUqAc5iyVHj3EDWvdHO0F9B6mI0ReZHSjNl
	L5+iAkjVNhpDKNXq9i+/r+ENvblthMs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-lOmP5JBSNsCJ1dKzYpnaIw-1; Thu,
 29 May 2025 07:45:37 -0400
X-MC-Unique: lOmP5JBSNsCJ1dKzYpnaIw-1
X-Mimecast-MFC-AGG-ID: lOmP5JBSNsCJ1dKzYpnaIw_1748519136
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 549FA1800A25;
	Thu, 29 May 2025 11:45:33 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D3DF1954191;
	Thu, 29 May 2025 11:45:31 +0000 (UTC)
Date: Thu, 29 May 2025 13:45:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] hexdump: (man) put a list item on a single line, to
 avoid a warning
Message-ID: <tsscy75bbuqpezzzrnhlc2qorynr2zgydh43ep5ppg7p4p4jun@fex55hnwmvex>
References: <20250523120407.75188-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523120407.75188-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, May 23, 2025 at 02:04:04PM +0200, Benno Schulenberg wrote:
>  text-utils/hexdump.1.adoc | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied (all set), thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

