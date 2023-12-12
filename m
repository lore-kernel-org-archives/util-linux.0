Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmsYLLsx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32D09F
	for <util-linux@vger.kernel.org>; Tue, 12 Dec 2023 02:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702377899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pp+aWJwvz/yDcLA6MehjixMbwksn7sxMFuS1g8jgsos=;
	b=UmsYLLsxZjjNNsJeQu4DVpBrFleczJHoTF8fJLQ+xslxMwKH2u6dlScdH0slBRpKVJqs10
	RB6yOx/4+7RRFqcheYmXKfVHb+cYtmgGsXEadDdbAhSdWUJ4GtHDvhnoFYPl4Or9HGxdnG
	kw2t9L1uOwN9xLaVL5QuNaFondiizK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-CkPLZ_-HPUWF2XfG5sKYwQ-1; Tue, 12 Dec 2023 05:44:55 -0500
X-MC-Unique: CkPLZ_-HPUWF2XfG5sKYwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 607A4185A78A;
	Tue, 12 Dec 2023 10:44:55 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C6C422026D66;
	Tue, 12 Dec 2023 10:44:54 +0000 (UTC)
Date: Tue, 12 Dec 2023 11:44:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Rishabh Thukral <rthukral@arista.com>
Cc: util-linux@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] util-linux/sys-utils dmesg support for additional human
 readable timestamp
Message-ID: <20231212104452.xfw632mgyjcixwmk@ws.net.home>
References: <20231205195333.15832-1-rthukral@arista.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205195333.15832-1-rthukral@arista.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Tue, Dec 05, 2023 at 11:53:33AM -0800, Rishabh Thukral wrote:
> diff --git a/sys-utils/dmesg.1.adoc b/sys-utils/dmesg.1.adoc
> index 6f4941ede..16af7d940 100644
> --- a/sys-utils/dmesg.1.adoc
> +++ b/sys-utils/dmesg.1.adoc

Added as a PR (to make sure it pass CI)
https://github.com/util-linux/util-linux/pull/2641

> +#define TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED 8

I did a small change to the code to make some names shorter :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

