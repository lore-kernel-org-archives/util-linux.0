Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493610962
	for <util-linux@vger.kernel.org>; Mon, 25 Mar 2024 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392753; cv=none; b=KuqS9iDh/0F7aTCbwg5fn+OaZWRfhu7BYv7IQxt1bBBXY1DiV2ZLvkpODAFAZlFVe0ZZ+7PwcchHsFK8MsPr3lHpgg/DADyx2zbtcN1mL7zT42DoJ8y+x4cUWmKe+9/V5aOEwmA1OZknKZz/wfZURqf1IXS2rnHmJXRfkqwrCE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392753; c=relaxed/simple;
	bh=4WCHxEXu+7SStf04BqAObR0kGBgouOmuO4VnM7Ps6so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki2iofrN0SuqDtV+oN+qhcTn1PoGVIuwOkI87HvyGylN4nNGLCFbUVHXtLJUFwiA2HVf/5hOJKt4R/wbN9JYoQiLpmYNm3zieg2ZWRKltiPPLv1gfdfaAgIwoRk2yni4ZKCREcTiAjL2+54Cb5VeFXT5TPsOyS8j4sbYrKGoSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NI9Z+MUt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NI9Z+MUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711392750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrJaHGu1oWVq4y20EQsCZvw0dy0TV7HiwbJaUc4gzOs=;
	b=NI9Z+MUtEYjAyazhtEGlTEOb/6+zFsReG9pNb0VinqxOAxPQP6AK/+ux5YougZZvYt3qAL
	Svfd3RYNL83KbF+SyaObaeC7ZxcKlDEBAUvC72+XimD1td77Hn3EFqv9pijV2J5mLGoWBs
	4FAB0d9sSh09LieMM1ICvWdTVFrQ9Vs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-kYCQXoOLPqOdi1BB4udGMg-1; Mon,
 25 Mar 2024 14:52:28 -0400
X-MC-Unique: kYCQXoOLPqOdi1BB4udGMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25A9638157A2;
	Mon, 25 Mar 2024 18:52:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A72A32166B31;
	Mon, 25 Mar 2024 18:52:27 +0000 (UTC)
Date: Mon, 25 Mar 2024 19:52:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Tim Hallmann <tim@t8w.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] rev: Check for wchar conversion errors
Message-ID: <20240325185221.2uldvvwqkqi44qy6@ws.net.home>
References: <20240324191430.319771-1-tim@t8w.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324191430.319771-1-tim@t8w.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Sun, Mar 24, 2024 at 08:14:30PM +0100, Tim Hallmann wrote:
>  text-utils/rev.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Looks good, I've created PR
https://github.com/util-linux/util-linux/pull/2854 to verify the
change against our tests. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

