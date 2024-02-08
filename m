Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DC6EB51
	for <util-linux@vger.kernel.org>; Thu,  8 Feb 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393358; cv=none; b=Gm1uS2xcfEkV43EChWiqBcalrmVi0RuHzZl5NI/xhGVLT0sG0iYs+XjGWWRy/RjGd2vaOwZkqbAxovVxextcMc5FgZKH5eNSHmFVg/bfGNCP+mTOqFCLCWeYx1MQi1LY7fByaMG+LaznA9A0MbdwA3WC4hPR6nba5qSfCFbqMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393358; c=relaxed/simple;
	bh=XWmzyxIC6F55okepkkXryjBylGrwnZnIBOzZ8LQWP5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9mIAkwIJvi0o2IPf+jLR/anoGQmKVTUciXG7xRA7+Vj2mGuI3tEJGpGqcotvv36voGc8R2fefmnMblifBxgH6YtM/Wtq/6obN4PAj/ZMCl1BvP/D3jpf32Ms6vrZv/9ZKISA4O5YGSpiiB9cxnGiHn5aTNx1m9eZUG8QZjSYXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhfzuxME; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhfzuxME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707393355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnwKvXtBaccIQUMuKnvfqXFDTB1cpDnQ7Fr8EgIPXeI=;
	b=JhfzuxMEzh5IsVr6bhCbVJKA5X5ID6eacKnYtqUzIlpxk/SL4mvI4AJOUzCAfPoaBp3j/Y
	JqL/Jb6iO3KKrGG7+MusYyuSvqMyYlHtfU96zNTf1RoxaPhtvPY9OeSWLLxIP8m+Sd6B4s
	uxu1xH4YBiInCdNdpWTHrAvPdIEyhhM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-AjFKA4_jMzqNW5d--fHXvg-1; Thu, 08 Feb 2024 06:55:52 -0500
X-MC-Unique: AjFKA4_jMzqNW5d--fHXvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D98CD868902;
	Thu,  8 Feb 2024 11:55:51 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6694B11215;
	Thu,  8 Feb 2024 11:55:51 +0000 (UTC)
Date: Thu, 8 Feb 2024 12:55:49 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: util-linux@vger.kernel.org
Subject: Re: fsck exits 0 with no output (just version) when it doesn't find
 a type-specific fsck
Message-ID: <20240208115549.4iucrphww74l5zna@ws.net.home>
References: <f63r2qpu2tzoaabfsuq5yjlqguystzu4tyjvok3etadzy4ouk6@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f63r2qpu2tzoaabfsuq5yjlqguystzu4tyjvok3etadzy4ouk6@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Wed, Feb 07, 2024 at 06:52:47PM +0100, наб wrote:
> I think in -A mode it makes sense to silently ignore a lack of type-specific fsck.
> But when explicitly requesting fsck /dev/whatever, that condition
> should at /least/ warn (I'm assuming erroring out would be too invasive),
> because right now fsck cleared my potentially-broken filesystem w/o checks.

 Good idea, possible improvements:
 https://github.com/util-linux/util-linux/pull/2777

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

