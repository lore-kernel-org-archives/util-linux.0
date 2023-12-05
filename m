Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgIIFCIV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2559BA4
	for <util-linux@vger.kernel.org>; Tue,  5 Dec 2023 02:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701771999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KD90ML3gBuurl4kZNG1hXzr+Kl4BJl8FvIueAFlw568=;
	b=fgIIFCIVzLC2CahqOtdyNXtthZZv9mNlgop2b7zT1fH2WX9oN7JKybYrxzuW9Q9Y2Wvqd+
	8SIMliQ8W/13qnsV7y3DAGp3F2F0TOoOp0Tww8mw2DN8AQOfRakcBXfqyHRkUuqZhmFaTe
	My2SnQW+iT4Gfb0+0lPOzdEk8lwG/Q0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-JVbL9WbBOtifKiyPm6DH5w-1; Tue, 05 Dec 2023 05:26:36 -0500
X-MC-Unique: JVbL9WbBOtifKiyPm6DH5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF0BD185A782;
	Tue,  5 Dec 2023 10:26:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.175])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BE8D1121313;
	Tue,  5 Dec 2023 10:26:35 +0000 (UTC)
Date: Tue, 5 Dec 2023 11:26:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Samuel Thibault <samuel.thibault@aquilenet.fr>,
	util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.39.3
Message-ID: <20231205102633.oamviajtb6mt4qqc@ws.net.home>
References: <20231204200508.mtdmxgrsvhux7m7s@ws.net.home>
 <20231204210844.32vk3tr32rwqonar@begin>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204210844.32vk3tr32rwqonar@begin>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Mon, Dec 04, 2023 at 10:08:44PM +0100, Samuel Thibault wrote:
> Here a fix for non-Linux builds.

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

