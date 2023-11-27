Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPtjPgIT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6126125
	for <util-linux@vger.kernel.org>; Mon, 27 Nov 2023 00:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701075474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Rq0/Rfc5Q3WZPOMoGCcXF4wopouB/Y9xUEXNyhE4e0=;
	b=BPtjPgITkqoW6XCGTBQvuvc0XPpT+KGQf5QrVxlkElKbAaqXExXfibsiUS4uuxySxRWjlH
	G4AntSV1+RUpVCpQZooYfZh21y51y0DtxZm5p38C2rLhzcRgiZ8FpXMY/kektAY3ql2Jgf
	Bw+1B+HgP+WAKslagSqiOBjLTI8T30k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-l5DJJaiOP0ClkorxTBnJBw-1; Mon, 27 Nov 2023 03:57:51 -0500
X-MC-Unique: l5DJJaiOP0ClkorxTBnJBw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 399D28564E1;
	Mon, 27 Nov 2023 08:57:51 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6205F492BFA;
	Mon, 27 Nov 2023 08:57:50 +0000 (UTC)
Date: Mon, 27 Nov 2023 09:57:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Junxiao Bi <junxiao.bi@oracle.com>
Cc: util-linux@vger.kernel.org, thomas@t-8ch.de, dsimic@manjaro.org
Subject: Re: [PATCH] losetup: report lost loop devices for finding free loop
Message-ID: <20231127085748.kwq47xdqejqibslb@ws.net.home>
References: <20231107184806.48577-1-junxiao.bi@oracle.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107184806.48577-1-junxiao.bi@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Tue, Nov 07, 2023 at 10:48:06AM -0800, Junxiao Bi wrote:
>  sys-utils/losetup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

