Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0232266EFA
	for <util-linux@vger.kernel.org>; Tue,  8 Apr 2025 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109252; cv=none; b=XhT43epCtOTlev/xRYgFzXXSWjq5iC0unNiuYlLTfps5zGhlv/z8U0A/rjwJBtbaYUsJDhYDxLUFhU8Oo/2yz+RoyHBDegsb7DqJYn0MCBXHMVFnzEcThtmazhOZH/W1+i2dJIIcPOvLDaI4vaN+0Aqp3xywytSMRLoVKkoutXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109252; c=relaxed/simple;
	bh=QmeAsZMz87IQP41EK58loP3mOF5j0sma9tFsAGAI2mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNoFChOjSLypz8db7lf5J7T/jtjvkATiU/hTHmoLpkUjMZsp6gKjogdfdsEtXlEzpzDf1c1rjggNU5GtACnvJp1UzkkryE70K0cJpMWOnKv0YXCYjjUgSadOb2a/4jkMk5Ed9a9IBIWJOGNB9dpshi6wKH8rspnfGKocozo94kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESwFlPT6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESwFlPT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744109249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J1lmZBjC0ywrgm+QeLseVg/YyrErf6JZIqgRWF29ZNQ=;
	b=ESwFlPT6xnW6djyDXuK1qyPjYNNczs7V7egL69pwhYtIIibR1H+mPH5xTN0o/lIJd4ghJL
	36tDmoMwLB6CwOyHCOhOpnIIkqv6DniD6TVklq2cDvfUqtYiGmrC45IMg9FPOoqwGQLAwk
	A8SlSOQW6EEj1vfpy50y0XtGZ+xYDHA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-RCKyR278MICBf52ZfymKwg-1; Tue,
 08 Apr 2025 06:47:26 -0400
X-MC-Unique: RCKyR278MICBf52ZfymKwg-1
X-Mimecast-MFC-AGG-ID: RCKyR278MICBf52ZfymKwg_1744109245
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 745751828A8A;
	Tue,  8 Apr 2025 10:47:25 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9406C18009BC;
	Tue,  8 Apr 2025 10:47:24 +0000 (UTC)
Date: Tue, 8 Apr 2025 12:47:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/8] setarch: (man) remove a synopsis line that
 mistakenly mentions `arch`
Message-ID: <hekzxsmqqku2hm4zimenhcmjf2xin3w7vakymwypnwwlnturdz@3xjh3dh5uru5>
References: <20250407151503.23394-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407151503.23394-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 07, 2025 at 05:14:32PM +0200, Benno Schulenberg wrote:
> Bug existed since commit 0554182555 from seven years ago.

Patches 2-8 have been applied; the first one is postponed.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

