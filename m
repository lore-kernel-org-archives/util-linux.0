Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7B1E863
	for <util-linux@vger.kernel.org>; Tue, 23 Apr 2024 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866030; cv=none; b=q96xvUZqOSIbgt/7xeVySMZCAS8B5aJx2qo5+vfmvtowMiLlZzpcvx6fJgqqA3Ceih3QomFz+yokp0yEuwcHiXKvTwwVwld3nB+PVE22gi8ZXTnCJz1B919yF5T0k8n3QAb/uOd98tebdz0WXMQA6b94Q6ajqYuYcxy9ziYweF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866030; c=relaxed/simple;
	bh=MaHYXU/uuuUslu2oFqDc9mEXg3EaMFL3shxubamhrwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgGySXtBPkzcpBjjlQlGU7bvuRxM1Asi2HKk0L7uGUWH8ZL3kzUe5AAfhE+TZOHgpyQBk9r58IWqXi3Fq6P9wINvi+mphX8KAPnlOikfzT480KmQh8sFi04UCUmdrTU/hwbxmP6lT6dUvMsax9A7BKPwzNxxAoDEQLwvQ6nY56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNQyjPIQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNQyjPIQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713866027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i8gMMXszfYQJqxih2yCTqIPYhUU6B8XtwG26cILzsis=;
	b=HNQyjPIQPXPZC3v5dnFyW6bDS8CWZ1N5UvjhjhFlQ/jHLk1CDA6V9VFuL6QZWHemJXCcbL
	sASZu+iEsriQASdr30H9gWGtz+y08VG1xGWmRohvL3P6jmquM18mBUmSH1Qo/186Ajz6Hy
	fnE003gZedsHhzKsN2j6QsQcymQ+new=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-q90_WfZfNlSMB1jZs5ITGw-1; Tue, 23 Apr 2024 05:53:43 -0400
X-MC-Unique: q90_WfZfNlSMB1jZs5ITGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B1A018065B4;
	Tue, 23 Apr 2024 09:53:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B75AF40C122D;
	Tue, 23 Apr 2024 09:53:42 +0000 (UTC)
Date: Tue, 23 Apr 2024 11:53:40 +0200
From: Karel Zak <kzak@redhat.com>
To: rasmus.villemoes@prevas.dk
Cc: util-linux@vger.kernel.org, Masatake YAMATO <yamato@redhat.com>
Subject: Re: [PATCH] flock: add support for using fcntl() with open file
 description locks
Message-ID: <20240423095340.vrjecukz3azao6lj@ws.net.home>
References: <20240417100948.75817-1-rasmus.villemoes@prevas.dk>
 <20240418.023354.1867217317145795622.yamato@redhat.com>
 <20240423095002.rpxqdoqpra5p3uaw@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423095002.rpxqdoqpra5p3uaw@ws.net.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Tue, Apr 23, 2024 at 11:50:05AM +0200, Karel Zak wrote:
> On Thu, Apr 18, 2024 at 02:33:54AM +0900, Masatake YAMATO wrote:

Oh, sorry, I replied to Masatake's email instead of Rasmus's. My notes
are for the original patch :-)

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

