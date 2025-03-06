Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887225B686
	for <util-linux@vger.kernel.org>; Thu,  6 Mar 2025 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283572; cv=none; b=JrThdPPWbLe6UX5Eak2ObTGU+FKNT4EzKj6XZwCuQfD4a/ua5JmYkX9IS29t4OassPwZ3uOgmW73PqihKm1HP8enC/tLtO5S5hLg4JA9JO0WogvcEhn4anQo/66AIS4S1Ho6JcwJKjO5u+XNabeWafTm4iHCeflwx5cNb30EzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283572; c=relaxed/simple;
	bh=K4KmhdkKUN/Ra8oIuqhG+wcx/Cfepl/3BEZw3ClmyGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd/05mT8rcHNhM1+x3KWPDmx1SRl8vhuia+zFRcMD5AgE4BkVXEw4BHk75UeBqTeNFmVx7g0mVPDkTLOAID7gnG3uur1o9FSs3wrtUyyV+xScfsM3uifpug4DscIIsMV0wYWjSe7ZMQFCNgEwJl2r3NfiVcQ8DYLewS4CX9rELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcxJZKNA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcxJZKNA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741283568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01xodwX0R0STSWEjoo6qpJvuIbShdNfrBKB/m7MsBEc=;
	b=QcxJZKNAI5yCQxxrbePCD/MZ8Agt34X34xbdYx6ts61W2J0owYaziViuD41Sph8t/x1uGX
	XUdHYOM6bI3q1x6h2LReHlNZvomvmN45m2JKbuzBizyj0nNiHo4I2j1qG8uYr9h/FabSCu
	4rsxKmG1MjDmgvsEy8GgSeRk+ZRvBV4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623--GGORrvYMqmB175DbKhzPg-1; Thu,
 06 Mar 2025 12:52:40 -0500
X-MC-Unique: -GGORrvYMqmB175DbKhzPg-1
X-Mimecast-MFC-AGG-ID: -GGORrvYMqmB175DbKhzPg_1741283559
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CE10180AF73;
	Thu,  6 Mar 2025 17:52:39 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 591681801751;
	Thu,  6 Mar 2025 17:52:37 +0000 (UTC)
Date: Thu, 6 Mar 2025 18:52:34 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] lsmem: increase the available width for the summary
 text labels
Message-ID: <yi3f5qmetrq33znjb6p54eqlaktui6kywlro4tsaippfyt7cxc@xb5hibkzxuum>
References: <20250304160806.10374-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304160806.10374-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Mar 04, 2025 at 05:08:05PM GMT, Benno Schulenberg wrote:
>  sys-utils/lsmem.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

