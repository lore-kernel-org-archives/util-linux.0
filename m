Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5921FBC9C
	for <util-linux@vger.kernel.org>; Mon,  3 Mar 2025 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001570; cv=none; b=CIbrKydCEMCraWAWHZWV68aO2DJFuASqptw9Xzr9e2CFRz3DO8Aa71ECjlCz760ElNz5ncvK6I4MqQ4pkHE+r+NNqx1xQ/m1I0wfpXwpfUtGN6KxTo7iQMMfvJB0OiRrhIlr4aXtl8Chd10CEGjklVLzYnanOANDQDlKaqMJIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001570; c=relaxed/simple;
	bh=lvgylN7QScxy0YvT3flidV81TjhR/9e2pDCONy4rR5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip2EQe5nJc7/u6d6Oi1/SMjJT23BHU7JuSJBvXuRWF5cCu8icRL53Cb6qk9/obanho7kKBSl2AL0jXJjzOWdY8g+2U5Uc4upgQUTp2iEmG6EGkEm9Xhl2rrJwt1udpzYDnP/3qXBqlMF0+QXp/o7LypYAasv+dPwBGKU/2FOnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCmjvAyF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCmjvAyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741001567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGSqMK+bA5RDjmOFjOvso+D0egbxPW7BLgfU0wv2hG4=;
	b=MCmjvAyFRxUYExVZTP/nEYSd/jCwD+fh/rnny1KCZWe4EnJj2XIdgcGNFljC4cvpHWfykN
	nxUlYmHp8ON1uPHbf+1R5uZhAiU6fIkDRMU0BIGSJ9zs4/dFhwzIoi5lr+WHcQqXxFME4A
	RslnLPJFLfojg9ucf7+PgoHcI487fRQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-bwXoz_zVPRq-j3P6L2Y33Q-1; Mon,
 03 Mar 2025 06:32:36 -0500
X-MC-Unique: bwXoz_zVPRq-j3P6L2Y33Q-1
X-Mimecast-MFC-AGG-ID: bwXoz_zVPRq-j3P6L2Y33Q_1741001555
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4BF31954B23;
	Mon,  3 Mar 2025 11:32:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C85A8180035F;
	Mon,  3 Mar 2025 11:32:34 +0000 (UTC)
Date: Mon, 3 Mar 2025 12:32:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] column: replace a mistaken word in an error message
Message-ID: <mtr3urghiu2ezk2uprqwuvkgfxktdb3md5vc4zwbidgxeckzny@2n7vycofqgom>
References: <20250303102137.4020-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303102137.4020-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Mar 03, 2025 at 11:21:37AM GMT, Benno Schulenberg wrote:
>  text-utils/column.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Benno, I'd like to release -rc2 ASAP. This means passing the task to
the translators. Do you think we need more time before rc2 to clean up
the strings?

The cleanup can continue in the master branch, but the changes will
not go into v2.41. I have no problem with this, but I'd like to be
considerate of your work and the translators.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

