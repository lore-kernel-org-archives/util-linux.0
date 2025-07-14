Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B451FE471
	for <util-linux@vger.kernel.org>; Mon, 14 Jul 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495401; cv=none; b=l9Dd8HJEHNbrL/0tIfL6KCS1/tYchLi8Uz7mW16v0M636B2ofa14c/geYjYN/j677KImn7dhI9RJh/ERkL0dwK8ALVtEL4412wNwMW0yANP334ZBIQ2MlDX3cvq23Ur2nY0ZeZRkCQEOKECM2AoQdt9U/EQ5htPLqZwDPz3YFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495401; c=relaxed/simple;
	bh=3rkU53q0YOdstPekPnKxvzZRLQ7jFTedzxvOyCrLEgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QY/fjA8LBMLWzG/2aGPRSeJX6CqIgWybskok2g5PAjgSaI79r91blW+RoTZssDJj3dwFPAkrDoKLsCo7g83mR1p7zGQWv+TG7mdFMUa9XtKHUGCBT9wLIU7IPFJ1+4WusYDFq+6c8agMpsDDL5yamGwnRyfbYTGFkqWWmY98RPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rinp2PAm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rinp2PAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752495395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wDBE7fLq4h0LjAbuYl5uq5HI89vgqwYlNcDmySB0e3I=;
	b=Rinp2PAmHtnqvshKqv/0SA81xDRpsyjV5pYogsL963c3EbVkLp+qXS2IgNsFTZh30ep+Xk
	KAP3yyKul2YOLYRFhdNxe/53MRE/WsHPjESEf9TDKEZKH8qGMvbVwU6/RWMV87G5EmTpty
	Ra5xTZz3hWPtcuV+n4ipg/tXQD50sxg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-NOgrjp1ZMRCqOconBHNxqw-1; Mon,
 14 Jul 2025 08:16:34 -0400
X-MC-Unique: NOgrjp1ZMRCqOconBHNxqw-1
X-Mimecast-MFC-AGG-ID: NOgrjp1ZMRCqOconBHNxqw_1752495393
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F067719560BA;
	Mon, 14 Jul 2025 12:16:32 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.225])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9D141955F21;
	Mon, 14 Jul 2025 12:16:31 +0000 (UTC)
Date: Mon, 14 Jul 2025 14:16:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Paul Benoit <paul@os.amperecomputing.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] lscpu-arm: Remove the "Ampere-1a" part.
Message-ID: <crm5fcuper7bhu7iv7jbejf3rnowwo4tuwrjnutngta56dedgm@zajfg6nh2okx>
References: <20250711211648.53361-1-paul@os.amperecomputing.com>
 <20250711211648.53361-2-paul@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711211648.53361-2-paul@os.amperecomputing.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Jul 11, 2025 at 02:16:48PM -0700, Paul Benoit wrote:
> Remove the "Ampere-1a" part.  On newer Ampere Computing systems, the
> system/model name will be obtained from /sys/bus/soc/devices/soc0/machine,
> that is populated with the ARM SMC CC SOC_ID Name.

If I understand correctly, there are old systems without
/sys/.../soc0/machine, right? The change will remove Ampere-1a from
the lscpu output. This sounds backward incompatible.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

