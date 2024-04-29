Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BA8487
	for <util-linux@vger.kernel.org>; Mon, 29 Apr 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394310; cv=none; b=cz1/lXKqV9jYqerSo1k4HIk4r7zGHxZx2AUEoBRkMituFnMQ90c9mnt20mOeFPvQbN9O//yJzJkYgT+7tyMEDzauCAnsCpX0F57Na45N0Bj/SGXjB3GTV4M4fX+E6Q94cxrgmFc4mDZcMAwhTPp7LlWqfoGlHWjwSTzaGphtH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394310; c=relaxed/simple;
	bh=Hw3JN5KAzPl24YneOyd8ygkhOuAl3u+oXuh7DS2Rx9Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NkcvapQcLtm4e1hXEvuJwrrH3W8x4Qx5Uvxy80Wgu2sHto3Bldj3hL+/G6piAEe0UYRVFaC2SfBQzNz41iNz+aD6HKFtjg1YDR3Tjb09Eund8EucXPzJANsXVEjQ38oPp63+zYVPtoaY9Y5tz5oghVv18pt/Z3UQ3L+LseGQakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjULvEfl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjULvEfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714394307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=/vjIZLETj0+dr7M5WqpQI0rqT9cQBpjKfLymmJ1fgn8=;
	b=VjULvEflntOwbCVAQWjm42+rWotIIwitDigbfXp4zAzNL8pHFzuzUyyhceAjIjFm+7bxZy
	H7s5kXT3JcLcFbG9gNJ6JTsLJosEZjfh01p6yU8J/my1TATEbbUnuVCIU8Jrj4tD6IfpLJ
	4EXSoRG6VB4A6DY21E8reKMIEBdDCvg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-yyoGrvg7OvOUNlFfBLHHbw-1; Mon,
 29 Apr 2024 08:38:26 -0400
X-MC-Unique: yyoGrvg7OvOUNlFfBLHHbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD84029AA399
	for <util-linux@vger.kernel.org>; Mon, 29 Apr 2024 12:38:25 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 82A3351BF
	for <util-linux@vger.kernel.org>; Mon, 29 Apr 2024 12:38:25 +0000 (UTC)
Date: Mon, 29 Apr 2024 14:38:23 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.40.1 this week
Message-ID: <20240429123823.gcbqklfbms5uw2vs@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


Hi all,

I would like to announce the release of v2.40.1 from the
stable/v2.40.1 branch this Thursday or Friday.

Please take the time to test the branch and ensure that it includes
all of the fixes that have been reported and requested.

Thank you.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

