Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5E17584
	for <util-linux@vger.kernel.org>; Mon, 29 Apr 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379325; cv=none; b=fDEA+XQbH4l/nE+YiW7Wy/Y8AMvbDb+ZDM6P7F9FbkvDSBUdH83rTWncHiKry0oHwa310LLBCFIUBz40VUw6DYGPseUDieh4minnncyobzr794NyCXCKFRG/VGC7MFhDozxzBWzzHJElfWCl+g5mdBnsxZtTXq8mgGyQmbgDBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379325; c=relaxed/simple;
	bh=hh/hrfkK47QNGpX2hfMdQtj4/d/NNdlpUflHMcl5kx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W00YpSQPp6sbbhjl67XG4pSj3ygk8GgY0VXJ/U2tggCFwo33PgaB10v21hO9ppM/J9+kYJ0/sImMeQwjEq0R0qcJ7Y4H0Hd6EOBgPZsdAs7EJXVcMntqdeS80v61+zYdjdvasyPXQR/slKBIVPG42kAx1Xmxv4JBCA4fo1aQGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5krJG1l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5krJG1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714379322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADo1dUo+TZEdRJqqt9R8X85bGUT/zwIdW4DckFVDbOs=;
	b=J5krJG1lR5qwRCIOw34URpnliOQrEqVbQO7K91nNPQhoFXT9mlL0QgeqoYB1U7mzyU/YrJ
	nGg+eDK0sornrzgJC9tgAk2ia6v6QE0Q1pEt0sMThGtFF5rCW4tDh60wpdH/ymLaBxvfNa
	rxJ5c/5phkb5bpTklE5Ue6eCnPTHAn0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-jWn_MNiSO-aqxIrpxhZPgw-1; Mon,
 29 Apr 2024 04:28:40 -0400
X-MC-Unique: jWn_MNiSO-aqxIrpxhZPgw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A6BF29AA38E;
	Mon, 29 Apr 2024 08:28:40 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6079740F18C;
	Mon, 29 Apr 2024 08:28:39 +0000 (UTC)
Date: Mon, 29 Apr 2024 10:28:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: Thijs Raymakers <thijs@raymakers.nl>, util-linux@vger.kernel.org,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v12] coresched: Manage core scheduling cookies for tasks
Message-ID: <20240429082837.ao6mps7zbosrb2u5@ws.net.home>
References: <295323c3-a43a-4f60-9c71-3b38a19b1d6f@t-8ch.de>
 <20240425162226.130639-1-thijs@raymakers.nl>
 <73694be2-6215-4baf-8bfa-573cfc2dbfb7@t-8ch.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73694be2-6215-4baf-8bfa-573cfc2dbfb7@t-8ch.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Fri, Apr 26, 2024 at 08:03:35PM +0200, Thomas Weiﬂschuh wrote:
> Thanks for all the work.
> 
> On 2024-04-25 18:22:25+0000, Thijs Raymakers wrote:
> > Co-authored-by: Phil Auld <pauld@redhat.com>
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>
> 
> Reviewed-by: Thomas Weiﬂschuh <thomas@t-8ch.de>

Merged. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

