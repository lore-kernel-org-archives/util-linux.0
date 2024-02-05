Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041718633
	for <util-linux@vger.kernel.org>; Mon,  5 Feb 2024 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132223; cv=none; b=fpwFN2s8eghoRk9jB0/r7EwV+mOmUgu2nb7+Bx4q+lWuuHzNd634lIUFCO1bCGpOVnKdHLe9iGX3JPFw0mgmc1ig6elyYo2/hahgOGd9SejW0Be7HO6lQzyu0ibTIzbrP/XM8mRKh/11PlfvtdQ+ADn3C0qJcx+W//m1W+49qnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132223; c=relaxed/simple;
	bh=4lYkC8Zvv/+m4Di8jCuZ6dGYchj9Z4Whi+EQJb6d8kQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VrHPDJWH0EwsqFtcayC3jNdhCKoL/hNtub3v564hGKgErJ6V45++EpOOutyPo5YHu5NdqjOXvfR2jAmrk/YX0QVomtvtxJZ64f9XW+SpHfLCItUAEeCFjQ3OfdwrVboIvFYFojZbNsIob5oCE27SOcViXO7NNzf1bk0FPf5Mqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7yUqrUp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7yUqrUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707132220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Xj9SxAIegsI26hdDGwHPsUbKbBR2hfsvUlJiOpw0Muk=;
	b=H7yUqrUpKDt7F16jSAL+sdelprUyFWx2VuRdkOf9A3IGazi7I53TYtm1K0jcJb+vsjFtLW
	mSlkw3/2pQbvLm4H9aOvpdZOnxT7jcdIXz4kEn+Kf5UJ4zDhCa6zd9n2arvxLVfdgPozjL
	SgJhFBAQjzZPGcnNcRa669U6UfhpJTI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-S0n-UjhIMPijW5JTmSjrlQ-1; Mon,
 05 Feb 2024 06:23:38 -0500
X-MC-Unique: S0n-UjhIMPijW5JTmSjrlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7138929ABA19
	for <util-linux@vger.kernel.org>; Mon,  5 Feb 2024 11:23:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 19F8B1121313
	for <util-linux@vger.kernel.org>; Mon,  5 Feb 2024 11:23:37 +0000 (UTC)
Date: Mon, 5 Feb 2024 12:23:36 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: branches and v2.40
Message-ID: <20240205112336.7gj7nygpqpio2fq4@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3



 Hi all,

I've created a "stable/v2.40" branch where we will continue to work on   
v2.40 (rc2, etc). The "master" branch will be used for development as  
usual, and relevant bug fixes will be ported to the stable branch. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

