Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8367207656
	for <util-linux@vger.kernel.org>; Thu,  6 Mar 2025 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262046; cv=none; b=HpyRJlumayOdPITJGbpCKNKtHrf32UJwpGpuYzAgiCIOktnn/skZJ9eCFGWc/pbLKeMIhwEZhxJtTnKE0rtPDLguolPHFrQu4/w6oHiLqxHEBOKwAecK84abxi1K/oGIPLSSBTjVOZo2SwusfCyOp4a3/j/agHwHOhYOatU9gwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262046; c=relaxed/simple;
	bh=VKqgIxMnZqaDhI884XJ6RPXbshJDFlXkWCM9B65EeSo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RRlhB9u6+1ZK9hSH453etNsqC8TBLzDUBeZa8usFvGD/p+wXg/ar51jOT8jxppVLhkqjYi2+H/oYTwUAgSPPym3iOzdqlk4DBPMEou/cf/nEdA6KvftFANzZZPJ37iTV/6U+II05VFBMrxEYT9MyrvHKD2iut9pvK4yBfkd8lUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lw+GJYsQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lw+GJYsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741262043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=VbDwloGI3pR8CEEcBlzxPvYiwRf7jT1t5V5YK8N6l+4=;
	b=Lw+GJYsQPYa5zUfX0PG6sJgTkhBPswLCrCJ+aM/hGKrJwsVwsUlTKFmmw7wRn2SlLHzfaE
	DwNb9Ihm4OAhAEhof43MhBc9Og8CrdnCAOgKkd2d6xDTIr/LxJA6p1fwyz+7UxzZ4y+Tr+
	5cInT/yVUwnGUtQjlCtuXmsRoHEX1gs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-yvKlDf8CPLuqvtvcJ1YIzw-1; Thu,
 06 Mar 2025 06:54:00 -0500
X-MC-Unique: yvKlDf8CPLuqvtvcJ1YIzw-1
X-Mimecast-MFC-AGG-ID: yvKlDf8CPLuqvtvcJ1YIzw_1741262039
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 499A519560B3;
	Thu,  6 Mar 2025 11:53:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E6901801747;
	Thu,  6 Mar 2025 11:53:56 +0000 (UTC)
Date: Thu, 6 Mar 2025 12:53:53 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.41-rc2
Message-ID: <jnoop7vzwoott376m2y7y7nru5yr2xtgtdcsueqgd7igleooyb@gen2pdy7cbln>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


The util-linux release v2.41-rc2 is now available at

  https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41-rc2.tar.xz

Feedback and bug reports, as always, are welcomed.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

