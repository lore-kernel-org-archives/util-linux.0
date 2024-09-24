Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E315887C
	for <util-linux@vger.kernel.org>; Tue, 24 Sep 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181137; cv=none; b=UBshQkfKK/DZjKmOaYbnfA1FB6Uy014amFE70kCc8rua3cSbBTCRJnZfY7v+QARu3h1AoXOCgl8Z1I5jegZt8NVSIw8qOXxdhYszoKwDjJJYYO7F5ezdAHPh3kUsgPruRNt10hIDdhSeJvsc6aIFl8Zm7527lUTQEWCRjewI7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181137; c=relaxed/simple;
	bh=xtNKtXAa12m+qEuj/t43DXG9XirF2l6HDeNrYcDKOkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DesCzcqW9AdzhIMZ1QMjcBQl8XObUZ32YUDK6ry1C+UI5sXawGIUQdVT7D+3xdbnJw4RmAwLCX7kjiReBgDUInGYoZxECQBxEHB8pVsgnrKZH3wBIuAFl6E+FoMIknBgh9wtA+2cLLmxjBrQAVFahwXhvn5NjsgTc005ihhkGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ix6GcwAU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ix6GcwAU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727181134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCTSvC8wD7c7p+X+ecgv/jzI0uHCnXU1vv7GyOJJ7DQ=;
	b=Ix6GcwAUK5/1fG/BbR7ffXM4cOqHmdXY9BIaio2hxkvLAv8OhAN3DP8c39p5Cxmn+B4FN4
	Qs6HEAhiALssQd9N4djPgZcv8DurGyfWoN+nU/yN3i7QxiWqwEU7peh3YLqkPRoWpSed0I
	bawD80xvjp6PCwDo5q3ioWQNH2pay5g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-ZzgJ8M0COzu8NPAxEwzofw-1; Tue,
 24 Sep 2024 08:32:13 -0400
X-MC-Unique: ZzgJ8M0COzu8NPAxEwzofw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A57B18BC2FD;
	Tue, 24 Sep 2024 12:32:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.111])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C99D5300239C;
	Tue, 24 Sep 2024 12:32:09 +0000 (UTC)
Date: Tue, 24 Sep 2024 14:32:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Henrik =?utf-8?Q?Lindstr=C3=B6m?= <henrik@lxm.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] Add options to enable building lsblk and dmesg
Message-ID: <rfx445yimsaeug23c7s5ttbex3ycvdcsayxdz45z4guksiz7wl@j43loztpnqld>
References: <20240921082310.232867-1-henrik@lxm.se>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240921082310.232867-1-henrik@lxm.se>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Sep 21, 2024 at 10:23:08AM GMT, Henrik Lindström wrote:
> Henrik Lindström (2):
>   lsblk: allow enabling with --disable-all-programs
>   dmesg: allow enabling with --disable-all-programs
> 
>  configure.ac | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Applied, thanks!

    Karel
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

