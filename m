Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DBC230BE1
	for <util-linux@vger.kernel.org>; Mon, 17 Mar 2025 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206146; cv=none; b=MwKYjePCiDQHg0RisEcr1Qd5uL4lXMvP1GgfDSKgpsA2asVGHh+HZVslhjULiznyBFi3hi4fkvvSvxcLRG/MnHIgG9PEHuuNAdfhFTMOio0z/jQSRaDvWaRwlOxbDeeJMTxnYHSGkjL9UcDX3E8KDzFRnEOzrQXfgsU008ycOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206146; c=relaxed/simple;
	bh=BhT8EpLxtP57RRTFcnRS9N6m0yVvtNqHNMKBo8VVFJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjD4izQ7Ks8BejzUk3ah45HHF2m8a9Biwam9KS28AHlavV5FRq3Q2F5i0e5Ly8mC/Bqfc43mZ6zzeaPp85dhtcFWUXlmkeVjdg20L5vC9iM6FDbRAW+Y1m/jxbGQjDyW7Ktt7KUM8yHpzBCoEurKlNd3/zCiqa4ppAPzZ4F3jZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTjkNNa0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTjkNNa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742206143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXicYsNrUw2inzjbBDrBibHtcdorys7KRRt+bCpH+JI=;
	b=dTjkNNa0pM8JfPFXX8k9wm0ZKMakD8XANmHZO08D5y+eJzdvMG08Vo4UfV4wMAs2PgNWrg
	aeGYYEuLr8HQhM65hdWV0J2gkpDWXnWWLtTV/7RUeN8UW2pqspPZhxjn+yAvAz+W3AUycu
	+13g6o/H+VLjtET0zjJZdYcH/DjatnU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-paIHY6bhO92Kyu4RE9_Z4g-1; Mon,
 17 Mar 2025 06:09:01 -0400
X-MC-Unique: paIHY6bhO92Kyu4RE9_Z4g-1
X-Mimecast-MFC-AGG-ID: paIHY6bhO92Kyu4RE9_Z4g_1742206139
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BF411800257;
	Mon, 17 Mar 2025 10:08:58 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.181])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90A0930001A2;
	Mon, 17 Mar 2025 10:08:57 +0000 (UTC)
Date: Mon, 17 Mar 2025 11:08:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] swapon: make options --help and --version override
 --summary
Message-ID: <m6xg2n5k5bbn63vb5lz3dhhyj4rctewbwfsypoq6qmpvzmrct6@hwenn66qu2d3>
References: <20250313145149.10323-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313145149.10323-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Mar 13, 2025 at 03:51:49PM GMT, Benno Schulenberg wrote:
>  sys-utils/swapon.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

 Applied, thanks. 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

