Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHzPsc+1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C1AB
	for <util-linux@vger.kernel.org>; Tue, 12 Dec 2023 03:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702378855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aesioKGbz85NLU3UKpUYYGRhlDmVMRQChVWPBR8roww=;
	b=OHzPsc+1L0RV8DzG9KoxLOt9NmN9bMTU73x/rKqV0LLjS1yaxIsQUXyMUVUZsv6yqJ+5Dw
	erBUIClaqCPomcj5M1HSZVyT/CL0EwcTm+FacBaQy1FNppAUY28FF3aHTZQF+Tjba5ooyG
	EE8kkWoKP6SVvum1QgClRz0O7Zs01Vg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-c1cmgaxDMMaRoi_ASYEbfQ-1; Tue, 12 Dec 2023 06:00:52 -0500
X-MC-Unique: c1cmgaxDMMaRoi_ASYEbfQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3368B101A555;
	Tue, 12 Dec 2023 11:00:52 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B6BF7492BE6;
	Tue, 12 Dec 2023 11:00:51 +0000 (UTC)
Date: Tue, 12 Dec 2023 12:00:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: logger: should priority come before octet-count?
Message-ID: <20231212110049.imirb33nx356ifua@ws.net.home>
References: <qudzfymzxye6dofpgzhjsemss6zykiymyr6ujr4fmq3ah2dai6@dnb5zen5j3zd>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qudzfymzxye6dofpgzhjsemss6zykiymyr6ujr4fmq3ah2dai6@dnb5zen5j3zd>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Mon, Dec 11, 2023 at 03:04:07PM -0600, Goldwyn Rodrigues wrote:
> Hi,
> 
> When providing --octet-count with --rfc5424, the message prefixes the
> message length on the message. This however comes before priority, and
> the syslog message looks like:
> 
> 120 <13>1 2023-12-11T14:22:08.433695-06:00 kora root - rsyslog_dbg [timeQuality tzKnown="1" isSynced="0"] dummy goes to town

As described by RFC: https://datatracker.ietf.org/doc/html/rfc6587#section-3.4.1

I think --octet-count makes sense only in situations when used against server
that supports it (implements RFC6587 over TCP).

The octet count is used as a framing method to separate messages. IMHO
it has to be at the beginning.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

