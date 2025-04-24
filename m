Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453E1F0E47
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488649; cv=none; b=rL7uoAyxkThmupaPwxCdQnVLSNzR4+weuH34ewVpW8pMaiwBYlVObkYdWZfOGHY/+1A6GOYbT6iL14p3fWSmKatt/BGhgWOfLDZwwvsmNgCIf5Zz/PBrWWtYl9C5gdDeDHQP8jbw4eMJ5fSTtEm3GhoZZEeO9yOyX9AdGBAs5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488649; c=relaxed/simple;
	bh=9QdzI7iY4YKd5X+zSZm5yRsGPKBmqBWXhoFpV9/Gcqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7X6rj5vrAaqDBfmqtIwqjo4pIsj62ufmYTU+3SgaJKT/HtqYgnT1UIF9MBIRWU+XtGqeL1qY/rrHUWvaak+N4+KSmvT3X3Ynhv4s6YNqRj1rwl+J30+ZfsPMNGJaDUf8GCFf6dlYwf6QrCuptfN8c6U+XkShhgGege4B/+AJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSH7yMgQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSH7yMgQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745488645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u//IGhTGRfGGI+3GD3AFW6pn4Y9CYNhKnXwTnEXvY/U=;
	b=XSH7yMgQDGMzDRoHtc6zGvE9a16ip3amZ/S149y37SEFImrw+kTzbKUnpkZNd41gD1LulF
	eeWQcRYpnAVgIFh+htapXwt4groURssu2tnd8QIWQV5cOt275jwTj6dIrgF2oUFFrPPUri
	DEecmyn7jSwhwt7gz7+s+9jMac3rbpU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-WEt8jdPRPOm2qUjavct2Mg-1; Thu,
 24 Apr 2025 05:57:21 -0400
X-MC-Unique: WEt8jdPRPOm2qUjavct2Mg-1
X-Mimecast-MFC-AGG-ID: WEt8jdPRPOm2qUjavct2Mg_1745488640
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD9B71955DCC;
	Thu, 24 Apr 2025 09:57:20 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.130])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83F131956095;
	Thu, 24 Apr 2025 09:57:19 +0000 (UTC)
Date: Thu, 24 Apr 2025 11:57:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Robin Jarry <robin@jarry.cc>
Subject: Re: [PATCH 01/10] bits: (man) normalize the markup and improve some
 layout
Message-ID: <3eis2hzr77ggkbq67m33zmwsgccuusbaj3fkcvff5g25dqalpk@hpimyesf5ua4>
References: <20250417094825.20870-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417094825.20870-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Apr 17, 2025 at 11:48:15AM +0200, Benno Schulenberg wrote:
>  text-utils/bits.1.adoc | 80 ++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 38 deletions(-)

Applied (all 10 patches), thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

