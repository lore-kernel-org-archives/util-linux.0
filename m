Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4425A33A
	for <util-linux@vger.kernel.org>; Tue, 25 Feb 2025 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470126; cv=none; b=I1O/V2RB0Uz7dFce90ZI0qluaoHOK0XqHqVgfjX6VH3MO4poHrTHNYrxOgBviBdLuNfIMUiLuMh/bFchA1nwc8ZYIfeZg6+qPd4jFFLu7t6ZnuN7hw7EJYyE49h/BD4LHbehQiz/C0T7YZT6BDlEkBs89HOWVLKTswXoMHbU9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470126; c=relaxed/simple;
	bh=lamDxPLeJu6p1SKPIV9PPDBgTi2pNDtQlj9i0yMNGqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEbFoguwnrqFq7YAygxSFe2KVLMXVthN+F/m/3ZUvVdRPSGYeJszsnxB9+gXJUuz9g0jkUVu283O0CsBqQgaeXEdCN7TFgIKGz3e3vhvE/23cX0JIxDlVZAvVjkKS8MyvSXJrZuK6887rDIatcKWLncgov1YyO+PqogGo3ovUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asbiB8wj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asbiB8wj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740470123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bN+lHQ50lnV9mI/yQudIGK+72d9Y+2bvvnwjA2gIW/w=;
	b=asbiB8wjuqKPOjdfVw30YGt14j/v8BPzOdWaJI3Thygg72SoFutGjEiuXtSl2/GsnYU4dV
	PLwnvb/5DXRkJwLDghUcurdQq7YOk7gl2NG+P+q4O+uKSVvTjoZEQAUtu2c6trLV3VtkEH
	cVDPxaQP4eqtSYmX5eGQJYZGRSCZwb8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-_xcLOdI3MyeKb00J00A7Gg-1; Tue,
 25 Feb 2025 02:55:19 -0500
X-MC-Unique: _xcLOdI3MyeKb00J00A7Gg-1
X-Mimecast-MFC-AGG-ID: _xcLOdI3MyeKb00J00A7Gg_1740470118
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC1701955F28;
	Tue, 25 Feb 2025 07:55:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E365180087F;
	Tue, 25 Feb 2025 07:55:16 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:55:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: 1098694-quiet@bugs.debian.org, Florian Bach <Leseratte10@vodafone.de>, 
	util-linux@vger.kernel.org
Subject: Re: Bug#1098694: Crash in agetty due to invalid strncmp call in
 Trixie
Message-ID: <64wpctmzfsbxasorpi62zugns7mfjordxaprttnuhsqkew4i7x@h27ceoljgtp5>
References: <5534c6e1-b819-4aaa-a8c1-fa22852e327b@vodafone.de>
 <tzuam3pqfrm6g7t4hwwapmpxxux75bf4vxd42qb6iode2hqnnx@ve4h5lyd3yp6>
 <bee22700-d1e4-42a2-9fe6-9ba9d2e64538@vodafone.de>
 <5534c6e1-b819-4aaa-a8c1-fa22852e327b@vodafone.de>
 <4ewlrlhq7eskooeb5h7v4p5qv6r3nvm2ubmuo5546lo5yxsrta@pr2horn2sxog>
 <b5ikwzm4qjyxazwnck736kqdihgjmyjbsfuikfwntaece7fmmu@oxxt7prt45jz>
 <2tlkt7g2blnq3gigedhwgnrt5w7n6k5zyr3dvpadyrl2bn5p2d@v6rhkcmaeryo>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2tlkt7g2blnq3gigedhwgnrt5w7n6k5zyr3dvpadyrl2bn5p2d@v6rhkcmaeryo>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 24, 2025 at 07:59:11PM GMT, Karel Zak wrote:
>  Oh, I have implemented something like this https://github.com/util-linux/util-linux/pull/3425

Merged.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

