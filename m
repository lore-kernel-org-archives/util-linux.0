Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C8266EFB
	for <util-linux@vger.kernel.org>; Tue,  8 Apr 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112685; cv=none; b=BupsKN5TAiMCnNE/UsXrk7J3ZxzK8XPaiMKAc+CPB1IZ3PD8Ht4f3nl637U2Zv6qMHnUOGokN2jeTj5RalUxgwzk6TeRUpulEznVvPYEOBv78K2WcTzdTA8pMPs5HIeMrOL6jiizrs4v4z7wEk939Rl+TfUbQ6gM6geOYj4qQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112685; c=relaxed/simple;
	bh=QRwP6AuHd81Ec1BrSySxMOmpH8y8/u3Zt6EOzR4BUsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyWbzgG1518SO73Yk7+P0SiwH7wH0UIyu/mUI3cbKgIPIog1tG/yh7b4wQv2K345Io67J4hTzarUA0DPz98hWF9OV6fKlzgblR4njsFOzINXSKGKLQAinYBFMvQlZbBTp3F62Gk2YBV3lpj9wocTRC40xqmVjUgbotm1XxUm5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVKuOApT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVKuOApT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744112682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wkKEZsY5hzr2+drmY2J8LcYOC6knxB7eZ7v2FiDxK/k=;
	b=jVKuOApTl9kP7UfrQAMuUGdfCVfMuazAwXLHbvhebQe5OoBk0vND04F/AJgYkOxy5LOuK7
	/cHGZnq3M2jEPObUOijgx/vFYNxkAxxEVx/mdhkyvrQDgbrSeeAAlY/ozq71oqAIvpomw+
	GzWL2bQYO4fYNoDoemmK+R0wTFMV7ZI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-6Omr00x8Oy-dapOBKvE4og-1; Tue,
 08 Apr 2025 07:44:37 -0400
X-MC-Unique: 6Omr00x8Oy-dapOBKvE4og-1
X-Mimecast-MFC-AGG-ID: 6Omr00x8Oy-dapOBKvE4og_1744112676
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA9FC1955DBF;
	Tue,  8 Apr 2025 11:44:36 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3D32180B486;
	Tue,  8 Apr 2025 11:44:35 +0000 (UTC)
Date: Tue, 8 Apr 2025 13:44:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] hwclock: remove two comments about parameters that
 no longer exist
Message-ID: <6kyxdf2iqe72rf2f3r5ooz747ovzmc36vtqmyrpit5mexungpn@fhnkxdutjykb>
References: <20250406152147.9225-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406152147.9225-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, Apr 06, 2025 at 05:21:44PM +0200, Benno Schulenberg wrote:
>  sys-utils/hwclock.c | 5 -----
>  1 file changed, 5 deletions(-)

All four patches have been applied. Thank you!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

