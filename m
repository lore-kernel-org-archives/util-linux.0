Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393F19E
	for <util-linux@vger.kernel.org>; Mon,  3 Jun 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413623; cv=none; b=N6sr9uLt4+H7w67l3QW+BZ+akWjz/45A9wJpoOkzf/8Hq3jZtwcrIoshYAyaai9z6KV2Shv3HOhd6BlgbXU7F5+i4g5958OkNxH6Qj6sjH00TfBfp00PW/J2ycr7c24Zf5A6N66dqa5BNL4KBYe9/97vKziRLKNCQVUEO99k0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413623; c=relaxed/simple;
	bh=U7jnoqtNs0S/C0LL6IwKl94Un5LjsppBpW0tObHZ0rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYcLtZK5pFGgRH0khvgyv4iI/OltxLZSSjqTJUOX+PMUHTRjO8wBeBjU6JlY//nKo44w9LyHjIO8kJ8ynSEAc9qTVJjGqQP5b1/HpCEEEUjGCQ+jU06uk6UXFzoUsoryWCx3p9DhJz+f6AEGIRgeIleGfDviFUevUUFLuA8iJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMRmcsGE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMRmcsGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717413620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HtL3id9mX3yqV9Kw3S21L1HGbAfzMDVPiGvsvZC5xz4=;
	b=OMRmcsGEFef1kDdsRryhSgZyKiwVZ579HHN19hQnbZm8mcWN130v61KrcaStuDfVPMFEmL
	D48xgxhjqUEfttIfbGl73aNSobk6a1YkdIb15LEWRCOZYaVip4HON6rBvvbf8AkKwKKGJZ
	TJAHZrDUEd/bv0KCaoZ9XK7IGh55k4E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-tnJYhZEPPhyLA_a7-X9aTQ-1; Mon,
 03 Jun 2024 07:20:17 -0400
X-MC-Unique: tnJYhZEPPhyLA_a7-X9aTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00C011C05129;
	Mon,  3 Jun 2024 11:20:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.37])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 814DE28E3;
	Mon,  3 Jun 2024 11:20:16 +0000 (UTC)
Date: Mon, 3 Jun 2024 13:20:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Linus Heckemann <git@sphalerite.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: provide tree fd even when a mount helper is
 used
Message-ID: <20240603112014.jrhwwbhhzfdbeju4@ws.net.home>
References: <20240530180041.3447273-1-git@sphalerite.org>
 <20240531094125.r2nvmio47itrtzep@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531094125.r2nvmio47itrtzep@ws.net.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Fri, May 31, 2024 at 11:41:28AM +0200, Karel Zak wrote:
> On Thu, May 30, 2024 at 08:00:34PM +0200, Linus Heckemann wrote:
> > Previously, the X-mount.subdir option would fail (mount exited with
> > code 0, but the target was not mounted) when a helper was used.
> 
> I will think about it :-)

 https://github.com/util-linux/util-linux/pull/3075

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

