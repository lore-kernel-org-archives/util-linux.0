Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czP1n6Fp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2771724
	for <util-linux@vger.kernel.org>; Fri,  8 Dec 2023 03:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702035946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omm690iNemm7txZ9KefOa8f/61enbIZ8X8pMEuUqXK4=;
	b=czP1n6Fpg3mOOrZ+chXrmnG8ntw1fz78Pb5Z+z59oqewsVv4CTQbXSs1KC8Wg6EkdQeACm
	UIk4F3agxM0j1rt3t/F5B7vwSRg/X0ZCEVFtf+MpUdoDIqkPSdy3ehlv5BOzTCRr3UWo2q
	ryh/VHf0z5j7so2mMF4m6QCZH5SkIAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-GLRMz24mPTO-q96W4whVhA-1; Fri, 08 Dec 2023 06:45:44 -0500
X-MC-Unique: GLRMz24mPTO-q96W4whVhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BB2D185A786;
	Fri,  8 Dec 2023 11:45:44 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.175])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BE959C185A0;
	Fri,  8 Dec 2023 11:45:43 +0000 (UTC)
Date: Fri, 8 Dec 2023 12:45:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Eli Schwartz <eschwartz93@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] bash-completion: make sure that "lastb" actually
 completes
Message-ID: <20231208114541.i73vykgybbl5jdjw@ws.net.home>
References: <20231207004204.3443364-1-eschwartz93@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207004204.3443364-1-eschwartz93@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Wed, Dec 06, 2023 at 07:40:44PM -0500, Eli Schwartz wrote:
>  bash-completion/last | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

