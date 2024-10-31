Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13B114901B
	for <util-linux@vger.kernel.org>; Thu, 31 Oct 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365111; cv=none; b=LJ6Hyoy0/miCqtEAlY9nrzRf/qcfeTHi6aAXyqBQo0akgxctHcLnZydvxbh7Wi1l0NSRHCsE8w/0Qm6ouWsVIEm88JY8R7YPxQdcjTEWEu3K5Lhc8GN/aRo79WMi6CJgdVX9VR8dlMBP9TKPbU4XIQHTLiezdfIC8yLHM04THMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365111; c=relaxed/simple;
	bh=2rg7Q/F/miHMekOJvGVbWPu/YjTl7ME7tZdQUTJpsuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLI7Z2bFURQT4rplcdDHbQ1KBJOmoc9/JCJLnAlPn77hr9rV/C/OO1XJNjbxsoqreLDvhDoyNJZF31Z7nUkNBwda7axiR+o4L55oEHnLrXRKo/jcliNN6eMBx4eO3iq11Ytl/L2MMoHU2vtqe0tuuWGBuTd6ABZFaqXO3zR7J3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAsSqiBd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAsSqiBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730365108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bwWhQ6dxsB+lOGRRkWrj3TZ9Qa5oS+BsGYIrtRAhqU=;
	b=ZAsSqiBdseesJeaVK5RGJbJAoXaRtOwtrUQCPEau2aE4qa4rs1fI26oBzS/RLfF6mYd7Fu
	Gzqx4VD45nJt5iGRJeYQnoF3ZLgJUTveDLl5ufnx22aJy0Xy9dLl/ZfMJMAqapIRmKZ8be
	nMVh3KsIokM90D/fWaACFyg4QT22/rc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-kNKE0ToBNDahxHqnAs_LHw-1; Thu,
 31 Oct 2024 04:58:25 -0400
X-MC-Unique: kNKE0ToBNDahxHqnAs_LHw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49E721956088;
	Thu, 31 Oct 2024 08:58:24 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.59])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55E871956052;
	Thu, 31 Oct 2024 08:58:22 +0000 (UTC)
Date: Thu, 31 Oct 2024 09:58:19 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] hardlink: add --list-duplicates and --zero
Message-ID: <ivgbtqt2qjlpzxgh6tkdapfohjwu677heddtn7cpkpaqjyoi6g@brl4uxsj6lsv>
References: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
 <b22071e3546940d6d0fa6e1d9d03f292e18229e2.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b22071e3546940d6d0fa6e1d9d03f292e18229e2.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Oct 28, 2024 at 07:19:30PM GMT, наб wrote:
> --list-duplicates codifies what everyone keeps re-implementing with
> find -exec b2sum or src:perforate's finddup or whatever.
> 
> hardlink already knows this, so make the data available thusly,
> in a format well-suited for pipeline processing
> (fixed-width key for uniq/cut/&c.,
>  tab delimiter for cut &a.,
>  -z for correct filename handling).

Why do we need a 16-byte discriminator? The list consists of absolute
paths, so it should be unique enough. This seems like an unusual
thing, as I cannot recall any other tool that uses something like
this.

> +*-l*, *--list-duplicates*::
> +Don't link anything, but list the absolute path of every duplicate file, one per line, preceded by a unique 16-byte discriminator and a tab.
...

> +				printf("%016zu\t%s%c", (size_t)other, l->path, opts.line_delim);

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

