Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWNxyEI0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC68A4
	for <util-linux@vger.kernel.org>; Tue,  5 Dec 2023 02:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701771968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJopxm6FF2zTVkcPPEp56t3k1FxFmC73Rljs/BBOyoc=;
	b=aWNxyEI0VHEF6Bq8QxbNxGRkIlFPu7GriDyZxgOJc8P8k4qolO7Yiuwe37+ynbV2DiJAIH
	E3QxBSiQrKiYtf5hfNR8iLvKnyzeooME1jrDy1zzIrwQn5Ve6RP95L/UsdSwpKVYu506xZ
	MzGiEmdjtWfKrFNqqyrUL3aerSB9oKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-QmIuoxVKPEWx1LfW44SRfQ-1; Tue, 05 Dec 2023 05:26:06 -0500
X-MC-Unique: QmIuoxVKPEWx1LfW44SRfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 105408A51C1;
	Tue,  5 Dec 2023 10:26:06 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.175])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 916B81C060AF;
	Tue,  5 Dec 2023 10:26:05 +0000 (UTC)
Date: Tue, 5 Dec 2023 11:26:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Remigiusz Leon Suwalski <remigiusz.suwalski@protonmail.ch>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: Piped `column -t` inserts extra newlines since Oct 2023
Message-ID: <20231205102603.csxm6luqnayetva5@ws.net.home>
References: <StZBjLc2hfwARaOlTwkjpnqrtWLLL_rya0UmGRk5OFwX1Y1KthwQWBz5bcDpEOjcq2hbJ6aY4fcoAMU3pU2spFhGDbGwmd4puAzNrvspFpE=@protonmail.ch>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <StZBjLc2hfwARaOlTwkjpnqrtWLLL_rya0UmGRk5OFwX1Y1KthwQWBz5bcDpEOjcq2hbJ6aY4fcoAMU3pU2spFhGDbGwmd4puAzNrvspFpE=@protonmail.ch>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Mon, Dec 04, 2023 at 05:26:05PM +0000, Remigiusz Leon Suwalski wrote:
> Hi,
> I have discovered that `column` utility behaves oddly when piped to another command, as shown on examples below. I am not sure whether this is a bug or intended behaviour.
> 
> First `column` built from sources (commit https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=94feb5a20d23904cc15cd857c4e00f35f495116c):
> $ echo '_ __ ___ ________ __________ ________' | ./column -t | nl # strange
> 1  __
> 2     ___
> 3          ___
> 4                 _________
> 5                                       __________
> 6                                                                  _______
> $ echo '_ __ ___ ________ __________ ________' | ./column -t > file.txt # the same issue as above
> $ echo '_ __ ___ ________ __________ ________' | ./column -t # expected
> _  __  ___  ________  __________  ________

I cannot reproduce this on the current devel tree and stable/v2.39
tree, I see:

$ echo '_ __ ___ ________ __________ ________' | ./column -t | nl
     1	_  __  ___  ________  __________  ________


$ echo '_ __ ___ ________ __________ ________' | ./column -t > a
$ cat a
_  __  ___  ________  __________  ________


   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

