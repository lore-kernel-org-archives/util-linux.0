Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7706E541
	for <util-linux@vger.kernel.org>; Mon, 15 Jan 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiJPVESM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705311683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WcxlDhAu5vq570bSyvT+8+qNxlk4z84ocktiGz8cIeI=;
	b=KiJPVESMt54HcEdlG+u2B2F6GI6iE/X7jVw51ju+vOjAx/pDLCjL7XxNMpXgOWIxM0J2Vv
	CatKiSBtKc55hjW2mE/WOE5QHzw3KDqPB18WnOpJGV8v6ATuZmA8mZ9wk4/c9KEwSrY+hb
	DzYMsWgSTyY4zdMjkRZcCGOK7ljFoII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-wt3OuJLWNhuihU2L-9lHPw-1; Mon, 15 Jan 2024 04:41:22 -0500
X-MC-Unique: wt3OuJLWNhuihU2L-9lHPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF861811E9C;
	Mon, 15 Jan 2024 09:41:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BDA52166B31;
	Mon, 15 Jan 2024 09:41:21 +0000 (UTC)
Date: Mon, 15 Jan 2024 10:41:19 +0100
From: Karel Zak <kzak@redhat.com>
To: Michael Trapp <michael.trapp@sap.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] uuidd: add cont_clock persistence
Message-ID: <20240115094119.sii4i3jnxpjg5rlw@ws.net.home>
References: <20240110162938.20672-1-michael.trapp@sap.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110162938.20672-1-michael.trapp@sap.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Wed, Jan 10, 2024 at 05:29:38PM +0100, Michael Trapp wrote:
>  libuuid/src/gen_uuid.c | 120 ++++++++++++++++++++++++++++++-----------
>  libuuid/src/uuidP.h    |   1 +
>  misc-utils/uuidd.c     |   9 ----
>  3 files changed, 90 insertions(+), 40 deletions(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

